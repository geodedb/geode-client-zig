const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // ========================================================================
    // External Dependencies (from build.zig.zon)
    // ========================================================================

    // QUIC transport protocol - main networking dependency
    const quic_dep = b.dependency("quic", .{
        .target = target,
        .optimize = optimize,
    });
    const quic_mod = quic_dep.module("quic");

    // JSON library for enhanced JSON operations (optional, std.json also available)
    const json_dep = b.dependency("json", .{
        .target = target,
        .optimize = optimize,
    });
    const json_mod = json_dep.module("json");

    // DNS resolution library
    const dns_dep = b.dependency("dns", .{
        .target = target,
        .optimize = optimize,
    });
    const dns_mod = dns_dep.module("dns");

    // Configuration library (YAML, TOML, JSON)
    const config_dep = b.dependency("config", .{
        .target = target,
        .optimize = optimize,
    });
    const config_mod = config_dep.module("config");

    // Structured logging
    const slog_dep = b.dependency("slog", .{
        .target = target,
        .optimize = optimize,
    });
    const slog_mod = slog_dep.module("slogz");

    // URI parsing
    const uri_dep = b.dependency("uri", .{
        .target = target,
        .optimize = optimize,
    });
    const uri_mod = uri_dep.module("uri");

    // String utilities
    const strings_dep = b.dependency("strings", .{
        .target = target,
        .optimize = optimize,
    });
    const strings_mod = strings_dep.module("strings");

    // ========================================================================
    // Geode Client Module
    // ========================================================================

    // Create geode_client module with all dependencies
    const geode_client_mod = b.createModule(.{
        .root_source_file = b.path("geode_client_v2.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Add QUIC as the primary transport dependency
    geode_client_mod.addImport("quic", quic_mod);

    // Add optional utility dependencies
    geode_client_mod.addImport("json", json_mod);
    geode_client_mod.addImport("dns", dns_mod);
    geode_client_mod.addImport("config", config_mod);
    geode_client_mod.addImport("slog", slog_mod);
    geode_client_mod.addImport("uri", uri_mod);
    geode_client_mod.addImport("strings", strings_mod);

    // Export geode_client module for dependents
    _ = b.addModule("geode_client", .{
        .root_source_file = b.path("geode_client_v2.zig"),
        .imports = &.{
            .{ .name = "quic", .module = quic_mod },
            .{ .name = "json", .module = json_mod },
            .{ .name = "dns", .module = dns_mod },
            .{ .name = "config", .module = config_mod },
            .{ .name = "slog", .module = slog_mod },
            .{ .name = "uri", .module = uri_mod },
            .{ .name = "strings", .module = strings_mod },
        },
    });

    // ========================================================================
    // Test Executables
    // ========================================================================

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
    test_exe.root_module.addImport("quic", quic_mod);

    // Link system libraries required by QUIC
    test_exe.linkLibC();
    if (target.result.os.tag != .windows) {
        test_exe.linkSystemLibrary("ssl");
        test_exe.linkSystemLibrary("crypto");
    }
    if (target.result.os.tag == .linux) {
        test_exe.linkSystemLibrary("dl");
    }
    if (target.result.os.tag == .windows) {
        test_exe.linkSystemLibrary("ws2_32");
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
    test_exe_v2.root_module.addImport("quic", quic_mod);

    // Link system libraries required by QUIC
    test_exe_v2.linkLibC();
    if (target.result.os.tag != .windows) {
        test_exe_v2.linkSystemLibrary("ssl");
        test_exe_v2.linkSystemLibrary("crypto");
    }
    if (target.result.os.tag == .linux) {
        test_exe_v2.linkSystemLibrary("dl");
    }
    if (target.result.os.tag == .windows) {
        test_exe_v2.linkSystemLibrary("ws2_32");
    }

    b.installArtifact(test_exe_v2);

    // ========================================================================
    // Run Commands
    // ========================================================================

    const run_test = b.addRunArtifact(test_exe);
    run_test.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the test");
    run_step.dependOn(&run_test.step);

    const run_test_v2 = b.addRunArtifact(test_exe_v2);
    run_test_v2.step.dependOn(b.getInstallStep());

    const run_step_v2 = b.step("run-v2", "Run the v2 test");
    run_step_v2.dependOn(&run_test_v2.step);

    // ========================================================================
    // Unit Tests
    // ========================================================================

    const unit_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("geode_client_v2.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    unit_tests.root_module.addImport("quic", quic_mod);
    unit_tests.root_module.addImport("json", json_mod);
    unit_tests.root_module.addImport("dns", dns_mod);
    unit_tests.root_module.addImport("config", config_mod);
    unit_tests.root_module.addImport("slog", slog_mod);
    unit_tests.root_module.addImport("uri", uri_mod);
    unit_tests.root_module.addImport("strings", strings_mod);

    unit_tests.linkLibC();
    if (target.result.os.tag != .windows) {
        unit_tests.linkSystemLibrary("ssl");
        unit_tests.linkSystemLibrary("crypto");
    }
    if (target.result.os.tag == .linux) {
        unit_tests.linkSystemLibrary("dl");
    }

    const run_unit_tests = b.addRunArtifact(unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
}
