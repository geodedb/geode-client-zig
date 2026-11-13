// SPDX-License-Identifier: Apache-2.0
//! Owned client certificate and private key for mutual TLS over QUIC.
//!
//! The vendored quic library takes the client identity as DER in
//! `inline_client_cert_der` / `inline_client_priv_key`; those are the fields
//! its client TLS context sends from. `cert_path` / `key_path` are server
//! settings: a non-null `cert_path` makes the endpoint a SERVER. The DER
//! material must outlive the endpoint.
const std = @import("std");
const quic = @import("quic");

pub const max_file_bytes = 1024 * 1024;

pub const ClientIdentity = struct {
    cert_der: []u8,
    key_der: []u8,

    /// Zeroes the key, then frees both.
    pub fn deinit(self: *ClientIdentity, allocator: std.mem.Allocator) void {
        allocator.free(self.cert_der);
        std.crypto.secureZero(u8, self.key_der);
        allocator.free(self.key_der);
        self.* = undefined;
    }
};

/// Load a PEM client certificate and private key (EC, RSA or PKCS#8).
/// null when neither path is given; error.ClientCertificateKeyMismatch when
/// only one is. A missing, unreadable or unparseable file is an error, never
/// a connection without the certificate the caller asked to present.
pub fn load(allocator: std.mem.Allocator, cert_path: ?[]const u8, key_path: ?[]const u8) !?ClientIdentity {
    if ((cert_path == null) != (key_path == null)) return error.ClientCertificateKeyMismatch;
    const cert_p = cert_path orelse return null;
    const io = std.Io.Threaded.global_single_threaded.io();

    const cert_pem = try std.Io.Dir.cwd().readFileAlloc(io, cert_p, allocator, .limited(max_file_bytes));
    defer allocator.free(cert_pem);
    const cert_der = try quic.pem.parseCertificate(allocator, cert_pem);
    errdefer allocator.free(cert_der);
    if (cert_der.len == 0) return error.InvalidClientCertificate;

    const key_pem = try std.Io.Dir.cwd().readFileAlloc(io, key_path.?, allocator, .limited(max_file_bytes));
    defer {
        std.crypto.secureZero(u8, key_pem);
        allocator.free(key_pem);
    }
    const key_der = try quic.pem.parsePrivateKey(allocator, key_pem);
    errdefer {
        std.crypto.secureZero(u8, key_der);
        allocator.free(key_der);
    }
    if (key_der.len == 0) return error.InvalidClientKey;

    return .{ .cert_der = cert_der, .key_der = key_der };
}

/// Put `identity` in the client fields of `cfg`, and clear the server-only
/// `cert_path` / `key_path`.
pub fn apply(cfg: *quic.QuicConfig, identity: ?ClientIdentity) void {
    cfg.cert_path = null;
    cfg.key_path = null;
    cfg.inline_client_cert_der = if (identity) |id| id.cert_der else null;
    cfg.inline_client_priv_key = if (identity) |id| id.key_der else null;
}

// ---------------------------------------------------------------------------
// Tests (real openssl-made certificates; skipped when openssl is absent)
// ---------------------------------------------------------------------------

const Fixture = struct {
    tmp: std.testing.TmpDir,
    dir: []u8,

    fn path(self: *const Fixture, buf: []u8, name: []const u8) []const u8 {
        return std.fmt.bufPrint(buf, "{s}/{s}", .{ self.dir, name }) catch unreachable;
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
    errdefer std.testing.allocator.free(dir);
    const fx = Fixture{ .tmp = tmp, .dir = dir };
    var a: [std.fs.max_path_bytes]u8 = undefined;
    var b: [std.fs.max_path_bytes]u8 = undefined;
    try runOpenssl(&.{ "openssl", "ecparam", "-name", "prime256v1", "-genkey", "-noout", "-out", fx.path(&a, "client.key") });
    try runOpenssl(&.{ "openssl", "req", "-sha256", "-x509", "-new", "-key", fx.path(&a, "client.key"), "-days", "1", "-subj", "/CN=client-identity-test", "-out", fx.path(&b, "client.crt") });
    try runOpenssl(&.{ "openssl", "pkcs8", "-topk8", "-nocrypt", "-in", fx.path(&a, "client.key"), "-out", fx.path(&b, "pkcs8.key") });
    return fx;
}

test "client identity loads PEM certificate and key as DER" {
    const allocator = std.testing.allocator;
    var fx = try makeFixture();
    defer fx.deinit();
    var a: [std.fs.max_path_bytes]u8 = undefined;
    var b: [std.fs.max_path_bytes]u8 = undefined;
    for ([_][]const u8{ "client.key", "pkcs8.key" }) |key_name| {
        var id = (try load(allocator, fx.path(&a, "client.crt"), fx.path(&b, key_name))).?;
        defer id.deinit(allocator);
        // Both decode to a DER SEQUENCE.
        try std.testing.expectEqual(@as(u8, 0x30), id.cert_der[0]);
        try std.testing.expectEqual(@as(u8, 0x30), id.key_der[0]);
    }
}

test "client identity refuses incomplete or unreadable material" {
    const allocator = std.testing.allocator;
    try std.testing.expectEqual(@as(?ClientIdentity, null), try load(allocator, null, null));
    var fx = try makeFixture();
    defer fx.deinit();
    var a: [std.fs.max_path_bytes]u8 = undefined;
    var b: [std.fs.max_path_bytes]u8 = undefined;
    try std.testing.expectError(error.ClientCertificateKeyMismatch, load(allocator, fx.path(&a, "client.crt"), null));
    try std.testing.expectError(error.ClientCertificateKeyMismatch, load(allocator, null, fx.path(&a, "client.key")));
    try std.testing.expectError(error.FileNotFound, load(allocator, fx.path(&a, "missing.crt"), fx.path(&b, "client.key")));
    try std.testing.expectError(error.FileNotFound, load(allocator, fx.path(&a, "client.crt"), fx.path(&b, "missing.key")));
    try std.testing.expectError(error.NoCertificateFound, load(allocator, fx.path(&a, "client.key"), fx.path(&b, "client.key")));
    try std.testing.expectError(error.UnsupportedKeyType, load(allocator, fx.path(&a, "client.crt"), fx.path(&b, "client.crt")));
}
