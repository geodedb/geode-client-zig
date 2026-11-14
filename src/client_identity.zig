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
/// null when neither path is given; error.ClientKeyMissing for a
/// certificate without its key and error.ClientCertificateMissing for a key
/// without its certificate, before any file is opened. A missing or
/// unreadable file keeps its filesystem error (FileNotFound, AccessDenied,
/// ...); a certificate file without a certificate is NoCertificateFound, a
/// key file without a supported key is UnsupportedKeyType, a damaged key is
/// InvalidClientKey, and a file over max_file_bytes is StreamTooLong. Never
/// a connection without the certificate the caller asked to present.
///
/// SONNY-6494: both files are read, and the key decoded, through an
/// allocator that zeroes every buffer it frees, so no copy of the key (the
/// file text, a buffer outgrown while reading, the base64 body, a partial
/// decode) is left in freed memory on any path. A key file given as the
/// certificate is read the same way.
pub fn load(allocator: std.mem.Allocator, cert_path: ?[]const u8, key_path: ?[]const u8) !?ClientIdentity {
    if (cert_path != null and key_path == null) return error.ClientKeyMissing;
    if (cert_path == null and key_path != null) return error.ClientCertificateMissing;
    const cert_p = cert_path orelse return null;
    const io = std.Io.Threaded.global_single_threaded.io();
    var zeroing: ZeroingAllocator = .{ .child = allocator };
    const zalloc = zeroing.allocator();

    const cert_pem = try std.Io.Dir.cwd().readFileAlloc(io, cert_p, zalloc, .limited(max_file_bytes));
    defer zalloc.free(cert_pem);
    const cert_der = try quic.pem.parseCertificate(allocator, cert_pem);
    errdefer allocator.free(cert_der);
    if (cert_der.len == 0) return error.InvalidClientCertificate;

    const key_pem = try std.Io.Dir.cwd().readFileAlloc(io, key_path.?, zalloc, .limited(max_file_bytes));
    defer zalloc.free(key_pem);
    const key_der = try decodePrivateKeyPem(zalloc, key_pem);
    return .{ .cert_der = cert_der, .key_der = key_der };
}

/// The PEM labels quic.pem.parsePrivateKey accepts, in its order: SEC1 EC,
/// PKCS#1 RSA, PKCS#8.
const key_labels = [_][]const u8{ "EC PRIVATE KEY", "RSA PRIVATE KEY", "PRIVATE KEY" };

/// Decode the first supported private key block of `pem` to DER. Every
/// intermediate buffer comes from (and returns to) `zalloc`, which zeroes
/// what it frees; quic.pem.parsePrivateKey frees its base64 copy without
/// zeroing and leaks its output when the base64 does not decode.
fn decodePrivateKeyPem(zalloc: std.mem.Allocator, pem: []const u8) ![]u8 {
    inline for (key_labels) |label| {
        const begin = "-----BEGIN " ++ label ++ "-----";
        const end = "-----END " ++ label ++ "-----";
        if (std.mem.indexOf(u8, pem, begin)) |start| {
            const body = pem[start + begin.len ..];
            const body_len = std.mem.indexOf(u8, body, end) orelse return error.InvalidClientKey;
            return decodeBase64Body(zalloc, body[0..body_len]);
        }
    }
    return error.UnsupportedKeyType;
}

fn decodeBase64Body(zalloc: std.mem.Allocator, body: []const u8) ![]u8 {
    const b64 = try zalloc.alloc(u8, body.len);
    defer zalloc.free(b64);
    var n: usize = 0;
    for (body) |c| switch (c) {
        '\n', '\r', ' ', '\t' => {},
        else => {
            b64[n] = c;
            n += 1;
        },
    };
    if (n == 0) return error.InvalidClientKey;
    const decoder = std.base64.standard.Decoder;
    const der_len = decoder.calcSizeForSlice(b64[0..n]) catch return error.InvalidClientKey;
    const der = try zalloc.alloc(u8, der_len);
    errdefer zalloc.free(der);
    decoder.decode(der, b64[0..n]) catch return error.InvalidClientKey;
    if (der.len == 0) return error.InvalidClientKey;
    return der;
}

