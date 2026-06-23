// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros

//! Smoke test: proves the crypto_backend seam module resolves under both
//! -Dfips=false (std_shim backend) and -Dfips=true (OpenSSL FIPS backend),
//! and that a SHA-256 digest returns 32 bytes in both modes.
const std = @import("std");
const cb = @import("crypto_backend");

test "crypto_backend seam wired: hash digest works in both modes" {
    var out: [32]u8 = undefined;
    const n = try cb.Hash.digest(.sha256, "abc", &out);
    try std.testing.expectEqual(@as(usize, 32), n);
}
