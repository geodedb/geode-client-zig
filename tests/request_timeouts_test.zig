// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// SONNY-6617: every wait of a GeodeClient honours Config.timeout_ms.
//
// v0.3.18 applied timeout_ms to the QUIC handshake and the HELLO answer
// only. query, begin, commit, rollback and ping still waited a fixed 30 s
// for their answers, writeAll a fixed 30 s for flow control, and the gRPC
// transport not at all: GrpcClient.connect was a blocking TCP connect (the
// kernel's SYN retries, about two minutes) and every gRPC read blocked
// until the server answered or closed.
//
// The lenient parser's doc says an invalid timeout or page_size falls back
// to the default; it kept an out-of-range number (timeout_ms=0), which
// `connect` then refused with InvalidTimeout.
//
// HELLO: a client built in code sent version "0.1.0" (the library is
// 0.3.x) and conformance "minimum" (docs/DSN.md: "min" or "full"), as did
// the gRPC HELLO.
//
// All on real sockets: the QUIC fixture's silent server (handshake done,
// never answers) and deaf server (never reads a stream), and loopback TCP.

const std = @import("std");
const builtin = @import("builtin");
const geode_client = @import("geode_client");
const fixture = @import("quic_echo_fixture.zig");
const test_paths = @import("test_paths");
const config = geode_client.config;
const grpc = geode_client.grpc;
const GeodeClient = geode_client.GeodeClient;

const testing = std.testing;
const io = std.Io.Threaded.global_single_threaded.io();
const linux = std.os.linux;

fn nowMs() i64 {
    return std.Io.Clock.awake.now(io).toMilliseconds();
}

/// A wait bounded by a 500 ms timeout: at least the timeout, and far below
/// the old fixed waits (slack for a loaded runner).
fn expectAboutHalfSecond(what: []const u8, elapsed_ms: i64) !void {
    if (elapsed_ms < 450 or elapsed_ms > 10_000) {
        std.debug.print("{s} waited {d} ms, want about 500 ms (timeout_ms=500)\n", .{ what, elapsed_ms });
        return error.TestUnexpectedResult;
    }
}

/// A client connected to `server` (generous handshake), then timeout_ms=500.
fn connectedClient(server: *fixture.EchoServer, pki: *const fixture.Pki) !GeodeClient {
    var client = try fixture.verifyingClient("127.0.0.1", server.port(), pki);
    errdefer client.deinit();
    client.timeout_ms = 60_000;
    try client.connect();
    client.timeout_ms = 500;
    return client;
}

test "SONNY-6617: query, begin, commit, rollback and ping wait Config.timeout_ms for their answer" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var pki = try fixture.makePki();
    defer pki.deinit();
    var server: fixture.EchoServer = undefined;
    try fixture.startSilentServer(&server, "127.0.0.1:0", &pki);
    defer server.stop();

    const Op = enum { query, begin, commit, rollback, ping };
    inline for (comptime std.enums.values(Op)) |op| {
        var client = try connectedClient(&server, &pki);
        defer client.deinit();
        const start = nowMs();
        const outcome: anyerror!void = switch (op) {
            .query => if (client.query("RETURN 1 AS x", null)) |r| {
                var res = r;
                res.deinit();
            } else |e| e,
            .begin => if (client.begin()) |_| {} else |e| e,
            .commit => client.commit(),
            .rollback => client.rollback(),
            .ping => if (client.ping()) |_| {} else |e| e,
        };
        try testing.expectError(error.ReceiveTimeout, outcome);
        try expectAboutHalfSecond(@tagName(op), nowMs() - start);
    }
}

test "SONNY-6617: a write blocked by flow control gives up after Config.timeout_ms" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var pki = try fixture.makePki();
    defer pki.deinit();
    var server: fixture.EchoServer = undefined;
    try fixture.startDeafServer(&server, "127.0.0.1:0", &pki);
    defer server.stop();

    var client = try connectedClient(&server, &pki);
    defer client.deinit();
    // Far beyond any stream window: the server never reads, so the write
    // stalls on flow control.
    const big = try testing.allocator.alloc(u8, 64 << 20);
    defer testing.allocator.free(big);
    @memset(big, 'x');
    std.mem.writeInt(u32, big[0..4], @intCast(big.len - 4), .big);
    const start = nowMs();
    try testing.expectError(error.WriteError, client.sendRawFramed(big));
    try expectAboutHalfSecond("writeAll", nowMs() - start);
}

