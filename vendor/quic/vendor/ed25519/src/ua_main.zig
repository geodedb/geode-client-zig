const ed = @import("ed25519");

pub fn main() !void {
    var seed: [32]u8 = .{0} ** 32;
    seed[0] = 1;
    const kp = ed.deriveKeyPair(&seed);
    var sig: [64]u8 = undefined;
    const msg = "ua";
    ed.sign(&sig, msg, &kp.sk);
    const ok = ed.verify(&sig, msg, &kp.pk);
    if (!ok) return error.VerifyFailed;
    // silent success
}