/// Forwards to `child` and zeroes every buffer before freeing it. Shrinking
/// in place and remap are declined, so a buffer that moves or shrinks is
/// copied and its old memory comes back through `free`.
const ZeroingAllocator = struct {
    child: std.mem.Allocator,

    fn allocator(self: *ZeroingAllocator) std.mem.Allocator {
        return .{ .ptr = self, .vtable = &.{ .alloc = alloc, .resize = resize, .remap = remap, .free = free } };
    }

    fn alloc(ctx: *anyopaque, len: usize, alignment: std.mem.Alignment, ra: usize) ?[*]u8 {
        const self: *ZeroingAllocator = @ptrCast(@alignCast(ctx));
        return self.child.rawAlloc(len, alignment, ra);
    }

    fn resize(ctx: *anyopaque, memory: []u8, alignment: std.mem.Alignment, new_len: usize, ra: usize) bool {
        const self: *ZeroingAllocator = @ptrCast(@alignCast(ctx));
        if (new_len < memory.len) return false;
        return self.child.rawResize(memory, alignment, new_len, ra);
    }

    fn remap(_: *anyopaque, _: []u8, _: std.mem.Alignment, _: usize, _: usize) ?[*]u8 {
        return null;
    }

    fn free(ctx: *anyopaque, memory: []u8, alignment: std.mem.Alignment, ra: usize) void {
        const self: *ZeroingAllocator = @ptrCast(@alignCast(ctx));
        std.crypto.secureZero(u8, memory);
        self.child.rawFree(memory, alignment, ra);
    }
};

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

fn runCmd(argv: []const []const u8) !void {
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
    runCmd(&.{ "openssl", "version" }) catch return error.SkipZigTest;
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
    try runCmd(&.{ "openssl", "ecparam", "-name", "prime256v1", "-genkey", "-noout", "-out", fx.path(&a, "client.key") });
    try runCmd(&.{ "openssl", "req", "-sha256", "-x509", "-new", "-key", fx.path(&a, "client.key"), "-days", "1", "-subj", "/CN=client-identity-test", "-out", fx.path(&b, "client.crt") });
    try runCmd(&.{ "openssl", "pkcs8", "-topk8", "-nocrypt", "-in", fx.path(&a, "client.key"), "-out", fx.path(&b, "pkcs8.key") });
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
    try std.testing.expectError(error.ClientKeyMissing, load(allocator, fx.path(&a, "client.crt"), null));
    try std.testing.expectError(error.ClientCertificateMissing, load(allocator, null, fx.path(&a, "client.key")));
    try std.testing.expectError(error.FileNotFound, load(allocator, fx.path(&a, "missing.crt"), fx.path(&b, "client.key")));
    try std.testing.expectError(error.FileNotFound, load(allocator, fx.path(&a, "client.crt"), fx.path(&b, "missing.key")));
    try std.testing.expectError(error.NoCertificateFound, load(allocator, fx.path(&a, "client.key"), fx.path(&b, "client.key")));
    try std.testing.expectError(error.UnsupportedKeyType, load(allocator, fx.path(&a, "client.crt"), fx.path(&b, "client.crt")));
}

// SONNY-6494: each kind of bad identity input fails with its own error
// before any endpoint exists, and no copy of the private key is left in
// freed memory on any path.

