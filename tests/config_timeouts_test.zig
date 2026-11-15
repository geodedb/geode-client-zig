// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// SONNY-6589: GeodeClient.initFromConfig applies every Config field.
//
// initFromConfig dropped timeout_ms, page_size, tls, hello_name, hello_ver
// and conformance. connect waited a fixed 30 s for the QUIC handshake and
// sendHello a fixed 30 s for the HELLO answer whatever the Config said; a
// gRPC connection chose TLS from `!insecure` instead of `tls`, so
// `?tls=0` could not connect and `?insecure=true` (skip certificate
// verification) silently became plaintext; HELLO fields 4-6 always carried
// the library's own name, version and conformance.
//
// The timeout tests dial real sockets: a UDP socket that never answers (the
// handshake cannot complete) and a QUIC server that completes the handshake
// but never answers the HELLO. The HELLO test reads the bytes that server
// received off the wire. The gRPC tests connect to a real TCP listener.

const std = @import("std");
const builtin = @import("builtin");
const geode_client = @import("geode_client");
const fixture = @import("quic_echo_fixture.zig");
const config = geode_client.config;
const GeodeClient = geode_client.GeodeClient;

const testing = std.testing;
const io = std.Io.Threaded.global_single_threaded.io();

fn nowMs() i64 {
    return std.Io.Clock.awake.now(io).toMilliseconds();
}

/// The elapsed time of a wait bounded by a 500 ms timeout: at least the
/// timeout, and far below the old fixed 30 s (slack for a loaded runner).
fn expectAboutHalfSecond(elapsed_ms: i64) !void {
    if (elapsed_ms < 450 or elapsed_ms > 10_000) {
        std.debug.print("waited {d} ms, want about 500 ms (timeout_ms=500)\n", .{elapsed_ms});
        return error.TimeoutNotApplied;
    }
}

test "SONNY-6589: initFromConfig copies timeout_ms, page_size, tls and the HELLO strings" {
    var cfg = try config.parseDSNStrict(testing.allocator, "grpc://127.0.0.1:50051?timeout_ms=1234&page_size=77&tls=0&hello_name=my-app&hello_ver=9.9.9&conformance=full");
    var client = try GeodeClient.initFromConfig(testing.allocator, cfg);
    defer client.deinit();
    // The client keeps its own copies: the Config's decoded strings are gone.
    cfg.deinit(testing.allocator);

    try testing.expectEqual(@as(u32, 1234), client.timeout_ms);
    try testing.expectEqual(@as(u32, 77), client.page_size);
    try testing.expect(!client.tls.?);
    try testing.expectEqualStrings("my-app", client.hello_name.?);
    try testing.expectEqualStrings("9.9.9", client.hello_ver.?);
    try testing.expectEqualStrings("full", client.conformance.?);
}

test "SONNY-6589: a client built in code keeps the defaults" {
    var client = try GeodeClient.init(testing.allocator, "127.0.0.1", 3141, true, "", "");
    defer client.deinit();
    try testing.expectEqual(config.DEFAULT_TIMEOUT_MS, client.timeout_ms);
    try testing.expectEqual(config.DEFAULT_PAGE_SIZE, client.page_size);
    try testing.expectEqual(@as(?bool, null), client.tls);
    try testing.expectEqual(@as(?[]const u8, null), client.hello_name);
    try testing.expectEqual(@as(?[]const u8, null), client.hello_ver);
    try testing.expectEqual(@as(?[]const u8, null), client.conformance);
}

fn initFromConfigThenDeinit(allocator: std.mem.Allocator, cfg: config.Config) !void {
    var client = try GeodeClient.initFromConfig(allocator, cfg);
    client.deinit();
}

test "SONNY-6589: initFromConfig frees what it copied when a later copy fails" {
    var cfg = try config.parseDSNStrict(testing.allocator, "quic://u:p@127.0.0.1:3141/g?tenant=t&role=r&ca=/ca.pem&cert=/c.pem&key=/k.pem&server_name=s&hello_name=n&hello_ver=v&conformance=c");
    defer cfg.deinit(testing.allocator);
    try testing.checkAllAllocationFailures(testing.allocator, initFromConfigThenDeinit, .{cfg});
}

test "SONNY-6589: connect gives up after Config.timeout_ms when the server never answers" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    // A real UDP socket that receives the client's Initial packets and never
    // replies: the handshake cannot complete.
    const any = try std.Io.net.IpAddress.parse("127.0.0.1", 0);
    const sink = try any.bind(io, .{ .mode = .dgram });
    defer sink.close(io);

    const dsn = try std.fmt.allocPrint(testing.allocator, "quic://127.0.0.1:{d}?insecure=true&timeout_ms=500", .{sink.address.getPort()});
    defer testing.allocator.free(dsn);
    var cfg = try config.parseDSNStrict(testing.allocator, dsn);
    defer cfg.deinit(testing.allocator);
    var client = try GeodeClient.initFromConfig(testing.allocator, cfg);
    defer client.deinit();

    const start = nowMs();
    try testing.expectError(error.ConnectionTimeout, client.connect());
    try expectAboutHalfSecond(nowMs() - start);
}

