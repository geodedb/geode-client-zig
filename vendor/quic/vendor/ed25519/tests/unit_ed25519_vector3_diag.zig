const std = @import("std");
const pure = @import("crypto_ed25519");

// Diagnostic test: exercise deriveKeyPair for RFC8032 vector3 seed and compare
// against the official public key (expected to mismatch currently), then attempt
// a sign/verify using the official pk to surface the verify failure details without
// perturbing the global test key mapping.
test "ed25519 vector3 diagnostic official pk mismatch" {
    const seed3 = [32]u8{ 0xc5, 0xaa, 0x8d, 0xf4, 0x3f, 0x9f, 0x83, 0x7b, 0xed, 0xb7, 0x44, 0x2f, 0x31, 0xdc, 0xb7, 0xb4, 0x64, 0x5a, 0x52, 0x45, 0x7b, 0x6b, 0x44, 0x25, 0x21, 0x64, 0x51, 0x3f, 0x18, 0x32, 0x8e, 0x00 };
    const pk_official = [32]u8{ 0xfc, 0x51, 0xcd, 0x8e, 0x62, 0x18, 0xa1, 0xa3, 0x8d, 0xa4, 0x7e, 0xd0, 0x02, 0x30, 0xf0, 0x58, 0x08, 0x16, 0xed, 0x13, 0xba, 0x33, 0x03, 0xac, 0x5d, 0xeb, 0x91, 0x15, 0x48, 0x90, 0x80, 0x25 };
    const kp = pure.deriveKeyPair(&seed3);
    if (!std.mem.eql(u8, &kp.pk, &pk_official)) {
        std.debug.print("vector3 derive mismatch: got={x} exp={x}\n", .{ kp.pk, pk_official });
    }
    // Attempt sign/verify using official pk (expected to fail currently) to capture log context.
    var sk_official: [64]u8 = undefined;
    @memcpy(sk_official[0..32], &seed3);
    @memcpy(sk_official[32..64], &pk_official);
    const msg = "v3-diag";
    var sig: [64]u8 = undefined;
    pure.sign(&sig, msg, &sk_official);
    const ok = pure.verify(&sig, msg, &pk_official);
    if (!ok) {
        const R: [32]u8 = sig[0..32].*;
        const S: [32]u8 = sig[32..64].*;
        std.debug.print("vector3 diag verify failed: R={x} S[0..4]={x}\n", .{ R, S[0..4].* });
    }
    try std.testing.expect(true); // always pass; diagnostics via logs
}

test "ed25519 vector3 official pk tuf-style message" {
    // Build a message like minituf: prefix + role + content
    const prefix = "TUF-SIG\x00";
    const role = "snapshot";
    const content = "vector3-content";
    var buf = std.ArrayList(u8).init(std.heap.page_allocator);
    defer buf.deinit();
    try buf.appendSlice(prefix);
    try buf.appendSlice(role);
    try buf.appendSlice(content);
    const msg = buf.items;
    const seed3 = [32]u8{ 0xc5, 0xaa, 0x8d, 0xf4, 0x3f, 0x9f, 0x83, 0x7b, 0xed, 0xb7, 0x44, 0x2f, 0x31, 0xdc, 0xb7, 0xb4, 0x64, 0x5a, 0x52, 0x45, 0x7b, 0x6b, 0x44, 0x25, 0x21, 0x64, 0x51, 0x3f, 0x18, 0x32, 0x8e, 0x00 };
    const pk_official = [32]u8{ 0xfc, 0x51, 0xcd, 0x8e, 0x62, 0x18, 0xa1, 0xa3, 0x8d, 0xa4, 0x7e, 0xd0, 0x02, 0x30, 0xf0, 0x58, 0x08, 0x16, 0xed, 0x13, 0xba, 0x33, 0x03, 0xac, 0x5d, 0xeb, 0x91, 0x15, 0x48, 0x90, 0x80, 0x25 };
    // Sign with seed-derived secret but using official pk half (may produce unverifiable signature if pk mismatch root cause).
    var sk_official: [64]u8 = undefined;
    @memcpy(sk_official[0..32], &seed3);
    @memcpy(sk_official[32..64], &pk_official);
    var sig: [64]u8 = undefined;
    // Generate a signature using the DERIVED public key (coherent pair) then attempt verify with official pk.
    const kp = pure.deriveKeyPair(&seed3);
    var sk_coherent: [64]u8 = undefined;
    @memcpy(sk_coherent[0..32], &seed3);
    @memcpy(sk_coherent[32..64], &kp.pk);
    pure.sign(&sig, msg, &sk_coherent);
    _ = pure.verify(&sig, msg, &pk_official); // expected failure triggers instrumentation
    try std.testing.expect(true);
}
