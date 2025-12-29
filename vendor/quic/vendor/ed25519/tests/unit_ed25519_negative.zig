const std = @import("std");
const ed = @import("../src/crypto/ed25519.zig");

// Negative RFC8032 edge cases: non-canonical S (S == L) and high-bit set encodings.

test "ed25519 verify rejects non-canonical S == L" {
    // Build a valid signature first
    var seed: [32]u8 = undefined;
    for (seed, 0..) |*b, i| b.* = @intCast(i);
    const pair = ed.deriveKeyPair(&seed);
    var msg: [3]u8 = .{ 'h', 'i', '!' };
    var sig: [64]u8 = undefined;
    ed.sign(&sig, &msg, &pair.sk);
    // Overwrite S with L (group order) to force non-canonical
    const L_bytes = [_]u8{ 0xed, 0xd3, 0xf5, 0x5c, 0x1a, 0x63, 0x12, 0x58, 0xd6, 0x9c, 0xf7, 0xa2, 0xde, 0xf9, 0xde, 0x14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x10 };
    for (L_bytes, 0..) |b, i| sig[32 + i] = b;
    try std.testing.expect(!ed.verify(&sig, &msg, &pair.pk));
}

test "ed25519 verify rejects high-bit set public key encoding" {
    var seed: [32]u8 = undefined;
    for (seed, 0..) |*b, i| b.* = @intCast(i);
    const pair = ed.deriveKeyPair(&seed);
    var pk_bad = pair.pk;
    pk_bad[31] |= 0x80; // set sign bit + keep rest same (likely invalid point)
    var msg: [1]u8 = .{'a'};
    var sig: [64]u8 = undefined;
    ed.sign(&sig, &msg, &pair.sk);
    try std.testing.expect(!ed.verify(&sig, &msg, &pk_bad));
}

test "ed25519 verify rejects high-bit set R encoding" {
    var seed: [32]u8 = undefined;
    for (seed, 0..) |*b, i| b.* = @intCast(i);
    const pair = ed.deriveKeyPair(&seed);
    var msg: [2]u8 = .{ 'o', 'k' };
    var sig: [64]u8 = undefined;
    ed.sign(&sig, &msg, &pair.sk);
    sig[31] |= 0x80; // mutate R encoding high bit to flip sign unpredictably
    try std.testing.expect(!ed.verify(&sig, &msg, &pair.pk));
}