test "SONNY-6589: connect refuses a timeout_ms outside 1..3600000" {
    for ([_]u32{ 0, 3_600_001 }) |ms| {
        var cfg = config.Config.init();
        cfg.host = "127.0.0.1";
        cfg.insecure = true;
        cfg.timeout_ms = ms;
        var client = try GeodeClient.initFromConfig(testing.allocator, cfg);
        defer client.deinit();
        try testing.expectError(error.InvalidTimeout, client.connect());
    }
    // SONNY-6617: the lenient parser no longer keeps a 0 it reads; it falls
    // back to the default, as documented (tests/request_timeouts_test.zig),
    // so only a Config built in code reaches connect's InvalidTimeout.
    var cfg = try config.parseDSN(testing.allocator, "quic://127.0.0.1:3141?timeout_ms=0");
    defer cfg.deinit(testing.allocator);
    try testing.expectEqual(config.DEFAULT_TIMEOUT_MS, cfg.timeout_ms);
}

/// The length-delimited fields of one protobuf message, by field number.
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

test "SONNY-6589: sendHello waits Config.timeout_ms and sends the configured HELLO name, version and conformance" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var pki = try fixture.makePki();
    defer pki.deinit();
    var server: fixture.EchoServer = undefined;
    try fixture.startSilentServer(&server, "127.0.0.1:0", &pki);
    defer server.stop();

    const dsn = try std.fmt.allocPrint(testing.allocator, "quic://alice:pw@127.0.0.1:{d}?ca={s}&timeout_ms=500&hello_name=my-app&hello_ver=9.9.9&conformance=full", .{ server.port(), pki.ca_path });
    defer testing.allocator.free(dsn);
    var cfg = try config.parseDSNStrict(testing.allocator, dsn);
    defer cfg.deinit(testing.allocator);
    var client = try GeodeClient.initFromConfig(testing.allocator, cfg);
    defer client.deinit();
    try testing.expectEqual(@as(u32, 500), client.timeout_ms);

    // timeout_ms bounds the handshake as well; a loaded runner can take more
    // than 500 ms to finish one (the connect bound is proven against a socket
    // that never answers above). Give the handshake a generous budget, then
    // restore the configured 500 ms so only the HELLO wait is measured.
    client.timeout_ms = 60_000;
    try client.connect();
    client.timeout_ms = cfg.timeout_ms;
    const start = nowMs();
    try testing.expectError(error.ReceiveTimeout, client.sendHello());
    try expectAboutHalfSecond(nowMs() - start);

    // [u32 length][QuicClientMessage { hello = 1: HelloRequest }]. Drive the
    // client until the server has read the whole frame (a loaded runner may
    // not have delivered it within the 500 ms HELLO wait).
    const deliver_start = nowMs();
    const wire = while (true) {
        const n = server.capturedLen();
        if (n >= 4 and n >= 4 + @as(usize, std.mem.readInt(u32, server.captured[0..4], .big))) break server.captured[0..n];
        if (nowMs() - deliver_start > 30_000) return error.HelloNotDelivered;
        client.pollTransport(10);
    };
    const frame_len = std.mem.readInt(u32, wire[0..4], .big);
    try testing.expectEqual(@as(usize, 4 + frame_len), wire.len);
    const hello = (try stringField(wire[4..], 1)) orelse return error.NoHello;
    try testing.expectEqualStrings("alice", (try stringField(hello, 1)).?);
    try testing.expectEqualStrings("my-app", (try stringField(hello, 4)).?);
    try testing.expectEqualStrings("9.9.9", (try stringField(hello, 5)).?);
    try testing.expectEqualStrings("full", (try stringField(hello, 6)).?);
}

/// A loopback TCP listener; connect completes from the kernel backlog.
fn listenTcp() !std.Io.net.Server {
    const any = try std.Io.net.IpAddress.parse("127.0.0.1", 0);
    return any.listen(io, .{});
}

test "SONNY-6589: a gRPC Config with tls=0 connects in plaintext" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var listener = try listenTcp();
    defer listener.deinit(io);
    const dsn = try std.fmt.allocPrint(testing.allocator, "grpc://127.0.0.1:{d}?tls=0", .{listener.socket.address.getPort()});
    defer testing.allocator.free(dsn);
    var cfg = try config.parseDSNStrict(testing.allocator, dsn);
    defer cfg.deinit(testing.allocator);
    var client = try GeodeClient.initFromConfig(testing.allocator, cfg);
    defer client.deinit();
    try client.connect();
    try testing.expect(client.grpc_client.?.connected);
}

test "SONNY-6589: a gRPC Config with insecure=true keeps TLS on (no plaintext downgrade)" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var listener = try listenTcp();
    defer listener.deinit(io);
    const dsn = try std.fmt.allocPrint(testing.allocator, "grpc://127.0.0.1:{d}?insecure=true", .{listener.socket.address.getPort()});
    defer testing.allocator.free(dsn);
    var cfg = try config.parseDSNStrict(testing.allocator, dsn);
    defer cfg.deinit(testing.allocator);
    var client = try GeodeClient.initFromConfig(testing.allocator, cfg);
    defer client.deinit();
    // TLS is asked for and the gRPC transport has no TLS yet: refused, never
    // sent in the clear.
    try testing.expectError(error.TlsNotImplemented, client.connect());
}
