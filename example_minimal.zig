const std = @import("std");
const client = @import("client_minimal.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    std.debug.print("=== Geode Zig Client - Minimal Example ===\n\n", .{});

    const config = client.Config{
        .host = "127.0.0.1",
        .port = 7567,
    };

    var geode_client = client.Client.init(allocator, config);
    defer geode_client.deinit();

    std.debug.print("Connecting to Geode server at {s}:{}...\n", .{ config.host, config.port });
    try geode_client.connect();
    defer geode_client.disconnect();
    std.debug.print("✓ Connected successfully\n", .{});

    std.debug.print("\nExecuting query: RETURN 1 AS x ORDER BY x LIMIT 1\n", .{});
    var result = try geode_client.execute("RETURN 1 AS x ORDER BY x LIMIT 1");
    defer result.deinit();

    std.debug.print("✓ Query executed successfully\n", .{});
    std.debug.print("Schema: {} columns\n", .{result.schema.columns.len});

    for (result.schema.columns) |col| {
        std.debug.print("  - Column: {s} (type: {s})\n", .{ col.name, col.type_name });
    }

    std.debug.print("\n=== Example completed successfully ===\n", .{});
}
