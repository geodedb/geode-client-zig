const std = @import("std");
const ed = @import("crypto_ed25519");
const support = @import("support_ed25519");

test "ed25519 decompress pk roundtrip + sign/verify" {
    // Use fixed seed and derive keypair
    var seed: [32]u8 = .{0} ** 32;
    seed[0] = 1;
    const kp = ed.deriveKeyPair(&seed);
    // Decompress public key is valid
    const maybe_A = ed.decompressPoint(&kp.pk);
    try std.testing.expect(maybe_A != null);
    // Simple sign/verify on small message
    const msg = "m";
    var sig: [64]u8 = undefined;
    ed.sign(&sig, msg, &kp.sk);
    const ok = ed.verify(&sig, msg, &kp.pk);
    try std.testing.expect(ok);
}

test "ed25519 decompress support vector keys" {
    const vecs = support.keys();
    var i: usize = 0;
    while (i < vecs.len) : (i += 1) {
        const pk = vecs[i].pubkey;
        const maybe = ed.decompressPoint(&pk);
        try std.testing.expect(maybe != null);
    }
}