/// Wraps the testing allocator and counts freed buffers that still hold key
/// material (any of `needles`). Shrinking in place is refused and remap is
/// declined, so every buffer the code under test gives back passes `free`.
const FreedKeyScanner = struct {
    child: std.mem.Allocator,
    needles: []const []const u8,
    hits: usize = 0,

    fn allocator(self: *FreedKeyScanner) std.mem.Allocator {
        return .{ .ptr = self, .vtable = &.{ .alloc = alloc, .resize = resize, .remap = remap, .free = free } };
    }

    fn alloc(ctx: *anyopaque, len: usize, alignment: std.mem.Alignment, ra: usize) ?[*]u8 {
        const self: *FreedKeyScanner = @ptrCast(@alignCast(ctx));
        return self.child.rawAlloc(len, alignment, ra);
    }

    fn resize(ctx: *anyopaque, memory: []u8, alignment: std.mem.Alignment, new_len: usize, ra: usize) bool {
        const self: *FreedKeyScanner = @ptrCast(@alignCast(ctx));
        if (new_len < memory.len) return false;
        return self.child.rawResize(memory, alignment, new_len, ra);
    }

    fn remap(_: *anyopaque, _: []u8, _: std.mem.Alignment, _: usize, _: usize) ?[*]u8 {
        return null;
    }

    fn free(ctx: *anyopaque, memory: []u8, alignment: std.mem.Alignment, ra: usize) void {
        const self: *FreedKeyScanner = @ptrCast(@alignCast(ctx));
        for (self.needles) |needle| {
            if (std.mem.indexOf(u8, memory, needle) != null) {
                self.hits += 1;
                break;
            }
        }
        self.child.rawFree(memory, alignment, ra);
    }
};

/// The material a leaked key copy would contain: the PEM label, a line of
/// the base64 body, and the start of the DER encoding.
const KeyNeedles = struct {
    body_line: [48]u8,
    der_prefix: [32]u8,

    fn init(fx: *const Fixture) !KeyNeedles {
        const gpa = std.testing.allocator;
        const io = std.Io.Threaded.global_single_threaded.io();
        var a: [std.fs.max_path_bytes]u8 = undefined;
        const pem = try std.Io.Dir.cwd().readFileAlloc(io, fx.path(&a, "client.key"), gpa, .limited(max_file_bytes));
        defer gpa.free(pem);
        var out: KeyNeedles = undefined;
        const body = pem[(std.mem.indexOfScalar(u8, pem, '\n') orelse return error.BadFixture) + 1 ..];
        @memcpy(&out.body_line, body[0..out.body_line.len]);
        const der = try quic.pem.parsePrivateKey(gpa, pem);
        defer gpa.free(der);
        @memcpy(&out.der_prefix, der[0..out.der_prefix.len]);
        return out;
    }

    fn list(self: *const KeyNeedles) [3][]const u8 {
        return .{ "PRIVATE KEY", &self.body_line, &self.der_prefix };
    }
};

/// Write `name` in the fixture directory.
fn writeFixtureFile(fx: *const Fixture, name: []const u8, data: []const u8) !void {
    const io = std.Io.Threaded.global_single_threaded.io();
    var a: [std.fs.max_path_bytes]u8 = undefined;
    try std.Io.Dir.cwd().writeFile(io, .{ .sub_path = fx.path(&a, name), .data = data });
}

/// corrupt.key: client.key with one base64 character in the middle of the
/// body replaced; big.key: client.key followed by more than max_file_bytes
/// of comment lines; noread.key: client.key, mode 000.
fn addBadKeys(fx: *const Fixture) !void {
    const gpa = std.testing.allocator;
    const io = std.Io.Threaded.global_single_threaded.io();
    var a: [std.fs.max_path_bytes]u8 = undefined;
    const pem = try std.Io.Dir.cwd().readFileAlloc(io, fx.path(&a, "client.key"), gpa, .limited(max_file_bytes));
    defer gpa.free(pem);

    const corrupt = try gpa.dupe(u8, pem);
    defer gpa.free(corrupt);
    const body_start = (std.mem.indexOfScalar(u8, corrupt, '\n') orelse return error.BadFixture) + 1;
    corrupt[body_start + 40] = '!';
    try writeFixtureFile(fx, "corrupt.key", corrupt);

    const big = try gpa.alloc(u8, pem.len + max_file_bytes + 4096);
    defer gpa.free(big);
    @memcpy(big[0..pem.len], pem);
    @memset(big[pem.len..], '#');
    var i: usize = pem.len + 63;
    while (i < big.len) : (i += 64) big[i] = '\n';
    try writeFixtureFile(fx, "big.key", big);

    try writeFixtureFile(fx, "noread.key", pem);
    var b: [std.fs.max_path_bytes]u8 = undefined;
    try runCmd(&.{ "chmod", "000", fx.path(&b, "noread.key") });
}

