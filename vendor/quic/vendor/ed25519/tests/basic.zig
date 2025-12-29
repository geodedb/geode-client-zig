const std = @import("std");
const ed = @import("ed25519");

test "ed25519 basic sign/verify roundtrip (vendored real impl)" {
    const seed = [_]u8{0} ** 32;
    const kp = ed.deriveKeyPair(&seed);
    const msg = "vendor-ed25519-test";
    var sig: [64]u8 = undefined;
    ed.sign(&sig, msg, &kp.sk);
    try std.testing.expect(ed.verify(&sig, msg, &kp.pk));
    var bad = sig;
    bad[0] ^= 0x01;
    try std.testing.expect(!ed.verify(&bad, msg, &kp.pk));
}
