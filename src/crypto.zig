// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Field-level encryption for Geode node/edge properties. Ported from
// geode-client-go crypto/cipher.go. AES-256-GCM authenticated encryption
// with HKDF-SHA256 key derivation and HMAC-SHA256 deterministic hashing.
//
// SECURITY: Derived key material is securely zeroed on deinit (CWE-316).
// FIPS: all crypto ops route through the crypto_backend seam; under
// -Dfips=true they execute on the OpenSSL FIPS provider; under
// -Dfips=false they use the std.crypto shim. The on-disk/wire format
// (nonce(12) || ciphertext || tag(16), base64, hex HMAC) is unchanged.

const std = @import("std");
const cb = @import("crypto_backend");

/// AES-256 key size in bytes.
pub const KEY_SIZE: usize = 32;
/// AES-GCM nonce size in bytes.
pub const NONCE_SIZE: usize = 12;
/// AES-GCM authentication tag size in bytes.
pub const TAG_SIZE: usize = 16;

/// Errors returned by the crypto module.
pub const CryptoError = error{
    /// Master key was shorter than KEY_SIZE bytes.
    MasterKeyTooShort,
    /// Ciphertext was shorter than the minimum (nonce + tag).
    CiphertextTooShort,
    /// GCM authentication failed (tampered or wrong key).
    AuthenticationFailed,
    /// Base64 decoding failed.
    InvalidBase64,
};

/// Derive a KEY_SIZE-byte subkey from `master_key` using HKDF-SHA256 with
/// the given info label (no salt, matching the Go driver).
fn deriveKey(master_key: []const u8, info: []const u8) (cb.Kdf.Error || CryptoError)![KEY_SIZE]u8 {
    var out: [KEY_SIZE]u8 = undefined;
    try cb.Kdf.hkdf(.sha256, master_key, &[_]u8{}, info, &out);
    return out;
}

/// Holds derived encryption and HMAC keys for field-level encryption.
pub const Cipher = struct {
    enc_key: [KEY_SIZE]u8,
    hmac_key: [KEY_SIZE]u8,

    const Self = @This();

    /// Create a Cipher from a master key (>= KEY_SIZE bytes). Derives
    /// separate AES and HMAC keys via HKDF-SHA256.
    pub fn init(master_key: []const u8) (CryptoError || cb.Kdf.Error)!Self {
        if (master_key.len < KEY_SIZE) return CryptoError.MasterKeyTooShort;
        return .{
            .enc_key = try deriveKey(master_key, "geode-encrypt"),
            .hmac_key = try deriveKey(master_key, "geode-hmac"),
        };
    }

    /// SECURITY: Securely zero derived key material (CWE-316).
    pub fn deinit(self: *Self) void {
        cb.secureZero(&self.enc_key);
        cb.secureZero(&self.hmac_key);
    }

    /// Encrypt `plaintext` with AES-256-GCM and a random nonce. Output layout
    /// is nonce(12) || ciphertext || tag(16). Caller owns the returned slice.
    pub fn encrypt(self: *const Self, allocator: std.mem.Allocator, plaintext: []const u8) (std.mem.Allocator.Error || cb.Csprng.Error || cb.Aead.Error)![]u8 {
        const out = try allocator.alloc(u8, NONCE_SIZE + plaintext.len + TAG_SIZE);
        errdefer allocator.free(out);
        var nonce: [NONCE_SIZE]u8 = undefined;
        // Fill the GCM nonce from the FIPS DRBG (under -Dfips=true) or from
        // OS entropy via the seam CSPRNG. A unique nonce per encryption under
        // the same key is mandatory for AES-GCM security.
        try cb.Csprng.bytes(&nonce);
        @memcpy(out[0..NONCE_SIZE], &nonce);
        const ct = out[NONCE_SIZE .. NONCE_SIZE + plaintext.len];
        var tag: [TAG_SIZE]u8 = undefined;
        try cb.Aead.seal(.aes_256_gcm, &self.enc_key, &nonce, &[_]u8{}, plaintext, ct, &tag);
        @memcpy(out[NONCE_SIZE + plaintext.len ..], &tag);
        return out;
    }

    /// Decrypt a ciphertext produced by `encrypt`. Returns AuthenticationFailed
    /// on tamper/wrong key, CiphertextTooShort on undersized input. Caller owns
    /// the returned slice.
    pub fn decrypt(self: *const Self, allocator: std.mem.Allocator, ciphertext: []const u8) (CryptoError || std.mem.Allocator.Error)![]u8 {
        if (ciphertext.len < NONCE_SIZE + TAG_SIZE) return CryptoError.CiphertextTooShort;
        var nonce: [NONCE_SIZE]u8 = undefined;
        @memcpy(&nonce, ciphertext[0..NONCE_SIZE]);
        const ct = ciphertext[NONCE_SIZE .. ciphertext.len - TAG_SIZE];
        var tag: [TAG_SIZE]u8 = undefined;
        @memcpy(&tag, ciphertext[ciphertext.len - TAG_SIZE ..]);
        const pt = try allocator.alloc(u8, ct.len);
        cb.Aead.open(.aes_256_gcm, &self.enc_key, &nonce, &[_]u8{}, ct, &tag, pt) catch {
            allocator.free(pt);
            return CryptoError.AuthenticationFailed;
        };
        return pt;
    }

    /// Encrypt `plaintext` and return a standard-base64-encoded string.
    pub fn encryptString(self: *const Self, allocator: std.mem.Allocator, plaintext: []const u8) (std.mem.Allocator.Error || cb.Csprng.Error || cb.Aead.Error)![]u8 {
        const ct = try self.encrypt(allocator, plaintext);
        defer allocator.free(ct);
        const enc = std.base64.standard.Encoder;
        const buf = try allocator.alloc(u8, enc.calcSize(ct.len));
        errdefer allocator.free(buf);
        _ = enc.encode(buf, ct);
        return buf;
    }

    /// Base64-decode then decrypt, returning the original plaintext.
    pub fn decryptString(self: *const Self, allocator: std.mem.Allocator, encoded: []const u8) (CryptoError || std.mem.Allocator.Error)![]u8 {
        const dec = std.base64.standard.Decoder;
        const n = dec.calcSizeForSlice(encoded) catch return CryptoError.InvalidBase64;
        const raw = try allocator.alloc(u8, n);
        defer allocator.free(raw);
        dec.decode(raw, encoded) catch return CryptoError.InvalidBase64;
        return self.decrypt(allocator, raw);
    }

    /// Compute HMAC-SHA256 of `data` with the derived HMAC key and return a
    /// 64-character lowercase hex digest. Caller owns the returned slice.
    pub fn hmacHex(self: *const Self, allocator: std.mem.Allocator, data: []const u8) (std.mem.Allocator.Error || cb.Mac.Error)![]u8 {
        var mac: [32]u8 = undefined;
        _ = try cb.Mac.hmac(.sha256, &self.hmac_key, data, &mac);
        const out = try allocator.alloc(u8, mac.len * 2);
        errdefer allocator.free(out);
        const hex = "0123456789abcdef";
        for (mac, 0..) |byte, i| {
            out[i * 2] = hex[byte >> 4];
            out[i * 2 + 1] = hex[byte & 0x0f];
        }
        return out;
    }
};

