const std = @import("std");
const GeodeClient = @import("geode_client").GeodeClient;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    std.debug.print("=== Geode Zig Client - Simple Example ===\n\n", .{});

    const host = "127.0.0.1";
    const port: u16 = 3141;

    // SECURITY: Default to secure mode; set GEODE_INSECURE=1 for local testing
    const insecure = blk: {
        if (std.process.getEnvVarOwned(allocator, "GEODE_INSECURE")) |val| {
            defer allocator.free(val);
            break :blk std.mem.eql(u8, val, "1") or std.mem.eql(u8, val, "true");
        } else |_| {
            break :blk false;
        }
    };

    var client = try GeodeClient.init(allocator, host, port, insecure, "", "");
    defer client.deinit();

    if (insecure) {
        std.debug.print("WARNING: TLS certificate verification is DISABLED (insecure=true)\n", .{});
        std.debug.print("WARNING: Only use GEODE_INSECURE=1 for local development/testing.\n\n", .{});
    }

    std.debug.print("Connecting to Geode server at {s}:{}...\n", .{ host, port });
    try client.connect();
    try client.openStream();
    std.debug.print("✓ Connected successfully\n", .{});

    // Handshake
    try client.sendHello("geode-zig-example", "1.0.0");
    const hello_response = try client.receiveMessage();
    defer allocator.free(hello_response);

    // Execute a simple query
    const query = "RETURN 1 AS x ORDER BY x LIMIT 1";
    std.debug.print("\nExecuting query: {s}\n", .{query});
    const request_id = "req_1";
    try client.sendRunGql(request_id, query, null);
    const schema_response = try client.receiveMessage();
    defer allocator.free(schema_response);

    var bindings_response: []u8 = undefined;
    if (try client.tryReceiveBufferedMessage()) |inline_response| {
        bindings_response = inline_response;
    } else {
        try client.sendPull(request_id, 1000);
        bindings_response = try client.receiveMessage();
    }
    defer allocator.free(bindings_response);

    // Process results
    std.debug.print("✓ Query executed successfully\n", .{});
    std.debug.print("Schema response: {s}\n", .{schema_response});
    std.debug.print("Bindings response: {s}\n", .{bindings_response});

    std.debug.print("\n=== Example completed successfully ===\n", .{});
}