/// A loopback TCP listener whose accept queue is full: a further connect
/// gets no SYN-ACK and waits.
const FullListener = struct {
    fd: std.c.fd_t,
    port: u16,
    fillers: [4]std.c.fd_t = .{ -1, -1, -1, -1 },

    fn open() !FullListener {
        const fd = std.c.socket(std.posix.AF.INET, std.posix.SOCK.STREAM, 0);
        if (fd < 0) return error.SocketFailed;
        errdefer _ = std.c.close(fd);
        var sa = std.posix.sockaddr.in{ .family = std.posix.AF.INET, .port = 0, .addr = std.mem.nativeToBig(u32, 0x7F000001), .zero = .{0} ** 8 };
        if (std.c.bind(fd, @ptrCast(&sa), @sizeOf(std.posix.sockaddr.in)) != 0) return error.BindFailed;
        if (std.c.listen(fd, 0) != 0) return error.ListenFailed;
        var len: std.posix.socklen_t = @sizeOf(std.posix.sockaddr.in);
        if (std.c.getsockname(fd, @ptrCast(&sa), &len) != 0) return error.GetSockNameFailed;
        var self = FullListener{ .fd = fd, .port = std.mem.bigToNative(u16, sa.port) };
        // Fill the accept queue (backlog 0 holds one; the rest are left in
        // SYN-SENT by the kernel's dropped SYNs).
        for (&self.fillers) |*f| {
            f.* = std.c.socket(std.posix.AF.INET, std.posix.SOCK.STREAM | std.posix.SOCK.NONBLOCK, 0);
            if (f.* >= 0) _ = std.c.connect(f.*, @ptrCast(&sa), @sizeOf(std.posix.sockaddr.in));
        }
        // Give the handshakes a moment to land in the queue.
        io.sleep(.fromNanoseconds(100 * std.time.ns_per_ms), .awake) catch {};
        return self;
    }

    fn close(self: *FullListener) void {
        for (self.fillers) |f| if (f >= 0) {
            _ = std.c.close(f);
        };
        _ = std.c.close(self.fd);
    }
};

test "SONNY-6617: a gRPC connect gives up after Config.timeout_ms when the server does not answer" {
    if (builtin.os.tag != .linux) return error.SkipZigTest;
    var listener = try FullListener.open();
    defer listener.close();

    const dsn = try std.fmt.allocPrint(testing.allocator, "grpc://127.0.0.1:{d}?tls=0&timeout_ms=500", .{listener.port});
    defer testing.allocator.free(dsn);
    var cfg = try config.parseDSNStrict(testing.allocator, dsn);
    defer cfg.deinit(testing.allocator);
    var client = try GeodeClient.initFromConfig(testing.allocator, cfg);
    defer client.deinit();
    const start = nowMs();
    try testing.expectError(error.ConnectionTimeout, client.connect());
    try expectAboutHalfSecond("gRPC connect", nowMs() - start);
}

/// Accepts one TCP connection and never writes; closes it after 20 s so a
/// client that ignores its timeout fails instead of hanging the test.
const MuteTcpServer = struct {
    fd: std.c.fd_t,
    port: u16,
    thread: ?std.Thread = null,
    stop: std.atomic.Value(bool) = .init(false),

    fn start(self: *MuteTcpServer) !void {
        self.fd = std.c.socket(std.posix.AF.INET, std.posix.SOCK.STREAM, 0);
        if (self.fd < 0) return error.SocketFailed;
        var sa = std.posix.sockaddr.in{ .family = std.posix.AF.INET, .port = 0, .addr = std.mem.nativeToBig(u32, 0x7F000001), .zero = .{0} ** 8 };
        if (std.c.bind(self.fd, @ptrCast(&sa), @sizeOf(std.posix.sockaddr.in)) != 0) return error.BindFailed;
        if (std.c.listen(self.fd, 4) != 0) return error.ListenFailed;
        var len: std.posix.socklen_t = @sizeOf(std.posix.sockaddr.in);
        if (std.c.getsockname(self.fd, @ptrCast(&sa), &len) != 0) return error.GetSockNameFailed;
        self.port = std.mem.bigToNative(u16, sa.port);
        self.thread = try std.Thread.spawn(.{}, run, .{self});
    }

    fn run(self: *MuteTcpServer) void {
        const conn = std.c.accept(self.fd, null, null);
        if (conn < 0) return;
        defer _ = std.c.close(conn);
        const t0 = nowMs();
        while (!self.stop.load(.acquire) and nowMs() - t0 < 20_000) {
            io.sleep(.fromNanoseconds(20 * std.time.ns_per_ms), .awake) catch {};
        }
    }

    fn deinit(self: *MuteTcpServer) void {
        self.stop.store(true, .release);
        if (self.thread) |t| t.join();
        _ = std.c.close(self.fd);
    }
};

