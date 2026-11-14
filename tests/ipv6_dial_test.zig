// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// SONNY-6494: a GeodeClient reaches a QUIC server on an IPv6 address.
//
// GeodeClient bound its endpoint to 0.0.0.0:0 whatever the destination and
// formatted the dial address as "{host}:{port}" without brackets, so `::1`
// became the unparseable "::1:3141" and an IPv6 server was unreachable.
//
// Each test runs a real QUIC server endpoint from the vendored quic library
// on loopback (a CA-signed certificate made by openssl, carrying IP SANs for
// ::1 and 127.0.0.1) that echoes every byte it reads, and drives the real
// GeodeClient through connect -> sendRawFramed -> receiveRawFrame with
// certificate verification ON. This proves the transport path (endpoint
// family, dial address, TLS name check against an IPv6 IP SAN, stream round
// trip). It does not run a geode server, so HELLO/query handling over IPv6
// is covered by geode's own tests once it pins this library.
//
// Skipped (with a message) when openssl is missing or the host cannot bind
// ::1.

const std = @import("std");
const builtin = @import("builtin");
const geode_client = @import("geode_client");
const quic = @import("quic");
const GeodeClient = geode_client.GeodeClient;

const io = std.Io.Threaded.global_single_threaded.io();

fn runOpenssl(argv: []const []const u8) !void {
    const gpa = std.testing.allocator;
    var threaded = std.Io.Threaded.init(std.heap.smp_allocator, .{});
    defer threaded.deinit();
    const result = try std.process.run(gpa, threaded.io(), .{ .argv = argv });
    defer gpa.free(result.stdout);
    defer gpa.free(result.stderr);
    if (result.term != .exited or result.term.exited != 0) {
        std.debug.print("openssl failed: {s}\n", .{result.stderr});
        return error.OpensslFailed;
    }
}

/// ca.crt (trust anchor), server.crt (signed by ca, SAN IP:::1,
/// IP:127.0.0.1, DNS:localhost, DNS:ip6-localhost), server.key.
const Pki = struct {
    tmp: std.testing.TmpDir,
    dir: []u8,
    ca_path: []u8,
    cert_der: []u8,
    key_der: []u8,

    fn path(self: *const Pki, name: []const u8) ![]u8 {
        return std.fmt.allocPrint(std.testing.allocator, "{s}/{s}", .{ self.dir, name });
    }

    fn deinit(self: *Pki) void {
        const gpa = std.testing.allocator;
        gpa.free(self.cert_der);
        std.crypto.secureZero(u8, self.key_der);
        gpa.free(self.key_der);
        gpa.free(self.ca_path);
        gpa.free(self.dir);
        self.tmp.cleanup();
    }
};

fn makePki() !Pki {
    const gpa = std.testing.allocator;
    runOpenssl(&.{ "openssl", "version" }) catch {
        std.debug.print("SKIP: openssl is not available to make test certificates\n", .{});
        return error.SkipZigTest;
    };
    var tmp = std.testing.tmpDir(.{});
    errdefer tmp.cleanup();
    var cwd_buf: [std.fs.max_path_bytes]u8 = undefined;
    const cwd_len = try std.process.currentPath(io, &cwd_buf);
    const dir = try std.fmt.allocPrint(gpa, "{s}/.zig-cache/tmp/{s}", .{ cwd_buf[0..cwd_len], &tmp.sub_path });
    errdefer gpa.free(dir);
    var pki = Pki{ .tmp = tmp, .dir = dir, .ca_path = undefined, .cert_der = undefined, .key_der = undefined };

    const ca_key = try pki.path("ca.key");
    defer gpa.free(ca_key);
    const ca_crt = try pki.path("ca.crt");
    errdefer gpa.free(ca_crt);
    const srv_key = try pki.path("server.key");
    defer gpa.free(srv_key);
    const srv_crt = try pki.path("server.crt");
    defer gpa.free(srv_crt);
    try runOpenssl(&.{ "openssl", "ecparam", "-name", "prime256v1", "-genkey", "-noout", "-out", ca_key });
    try runOpenssl(&.{ "openssl", "req", "-sha256", "-x509", "-new", "-key", ca_key, "-days", "1", "-subj", "/CN=geode-ipv6-test-ca", "-addext", "basicConstraints=critical,CA:TRUE", "-addext", "keyUsage=critical,keyCertSign,cRLSign", "-out", ca_crt });
    try runOpenssl(&.{ "openssl", "ecparam", "-name", "prime256v1", "-genkey", "-noout", "-out", srv_key });
    // CSR + `x509 -req` rather than `req -x509 -CA`: the latter is OpenSSL 3
    // only, and macOS ships LibreSSL.
    const srv_csr = try pki.path("server.csr");
    defer gpa.free(srv_csr);
    const srv_ext = try pki.path("server.ext");
    defer gpa.free(srv_ext);
    try std.Io.Dir.cwd().writeFile(io, .{
        .sub_path = srv_ext,
        .data = "subjectAltName=IP:::1,IP:127.0.0.1,DNS:localhost,DNS:ip6-localhost\nbasicConstraints=critical,CA:FALSE\n",
    });
    try runOpenssl(&.{ "openssl", "req", "-sha256", "-new", "-key", srv_key, "-subj", "/CN=geode-ipv6-test-server", "-out", srv_csr });
    try runOpenssl(&.{ "openssl", "x509", "-req", "-sha256", "-in", srv_csr, "-CA", ca_crt, "-CAkey", ca_key, "-set_serial", "2", "-days", "1", "-extfile", srv_ext, "-out", srv_crt });

    const crt_pem = try std.Io.Dir.cwd().readFileAlloc(io, srv_crt, gpa, .limited(1024 * 1024));
    defer gpa.free(crt_pem);
    const key_pem = try std.Io.Dir.cwd().readFileAlloc(io, srv_key, gpa, .limited(1024 * 1024));
    defer gpa.free(key_pem);
    pki.cert_der = try quic.pem.parseCertificate(gpa, crt_pem);
    errdefer gpa.free(pki.cert_der);
    pki.key_der = try quic.pem.parsePrivateKey(gpa, key_pem);
    pki.ca_path = ca_crt;
    return pki;
}

