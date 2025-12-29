const std = @import("std");
const GeodeClient = @import("geode_client").GeodeClient;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    std.debug.print("Geode Zig Client Example\n", .{});
    std.debug.print("=========================\n\n", .{});

    // Parse command line args
    var args = try std.process.argsWithAllocator(allocator);
    defer args.deinit();

    _ = args.skip(); // Skip program name

    var host: []const u8 = "localhost";
    var port: u16 = 8443;
    var query: []const u8 = "RETURN 1 AS x";

    while (args.next()) |arg| {
        if (std.mem.eql(u8, arg, "--host")) {
            host = args.next() orelse "localhost";
        } else if (std.mem.eql(u8, arg, "--port")) {
            const port_str = args.next() orelse "8443";
            port = try std.fmt.parseInt(u16, port_str, 10);
        } else if (std.mem.eql(u8, arg, "--query")) {
            query = args.next() orelse "RETURN 1 AS x";
        }
    }

    std.debug.print("Connecting to {s}:{d}\n", .{ host, port });

    // Create and connect client
    var client = GeodeClient.init(allocator, host, port, true); // insecure = true
    defer client.deinit();

    std.debug.print("Initializing connection...\n", .{});
    try client.connect();

    std.debug.print("Opening stream...\n", .{});
    try client.openStream();

    // Send HELLO
    std.debug.print("Sending HELLO...\n", .{});
    try client.sendHello("geode-zig-example", "1.0.0");

    std.debug.print("Waiting for HELLO response...\n", .{});
    const hello_response = try client.receiveMessage();
    defer allocator.free(hello_response);
    std.debug.print("HELLO response: {s}\n\n", .{hello_response});

    // Execute query
    std.debug.print("Executing query: {s}\n", .{query});
    const request_id = "req_example";
    try client.sendRunGql(request_id, query, null);

    std.debug.print("Waiting for SCHEMA response...\n", .{});
    const schema_response = try client.receiveMessage();
    defer allocator.free(schema_response);
    std.debug.print("SCHEMA: {s}\n\n", .{schema_response});

    // Pull results
    std.debug.print("Pulling results...\n", .{});
    try client.sendPull(request_id, 1000);

    std.debug.print("Waiting for BINDINGS response...\n", .{});
    const bindings_response = try client.receiveMessage();
    defer allocator.free(bindings_response);
    std.debug.print("BINDINGS: {s}\n\n", .{bindings_response});

    std.debug.print("Success!\n", .{});
}