test "SONNY-6617: a gRPC request waits Config.timeout_ms for its answer" {
    if (builtin.os.tag != .linux) return error.SkipZigTest;
    var server: MuteTcpServer = .{ .fd = -1, .port = 0 };
    try server.start();
    defer server.deinit();

    const dsn = try std.fmt.allocPrint(testing.allocator, "grpc://127.0.0.1:{d}?tls=0&timeout_ms=500", .{server.port});
    defer testing.allocator.free(dsn);
    var cfg = try config.parseDSNStrict(testing.allocator, dsn);
    defer cfg.deinit(testing.allocator);
    var client = try GeodeClient.initFromConfig(testing.allocator, cfg);
    defer client.deinit();
    try client.connect();
    const start = nowMs();
    try testing.expectError(error.ReceiveTimeout, client.ping());
    try expectAboutHalfSecond("gRPC ping", nowMs() - start);
}

test "SONNY-6617: the lenient parser falls back to the default for an out-of-range timeout or page_size, as documented" {
    for ([_][]const u8{ "timeout_ms=0", "timeout_ms=3600001", "timeout=0", "connect_timeout=0", "connect_timeout=3601", "connect_timeout=5000000", "timeout_ms=x" }) |q| {
        const dsn = try std.fmt.allocPrint(testing.allocator, "quic://127.0.0.1:3141?{s}", .{q});
        defer testing.allocator.free(dsn);
        var cfg = try config.parseDSN(testing.allocator, dsn);
        defer cfg.deinit(testing.allocator);
        if (cfg.timeout_ms != config.DEFAULT_TIMEOUT_MS) {
            std.debug.print("parseDSN(?{s}).timeout_ms = {d}, want the default {d}\n", .{ q, cfg.timeout_ms, config.DEFAULT_TIMEOUT_MS });
            return error.TestUnexpectedResult;
        }
        // And strict mode still refuses it.
        try testing.expect(std.meta.isError(config.parseDSNStrict(testing.allocator, dsn)));
    }
    for ([_][]const u8{ "page_size=0", "page_size=100001", "page_size=x" }) |q| {
        const dsn = try std.fmt.allocPrint(testing.allocator, "quic://127.0.0.1:3141?{s}", .{q});
        defer testing.allocator.free(dsn);
        var cfg = try config.parseDSN(testing.allocator, dsn);
        defer cfg.deinit(testing.allocator);
        try testing.expectEqual(config.DEFAULT_PAGE_SIZE, cfg.page_size);
    }
    // In range: kept.
    var cfg = try config.parseDSN(testing.allocator, "quic://127.0.0.1:3141?timeout_ms=1&page_size=100000");
    defer cfg.deinit(testing.allocator);
    try testing.expectEqual(@as(u32, 1), cfg.timeout_ms);
    try testing.expectEqual(@as(u32, 100000), cfg.page_size);
}

/// The package version from build.zig.zon.
fn packageVersion(buf: []u8) ![]const u8 {
    const text = try std.Io.Dir.cwd().readFile(io, test_paths.build_zon, buf);
    const key = ".version = \"";
    const at = std.mem.indexOf(u8, text, key) orelse return error.NoVersion;
    const rest = text[at + key.len ..];
    return rest[0 .. std.mem.indexOfScalar(u8, rest, '"') orelse return error.NoVersion];
}

fn stringField(msg: []const u8, number: u64) !?[]const u8 {
    var i: usize = 0;
    var found: ?[]const u8 = null;
    while (i < msg.len) {
        const key = try readVarint(msg, &i);
        switch (@as(u3, @truncate(key))) {
            0 => _ = try readVarint(msg, &i),
            2 => {
                const len: usize = @intCast(try readVarint(msg, &i));
                if (i + len > msg.len) return error.Truncated;
                if (key >> 3 == number) found = msg[i .. i + len];
                i += len;
            },
            else => return error.UnexpectedWireType,
        }
    }
    return found;
}

fn readVarint(buf: []const u8, i: *usize) !u64 {
    var out: u64 = 0;
    var shift: u6 = 0;
    while (i.* < buf.len) {
        const b = buf[i.*];
        i.* += 1;
        out |= @as(u64, b & 0x7f) << shift;
        if (b & 0x80 == 0) return out;
        shift = std.math.add(u6, shift, 7) catch return error.VarintTooLong;
    }
    return error.Truncated;
}