/// A QUIC server endpoint on `bind_addr` that echoes every stream byte.
const EchoServer = struct {
    ep: *quic.QuicEndpoint,
    cfg: quic.QuicConfig,
    alloc: std.mem.Allocator,
    done: std.atomic.Value(bool) = .init(false),
    thread: ?std.Thread = null,

    const alpn = [_][]const u8{"geode/1"};

    fn start(self: *EchoServer, bind_addr: []const u8, pki: *const Pki) !void {
        self.alloc = std.testing.allocator;
        self.cfg = .{
            .alpn = &alpn,
            .inline_server_cert_der = pki.cert_der,
            .inline_server_priv_p256 = pki.key_der,
        };
        self.done = .init(false);
        self.ep = try quic.endpointInit(&self.alloc, bind_addr, &self.cfg);
        errdefer quic.endpointDeinit(self.ep);
        self.thread = try std.Thread.spawn(.{}, run, .{self});
    }

    /// The bound UDP port (the quic aggregate module does not re-export
    /// api.getPort, so read the socket the same way it does).
    fn port(self: *EchoServer) u16 {
        const addr = self.ep.transport.getLocalAddr() catch return 0;
        const posix = std.posix;
        return switch (addr.storage.family) {
            posix.AF.INET => std.mem.bigToNative(u16, @as(*const posix.sockaddr.in, @ptrCast(@alignCast(&addr.storage))).port),
            posix.AF.INET6 => std.mem.bigToNative(u16, @as(*const posix.sockaddr.in6, @ptrCast(@alignCast(&addr.storage))).port),
            else => 0,
        };
    }

    fn stop(self: *EchoServer) void {
        self.done.store(true, .release);
        if (self.thread) |t| t.join();
        quic.endpointDeinit(self.ep);
    }

    fn run(self: *EchoServer) void {
        var conns: [8]*quic.QuicConnection = undefined;
        var n_conns: usize = 0;
        var streams: [8]?u64 = .{null} ** 8;
        var buf: [4096]u8 = undefined;
        while (!self.done.load(.acquire)) {
            quic.poll(self.ep, 5) catch {};
            while (quic.tryAccept(self.ep)) |c| {
                if (n_conns == conns.len) break;
                conns[n_conns] = c;
                n_conns += 1;
            }
            for (conns[0..n_conns], 0..) |c, i| {
                if (streams[i] == null and quic.hasIncomingStreams(c)) {
                    streams[i] = quic.acceptStream(c) catch null;
                }
                const sid = streams[i] orelse continue;
                const got = quic.readStream(c, sid, &buf) catch continue;
                var sent: usize = 0;
                while (sent < got and !self.done.load(.acquire)) {
                    const w = quic.writeStream(c, sid, buf[sent..got], false) catch break;
                    if (w == 0) quic.poll(self.ep, 1) catch {};
                    sent += w;
                }
            }
        }
        for (conns[0..n_conns]) |c| quic.destroy(self.ep, c);
    }
};

/// Start an echo server on `bind_addr`, or skip when the host cannot bind it.
fn startServer(server: *EchoServer, bind_addr: []const u8, pki: *const Pki) !void {
    server.start(bind_addr, pki) catch |err| {
        std.debug.print("SKIP: cannot bind a QUIC server on {s} ({s}); the host has no usable address of that family\n", .{ bind_addr, @errorName(err) });
        return error.SkipZigTest;
    };
}

