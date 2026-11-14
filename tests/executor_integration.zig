// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Integration tests for src/executor.zig against a live Geode server.
//
// Requires a running Geode server. Configure via GEODE_SERVER env var
// (default: 127.0.0.1:3141). Set GEODE_INSECURE=1 to skip TLS verify.
//
// Run with: make test-integration
//          (or GEODE_SERVER=localhost:3141 GEODE_INSECURE=1 make test-integration)

const std = @import("std");
const tp = @import("thread_pool");
const runner_mod = @import("executor");
const geode = @import("geode_client");

const ServerAddr = struct {
    host: []const u8,
    port: u16,
    insecure: bool,
    username: []const u8,
    password: []const u8,
    host_owned: bool,
};

fn getEnvOpt(name: [*:0]const u8) ?[]const u8 {
    if (std.c.getenv(name)) |v| return std.mem.span(v);
    return null;
}

fn getEnvOr(name: [*:0]const u8, default: []const u8) []const u8 {
    return getEnvOpt(name) orelse default;
}

fn defaultPassword() []const u8 {
    return getEnvOpt("GEODE_PASSWORD") orelse
        getEnvOpt("GEODE_DEFAULT_PASSWORD") orelse
        getEnvOr("GEODE_ADMIN_PASSWORD", "geode-test-password");
}

fn getServerAddr(allocator: std.mem.Allocator) !ServerAddr {
    const dsn = getEnvOpt("GEODE_SERVER") orelse {
        return .{
            .host = "127.0.0.1",
            .port = 3141,
            .insecure = true,
            .username = getEnvOr("GEODE_USERNAME", "geode"),
            .password = defaultPassword(),
            .host_owned = false,
        };
    };

    // The DSN host grammar (`[::1]:3141` for IPv6); a bad address is an
    // error, not the default port (SONNY-6494).
    const hp = try geode.config.splitHostPort(dsn, 3141);
    const host_copy = try allocator.dupe(u8, hp.host);
    return .{
        .host = host_copy,
        .port = hp.port,
        .insecure = true,
        .username = getEnvOr("GEODE_USERNAME", "geode"),
        .password = defaultPassword(),
        .host_owned = true,
    };
}

test "executor runs a real ping on blocking lane" {
    const addr = try getServerAddr(std.testing.allocator);
    defer if (addr.host_owned) std.testing.allocator.free(addr.host);

    var runner = try runner_mod.Executor.init(std.testing.allocator, .{
        .max_threads = 4,
        .blocking_workers = 2,
    });
    defer runner.deinit();

    const Ctx = struct {
        host: []const u8,
        port: u16,
        insecure: bool,
        username: []const u8,
        password: []const u8,
        result: std.atomic.Value(bool),

        fn run(raw: *anyopaque, _: *tp.TaskContext) void {
            const self: *@This() = @ptrCast(@alignCast(raw));
            var client = geode.GeodeClient.init(
                std.testing.allocator,
                self.host,
                self.port,
                self.insecure,
                self.username,
                self.password,
            ) catch return;
            defer client.deinit();
            client.connect() catch return;
            client.openStream() catch return;
            client.sendHello() catch return;
            const ok = client.ping() catch false;
            self.result.store(ok, .release);
        }
    };
    var ctx = Ctx{
        .host = addr.host,
        .port = addr.port,
        .insecure = addr.insecure,
        .username = addr.username,
        .password = addr.password,
        .result = std.atomic.Value(bool).init(false),
    };

    const handle = try runner.submit(Ctx.run, &ctx, .blocking);
    try runner.wait(handle);
    try std.testing.expect(ctx.result.load(.acquire));
}
