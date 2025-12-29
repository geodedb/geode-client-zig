const std = @import("std");
const ed = @import("crypto_ed25519");
const builtin = @import("builtin");

fn monoNs() u64 {
    const t = std.time.nanoTimestamp();
    return @intCast(if (t < 0) 0 else t);
}

// Very coarse timing variance guard for base scalar multiplication.
// Collect N samples of scalarMulBase for random scalars derived from a fixed seed PRNG.
// Fails if max/min exceeds a loose factor (indicating a branchy path regression).
// This runs in Debug so noise is high; target is only to detect egregious differences.

fn xorshift64star(state: *u64) u64 {
    var x = state.*;
    x ^= x >> 12;
    x ^= x << 25;
    x ^= x >> 27;
    state.* = x;
    return @mulWithOverflow(x, 0x2545F4914F6CDD1D)[0];
}

fn fillRandom(state: *u64, buf: []u8) void {
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

fn benchScalarMul(samples: usize) !void {
    var seed_state: u64 = 0x1234_5678_9abc_def0;
    var min_ns: u64 = ~@as(u64, 0);
    var max_ns: u64 = 0;
    var i: usize = 0;
    var accum_first_byte: u64 = 0; // use to ensure work not elided
    while (i < samples) : (i += 1) {
        var s: [32]u8 = undefined;
        fillRandom(&seed_state, &s);
        // Clamp like key derivation would (so distribution resembles real scalars)
        s[0] &= 248;
        s[31] &= 63;
        s[31] |= 64;
        const t0 = monoNs();
        const P = ed.test_scalarMulBase(&s);
        const dt = monoNs() - t0;
        if (dt < min_ns) min_ns = dt;
        if (dt > max_ns) max_ns = dt;
        var enc: [32]u8 = undefined;
        ed.test_compressPoint(P, &enc); // ensure full work
        accum_first_byte +%= enc[0];
    }
    // Allow up to 8x spread (very lenient) to avoid false positives on shared runners.
    if (min_ns == 0) return; // degenerate, skip check
    const spread_num = max_ns;
    const spread_den = if (min_ns == 0) 1 else min_ns;
    // Avoid division by zero.
    const ratio_times_100 = @divTrunc(spread_num * 100, spread_den);
    // 800 == 8.00x
    try std.testing.expect(ratio_times_100 <= 800);
    std.debug.print("ed25519.ct_timing samples={} min={}ns max={}ns ratio={}.{}x accum_byte={}\n", .{ samples, min_ns, max_ns, ratio_times_100 / 100, ratio_times_100 % 100, accum_first_byte });
}

test "ed25519 constant-time scalarMulBase coarse variance guard" {
    // Skip in non-Debug modes; variance expectations tuned for Debug noise profile.
    if (builtin.mode != .Debug) return error.SkipZigTest;
    // Keep sample count modest for CI runtime; expand when UA_PERF_HARNESS_ENABLE=1
    var samples: usize = 32;
    if (std.process.getEnvVarOwned(std.heap.page_allocator, "UA_PERF_HARNESS_ENABLE")) |v| {
        defer std.heap.page_allocator.free(v);
        if (v.len > 0 and v[0] == '1') samples = 128;
    } else |_| {}
    try benchScalarMul(samples);
}
