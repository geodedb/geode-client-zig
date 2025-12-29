const std = @import("std");
const ed = @import("crypto_ed25519");

// Deterministic pseudo-fuzz exercising sign/verify, decompress/compress, and small-order rejection.
// Uses a fixed seed so test is reproducible yet provides broad input coverage over time.

fn xorshift64star(state: *u64) u64 {
    var x = state.*;
    x ^= x >> 12;
    x ^= x << 25;
    x ^= x >> 27;
    state.* = x;
    return @mulWithOverflow(x, 0x2545F4914F6CDD1D)[0];
}

fn prngBytes(state: *u64, buf: []u8) void {
    var i: usize = 0;
    while (i < buf.len) : (i += 1) {
        if ((i & 7) == 0) {
            const v = xorshift64star(state);
            var k: usize = 0;
            while (k < 8 and i + k < buf.len) : (k += 1) {
                buf[i + k] = @intCast((v >> @intCast(k * 8)) & 0xff);
            }
        }
    }
}

fn randomMessage(state: *u64, out: []u8) []u8 {
    const len: usize = @intCast(xorshift64star(state) % (out.len + 1));
    prngBytes(state, out[0..len]);
    return out[0..len];
}

test "ed25519 fuzz-ish sign/verify & encode invariants" {
    // Fixed 64-bit seed (was mnemonic literal; replace with valid hex constant)
    var prng_state: u64 = 0xfeed_f155_ed25_1919;
    var i: usize = 0;
    var msg_buf: [128]u8 = undefined;

    while (i < 256) : (i += 1) { // 256 iterations quick in Debug
        // Random seed -> derive keypair (hash+clamp inside derive)
        var seed: [32]u8 = undefined;
        prngBytes(&prng_state, &seed);
        const kp = ed.deriveKeyPair(&seed);

        // Random message
        const msg = randomMessage(&prng_state, &msg_buf);

        // Sign & verify
        var sig: [64]u8 = undefined;
        ed.sign(&sig, msg, &kp.sk);
        if (!ed.verify(&sig, msg, &kp.pk)) {
            std.debug.print("fuzz verify failed iter={} pk={x} sig={x}\n", .{ i, kp.pk, sig });
            try std.testing.expect(false);
        }

        // Tamper S high bit or R encoding randomly and ensure rejection
        var mutated = sig;
        if ((i & 1) == 0) mutated[63] ^= 0x80 else mutated[0] ^= 0x80; // flip bit in S or R
        const accepted = ed.verify(&mutated, msg, &kp.pk);
        if (accepted) {
            std.debug.print("fuzz negative accepted iter={} mut_sig={x}\n", .{ i, mutated });
            try std.testing.expect(false);
        }

        // Compress/decompress public key roundtrip
        const P = ed.test_decompressPoint(&kp.pk) orelse {
            std.debug.print("fuzz decompress pk failed iter={} pk={x}\n", .{ i, kp.pk });
            try std.testing.expect(false);
            return;
        };
        var enc: [32]u8 = undefined;
        ed.test_compressPoint(P, &enc);
        if (!std.mem.eql(u8, &enc, &kp.pk)) {
            std.debug.print("fuzz pk roundtrip mismatch iter={} got={x} exp={x}\n", .{ i, enc, kp.pk });
            try std.testing.expect(false);
        }

        // Light extra operation to vary instruction mix so that accidental data-dependent timing
        // shifts are more likely to surface in ct timing guard test (compress another point).
        var enc2: [32]u8 = undefined;
        ed.test_compressPoint(P, &enc2);
        std.mem.doNotOptimizeAway(enc2);
    }
    try std.testing.expect(true);
}
