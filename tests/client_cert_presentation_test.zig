// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// SONNY-6457: a GeodeClient given a client certificate and key presents
// them over QUIC.
//
// The vendored quic library takes a client identity as DER in
// `inline_client_cert_der` / `inline_client_priv_key`, the fields its client
// TLS context sends from. `cert_path` is a server setting: a non-null one
// makes the endpoint a SERVER. GeodeClient put the client certificate path
// in `cert_path` and never loaded the certificate, so `geode query
// --client-cert` against an mTLS-required server timed out.
//
// Uses real openssl-made certificates (skipped when openssl is absent) and
// the real vendored endpoint.

const std = @import("std");
const geode_client = @import("geode_client");
const quic = @import("quic");
const GeodeClient = geode_client.GeodeClient;

const Fixture = struct {
    tmp: std.testing.TmpDir,
    dir: []u8,

    fn path(self: *const Fixture, name: []const u8) ![]u8 {
        return std.fmt.allocPrint(std.testing.allocator, "{s}/{s}", .{ self.dir, name });
    }

    fn deinit(self: *Fixture) void {
        std.testing.allocator.free(self.dir);
        self.tmp.cleanup();
    }
};

fn runOpenssl(argv: []const []const u8) !void {
    const gpa = std.testing.allocator;
    var threaded = std.Io.Threaded.init(std.heap.smp_allocator, .{});
    defer threaded.deinit();
    const result = try std.process.run(gpa, threaded.io(), .{ .argv = argv });
    defer gpa.free(result.stdout);
    defer gpa.free(result.stderr);
    if (result.term != .exited or result.term.exited != 0) return error.OpensslFailed;
}

/// client.key (SEC1 EC key), client.crt (self-signed), pkcs8.key (the same
/// key as PKCS#8).
fn makeFixture() !Fixture {
    runOpenssl(&.{ "openssl", "version" }) catch return error.SkipZigTest;
    var tmp = std.testing.tmpDir(.{});
    errdefer tmp.cleanup();
    const io = std.Io.Threaded.global_single_threaded.io();
    var cwd_buf: [std.fs.max_path_bytes]u8 = undefined;
    const cwd_len = try std.process.currentPath(io, &cwd_buf);
    const dir = try std.fmt.allocPrint(std.testing.allocator, "{s}/.zig-cache/tmp/{s}", .{ cwd_buf[0..cwd_len], &tmp.sub_path });
    var fx = Fixture{ .tmp = tmp, .dir = dir };
    errdefer std.testing.allocator.free(fx.dir);
    const key = try fx.path("client.key");
    defer std.testing.allocator.free(key);
    const crt = try fx.path("client.crt");
    defer std.testing.allocator.free(crt);
    const pkcs8 = try fx.path("pkcs8.key");
    defer std.testing.allocator.free(pkcs8);
    try runOpenssl(&.{ "openssl", "ecparam", "-name", "prime256v1", "-genkey", "-noout", "-out", key });
    try runOpenssl(&.{ "openssl", "req", "-sha256", "-x509", "-new", "-key", key, "-days", "1", "-subj", "/CN=geode-client-cert-test", "-out", crt });
    try runOpenssl(&.{ "openssl", "pkcs8", "-topk8", "-nocrypt", "-in", key, "-out", pkcs8 });
    return fx;
}

fn readDer(fx: *const Fixture, name: []const u8, comptime is_key: bool) ![]u8 {
    const p = try fx.path(name);
    defer std.testing.allocator.free(p);
    const io = std.Io.Threaded.global_single_threaded.io();
    const pem = try std.Io.Dir.cwd().readFileAlloc(io, p, std.testing.allocator, .limited(1024 * 1024));
    defer std.testing.allocator.free(pem);
    return if (is_key) quic.pem.parsePrivateKey(std.testing.allocator, pem) else quic.pem.parseCertificate(std.testing.allocator, pem);
}

fn clientWith(fx: *const Fixture, cert: ?[]const u8, key: ?[]const u8) !GeodeClient {
    var client = try GeodeClient.init(std.testing.allocator, "127.0.0.1", 3141, false, "u", "p");
    errdefer client.deinit();
    if (cert) |c| client.client_cert_path = try fx.path(c);
    if (key) |k| client.client_key_path = try fx.path(k);
    return client;
}

test "SONNY-6457: a client certificate keeps the endpoint a client and is carried in the client TLS fields" {
    var fx = try makeFixture();
    defer fx.deinit();
    const cert_der = try readDer(&fx, "client.crt", false);
    defer std.testing.allocator.free(cert_der);

    for ([_][]const u8{ "client.key", "pkcs8.key" }) |key_name| {
        const key_der = try readDer(&fx, key_name, true);
        defer std.testing.allocator.free(key_der);
        var client = try clientWith(&fx, "client.crt", key_name);
        defer client.deinit();
        try client.ensureEndpoint();
        const ep = client.endpoint.?;
        try std.testing.expectEqualStrings("Client", @tagName(ep.role));
        try std.testing.expectEqual(@as(?[]const u8, null), ep.cfg.cert_path);
        try std.testing.expectEqualSlices(u8, cert_der, ep.cfg.inline_client_cert_der orelse return error.ClientCertificateNotLoaded);
        try std.testing.expectEqualSlices(u8, key_der, ep.cfg.inline_client_priv_key orelse return error.ClientKeyNotLoaded);
    }
}

test "SONNY-6457: no client certificate leaves the client TLS fields empty" {
    var fx = try makeFixture();
    defer fx.deinit();
    var client = try clientWith(&fx, null, null);
    defer client.deinit();
    try client.ensureEndpoint();
    try std.testing.expectEqualStrings("Client", @tagName(client.endpoint.?.role));
    try std.testing.expectEqual(@as(?[]const u8, null), client.endpoint.?.cfg.inline_client_cert_der);
    try std.testing.expectEqual(@as(?[]const u8, null), client.endpoint.?.cfg.inline_client_priv_key);
}

test "SONNY-6457: incomplete or unreadable client identity material is refused before an endpoint exists" {
    var fx = try makeFixture();
    defer fx.deinit();
    const Case = struct { cert: ?[]const u8, key: ?[]const u8, want: anyerror };
    const cases = [_]Case{
        .{ .cert = "client.crt", .key = null, .want = error.ClientCertificateKeyMismatch },
        .{ .cert = null, .key = "client.key", .want = error.ClientCertificateKeyMismatch },
        .{ .cert = "missing.crt", .key = "client.key", .want = error.FileNotFound },
        .{ .cert = "client.crt", .key = "missing.key", .want = error.FileNotFound },
        .{ .cert = "client.key", .key = "client.key", .want = error.NoCertificateFound },
        .{ .cert = "client.crt", .key = "client.crt", .want = error.UnsupportedKeyType },
    };
    for (cases) |c| {
        var client = try clientWith(&fx, c.cert, c.key);
        defer client.deinit();
        try std.testing.expectError(c.want, client.ensureEndpoint());
        try std.testing.expectEqual(@as(?*quic.QuicEndpoint, null), client.endpoint);
    }
}
