const std = @import("std");
const ed = @import("crypto_ed25519");

test "ed25519 sign/verify smoke" {
    var seed: [32]u8 = undefined;
    // deterministic seed pattern
    for (seed, 0..) |*b, i| b.* = @intCast(i ^ 0x5a);
    const pair = ed.deriveKeyPair(&seed);
    const msg = "smoke";
    var sig: [64]u8 = undefined;
    ed.sign(&sig, msg, &pair.sk);
    try std.testing.expect(ed.verify(&sig, msg, &pair.pk));
}
