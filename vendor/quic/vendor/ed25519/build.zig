const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Optional verbose tracing for internal diagnostics (disabled by default).
    const trace_ed25519 = b.option(bool, "trace-ed25519", "Enable verbose ed25519 internal tracing prints") orelse false;

    // Module exposure (Zig 0.15 style). Root source file only; no separate static lib needed.
    var root_mod = b.createModule(.{ .root_source_file = b.path("src/ed25519.zig"), .target = target, .optimize = optimize });
    const build_opts = b.addOptions();
    build_opts.addOption(bool, "ed25519_trace", trace_ed25519);
    // Constant-time harness tunables
    const ct_iters = b.option(u32, "ct-iters", "Per-sample sign() loop iterations (default depends on build)");
    const ct_samples = b.option(u32, "ct-samples", "Samples per scalar class (default depends on build)");
    const ct_fail_t = b.option(f64, "ct-fail-t", "If absolute Welch t-statistic exceeds this, exit(1)");
    const ct_probe = b.option(bool, "ct-probe", "Inject artificial side-channel probe (expect large |t| and failure)");
    const ct_compact = b.option(bool, "ct-compact", "Emit single-line compact JSON output");
    const ct_no_raw = b.option(bool, "ct-no-raw", "Omit raw sample arrays from verbose JSON output");
    const ct_cpu_affinity_scan = b.option(bool, "ct-cpu-affinity-scan", "Parse /proc/self/status for Cpus_allowed_list to emit pin hint (Linux only)");
    build_opts.addOption(?u32, "ct_iters_opt", ct_iters);
    build_opts.addOption(?u32, "ct_samples_opt", ct_samples);
    build_opts.addOption(?f64, "ct_fail_t_opt", ct_fail_t);
    build_opts.addOption(?bool, "ct_probe_opt", ct_probe);
    build_opts.addOption(?bool, "ct_compact_opt", ct_compact);
    build_opts.addOption(?bool, "ct_no_raw_opt", ct_no_raw);
    build_opts.addOption(?bool, "ct_cpu_affinity_scan_opt", ct_cpu_affinity_scan);
    root_mod.addOptions("build_options", build_opts);
    // Provide module under expected name for dependents.
    b.modules.put("ed25519", root_mod) catch @panic("oom");

    const unit_tests = b.addTest(.{ .root_module = root_mod });
    const run_tests = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run vendored ed25519 tests");
    test_step.dependOn(&run_tests.step);

    // Stub binaries required by cross matrix (ua, ua-server)
    var ua_mod = b.createModule(.{ .root_source_file = b.path("src/ua_main.zig"), .target = target, .optimize = optimize });
    ua_mod.addImport("ed25519", root_mod);
    const ua_exe = b.addExecutable(.{ .name = "ua", .root_module = ua_mod });
    b.installArtifact(ua_exe);

    var ua_server_mod = b.createModule(.{ .root_source_file = b.path("src/ua_server_main.zig"), .target = target, .optimize = optimize });
    ua_server_mod.addImport("ed25519", root_mod);
    const ua_server_exe = b.addExecutable(.{ .name = "ua-server", .root_module = ua_server_mod });
    b.installArtifact(ua_server_exe);

    // Benchmark executable
    var bench_mod = b.createModule(.{ .root_source_file = b.path("src/bench.zig"), .target = target, .optimize = optimize });
    bench_mod.addImport("ed25519", root_mod);
    const bench_exe = b.addExecutable(.{ .name = "bench-ed25519", .root_module = bench_mod });
    const bench_run = b.addRunArtifact(bench_exe);
    const bench_step = b.step("bench", "Run micro benchmarks (keygen/sign/verify)");
    bench_step.dependOn(&bench_run.step);

    // Constant-time perf harness executable
    var ct_mod = b.createModule(.{ .root_source_file = b.path("src/ct_perf.zig"), .target = target, .optimize = optimize });
    ct_mod.addImport("ed25519", root_mod);
    // Expose build options (timing harness flags) directly to ct_perf module.
    ct_mod.addOptions("build_options", build_opts);
    const ct_exe = b.addExecutable(.{ .name = "ct-perf-ed25519", .root_module = ct_mod });
    const ct_run = b.addRunArtifact(ct_exe);
    const ct_step = b.step("ct-perf", "Run constant-time timing harness");
    ct_step.dependOn(&ct_run.step);

    // Aggregate build-only perf artifacts (no execution). Useful for CI "perf-build" stage.
    const perf_build = b.step("perf-build", "Build perf-related artifacts (bench + ct-perf)");
    perf_build.dependOn(&bench_exe.step);
    perf_build.dependOn(&ct_exe.step);

    // Module now registered in b.modules; nothing further required.
}