test "SONNY-6494: a missing half of the identity is named, before any file is read" {
    const allocator = std.testing.allocator;
    var fx = try makeFixture();
    defer fx.deinit();
    var a: [std.fs.max_path_bytes]u8 = undefined;
    // Even an unreadable path is not opened: the pairing is checked first.
    try std.testing.expectError(error.ClientKeyMissing, load(allocator, fx.path(&a, "missing.crt"), null));
    try std.testing.expectError(error.ClientCertificateMissing, load(allocator, null, fx.path(&a, "missing.key")));
}

test "SONNY-6494: bad identity files fail with distinct errors and leave no key material in freed memory" {
    var fx = try makeFixture();
    defer fx.deinit();
    try addBadKeys(&fx);
    const needles = try KeyNeedles.init(&fx);
    const needle_list = needles.list();

    const Case = struct { cert: []const u8, key: []const u8, want: anyerror };
    const cases = [_]Case{
        // unreadable
        .{ .cert = "missing.crt", .key = "client.key", .want = error.FileNotFound },
        .{ .cert = "client.crt", .key = "missing.key", .want = error.FileNotFound },
        .{ .cert = "client.crt", .key = "noread.key", .want = error.AccessDenied },
        // wrong PEM type: a key where the certificate belongs (the key text
        // passes through the certificate reader) and the reverse
        .{ .cert = "client.key", .key = "client.key", .want = error.NoCertificateFound },
        .{ .cert = "pkcs8.key", .key = "client.key", .want = error.NoCertificateFound },
        .{ .cert = "client.crt", .key = "client.crt", .want = error.UnsupportedKeyType },
        // a damaged key, and a key file over the size limit
        .{ .cert = "client.crt", .key = "corrupt.key", .want = error.InvalidClientKey },
        .{ .cert = "client.crt", .key = "big.key", .want = error.StreamTooLong },
    };
    var a: [std.fs.max_path_bytes]u8 = undefined;
    var b: [std.fs.max_path_bytes]u8 = undefined;
    for (cases) |c| {
        var scanner: FreedKeyScanner = .{ .child = std.testing.allocator, .needles = &needle_list };
        const got = load(scanner.allocator(), fx.path(&a, c.cert), fx.path(&b, c.key));
        if (std.mem.eql(u8, c.key, "noread.key")) {
            // root reads a mode-000 file; nothing to prove there.
            if (got) |maybe| if (maybe) |id| {
                var owned = id;
                owned.deinit(scanner.allocator());
                continue;
            } else {} else |_| {}
        }
        std.testing.expectError(c.want, got) catch |err| {
            std.debug.print("cert={s} key={s}: want {s}\n", .{ c.cert, c.key, @errorName(c.want) });
            return err;
        };
        if (scanner.hits != 0) {
            std.debug.print("cert={s} key={s}: {d} freed buffer(s) still held key material\n", .{ c.cert, c.key, scanner.hits });
            return error.KeyMaterialNotZeroed;
        }
    }
}

test "SONNY-6494: a loaded identity leaves no key material in freed memory" {
    var fx = try makeFixture();
    defer fx.deinit();
    const needles = try KeyNeedles.init(&fx);
    const needle_list = needles.list();
    var a: [std.fs.max_path_bytes]u8 = undefined;
    var b: [std.fs.max_path_bytes]u8 = undefined;
    for ([_][]const u8{ "client.key", "pkcs8.key" }) |key_name| {
        var scanner: FreedKeyScanner = .{ .child = std.testing.allocator, .needles = &needle_list };
        var id = (try load(scanner.allocator(), fx.path(&a, "client.crt"), fx.path(&b, key_name))).?;
        if (scanner.hits != 0) {
            std.debug.print("{s}: loading left {d} freed buffer(s) holding key material\n", .{ key_name, scanner.hits });
            return error.KeyMaterialNotZeroed;
        }
        id.deinit(scanner.allocator());
        if (scanner.hits != 0) return error.KeyMaterialNotZeroed;
    }
}
