const std = @import("std");
const ed = @import("ed25519");
const build_opts = @import("build_options");

// Simple constant-time harness skeleton. It performs timing over two classes of
// scalars that only differ in high bit patterns to feed the basepoint multiply.
// Output is JSON with aggregate stats. Future extension: Welch t-test.

fn mean_u128(values: []const u128) u128 {
    var acc: u256 = 0; // widened accumulator
    for (values) |v| acc += v;
    return @as(u128, @intCast(acc / values.len));
}

fn insertionSortU128(a: []u128) void {
    var i: usize = 1;
    while (i < a.len) : (i += 1) {
        const key = a[i];
        var j: isize = @as(isize, @intCast(i)) - 1;
        while (j >= 0 and a[@as(usize, @intCast(j))] > key) : (j -= 1) {
            a[@as(usize, @intCast(j + 1))] = a[@as(usize, @intCast(j))];
        }
        a[@as(usize, @intCast(j + 1))] = key;
    }
}

fn medianU128(values: []const u128) u128 {
    if (values.len == 0) return 0;
    var tmp: [64]u128 = undefined; // supports up to 64 samples (far above current defaults)
    std.debug.assert(values.len <= tmp.len);
    var i: usize = 0;
    while (i < values.len) : (i += 1) tmp[i] = values[i];
    insertionSortU128(tmp[0..values.len]);
    if (values.len % 2 == 1) return tmp[values.len / 2];
    const a0 = tmp[(values.len / 2) - 1];
    const a1 = tmp[values.len / 2];
    return @as(u128, @intCast((@as(u256, a0) + @as(u256, a1)) / 2));
}

fn madU128(values: []const u128) u128 {
    if (values.len == 0) return 0;
    const med = medianU128(values);
    var diffs: [64]u128 = undefined;
    std.debug.assert(values.len <= diffs.len);
    var i: usize = 0;
    while (i < values.len) : (i += 1) {
        const v = values[i];
        if (v >= med) diffs[i] = v - med else diffs[i] = med - v;
    }
    insertionSortU128(diffs[0..values.len]);
    // median of diffs
    if (values.len % 2 == 1) return diffs[values.len / 2];
    const d0 = diffs[(values.len / 2) - 1];
    const d1 = diffs[values.len / 2];
    return @as(u128, @intCast((@as(u256, d0) + @as(u256, d1)) / 2));
}

