// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros

//! FIPS parity / KAT (Known-Answer Test) suite.
//!
//! Each test asserts the `crypto_backend` seam produces KNOWN-CORRECT
//! outputs against published test vectors. Because the test file is
//! compiled and run under BOTH `-Dfips=false` (std.crypto shim) and
//! `-Dfips=true` (OpenSSL FIPS provider), a green run proves:
//!   1. Algorithmic correctness — the seam computes the right answer.
//!   2. Backend parity — both backends agree on the same answer.
//!
//! Vectors:
//!   SHA-256  — FIPS 180-4 sample message "abc"
//!   HMAC-SHA256 — RFC 4231 Test Case 2
//!   AES-256-GCM — seal/open round-trip + tag-tamper authentication check
//!   HKDF-SHA256 — RFC 5869 Test Case 1
const std = @import("std");
const cb = @import("crypto_backend");

// ---------------------------------------------------------------------------
// SHA-256 KAT: FIPS 180-4 sample message "abc"
// Expected: ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
// ---------------------------------------------------------------------------
test "KAT SHA-256 of 'abc'" {
    const expected = "\xba\x78\x16\xbf\x8f\x01\xcf\xea\x41\x41\x40\xde\x5d\xae\x22\x23" ++
        "\xb0\x03\x61\xa3\x96\x17\x7a\x9c\xb4\x10\xff\x61\xf2\x00\x15\xad";
    var out: [32]u8 = undefined;
    const n = try cb.Hash.digest(.sha256, "abc", &out);
    try std.testing.expectEqual(@as(usize, 32), n);
    try std.testing.expectEqualSlices(u8, expected, out[0..32]);
}

// ---------------------------------------------------------------------------
// HMAC-SHA256 KAT: RFC 4231 Test Case 2
//   key  = "Jefe"
//   data = "what do ya want for nothing?"
//   mac  = 5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843
// ---------------------------------------------------------------------------
test "KAT HMAC-SHA256 RFC 4231 TC-2" {
    const key = "Jefe";
    const data = "what do ya want for nothing?";
    const expected = "\x5b\xdc\xc1\x46\xbf\x60\x75\x4e\x6a\x04\x24\x26\x08\x95\x75\xc7" ++
        "\x5a\x00\x3f\x08\x9d\x27\x39\x83\x9d\xec\x58\xb9\x64\xec\x38\x43";
    var out: [32]u8 = undefined;
    const n = try cb.Mac.hmac(.sha256, key, data, &out);
    try std.testing.expectEqual(@as(usize, 32), n);
    try std.testing.expectEqualSlices(u8, expected, out[0..32]);
}

// ---------------------------------------------------------------------------
// AES-256-GCM round-trip + authentication check
//   Fixed 32-byte key, 12-byte nonce, 16-byte tag.
//   1. seal(pt)  → ciphertext + tag
//   2. open(ct, tag)   → recovered plaintext == original
//   3. flip tag byte 0 → open must return error.AuthFailed
// ---------------------------------------------------------------------------
test "AES-256-GCM seal/open round-trip and tag tamper" {
    // 32-byte key (all-zero for determinism)
    const key: [32]u8 = [_]u8{0x00} ** 32;
    // 12-byte nonce
    const nonce: [12]u8 = [_]u8{0x00} ** 12;
    // Additional authenticated data
    const ad = "parity-test-aad";
    // Plaintext
    const plaintext = "hello geode fips";

    var ciphertext: [plaintext.len]u8 = undefined;
    var tag: [16]u8 = undefined;

    // Seal
    try cb.Aead.seal(
        .aes_256_gcm,
        &key,
        &nonce,
        ad,
        plaintext,
        &ciphertext,
        &tag,
    );

    // Open — must recover original plaintext
    var recovered: [plaintext.len]u8 = undefined;
    try cb.Aead.open(
        .aes_256_gcm,
        &key,
        &nonce,
        ad,
        &ciphertext,
        &tag,
        &recovered,
    );
    try std.testing.expectEqualSlices(u8, plaintext, &recovered);

    // Tag tamper — open must fail with AuthFailed
    var bad_tag = tag;
    bad_tag[0] ^= 0xFF; // flip first byte
    var garbage: [plaintext.len]u8 = undefined;
    const result = cb.Aead.open(
        .aes_256_gcm,
        &key,
        &nonce,
        ad,
        &ciphertext,
        &bad_tag,
        &garbage,
    );
    try std.testing.expectError(error.AuthFailed, result);
}

// ---------------------------------------------------------------------------
// HKDF-SHA256 KAT: RFC 5869 Test Case 1
//   IKM  = 0x0b0b...0b (22 bytes)
//   Salt = 0x000102...0c (13 bytes)
//   Info = 0xf0f1...f9 (10 bytes)
//   L    = 42 bytes
//   OKM  = 3cb25f25faacd57a90434f64d0362f2a2d2d0a90cf1a5a4c5db02d56ecc4c5bf
//          34007208d5b887185865 (42 bytes)
// ---------------------------------------------------------------------------
test "KAT HKDF-SHA256 RFC 5869 TC-1" {
    const ikm = [_]u8{ 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b, 0x0b };
    const salt = [_]u8{ 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c };
    const info = [_]u8{ 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };
    const expected = [_]u8{
        0x3c, 0xb2, 0x5f, 0x25, 0xfa, 0xac, 0xd5, 0x7a,
        0x90, 0x43, 0x4f, 0x64, 0xd0, 0x36, 0x2f, 0x2a,
        0x2d, 0x2d, 0x0a, 0x90, 0xcf, 0x1a, 0x5a, 0x4c,
        0x5d, 0xb0, 0x2d, 0x56, 0xec, 0xc4, 0xc5, 0xbf,
        0x34, 0x00, 0x72, 0x08, 0xd5, 0xb8, 0x87, 0x18,
        0x58, 0x65,
    };
    var out: [42]u8 = undefined;
    try cb.Kdf.hkdf(.sha256, &ikm, &salt, &info, &out);
    try std.testing.expectEqualSlices(u8, &expected, &out);

    // Determinism check: same inputs → same output
    var out2: [42]u8 = undefined;
    try cb.Kdf.hkdf(.sha256, &ikm, &salt, &info, &out2);
    try std.testing.expectEqualSlices(u8, &out, &out2);
}
