const std = @import("std");

// Import vendor setup from local vendor directory
const quic_vendor_setup = @import("vendor/quic/vendor_setup.zig");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Setup QUIC modules from vendored library
    const quic_modules = quic_vendor_setup.setupModules(b, "vendor/quic", target, optimize);

    // Create geode_client module (uses vendor/quic directly)
    const geode_client_mod = b.createModule(.{
        .root_source_file = b.path("geode_client_v2.zig"),
        .target = target,
        .optimize = optimize,
    });
    geode_client_mod.addImport("vendor_quic", quic_modules.quic_api);

    // Build the test executable
    const test_exe = b.addExecutable(.{
        .name = "test_connection",
        .root_module = b.createModule(.{
            .root_source_file = b.path("test_connection.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    test_exe.root_module.addImport("geode_client", geode_client_mod);
    test_exe.root_module.addImport("vendor_quic", quic_modules.quic_api);

    test_exe.linkLibC();
    test_exe.linkSystemLibrary("ssl");
    test_exe.linkSystemLibrary("crypto");
    if (target.result.os.tag == .linux) {
        test_exe.linkSystemLibrary("dl");
    }

    b.installArtifact(test_exe);

    // Build the test_connection_v2 executable
    const test_exe_v2 = b.addExecutable(.{
        .name = "test_connection_v2",
        .root_module = b.createModule(.{
            .root_source_file = b.path("test_connection_v2.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    test_exe_v2.root_module.addImport("geode_client", geode_client_mod);
    test_exe_v2.root_module.addImport("vendor_quic", quic_modules.quic_api);

    test_exe_v2.linkLibC();
    test_exe_v2.linkSystemLibrary("ssl");
    test_exe_v2.linkSystemLibrary("crypto");
    if (target.result.os.tag == .linux) {
        test_exe_v2.linkSystemLibrary("dl");
    }

    b.installArtifact(test_exe_v2);

    // Run command
    const run_test = b.addRunArtifact(test_exe);
    run_test.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the test");
    run_step.dependOn(&run_test.step);

    const run_test_v2 = b.addRunArtifact(test_exe_v2);
    run_test_v2.step.dependOn(b.getInstallStep());

    const run_step_v2 = b.step("run-v2", "Run the v2 test");
    run_step_v2.dependOn(&run_test_v2.step);
}
