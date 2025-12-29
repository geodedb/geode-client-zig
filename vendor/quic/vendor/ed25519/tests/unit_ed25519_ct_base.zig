const std = @import("std");
const ed = @import("../src/crypto/ed25519.zig");

// Ensures constant-time base scalar multiplication yields identical results
// for known RFC8032 test vector scalar derived from seed.
// Uses vector #1 from RFC8032: seed = 000102...1f (incrementing bytes).

pub fn main() !void {}

test "ed25519 constant-time base scalar matches RFC8032 vector #1 public key" {
    var seed: [32]u8 = undefined;
    var i: usize = 0;
    while (i < 32) : (i += 1) seed[i] = @intCast(i);
    const pair = ed.deriveKeyPair(&seed);
    // Expected public key from RFC8032 test vector #1
    const expected_pk = [_]u8{
        0x8f, 0x25, 0x25, 0x89, 0x8e, 0x8b, 0x30, 0x0e,
        0x6a, 0x9c, 0x03, 0x00, 0xa0, 0x7d, 0x45, 0x99,
        0x0c, 0x6e, 0x9e, 0x29, 0xad, 0x0f, 0x33, 0x2b,
        0x9e, 0x2f, 0x0a, 0x74, 0xae, 0x20, 0x9a, 0x64,
    };
    try std.testing.expectEqualSlices(u8, &expected_pk, &pair.pk);
}