pub fn main() !void {
    // Allow overriding via environment build options (not yet wired in build.zig) or fallback.
    // Use smaller defaults for debug speed; release users may increase via future flags.
    const default_iters: usize = 200; // debug-friendly
    const default_samples: usize = 6;
    const opt_it: usize = if (build_opts.ct_iters_opt) |v| @as(usize, @intCast(v)) else default_iters;
    const opt_samples: usize = if (build_opts.ct_samples_opt) |v| @as(usize, @intCast(v)) else default_samples;
    var seed: [32]u8 = undefined;
    for (&seed, 0..) |*b, idx| b.* = @as(u8, @intCast(idx * 3 + 7));
    var kp = ed.deriveKeyPair(&seed);

    var msg: [32]u8 = undefined;
    for (&msg, 0..) |*b, idx| b.* = @as(u8, @intCast(31 - idx));

    const ITERS = opt_it;
    const SAMPLES = opt_samples;

    // Two scalar classes: original secret scalar vs scalar with flipped top bit window.
    var sig: [64]u8 = undefined;

    var samples_a: [SAMPLES]u128 = undefined;
    var samples_b: [SAMPLES]u128 = undefined;

    // Prepare modified key with top 3 bits inverted (still < L because derive clamps)
    var sk_b = kp.sk; // copy
    sk_b[0] &= 248; // keep clamping semantics
    sk_b[31] &= 63;
    sk_b[31] |= 64; // ensure high bit pattern difference

    const probe_enabled = build_opts.ct_probe_opt orelse false;
    const compact = build_opts.ct_compact_opt orelse false;
    const cpu_aff_scan = build_opts.ct_cpu_affinity_scan_opt orelse false;
    const no_raw = build_opts.ct_no_raw_opt orelse false;
    const schema_version: u32 = 1; // increment when JSON structure (fields/semantics) changes

    var cpu_pin_hint_buf: [128]u8 = undefined;
    var cpu_pin_hint_len: usize = 0;
    var cpu_allowed_list: []const u8 = "";
    if (cpu_aff_scan) {
        // Best-effort parse of /proc/self/status for Cpus_allowed_list (Linux). Non-fatal on errors.
        const status_path = "/proc/self/status";
        var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
        defer arena.deinit();
        const alloc = arena.allocator();
        if (std.fs.cwd().openFile(status_path, .{})) |file| {
            defer file.close();
            if (file.readToEndAlloc(alloc, 32 * 1024)) |data| { // 32K cap
                var it = std.mem.splitScalar(u8, data, '\n');
                while (it.next()) |line| {
                    if (std.mem.startsWith(u8, line, "Cpus_allowed_list")) {
                        if (std.mem.indexOfScalar(u8, line, '\t')) |tab_idx| {
                            cpu_allowed_list = line[tab_idx + 1 ..];
                        } else if (std.mem.indexOfScalar(u8, line, ':')) |colon_idx| {
                            cpu_allowed_list = std.mem.trim(u8, line[colon_idx + 1 ..], " \t");
                        }
                        break;
                    }
                }
            } else |_| {}
        } else |_| {}
        if (cpu_allowed_list.len != 0) {
            const max_copy = cpu_pin_hint_buf.len - 1;
            const to_copy = if (cpu_allowed_list.len < max_copy) cpu_allowed_list.len else max_copy;
            std.mem.copyForwards(u8, cpu_pin_hint_buf[0..to_copy], cpu_allowed_list[0..to_copy]);
            cpu_pin_hint_len = to_copy;
            cpu_pin_hint_buf[cpu_pin_hint_len] = 0; // sentinel
        }
    }

    // Warmup: gather and discard one sample pair to reduce first-run cache/JIT like effects (where applicable).
    var warmup_discarded = false;
    {
        const t0a_w = std.time.nanoTimestamp();
        var iwa: usize = 0;
        while (iwa < ITERS) : (iwa += 1) ed.sign(&sig, msg[0..], &kp.sk);
        const _dur_a_w = std.time.nanoTimestamp() - t0a_w;
        const t0b_w = std.time.nanoTimestamp();
        var iwb: usize = 0;
        while (iwb < ITERS) : (iwb += 1) ed.sign(&sig, msg[0..], &sk_b);
        const _dur_b_w = std.time.nanoTimestamp() - t0b_w;
        _ = _dur_a_w;
        _ = _dur_b_w; // silence unused; intentionally discarded
        warmup_discarded = true;
    }

    // Optional side-channel probe: introduce deliberate timing divergence in class B when enabled.
    // We do this using a public-data dependent dummy loop whose trip count depends on a bit of the
    // already public modified scalar (sk_b). This should inflate mean_b and trigger t-stat failure.
    const probe_scalar_bit = (sk_b[31] >> 6) & 0x1; // known differing high bit
    var s: usize = 0;
    while (s < SAMPLES) : (s += 1) {
        // Class A timing
        const t0a = std.time.nanoTimestamp();
        var i_a: usize = 0;
        while (i_a < ITERS) : (i_a += 1) ed.sign(&sig, msg[0..], &kp.sk);
        samples_a[s] = @as(u128, @intCast(std.time.nanoTimestamp() - t0a));

        // Class B timing (with optional artificial probe overhead)
        const t0b = std.time.nanoTimestamp();
        var i_b: usize = 0;
        while (i_b < ITERS) : (i_b += 1) {
            ed.sign(&sig, msg[0..], &sk_b);
        }
        if (probe_enabled) {
            // Additional signing loops create realistic workload divergence.
            var extra_loops: usize = 50; // baseline overhead
            if (probe_scalar_bit == 1) extra_loops = 400; // amplified
            var k: usize = 0;
            while (k < extra_loops) : (k += 1) ed.sign(&sig, msg[0..], &sk_b);
        }
        samples_b[s] = @as(u128, @intCast(std.time.nanoTimestamp() - t0b));
    }

    const mean_a = mean_u128(samples_a[0..]);
    const mean_b = mean_u128(samples_b[0..]);
    const diff: i128 = @as(i128, @intCast(mean_b)) - @as(i128, @intCast(mean_a));

    // Compute (biased) sample variances for Welch t-test.
    var var_a_acc: f128 = 0;
    var var_b_acc: f128 = 0;
    for (samples_a) |v| {
        const d = @as(f128, @floatFromInt(v)) - @as(f128, @floatFromInt(mean_a));
        var_a_acc += d * d;
    }
    for (samples_b) |v| {
        const d = @as(f128, @floatFromInt(v)) - @as(f128, @floatFromInt(mean_b));
        var_b_acc += d * d;
    }
    const Sa2 = var_a_acc / @as(f128, @floatFromInt(SAMPLES - 1));
    const Sb2 = var_b_acc / @as(f128, @floatFromInt(SAMPLES - 1));
    const mean_a_f = @as(f128, @floatFromInt(mean_a));
    const mean_b_f = @as(f128, @floatFromInt(mean_b));
    const diff_f = mean_b_f - mean_a_f;
    const inv_n = 1.0 / @as(f128, @floatFromInt(SAMPLES));
    const se2 = Sa2 * inv_n + Sb2 * inv_n;
    var t_stat: f128 = 0;
    if (se2 != 0) t_stat = diff_f / @sqrt(se2);
    // Welch-Satterthwaite df approximation
    var df: f128 = 0;
    if (se2 != 0) {
        const num = se2 * se2;
        const term_a = (Sa2 * inv_n) * (Sa2 * inv_n) / (@as(f128, @floatFromInt(SAMPLES - 1)));
        const term_b = (Sb2 * inv_n) * (Sb2 * inv_n) / (@as(f128, @floatFromInt(SAMPLES - 1)));
        const denom = term_a + term_b;
        if (denom != 0) {
            df = num / denom;
        } else {
            df = 0;
        }
    }
    const abs_t = if (t_stat < 0) -t_stat else t_stat;
    const user_fail_thr = build_opts.ct_fail_t_opt orelse 0.0; // disabled if 0.0
    var effective_thr: f64 = @as(f64, user_fail_thr); // may be auto-set when perf env enabled
    var threshold_source: []const u8 = if (user_fail_thr > 0) "user" else "none";
    if (user_fail_thr == 0) {
        const env_ptr = std.posix.getenv("UA_PERF_HARNESS_ENABLE");
        if (env_ptr) |p| {
            if (p[0] == '1') {
                // Auto-threshold only if sample size sufficient for a mild statistical claim.
                if (SAMPLES >= 12) {
                    effective_thr = 8.0; // conservative strong |t| bound
                    threshold_source = "auto-env";
                }
            }
        }
    }
    const should_fail = if (effective_thr > 0 and abs_t > effective_thr) true else false;

    // Effect size (Cohen's d) using pooled standard deviation. For equal sample sizes n:
    // d = (mean_b - mean_a) / sqrt( ((n-1)Sa2 + (n-1)Sb2) / (2n - 2) )
    var effect_size: f64 = 0.0;
    {
        const n = @as(f64, @floatFromInt(SAMPLES));
        const pooled_var = ((@as(f64, @floatCast(Sa2)) * (n - 1.0)) + (@as(f64, @floatCast(Sb2)) * (n - 1.0))) / (2.0 * n - 2.0);
        if (pooled_var > 0) effect_size = (@as(f64, @floatFromInt(diff))) / @sqrt(pooled_var);
    }

    // Robust stats
    const median_a = medianU128(samples_a[0..]);
    const median_b = medianU128(samples_b[0..]);
    const median_diff: i128 = @as(i128, @intCast(median_b)) - @as(i128, @intCast(median_a));
    const mad_a = madU128(samples_a[0..]);
    const mad_b = madU128(samples_b[0..]);
    // Jitter metrics (robust relative dispersion). Guard divide-by-zero.
    var jitter_a: f64 = 0.0;
    var jitter_b: f64 = 0.0;
    if (median_a != 0) jitter_a = @as(f64, @floatFromInt(mad_a)) / @as(f64, @floatFromInt(median_a));
    if (median_b != 0) jitter_b = @as(f64, @floatFromInt(mad_b)) / @as(f64, @floatFromInt(median_b));

    // Approximate two-tailed p-value using standard normal approximation and a polynomial
    // approximation of erfc (Abramowitz-Stegun 7.1.26). p = erfc(z / sqrt(2)).
    var p_value: f64 = 1.0;
    {
        const z = @as(f64, @floatCast(abs_t));
        const inv_sqrt2 = 0.7071067811865476;
        const x = z * inv_sqrt2;
        // erfc approximation for x >= 0
        const t = 1.0 / (1.0 + 0.5 * x);
        const tau = t * @exp(-x * x - 1.26551223 +
            t * (1.00002368 +
                t * (0.37409196 +
                    t * (0.09678418 +
                        t * (-0.18628806 +
                            t * (0.27886807 +
                                t * (-1.13520398 +
                                    t * (1.48851587 +
                                        t * (-0.82215223 +
                                            t * 0.17087277)))))))));
        const erfc_x = tau; // approximation yields erfc(x)
        p_value = erfc_x;
    }

    if (compact) {
        // Single-line compact JSON (no raw arrays to keep artifact light)
        std.debug.print("{{", .{});
        std.debug.print("\"schema\":{},", .{schema_version});
        std.debug.print("\"samples\":{},", .{SAMPLES});
        std.debug.print("\"iters\":{},", .{ITERS});
        std.debug.print("\"mean_a\":{},\"mean_b\":{},", .{ mean_a, mean_b });
        std.debug.print("\"diff\":{},", .{diff});
        std.debug.print("\"t\":{d:.6},\"df\":{d:.2},", .{ @as(f64, @floatCast(t_stat)), @as(f64, @floatCast(df)) });
        std.debug.print("\"d\":{d:.6},", .{effect_size});
        std.debug.print("\"p\":{d:.6},", .{p_value});
        std.debug.print("\"thr\":{d:.2},", .{@as(f64, @floatCast(effective_thr))});
        std.debug.print("\"ja\":{d:.6},\"jb\":{d:.6},", .{ jitter_a, jitter_b });
        std.debug.print("\"fail\":{},", .{should_fail});
        if (cpu_aff_scan and cpu_pin_hint_len != 0) {
            std.debug.print("\"probe\":{},\"warmup\":{},\"cpu\":\"{s}\"", .{ probe_enabled, warmup_discarded, cpu_pin_hint_buf[0..cpu_pin_hint_len] });
        } else {
            std.debug.print("\"probe\":{},\"warmup\":{}", .{ probe_enabled, warmup_discarded });
        }
        std.debug.print("}}\n", .{});
    } else {
        std.debug.print("{{\n", .{});
        std.debug.print("  \"schema\": {},\n", .{schema_version});
        std.debug.print("  \"samples\": {},\n", .{SAMPLES});
        std.debug.print("  \"iters_per_sample\": {},\n", .{ITERS});
        std.debug.print("  \"mean_a_ns\": {},\n", .{mean_a});
        std.debug.print("  \"mean_b_ns\": {},\n", .{mean_b});
        std.debug.print("  \"mean_diff_ns\": {},\n", .{diff});
        std.debug.print("  \"t_stat\": {},\n", .{@as(f64, @floatCast(t_stat))});
        std.debug.print("  \"effect_size_d\": {d:.6},\n", .{effect_size});
        std.debug.print("  \"welch_df\": {},\n", .{@as(f64, @floatCast(df))});
        std.debug.print("  \"abs_t\": {},\n", .{@as(f64, @floatCast(abs_t))});
        std.debug.print("  \"p_value_approx\": {d:.6},\n", .{p_value});
        std.debug.print("  \"threshold\": {},\n", .{@as(f64, @floatCast(effective_thr))});
        std.debug.print("  \"threshold_source\": \"{s}\",\n", .{threshold_source});
        std.debug.print("  \"fail\": {},\n", .{should_fail});
        std.debug.print("  \"probe_enabled\": {},\n", .{probe_enabled});
        std.debug.print("  \"warmup_discarded\": {},\n", .{warmup_discarded});
        if (cpu_aff_scan and cpu_pin_hint_len != 0) {
            std.debug.print("  \"cpu_affinity_allowed\": \"{s}\",\n", .{cpu_pin_hint_buf[0..cpu_pin_hint_len]});
        }
        std.debug.print("  \"median_a_ns\": {},\n", .{median_a});
        std.debug.print("  \"median_b_ns\": {},\n", .{median_b});
        std.debug.print("  \"median_diff_ns\": {},\n", .{median_diff});
        std.debug.print("  \"mad_a_ns\": {},\n", .{mad_a});
        std.debug.print("  \"mad_b_ns\": {},\n", .{mad_b});
        std.debug.print("  \"jitter_a\": {d:.6},\n", .{jitter_a});
        std.debug.print("  \"jitter_b\": {d:.6},\n", .{jitter_b});
        // Raw sample arrays
        if (!no_raw) {
            std.debug.print("  \"samples_a\": [", .{});
            var i: usize = 0;
            while (i < SAMPLES) : (i += 1) {
                std.debug.print("{}", .{samples_a[i]});
                if (i + 1 < SAMPLES) std.debug.print(",", .{});
            }
            std.debug.print("],\n", .{});
            std.debug.print("  \"samples_b\": [", .{});
            i = 0;
            while (i < SAMPLES) : (i += 1) {
                std.debug.print("{}", .{samples_b[i]});
                if (i + 1 < SAMPLES) std.debug.print(",", .{});
            }
            std.debug.print("]\n", .{});
        } else {
            std.debug.print("  \"raw_samples_omitted\": true\n", .{});
        }
        std.debug.print("}}\n", .{});
    }

    if (should_fail) std.process.exit(1); // CI gate
}
