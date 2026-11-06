const std = @import("std");

/// Link system libraries required by QUIC/TLS transport.
fn linkSystemDeps(step: *std.Build.Step.Compile, target: std.Build.ResolvedTarget) void {
    step.root_module.link_libc = true;
    if (target.result.os.tag != .windows) {
        step.root_module.linkSystemLibrary("ssl", .{});
        step.root_module.linkSystemLibrary("crypto", .{});
    }
    if (target.result.os.tag == .linux) {
        step.root_module.linkSystemLibrary("dl", .{});
    }
    if (target.result.os.tag == .windows) {
        step.root_module.linkSystemLibrary("ws2_32", .{});
    }
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // ========================================================================
    // Build options
    // ========================================================================

    // -Dwith_otel: compile in otel instrumentation. OFF by default;
    // when off the otel dependency is never resolved (it's marked
    // `lazy = true` in build.zig.zon) and the seam in
    // src/observability.zig collapses to comptime-known no-ops so the
    // produced artifacts contain zero otel symbols. Mirrors the seam
    // pattern used by quic, dns, slog, metrics, thread-pool, and gql.
    const with_otel = b.option(
        bool,
        "with_otel",
        "Compile in otel instrumentation (off by default; zero overhead when off)",
    ) orelse false;

    // -Dfips: route security crypto through the OpenSSL FIPS provider.
    // OFF by default; when off the std_shim backend is used (no OpenSSL
    // link, no `fips` dependency resolved). When on, the `fips` lazy dep
    // is fetched and the crypto_backend module routes all crypto primitives
    // through the validated OpenSSL FIPS provider. Mirrors the seam pattern
    // used by quic/tls for their own openssl binding.
    const fips = b.option(
        bool,
        "fips",
        "Route security crypto through the OpenSSL FIPS provider (default false = std.crypto shim)",
    ) orelse false;
    const openssl_path = b.option(
        []const u8,
        "openssl_path",
        "OpenSSL FIPS install prefix (e.g. /usr/local/ssl)",
    );

    // Materialize ONE shared `build_options` MODULE. Every consumer
    // module imports the SAME module instance via `addImport` to avoid
    // Zig 0.16's "file exists in modules X and X0" error when two
    // independent `addOptions` modules share a transitive file path.
    //
    // The `package` option is a discriminator: every transitive dep
    // (quic, thread-pool, ...) also creates a `build_options` module
    // and Zig caches the synthesized .zig source by content hash. If
    // ours and a transitive dep's `addOptions` produced byte-identical
    // output (e.g. both only declared `with_otel = false`), they would
    // resolve to the SAME cached file. That file would then be the
    // root of two distinct named modules, which Zig rejects with
    // `file exists in modules 'build_options1' and 'build_options'`.
    // Stamping our package name into the options keeps our content
    // unique without touching upstream.
    const build_options = b.addOptions();
    build_options.addOption([]const u8, "package", "geode_client_zig");
    build_options.addOption(bool, "with_otel", with_otel);
    build_options.addOption(bool, "fips", fips);
    build_options.addOption([]const u8, "package_name", "geode-client-zig");
    const build_options_mod = build_options.createModule();

    // ========================================================================
    // External Dependencies (from build.zig.zon)
    // ========================================================================

    // QUIC transport protocol - main networking dependency
    const quic_dep = b.dependency("quic", .{
        .target = target,
        .optimize = optimize,
    });
    const quic_mod = quic_dep.module("quic");

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

    // Thread Pool - direct dependency for WaitGroup, BatchTask,
    // sync primitives, and lane_extension scheduler.
    const thread_pool_dep = b.dependency("thread_pool", .{
        .target = target,
        .optimize = optimize,
    });
    const thread_pool_mod = thread_pool_dep.module("thread_pool");

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
    // cfg_mod uses cb.secureZero — wired after crypto_backend_mod exists below.

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
    pool_mod.addImport("thread_pool", thread_pool_mod);
    pool_mod.addImport("metrics", metrics_mod);

    // Prepared statement module
    const prepared_mod = b.createModule(.{
        .root_source_file = b.path("src/prepared.zig"),
        .target = target,
        .optimize = optimize,
    });
    prepared_mod.addImport("types", types_mod);
    prepared_mod.addImport("validate", validate_mod);

    // Batch module
    const batch_mod = b.createModule(.{
        .root_source_file = b.path("src/batch.zig"),
        .target = target,
        .optimize = optimize,
    });
    batch_mod.addImport("types", types_mod);
    batch_mod.addImport("validate", validate_mod);
    batch_mod.addImport("thread_pool", thread_pool_mod);

    // Client metrics module
    const client_metrics_mod = b.createModule(.{
        .root_source_file = b.path("src/client_metrics.zig"),
        .target = target,
        .optimize = optimize,
    });
    client_metrics_mod.addImport("metrics", metrics_mod);

    // Executor module — shared thread_pool facade.
    const executor_mod = b.createModule(.{
        .root_source_file = b.path("src/executor.zig"),
        .target = target,
        .optimize = optimize,
    });
    executor_mod.addImport("thread_pool", thread_pool_mod);

    // batch_mod depends on executor_mod (Batch.runParallel) — declared
    // after executor_mod exists.
    batch_mod.addImport("executor", executor_mod);

    // Auth module
    const auth_mod = b.createModule(.{
        .root_source_file = b.path("src/auth.zig"),
        .target = target,
        .optimize = optimize,
    });
    auth_mod.addImport("validate", validate_mod);
    auth_mod.addImport("auth_lib", auth_lib_mod);
    auth_mod.addImport("uuid", uuid_mod);
    // auth_mod uses cb.secureZero — wired after crypto_backend_mod exists below.

    // Proto module (protobuf encoding/decoding)
    const proto_mod = b.createModule(.{
        .root_source_file = b.path("src/proto.zig"),
        .target = target,
        .optimize = optimize,
    });

    // gRPC transport module
    const grpc_mod = b.createModule(.{
        .root_source_file = b.path("src/grpc.zig"),
        .target = target,
        .optimize = optimize,
    });
    grpc_mod.addImport("proto", proto_mod);
    // grpc_mod uses cb.secureZero — wired after crypto_backend_mod exists below.

    // Encryption module (client-side field-level encryption config)
    const encryption_mod = b.createModule(.{
        .root_source_file = b.path("src/encryption.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Quote module (GQL identifier/string quoting)
    const quote_mod = b.createModule(.{
        .root_source_file = b.path("src/quote.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Schema module (.gql schema-file parsing)
    const schema_mod = b.createModule(.{
        .root_source_file = b.path("src/schema.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Crypto module (AES-256-GCM field-level encryption)
    const crypto_mod = b.createModule(.{
        .root_source_file = b.path("src/crypto.zig"),
        .target = target,
        .optimize = optimize,
    });
    // crypto_backend_mod import is wired after the seam section below.
    encryption_mod.addImport("crypto", crypto_mod);

    // Redact module
    const redact_mod = b.createModule(.{
        .root_source_file = b.path("src/redact.zig"),
        .target = target,
        .optimize = optimize,
    });
    // gtime module
    const gtime_mod = b.createModule(.{
        .root_source_file = b.path("src/gtime.zig"),
        .target = target,
        .optimize = optimize,
    });
    gtime_mod.addImport("types", types_mod);
    // Retry module
    const retry_mod = b.createModule(.{
        .root_source_file = b.path("src/retry.zig"),
        .target = target,
        .optimize = optimize,
    });
    retry_mod.addImport("error", error_mod);

    // ========================================================================
    // Observability seam (otel)
    // ========================================================================
    //
    // Single shared NAMED module so every consumer (public client,
    // tests, integration tests, benchmarks) resolves
    // `@import("observability")` to the same source file. Without
    // `addModule`, each consumer that did
    // `b.createModule(.{ .root_source_file = b.path("src/observability.zig"), ... })`
    // would create a distinct module identity for the same file and
    // Zig would fail with "file exists in modules X and X0".
    //
    // The seam's `enabled` flag tracks `build_options.with_otel`; when
    // off, every helper compiles to a comptime-known no-op and the
    // otel dependency is never resolved. See src/observability.zig.
    const observability_mod = b.addModule("observability", .{
        .root_source_file = b.path("src/observability.zig"),
        .target = target,
        .optimize = optimize,
    });
    observability_mod.addImport("build_options", build_options_mod);

    // Gated otel dependency. The `lazy = true` entry in build.zig.zon
    // means Zig only fetches the package when this branch executes;
    // with the flag off the dependency is never resolved and the
    // produced artifacts contain zero otel symbols.
    var otel_mod: ?*std.Build.Module = null;
    var observability_init_mod: ?*std.Build.Module = null;
    if (with_otel) {
        if (b.lazyDependency("otel", .{
            .target = target,
            .optimize = optimize,
        })) |otel_dep| {
            const m = otel_dep.module("otel");
            otel_mod = m;
            // The seam itself imports `otel` when enabled.
            observability_mod.addImport("otel", m);

            // Bootstrap helper. Only registered when `-Dwith_otel=true`
            // so the disabled build never compiles otel-touching code.
            const init_mod = b.addModule("observability_init", .{
                .root_source_file = b.path("src/observability_init.zig"),
                .target = target,
                .optimize = optimize,
            });
            init_mod.addImport("otel", m);
            init_mod.addImport("observability", observability_mod);
            observability_init_mod = init_mod;
        }
    }

    // ========================================================================
    // Crypto Backend Seam (fips / std_shim)
    // ========================================================================
    //
    // Single shared crypto_backend module. When -Dfips=false the module
    // delegates to the local std_shim (zero OpenSSL link, no `fips` dep).
    // When -Dfips=true the lazy `fips` dep is resolved, the fips backend
    // is wired in, and OpenSSL is linked via the canonical link.zig helper.
    //
    // Only the smoke test (and future crypto call sites) import this module.
    // Full call-site wiring is a later task.
    const policy_mod = b.createModule(.{
        .root_source_file = b.path("src/policy.zig"),
        .target = target,
        .optimize = optimize,
    });
    _ = policy_mod; // policy.zig is imported directly by std_shim via @import("policy.zig")

    const std_shim_mod = b.createModule(.{
        .root_source_file = b.path("src/std_shim.zig"),
        .target = target,
        .optimize = optimize,
    });

    const crypto_backend_mod = b.createModule(.{
        .root_source_file = b.path("src/crypto_backend.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "build_options", .module = build_options_mod },
            .{ .name = "std_shim", .module = std_shim_mod },
        },
    });

    // Lazy fips dependency: only resolved under -Dfips=true. When false
    // the `fips` dep is never fetched and no OpenSSL is linked. The import
    // `@import("fips")` inside crypto_backend.zig is only reached at
    // comptime when build_options.fips is true, so the missing module is
    // never a linker issue under the default build.
    if (fips) {
        const link_helper = @import("src/link.zig");
        if (b.lazyDependency("fips", .{ .target = target, .optimize = optimize })) |fips_dep| {
            crypto_backend_mod.addImport("fips", fips_dep.module("fips"));
            // linkOpenssl on crypto_backend_mod PROPAGATES to every artifact
            // that imports it (crypto/auth/config/grpc modules + their test
            // exes), so individual artifacts need no separate linkOpenssl call.
            // A routed module compiled into an artifact must reach the seam via
            // this import for the propagation to apply.
            link_helper.linkOpenssl(b, crypto_backend_mod, openssl_path);
        }
    }

    // Wire crypto_backend into crypto_mod now that crypto_backend_mod exists.
    // (crypto_mod is declared earlier in the file; the import must follow
    // crypto_backend_mod's creation.)
    crypto_mod.addImport("crypto_backend", crypto_backend_mod);

    // Wire crypto_backend into cfg_mod, auth_mod, and grpc_mod (Task 4 + Task 5: secureZero seam).
    // These modules are declared before crypto_backend_mod, so the addImport
    // calls are deferred to here.
    cfg_mod.addImport("crypto_backend", crypto_backend_mod);
    auth_mod.addImport("crypto_backend", crypto_backend_mod);
    grpc_mod.addImport("crypto_backend", crypto_backend_mod);

    // ========================================================================
    // Geode Client Module
    // ========================================================================
    //
    // Single named module rooted at `geode_client_v2.zig`. Previously
    // this file declared TWO modules with the same root source file
    // (`geode_client_mod` via `b.createModule` for internal use plus
    // `public_geode_client` via `b.addModule` for export). Zig 0.16
    // rejects that with "file exists in modules X and X0" because it
    // refuses to let one source file be the root of multiple modules
    // — see geode/scripts/detect_diamond_deps.py for the cross-repo
    // detection harness. The single-module pattern below mirrors what
    // thread-pool / wal / quic / etc. already do.
    const geode_client_mod = b.addModule("geode_client", .{
        .root_source_file = b.path("geode_client_v2.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "quic", .module = quic_mod },
            .{ .name = "uuid", .module = uuid_mod },
            .{ .name = "proto", .module = proto_mod },
            .{ .name = "config", .module = cfg_mod },
            .{ .name = "grpc", .module = grpc_mod },
            .{ .name = "encryption", .module = encryption_mod },
            .{ .name = "executor", .module = executor_mod },
            .{ .name = "thread_pool", .module = thread_pool_mod },
            .{ .name = "observability", .module = observability_mod },
        },
    });
    if (observability_init_mod) |m| geode_client_mod.addImport("observability_init", m);
    if (otel_mod) |m| geode_client_mod.addImport("otel", m);

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

    linkSystemDeps(test_exe, target);

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

    linkSystemDeps(test_exe_v2, target);

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

    const ca_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/ca_bundle.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    ca_tests.root_module.addImport("quic", quic_mod);
    const run_ca_tests = b.addRunArtifact(ca_tests);
    test_step.dependOn(&run_ca_tests.step);
    const ca_step = b.step("test-ca-bundle", "Test bounded owned QUIC CA bundles");
    ca_step.dependOn(&run_ca_tests.step);

    // Exercise the non-FIPS backend with real OS entropy on each native target.
    const entropy_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/portable_entropy_test.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    entropy_tests.root_module.addImport("std_shim", std_shim_mod);
    const run_entropy_tests = b.addRunArtifact(entropy_tests);
    test_step.dependOn(&run_entropy_tests.step);
    const entropy_step = b.step("test-portable-entropy", "Test portable OS entropy and signing");
    entropy_step.dependOn(&run_entropy_tests.step);
    const entropy_check = b.step("check-portable-entropy", "Compile portable entropy tests without running");
    entropy_check.dependOn(&entropy_tests.step);

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
    config_tests.root_module.addImport("crypto_backend", crypto_backend_mod);
    if (fips) {
        const link_helper = @import("src/link.zig");
        link_helper.linkOpenssl(b, config_tests.root_module, openssl_path);
    }
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
    pool_tests.root_module.addImport("thread_pool", thread_pool_mod);
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
    batch_tests.root_module.addImport("thread_pool", thread_pool_mod);
    batch_tests.root_module.addImport("executor", executor_mod);
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
    auth_tests.root_module.addImport("crypto_backend", crypto_backend_mod);
    if (fips) {
        const link_helper = @import("src/link.zig");
        link_helper.linkOpenssl(b, auth_tests.root_module, openssl_path);
    }
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

    // Test executor module
    const executor_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/executor.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    executor_tests.root_module.addImport("thread_pool", thread_pool_mod);
    const run_executor_tests = b.addRunArtifact(executor_tests);
    test_step.dependOn(&run_executor_tests.step);

    // Test encryption module
    const encryption_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/encryption.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    encryption_tests.root_module.addImport("crypto", crypto_mod);
    if (fips) {
        const link_helper = @import("src/link.zig");
        link_helper.linkOpenssl(b, encryption_tests.root_module, openssl_path);
    }
    const run_encryption_tests = b.addRunArtifact(encryption_tests);
    test_step.dependOn(&run_encryption_tests.step);

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
    grpc_tests.root_module.addImport("crypto_backend", crypto_backend_mod);
    if (fips) {
        const link_helper = @import("src/link.zig");
        link_helper.linkOpenssl(b, grpc_tests.root_module, openssl_path);
    }
    const run_grpc_tests = b.addRunArtifact(grpc_tests);
    test_step.dependOn(&run_grpc_tests.step);

    // Test quote module
    const quote_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/quote.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_quote_tests = b.addRunArtifact(quote_tests);
    test_step.dependOn(&run_quote_tests.step);

    // Test redact module
    const redact_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/redact.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_redact_tests = b.addRunArtifact(redact_tests);
    test_step.dependOn(&run_redact_tests.step);

    // Test schema module
    const schema_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/schema.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_schema_tests = b.addRunArtifact(schema_tests);
    test_step.dependOn(&run_schema_tests.step);

    // Test gtime module
    const gtime_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/gtime.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    gtime_tests.root_module.addImport("types", types_mod);
    const run_gtime_tests = b.addRunArtifact(gtime_tests);
    test_step.dependOn(&run_gtime_tests.step);

    // Test crypto module
    const crypto_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/crypto.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    crypto_tests.root_module.addImport("crypto_backend", crypto_backend_mod);
    if (fips) {
        const link_helper = @import("src/link.zig");
        link_helper.linkOpenssl(b, crypto_tests.root_module, openssl_path);
    }
    const run_crypto_tests = b.addRunArtifact(crypto_tests);
    test_step.dependOn(&run_crypto_tests.step);

    // Test retry module
    const retry_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/retry.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    retry_tests.root_module.addImport("error", error_mod);
    const run_retry_tests = b.addRunArtifact(retry_tests);
    test_step.dependOn(&run_retry_tests.step);

    // Exercise the exact transport deadline helpers without mutating the
    // public client's link requirements for downstream cross-compilation.
    const deadline_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/deadline.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_deadline_tests = b.addRunArtifact(deadline_tests);
    test_step.dependOn(&run_deadline_tests.step);
    const deadline_step = b.step("test-client-deadlines", "Test native client deadline accounting");
    deadline_step.dependOn(&run_deadline_tests.step);

    // Test geode_client module — DELETED 2026-05-01. Previously this
    // block did `b.addTest(.{ .root_module = geode_client_mod })`
    // followed by `linkSystemDeps(client_tests, target)`. Because
    // `client_tests.root_module` IS the shared `geode_client_mod`
    // (the dup-root fix from 0afe8c6), linkSystemDeps' calls
    // (link_libc + linkSystemLibrary("ssl") + ("crypto") + ("dl"))
    // MUTATED the shared public module, propagating the ssl/crypto
    // link requirement to every downstream consumer (geode's
    // gql / geode-auth / generate_* tooling exes). CI cross-compile
    // to x86_64-linux-gnu (no host libssl-dev for the cross target)
    // then failed with "unable to find dynamic system library 'ssl'"
    // — geode pipeline #1013/#1014.
    //
    // The geode_client module is exercised by integration_tests +
    // runner_integration_tests below (which import it BY NAME instead
    // of using it as their root_module, avoiding the mutation), so
    // dropping this test artifact loses no coverage. Restoring it
    // would require a wrapper module that imports geode_client by
    // name (not as root) and applies linkSystemDeps to the wrapper
    // only.

    // Test observability seam (covers both -Dwith_otel=false comptime
    // no-op path and the enabled path; the enabled path's `global`
    // tracer remains null so spans collapse to no-op `Span{}`).
    const observability_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/observability.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    observability_tests.root_module.addImport("build_options", build_options_mod);
    if (otel_mod) |m| observability_tests.root_module.addImport("otel", m);
    const run_observability_tests = b.addRunArtifact(observability_tests);
    test_step.dependOn(&run_observability_tests.step);

    // Smoke test: thread_pool module is wired.
    const tp_smoke = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/smoke_thread_pool.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    tp_smoke.root_module.addImport("thread_pool", thread_pool_mod);
    const run_tp_smoke = b.addRunArtifact(tp_smoke);
    test_step.dependOn(&run_tp_smoke.step);

    // Smoke test: crypto_backend seam resolves and a hash works in both
    // -Dfips=false (std_shim) and -Dfips=true (OpenSSL FIPS) modes.
    const cb_smoke = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/crypto_backend_smoke_test.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    cb_smoke.root_module.addImport("crypto_backend", crypto_backend_mod);
    // Under -Dfips=true the test binary must also link OpenSSL so the
    // fips backend can load at runtime. Mirror the fips-mode link used by
    // the module itself.
    if (fips) {
        const link_helper = @import("src/link.zig");
        link_helper.linkOpenssl(b, cb_smoke.root_module, openssl_path);
    }
    const run_cb_smoke = b.addRunArtifact(cb_smoke);
    test_step.dependOn(&run_cb_smoke.step);

    // Parity / KAT test: asserts KNOWN-CORRECT outputs (SHA-256, HMAC-SHA256,
    // AES-256-GCM, HKDF-SHA256) via the crypto_backend seam, proving both
    // correctness AND backend parity under -Dfips=false and -Dfips=true.
    const fips_parity = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/fips_parity_test.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    fips_parity.root_module.addImport("crypto_backend", crypto_backend_mod);
    if (fips) {
        const link_helper = @import("src/link.zig");
        link_helper.linkOpenssl(b, fips_parity.root_module, openssl_path);
    }
    const run_fips_parity = b.addRunArtifact(fips_parity);
    test_step.dependOn(&run_fips_parity.step);

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

    linkSystemDeps(integration_tests, target);

    const run_integration_tests = b.addRunArtifact(integration_tests);
    integration_test_step.dependOn(&run_integration_tests.step);

    // Executor integration test (live Geode server required)
    const runner_integration_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/executor_integration.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    runner_integration_tests.root_module.addImport("thread_pool", thread_pool_mod);
    runner_integration_tests.root_module.addImport("executor", executor_mod);
    runner_integration_tests.root_module.addImport("geode_client", geode_client_mod);
    runner_integration_tests.root_module.addImport("quic", quic_mod);
    linkSystemDeps(runner_integration_tests, target);
    const run_runner_integration_tests = b.addRunArtifact(runner_integration_tests);
    integration_test_step.dependOn(&run_runner_integration_tests.step);

    // Parity feature integration tests (compile always; server tests skip).
    const parity_integration_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/parity_integration.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    parity_integration_tests.root_module.addImport("quote", quote_mod);
    parity_integration_tests.root_module.addImport("redact", redact_mod);
    parity_integration_tests.root_module.addImport("schema", schema_mod);
    parity_integration_tests.root_module.addImport("gtime", gtime_mod);
    parity_integration_tests.root_module.addImport("crypto", crypto_mod);
    parity_integration_tests.root_module.addImport("retry", retry_mod);
    // parity_integration.zig uses std.c.getenv (serverConfigured), which
    // requires libc to be explicitly linked. linkSystemDeps sets link_libc,
    // matching how integration_tests / runner_integration_tests are built.
    linkSystemDeps(parity_integration_tests, target);
    if (fips) {
        const link_helper = @import("src/link.zig");
        link_helper.linkOpenssl(b, parity_integration_tests.root_module, openssl_path);
    }
    const run_parity_integration_tests = b.addRunArtifact(parity_integration_tests);
    integration_test_step.dependOn(&run_parity_integration_tests.step);

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
    bench_exe.root_module.addImport("proto", proto_mod);
    bench_exe.root_module.addImport("crypto", crypto_mod);
    if (fips) {
        const link_helper = @import("src/link.zig");
        link_helper.linkOpenssl(b, bench_exe.root_module, openssl_path);
    }

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
    benchmark_exe.root_module.addImport("executor", executor_mod);
    benchmark_exe.root_module.addImport("thread_pool", thread_pool_mod);

    linkSystemDeps(benchmark_exe, target);

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

    // Fuzz quote helpers
    const fuzz_quote = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("fuzz/fuzz_quote.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    fuzz_quote.root_module.addImport("quote", quote_mod);
    const run_fuzz_quote = b.addRunArtifact(fuzz_quote);
    fuzz_step.dependOn(&run_fuzz_quote.step);

    // Fuzz schema parsing
    const fuzz_schema = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("fuzz/fuzz_schema.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    fuzz_schema.root_module.addImport("schema", schema_mod);
    const run_fuzz_schema = b.addRunArtifact(fuzz_schema);
    fuzz_step.dependOn(&run_fuzz_schema.step);

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