test "Cipher rejects short master key" {
    try std.testing.expectError(CryptoError.MasterKeyTooShort, Cipher.init("too short"));
}

test "Cipher encrypt/decrypt round-trips" {
    const a = std.testing.allocator;
    const master = [_]u8{0x42} ** 48;
    var c = try Cipher.init(&master);
    defer c.deinit();

    const plaintext = "sensitive value 123";
    const ct = try c.encrypt(a, plaintext);
    defer a.free(ct);
    try std.testing.expect(ct.len == NONCE_SIZE + plaintext.len + TAG_SIZE);

    const pt = try c.decrypt(a, ct);
    defer a.free(pt);
    try std.testing.expectEqualStrings(plaintext, pt);
}

test "Cipher encryptString/decryptString round-trips via base64" {
    const a = std.testing.allocator;
    const master = [_]u8{0x07} ** 32;
    var c = try Cipher.init(&master);
    defer c.deinit();

    const enc = try c.encryptString(a, "hello@example.com");
    defer a.free(enc);
    // base64 has no non-base64 chars
    for (enc) |ch| {
        const ok = std.ascii.isAlphanumeric(ch) or ch == '+' or ch == '/' or ch == '=';
        try std.testing.expect(ok);
    }
    const dec = try c.decryptString(a, enc);
    defer a.free(dec);
    try std.testing.expectEqualStrings("hello@example.com", dec);
}

test "Cipher decrypt rejects tampered ciphertext" {
    const a = std.testing.allocator;
    const master = [_]u8{0x11} ** 32;
    var c = try Cipher.init(&master);
    defer c.deinit();

    const ct = try c.encrypt(a, "data");
    defer a.free(ct);
    ct[ct.len - 1] ^= 0xFF; // flip a tag byte
    try std.testing.expectError(CryptoError.AuthenticationFailed, c.decrypt(a, ct));
}

test "Cipher decrypt rejects too-short input" {
    const a = std.testing.allocator;
    const master = [_]u8{0x11} ** 32;
    var c = try Cipher.init(&master);
    defer c.deinit();
    try std.testing.expectError(CryptoError.CiphertextTooShort, c.decrypt(a, "short"));
}

test "Cipher hmacHex is deterministic and 64 hex chars" {
    const a = std.testing.allocator;
    const master = [_]u8{0x99} ** 32;
    var c = try Cipher.init(&master);
    defer c.deinit();

    const h1 = try c.hmacHex(a, "email@example.com");
    defer a.free(h1);
    const h2 = try c.hmacHex(a, "email@example.com");
    defer a.free(h2);
    const h3 = try c.hmacHex(a, "other@example.com");
    defer a.free(h3);

    try std.testing.expectEqual(@as(usize, 64), h1.len);
    try std.testing.expectEqualStrings(h1, h2);
    try std.testing.expect(!std.mem.eql(u8, h1, h3));
    for (h1) |ch| {
        const ok = (ch >= '0' and ch <= '9') or (ch >= 'a' and ch <= 'f');
        try std.testing.expect(ok);
    }
}

test "different master keys produce different ciphertext keys" {
    const a = std.testing.allocator;
    var c1 = try Cipher.init(&([_]u8{0x01} ** 32));
    defer c1.deinit();
    var c2 = try Cipher.init(&([_]u8{0x02} ** 32));
    defer c2.deinit();

    const ct = try c1.encrypt(a, "x");
    defer a.free(ct);
    // c2 cannot decrypt c1's ciphertext.
    try std.testing.expectError(CryptoError.AuthenticationFailed, c2.decrypt(a, ct));
}