/// connect, send one framed message, read it back.
fn roundTrip(client: *GeodeClient) !void {
    try client.connect();
    const body = "sonny-6494 ipv6 round trip";
    var frame: [4 + body.len]u8 = undefined;
    std.mem.writeInt(u32, frame[0..4], body.len, .big);
    @memcpy(frame[4..], body);
    try client.sendRawFramed(&frame);
    const echoed = try client.receiveRawFrame(std.testing.allocator, 10_000);
    defer std.testing.allocator.free(echoed);
    try std.testing.expectEqualStrings(body, echoed);
}

fn verifyingClient(host: []const u8, port: u16, pki: *const Pki) !GeodeClient {
    var client = try GeodeClient.init(std.testing.allocator, host, port, false, "", "");
    errdefer client.deinit();
    client.ca_cert_path = try std.testing.allocator.dupe(u8, pki.ca_path);
    return client;
}

const Families = struct { ip4: bool, ip6: bool };

/// Which address families `name` resolves to.
fn lookupFamilies(name: []const u8) !Families {
    var threaded: std.Io.Threaded = .init_single_threaded;
    threaded.allocator = std.testing.allocator;
    defer threaded.deinit();
    const tio = threaded.io();
    const host = try std.Io.net.HostName.init(name);
    var storage: [32]std.Io.net.HostName.LookupResult = undefined;
    var results: std.Io.Queue(std.Io.net.HostName.LookupResult) = .init(&storage);
    host.lookup(tio, &results, .{ .port = 0, .family = null }) catch return .{ .ip4 = false, .ip6 = false };
    var out: Families = .{ .ip4 = false, .ip6 = false };
    while (results.getOne(tio)) |r| switch (r) {
        .address => |a| switch (a) {
            .ip4 => out.ip4 = true,
            .ip6 => out.ip6 = true,
        },
        .canonical_name => {},
    } else |_| {}
    return out;
}

test "SONNY-6494: a GeodeClient round-trips over QUIC to a server on [::1]" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var pki = try makePki();
    defer pki.deinit();
    var server: EchoServer = undefined;
    try startServer(&server, "[::1]:0", &pki);
    defer server.stop();

    // Both spellings a caller can hand the client: the DSN form leaves the
    // host unbracketed (parseDSN strips the brackets).
    for ([_][]const u8{ "::1", "[::1]" }) |host| {
        var client = try verifyingClient(host, server.port(), &pki);
        defer client.deinit();
        try roundTrip(&client);
    }
}

test "SONNY-6494: a DSN with an IPv6 host reaches the server" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var pki = try makePki();
    defer pki.deinit();
    var server: EchoServer = undefined;
    try startServer(&server, "[::1]:0", &pki);
    defer server.stop();

    const dsn = try std.fmt.allocPrint(std.testing.allocator, "quic://[::1]:{d}/g?ca={s}", .{ server.port(), pki.ca_path });
    defer std.testing.allocator.free(dsn);
    var cfg = try geode_client.config.parseDSNStrict(std.testing.allocator, dsn);
    defer cfg.deinit(std.testing.allocator);
    var client = try GeodeClient.initFromConfig(std.testing.allocator, cfg);
    defer client.deinit();
    try roundTrip(&client);
}

test "SONNY-6494: an IPv4 destination still works (127.0.0.1)" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var pki = try makePki();
    defer pki.deinit();
    var server: EchoServer = undefined;
    try startServer(&server, "127.0.0.1:0", &pki);
    defer server.stop();
    var client = try verifyingClient("127.0.0.1", server.port(), &pki);
    defer client.deinit();
    try roundTrip(&client);
}

test "SONNY-6494: a host name with only an IPv6 address falls back to IPv6" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    // Debian/Ubuntu /etc/hosts maps ip6-localhost to ::1 only.
    const name = "ip6-localhost";
    const fam = try lookupFamilies(name);
    if (!fam.ip6 or fam.ip4) {
        std.debug.print("SKIP: '{s}' does not resolve to IPv6 only here (ip4={}, ip6={})\n", .{ name, fam.ip4, fam.ip6 });
        return error.SkipZigTest;
    }
    var pki = try makePki();
    defer pki.deinit();
    var server: EchoServer = undefined;
    try startServer(&server, "[::1]:0", &pki);
    defer server.stop();

    var client = try verifyingClient(name, server.port(), &pki);
    defer client.deinit();
    // An endpoint made before the destination is known (the IPv4 guess for
    // a name) is rebuilt for the family the name resolves to.
    try client.ensureEndpoint();
    try roundTrip(&client);
}