test "SONNY-6617: a client built in code sends the library's version and conformance min in its HELLO" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var buf: [16 << 10]u8 = undefined;
    const version = try packageVersion(&buf);
    const defaults = config.Config.init();
    try testing.expectEqualStrings(version, defaults.hello_ver);
    try testing.expectEqualStrings("min", defaults.conformance);

    var pki = try fixture.makePki();
    defer pki.deinit();
    var server: fixture.EchoServer = undefined;
    try fixture.startSilentServer(&server, "127.0.0.1:0", &pki);
    defer server.stop();
    var client = try connectedClient(&server, &pki);
    defer client.deinit();
    try testing.expectError(error.ReceiveTimeout, client.sendHello());

    const deliver_start = nowMs();
    const wire = while (true) {
        const n = server.capturedLen();
        if (n >= 4 and n >= 4 + @as(usize, std.mem.readInt(u32, server.captured[0..4], .big))) break server.captured[0..n];
        if (nowMs() - deliver_start > 30_000) return error.HelloNotDelivered;
        client.pollTransport(10);
    };
    const hello = (try stringField(wire[4..], 1)) orelse return error.NoHello;
    try testing.expectEqualStrings("geode-zig", (try stringField(hello, 4)).?);
    try testing.expectEqualStrings(version, (try stringField(hello, 5)).?);
    try testing.expectEqualStrings("min", (try stringField(hello, 6)).?);
}

/// Accepts one TCP connection, keeps the first gRPC frame it reads, closes.
const CaptureTcpServer = struct {
    fd: std.c.fd_t = -1,
    port: u16 = 0,
    thread: ?std.Thread = null,
    frame: [4096]u8 = undefined,
    frame_len: usize = 0,

    fn start(self: *CaptureTcpServer) !void {
        self.fd = std.c.socket(std.posix.AF.INET, std.posix.SOCK.STREAM, 0);
        if (self.fd < 0) return error.SocketFailed;
        var sa = std.posix.sockaddr.in{ .family = std.posix.AF.INET, .port = 0, .addr = std.mem.nativeToBig(u32, 0x7F000001), .zero = .{0} ** 8 };
        if (std.c.bind(self.fd, @ptrCast(&sa), @sizeOf(std.posix.sockaddr.in)) != 0) return error.BindFailed;
        if (std.c.listen(self.fd, 4) != 0) return error.ListenFailed;
        var len: std.posix.socklen_t = @sizeOf(std.posix.sockaddr.in);
        if (std.c.getsockname(self.fd, @ptrCast(&sa), &len) != 0) return error.GetSockNameFailed;
        self.port = std.mem.bigToNative(u16, sa.port);
        self.thread = try std.Thread.spawn(.{}, run, .{self});
    }

    fn run(self: *CaptureTcpServer) void {
        const conn = std.c.accept(self.fd, null, null);
        if (conn < 0) return;
        defer _ = std.c.close(conn);
        while (self.frame_len < self.frame.len) {
            const n = std.c.read(conn, self.frame[self.frame_len..].ptr, self.frame.len - self.frame_len);
            if (n <= 0) return;
            self.frame_len += @intCast(n);
            if (self.frame_len >= 5 and self.frame_len >= 5 + std.mem.readInt(u32, self.frame[1..5], .big)) return;
        }
    }

    fn deinit(self: *CaptureTcpServer) void {
        if (self.thread) |t| t.join();
        _ = std.c.close(self.fd);
    }
};

test "SONNY-6617: the gRPC HELLO sends the library's version and conformance min" {
    if (builtin.os.tag != .linux) return error.SkipZigTest;
    var buf: [16 << 10]u8 = undefined;
    const version = try packageVersion(&buf);
    var server: CaptureTcpServer = .{};
    try server.start();
    defer server.deinit();

    var cfg = grpc.GrpcConfig.init();
    _ = cfg.withHost("127.0.0.1");
    _ = cfg.withPort(server.port);
    _ = cfg.withTls(false);
    _ = cfg.withTimeout(5000);
    var gc = grpc.GrpcClient.init(testing.allocator, cfg);
    defer gc.deinit();
    try gc.connect();
    // The server closes after the frame: the answer never comes.
    try testing.expect(std.meta.isError(gc.hello("alice", "pw", null, null, null)));
    server.deinit();
    server.thread = null;
    server.fd = -1;

    const frame = server.frame[0..server.frame_len];
    try testing.expect(frame.len >= 5);
    const body = frame[5..];
    const hello = (try stringField(body, 1)) orelse return error.NoHello;
    try testing.expectEqualStrings(version, (try stringField(hello, 5)).?);
    try testing.expectEqualStrings("min", (try stringField(hello, 6)).?);
}
