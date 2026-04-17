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
    host_owned: bool,
};

fn getServerAddr(allocator: std.mem.Allocator) ServerAddr {
    const dsn = std.process.getEnvVarOwned(allocator, "GEODE_SERVER") catch {
        return .{ .host = "127.0.0.1", .port = 3141, .insecure = true, .host_owned = false };
    };
    defer allocator.free(dsn);

    const colon = std.mem.lastIndexOfScalar(u8, dsn, ':') orelse {
        const owned = allocator.dupe(u8, dsn) catch "127.0.0.1";
        return .{ .host = owned, .port = 3141, .insecure = true, .host_owned = true };
    };
    const port = std.fmt.parseInt(u16, dsn[colon + 1 ..], 10) catch 3141;
    const host_copy = allocator.dupe(u8, dsn[0..colon]) catch "127.0.0.1";
    return .{ .host = host_copy, .port = port, .insecure = true, .host_owned = true };
}

test "executor runs a real ping on blocking lane" {
    const addr = getServerAddr(std.testing.allocator);
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
        result: std.atomic.Value(bool),

        fn run(raw: *anyopaque, _: *tp.TaskContext) void {
            const self: *@This() = @ptrCast(@alignCast(raw));
            var client = geode.GeodeClient.init(
                std.testing.allocator,
                self.host,
                self.port,
                self.insecure,
                "admin",
                "admin",
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
        .result = std.atomic.Value(bool).init(false),
    };

    const handle = try runner.submit(Ctx.run, &ctx, .blocking);
    try runner.wait(handle);
    try std.testing.expect(ctx.result.load(.acquire));
}
