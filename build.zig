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

    // Protocol Buffers - same as geode server
    const protobuf_dep = b.dependency("protobuf", .{
        .target = target,
        .optimize = optimize,
    });
    const protobuf_mod = protobuf_dep.module("protobuf");

    // gRPC for Zig - same as geode server
    const grpc_zig_dep = b.dependency("grpc_zig", .{
        .target = target,
        .optimize = optimize,
    });
    const grpc_client_mod = grpc_zig_dep.module("grpc-client");

    // Spice - Fork/join parallelism
    const spice_dep = b.dependency("spice", .{
        .target = target,
        .optimize = optimize,
    });
    const spice_mod = spice_dep.module("spice");

    // UUID - RFC 9562 compliant (V1-V8)
    const uuid_dep = b.dependency("uuid", .{
        .target = target,
        .optimize = optimize,
    });
    const uuid_mod = uuid_dep.module("uuid");

    // Auth library - HMAC chain, API keys, TOTP/MFA primitives
    const auth_lib_dep = b.dependency("auth", .{
        .target = target,
        .optimize = optimize,
    });
    const auth_lib_mod = auth_lib_dep.module("auth");

    // Advanced Types - Network, vector, geographic, URL, range value types
    const advanced_types_dep = b.dependency("advanced_types", .{
        .target = target,
        .optimize = optimize,
    });
    const advanced_types_mod = advanced_types_dep.module("advanced_types");

    // GQL - ISO/IEC 39075:2024 Graph Query Language front-end
    const gql_dep = b.dependency("gql", .{
        .target = target,
        .optimize = optimize,
    });
    const gql_mod = gql_dep.module("gql");

    // Metrics - Counters, gauges, histograms, Prometheus export
    const metrics_dep = b.dependency("metrics", .{
        .target = target,
        .optimize = optimize,
    });
    const metrics_mod = metrics_dep.module("metrics");

    // Concurrency - Thread pool and bounded MPMC queue
    const concurrency_dep = b.dependency("concurrency", .{
        .target = target,
        .optimize = optimize,
    });
    const concurrency_mod = concurrency_dep.module("concurrency");

    // FLE - Field-level encryption with AEAD, HKDF, blind indices
    const fle_dep = b.dependency("fle", .{
        .target = target,
        .optimize = optimize,
    });
    const fle_mod = fle_dep.module("fle");

    // ========================================================================
    // Internal Modules (src/)
    // ========================================================================

    // Error module
    const error_mod = b.createModule(.{
        .root_source_file = b.path("src/error.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Types module
    const types_mod = b.createModule(.{
        .root_source_file = b.path("src/types.zig"),
        .target = target,
        .optimize = optimize,
    });
    types_mod.addImport("error", error_mod);
    types_mod.addImport("advanced_types", advanced_types_mod);

    // Validate module (defined before config because config depends on it)
    const validate_mod = b.createModule(.{
        .root_source_file = b.path("src/validate.zig"),
        .target = target,
        .optimize = optimize,
    });
    validate_mod.addImport("error", error_mod);
    validate_mod.addImport("gql", gql_mod);

    // Config module
    const cfg_mod = b.createModule(.{
        .root_source_file = b.path("src/config.zig"),
        .target = target,
        .optimize = optimize,
    });
    cfg_mod.addImport("error", error_mod);
    cfg_mod.addImport("validate", validate_mod);

    // Query builder module
    const query_builder_mod = b.createModule(.{
        .root_source_file = b.path("src/query_builder.zig"),
        .target = target,
        .optimize = optimize,
    });
    query_builder_mod.addImport("types", types_mod);
    query_builder_mod.addImport("validate", validate_mod);

    // Pool module
    const pool_mod = b.createModule(.{
        .root_source_file = b.path("src/pool.zig"),
        .target = target,
        .optimize = optimize,
    });
    pool_mod.addImport("config", cfg_mod);
    pool_mod.addImport("error", error_mod);
    pool_mod.addImport("concurrency", concurrency_mod);
    pool_mod.addImport("metrics", metrics_mod);

    // Prepared statement module
    const prepared_mod = b.createModule(.{
        .root_source_file = b.path("src/prepared.zig"),
        .target = target,
        .optimize = optimize,
    });
    prepared_mod.addImport("types", types_mod);
    prepared_mod.addImport("validate", validate_mod);

    // Explain/profile module
    const explain_mod = b.createModule(.{
        .root_source_file = b.path("src/explain.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Batch module
    const batch_mod = b.createModule(.{
        .root_source_file = b.path("src/batch.zig"),
        .target = target,
        .optimize = optimize,
    });
    batch_mod.addImport("types", types_mod);
    batch_mod.addImport("validate", validate_mod);

    // Client metrics module
    const client_metrics_mod = b.createModule(.{
        .root_source_file = b.path("src/client_metrics.zig"),
        .target = target,
        .optimize = optimize,
    });
    client_metrics_mod.addImport("metrics", metrics_mod);

    // Auth module
    const auth_mod = b.createModule(.{
        .root_source_file = b.path("src/auth.zig"),
        .target = target,
        .optimize = optimize,
    });
    auth_mod.addImport("validate", validate_mod);
    auth_mod.addImport("auth_lib", auth_lib_mod);
    auth_mod.addImport("uuid", uuid_mod);

    // Proto module (protobuf encoding/decoding)
    const proto_mod = b.createModule(.{
        .root_source_file = b.path("src/proto.zig"),
        .target = target,
        .optimize = optimize,
    });
    proto_mod.addImport("protobuf", protobuf_mod);

    // gRPC transport module
    const grpc_mod = b.createModule(.{
        .root_source_file = b.path("src/grpc.zig"),
        .target = target,
        .optimize = optimize,
    });
    grpc_mod.addImport("proto", proto_mod);
    grpc_mod.addImport("grpc_zig", grpc_client_mod);

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

    // Add internal modules
    geode_client_mod.addImport("error", error_mod);
    geode_client_mod.addImport("types", types_mod);
    geode_client_mod.addImport("config", cfg_mod);
    geode_client_mod.addImport("validate", validate_mod);
    geode_client_mod.addImport("query_builder", query_builder_mod);
    geode_client_mod.addImport("pool", pool_mod);
    geode_client_mod.addImport("prepared", prepared_mod);
    geode_client_mod.addImport("explain", explain_mod);
    geode_client_mod.addImport("batch", batch_mod);
    geode_client_mod.addImport("auth", auth_mod);
    geode_client_mod.addImport("client_metrics", client_metrics_mod);
    geode_client_mod.addImport("proto", proto_mod);
    geode_client_mod.addImport("grpc", grpc_mod);

    // Add external utility dependencies
    geode_client_mod.addImport("json", json_mod);
    geode_client_mod.addImport("dns", dns_mod);
    geode_client_mod.addImport("ext_config", config_mod);
    geode_client_mod.addImport("slog", slog_mod);
    geode_client_mod.addImport("uri", uri_mod);
    geode_client_mod.addImport("strings", strings_mod);
    geode_client_mod.addImport("protobuf", protobuf_mod);
    geode_client_mod.addImport("grpc_zig", grpc_client_mod);
    geode_client_mod.addImport("spice", spice_mod);
    geode_client_mod.addImport("uuid", uuid_mod);
    geode_client_mod.addImport("auth_lib", auth_lib_mod);
    geode_client_mod.addImport("advanced_types", advanced_types_mod);
    geode_client_mod.addImport("gql", gql_mod);
    geode_client_mod.addImport("metrics", metrics_mod);
    geode_client_mod.addImport("concurrency", concurrency_mod);
    geode_client_mod.addImport("fle", fle_mod);

    // Export geode_client module for dependents
    _ = b.addModule("geode_client", .{
        .root_source_file = b.path("geode_client_v2.zig"),
        .imports = &.{
            .{ .name = "quic", .module = quic_mod },
            .{ .name = "error", .module = error_mod },
            .{ .name = "types", .module = types_mod },
            .{ .name = "config", .module = cfg_mod },
            .{ .name = "validate", .module = validate_mod },
            .{ .name = "query_builder", .module = query_builder_mod },
            .{ .name = "pool", .module = pool_mod },
            .{ .name = "prepared", .module = prepared_mod },
            .{ .name = "explain", .module = explain_mod },
            .{ .name = "batch", .module = batch_mod },
            .{ .name = "auth", .module = auth_mod },
            .{ .name = "client_metrics", .module = client_metrics_mod },
            .{ .name = "proto", .module = proto_mod },
            .{ .name = "grpc", .module = grpc_mod },
            .{ .name = "json", .module = json_mod },
            .{ .name = "dns", .module = dns_mod },
            .{ .name = "ext_config", .module = config_mod },
            .{ .name = "slog", .module = slog_mod },
            .{ .name = "uri", .module = uri_mod },
            .{ .name = "strings", .module = strings_mod },
            .{ .name = "protobuf", .module = protobuf_mod },
            .{ .name = "grpc_zig", .module = grpc_client_mod },
            .{ .name = "spice", .module = spice_mod },
            .{ .name = "uuid", .module = uuid_mod },
            .{ .name = "auth_lib", .module = auth_lib_mod },
            .{ .name = "advanced_types", .module = advanced_types_mod },
            .{ .name = "gql", .module = gql_mod },
            .{ .name = "metrics", .module = metrics_mod },
            .{ .name = "concurrency", .module = concurrency_mod },
            .{ .name = "fle", .module = fle_mod },
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

    const test_step = b.step("test", "Run all unit tests");

    // Test error module
    const error_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/error.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_error_tests = b.addRunArtifact(error_tests);
    test_step.dependOn(&run_error_tests.step);

    // Test types module
    const types_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/types.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    types_tests.root_module.addImport("error", error_mod);
    types_tests.root_module.addImport("advanced_types", advanced_types_mod);
    const run_types_tests = b.addRunArtifact(types_tests);
    test_step.dependOn(&run_types_tests.step);

    // Test config module
    const config_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/config.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    config_tests.root_module.addImport("error", error_mod);
    config_tests.root_module.addImport("validate", validate_mod);
    const run_config_tests = b.addRunArtifact(config_tests);
    test_step.dependOn(&run_config_tests.step);

    // Test validate module
    const validate_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/validate.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    validate_tests.root_module.addImport("error", error_mod);
    validate_tests.root_module.addImport("gql", gql_mod);
    const run_validate_tests = b.addRunArtifact(validate_tests);
    test_step.dependOn(&run_validate_tests.step);

    // Test query_builder module
    const qb_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/query_builder.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    qb_tests.root_module.addImport("types", types_mod);
    qb_tests.root_module.addImport("validate", validate_mod);
    const run_qb_tests = b.addRunArtifact(qb_tests);
    test_step.dependOn(&run_qb_tests.step);

    // Test pool module
    const pool_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/pool.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    pool_tests.root_module.addImport("config", cfg_mod);
    pool_tests.root_module.addImport("error", error_mod);
    pool_tests.root_module.addImport("concurrency", concurrency_mod);
    pool_tests.root_module.addImport("metrics", metrics_mod);
    const run_pool_tests = b.addRunArtifact(pool_tests);
    test_step.dependOn(&run_pool_tests.step);

    // Test prepared module
    const prepared_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/prepared.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    prepared_tests.root_module.addImport("types", types_mod);
    prepared_tests.root_module.addImport("validate", validate_mod);
    const run_prepared_tests = b.addRunArtifact(prepared_tests);
    test_step.dependOn(&run_prepared_tests.step);

    // Test explain module
    const explain_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/explain.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_explain_tests = b.addRunArtifact(explain_tests);
    test_step.dependOn(&run_explain_tests.step);

    // Test batch module
    const batch_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/batch.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    batch_tests.root_module.addImport("types", types_mod);
    batch_tests.root_module.addImport("validate", validate_mod);
    const run_batch_tests = b.addRunArtifact(batch_tests);
    test_step.dependOn(&run_batch_tests.step);

    // Test auth module
    const auth_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/auth.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    auth_tests.root_module.addImport("validate", validate_mod);
    auth_tests.root_module.addImport("auth_lib", auth_lib_mod);
    auth_tests.root_module.addImport("uuid", uuid_mod);
    const run_auth_tests = b.addRunArtifact(auth_tests);
    test_step.dependOn(&run_auth_tests.step);

    // Test client_metrics module
    const client_metrics_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/client_metrics.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    client_metrics_tests.root_module.addImport("metrics", metrics_mod);
    const run_client_metrics_tests = b.addRunArtifact(client_metrics_tests);
    test_step.dependOn(&run_client_metrics_tests.step);

    // Test proto module
    const proto_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/proto.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_proto_tests = b.addRunArtifact(proto_tests);
    test_step.dependOn(&run_proto_tests.step);

    // Test grpc module
    const grpc_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/grpc.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    grpc_tests.root_module.addImport("proto", proto_mod);
    const run_grpc_tests = b.addRunArtifact(grpc_tests);
    test_step.dependOn(&run_grpc_tests.step);

    // Test geode_client module
    const client_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("geode_client_v2.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    client_tests.root_module.addImport("quic", quic_mod);
    client_tests.root_module.addImport("error", error_mod);
    client_tests.root_module.addImport("types", types_mod);
    client_tests.root_module.addImport("config", cfg_mod);
    client_tests.root_module.addImport("validate", validate_mod);
    client_tests.root_module.addImport("query_builder", query_builder_mod);
    client_tests.root_module.addImport("pool", pool_mod);
    client_tests.root_module.addImport("prepared", prepared_mod);
    client_tests.root_module.addImport("explain", explain_mod);
    client_tests.root_module.addImport("batch", batch_mod);
    client_tests.root_module.addImport("auth", auth_mod);
    client_tests.root_module.addImport("client_metrics", client_metrics_mod);
    client_tests.root_module.addImport("proto", proto_mod);
    client_tests.root_module.addImport("grpc", grpc_mod);
    client_tests.root_module.addImport("json", json_mod);
    client_tests.root_module.addImport("dns", dns_mod);
    client_tests.root_module.addImport("ext_config", config_mod);
    client_tests.root_module.addImport("slog", slog_mod);
    client_tests.root_module.addImport("uri", uri_mod);
    client_tests.root_module.addImport("strings", strings_mod);
    client_tests.root_module.addImport("protobuf", protobuf_mod);
    client_tests.root_module.addImport("grpc_zig", grpc_client_mod);
    client_tests.root_module.addImport("spice", spice_mod);
    client_tests.root_module.addImport("uuid", uuid_mod);
    client_tests.root_module.addImport("auth_lib", auth_lib_mod);
    client_tests.root_module.addImport("advanced_types", advanced_types_mod);
    client_tests.root_module.addImport("gql", gql_mod);
    client_tests.root_module.addImport("metrics", metrics_mod);
    client_tests.root_module.addImport("concurrency", concurrency_mod);
    client_tests.root_module.addImport("fle", fle_mod);

    client_tests.linkLibC();
    if (target.result.os.tag != .windows) {
        client_tests.linkSystemLibrary("ssl");
        client_tests.linkSystemLibrary("crypto");
    }
    if (target.result.os.tag == .linux) {
        client_tests.linkSystemLibrary("dl");
    }

    const run_client_tests = b.addRunArtifact(client_tests);
    test_step.dependOn(&run_client_tests.step);

    // ========================================================================
    // Integration Tests
    // ========================================================================

    const integration_test_step = b.step("test-integration", "Run integration tests (requires Geode server)");

    const integration_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/integration.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    integration_tests.root_module.addImport("geode_client", geode_client_mod);
    integration_tests.root_module.addImport("quic", quic_mod);

    // Link system libraries required by QUIC
    integration_tests.linkLibC();
    if (target.result.os.tag != .windows) {
        integration_tests.linkSystemLibrary("ssl");
        integration_tests.linkSystemLibrary("crypto");
    }
    if (target.result.os.tag == .linux) {
        integration_tests.linkSystemLibrary("dl");
    }
    if (target.result.os.tag == .windows) {
        integration_tests.linkSystemLibrary("ws2_32");
    }

    const run_integration_tests = b.addRunArtifact(integration_tests);
    integration_test_step.dependOn(&run_integration_tests.step);

    // ========================================================================
    // Benchmarks
    // ========================================================================

    const bench_exe = b.addExecutable(.{
        .name = "bench",
        .root_module = b.createModule(.{
            .root_source_file = b.path("benchmarks/bench.zig"),
            .target = target,
            .optimize = .ReleaseFast, // Always use ReleaseFast for benchmarks
        }),
    });

    // Add internal modules
    bench_exe.root_module.addImport("types", types_mod);
    bench_exe.root_module.addImport("query_builder", query_builder_mod);
    bench_exe.root_module.addImport("config", cfg_mod);
    bench_exe.root_module.addImport("pool", pool_mod);
    bench_exe.root_module.addImport("validate", validate_mod);
    bench_exe.root_module.addImport("error", error_mod);

    b.installArtifact(bench_exe);

    const run_bench = b.addRunArtifact(bench_exe);
    run_bench.step.dependOn(b.getInstallStep());

    const bench_step = b.step("bench", "Run performance benchmarks");
    bench_step.dependOn(&run_bench.step);

    // ========================================================================
    // Native Client Benchmark (for server throughput testing)
    // ========================================================================

    const benchmark_exe = b.addExecutable(.{
        .name = "benchmark",
        .root_module = b.createModule(.{
            .root_source_file = b.path("benchmark.zig"),
            .target = target,
            .optimize = .ReleaseFast, // Always use ReleaseFast for benchmarks
        }),
    });

    benchmark_exe.root_module.addImport("geode_client", geode_client_mod);
    benchmark_exe.root_module.addImport("quic", quic_mod);

    // Link system libraries required by QUIC
    benchmark_exe.linkLibC();
    if (target.result.os.tag != .windows) {
        benchmark_exe.linkSystemLibrary("ssl");
        benchmark_exe.linkSystemLibrary("crypto");
    }
    if (target.result.os.tag == .linux) {
        benchmark_exe.linkSystemLibrary("dl");
    }
    if (target.result.os.tag == .windows) {
        benchmark_exe.linkSystemLibrary("ws2_32");
    }

    b.installArtifact(benchmark_exe);

    const run_benchmark = b.addRunArtifact(benchmark_exe);
    run_benchmark.step.dependOn(b.getInstallStep());
    if (b.args) |args_slice| {
        run_benchmark.addArgs(args_slice);
    }

    const benchmark_step = b.step("benchmark", "Run native client benchmark");
    benchmark_step.dependOn(&run_benchmark.step);

    // ========================================================================
    // Property-Based / Fuzz Tests
    // ========================================================================

    const fuzz_step = b.step("test-fuzz", "Run property-based and fuzz tests");

    // Fuzz DSN parsing
    const fuzz_dsn = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("fuzz/fuzz_dsn.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    fuzz_dsn.root_module.addImport("config", cfg_mod);
    const run_fuzz_dsn = b.addRunArtifact(fuzz_dsn);
    fuzz_step.dependOn(&run_fuzz_dsn.step);

    // Fuzz types/Value
    const fuzz_types = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("fuzz/fuzz_types.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    fuzz_types.root_module.addImport("types", types_mod);
    const run_fuzz_types = b.addRunArtifact(fuzz_types);
    fuzz_step.dependOn(&run_fuzz_types.step);

    // Fuzz query builder
    const fuzz_qb = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("fuzz/fuzz_query_builder.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    fuzz_qb.root_module.addImport("query_builder", query_builder_mod);
    fuzz_qb.root_module.addImport("validate", validate_mod);
    const run_fuzz_qb = b.addRunArtifact(fuzz_qb);
    fuzz_step.dependOn(&run_fuzz_qb.step);

    // Fuzz validation
    const fuzz_validate = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("fuzz/fuzz_validate.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    fuzz_validate.root_module.addImport("validate", validate_mod);
    const run_fuzz_validate = b.addRunArtifact(fuzz_validate);
    fuzz_step.dependOn(&run_fuzz_validate.step);

    // Fuzz pool
    const fuzz_pool = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("fuzz/fuzz_pool.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    fuzz_pool.root_module.addImport("pool", pool_mod);
    fuzz_pool.root_module.addImport("config", cfg_mod);
    const run_fuzz_pool = b.addRunArtifact(fuzz_pool);
    fuzz_step.dependOn(&run_fuzz_pool.step);
}
