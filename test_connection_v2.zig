const std = @import("std");
const GeodeClient = @import("geode_client").GeodeClient;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Read server address from environment, with defaults
    const env_server = std.posix.getenv("GEODE_SERVER") orelse "127.0.0.1:8443";
    var host: []const u8 = "127.0.0.1";
    var port: u16 = 8443;

    // Parse host:port
    if (std.mem.indexOf(u8, env_server, ":")) |colon_idx| {
        host = env_server[0..colon_idx];
        port = std.fmt.parseInt(u16, env_server[colon_idx + 1 ..], 10) catch 8443;
    } else {
        host = env_server;
    }

    const insecure = std.posix.getenv("GEODE_INSECURE") != null;

    // Resolve hostname to IP address if needed (QUIC library requires numeric IP)
    var resolved_host: []const u8 = host;
    var resolved_host_buf: [64]u8 = undefined;

    // Check if host looks like a hostname (contains letters)
    var needs_resolution = false;
    for (host) |c| {
        if ((c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z')) {
            needs_resolution = true;
            break;
        }
    }

    if (needs_resolution) {
        std.debug.print("Resolving hostname {s}...\n", .{host});
        const list = std.net.getAddressList(allocator, host, port) catch |e| {
            std.debug.print("DNS resolution failed: {}\n", .{e});
            return e;
        };
        defer list.deinit();

        if (list.addrs.len > 0) {
            const addr = list.addrs[0];
            // Format IPv4 address from the sockaddr
            const ip_bytes = @as(*const [4]u8, @ptrCast(&addr.in.sa.addr)).*;
            const len = std.fmt.bufPrint(&resolved_host_buf, "{d}.{d}.{d}.{d}", .{
                ip_bytes[0], ip_bytes[1], ip_bytes[2], ip_bytes[3],
            }) catch {
                std.debug.print("Failed to format IP address\n", .{});
                return error.InvalidAddress;
            };
            resolved_host = resolved_host_buf[0..len.len];
            std.debug.print("Resolved to: {s}\n", .{resolved_host});
        } else {
            std.debug.print("No addresses found\n", .{});
            return error.AddressNotFound;
        }
    }

    std.debug.print("Creating Geode client...\n", .{});
    std.debug.print("Connecting to {s}:{d} (insecure={})\n", .{ resolved_host, port, insecure });
    var client = GeodeClient.init(allocator, resolved_host, port, insecure);
    defer client.deinit();

    std.debug.print("Connecting to server...\n", .{});
    try client.connect();
    std.debug.print("✓ Connected successfully!\n", .{});

    std.debug.print("Opening stream...\n", .{});
    try client.openStream();
    std.debug.print("✓ Stream opened successfully!\n", .{});

    std.debug.print("Sending HELLO...\n", .{});
    try client.sendHello("test-client-v2", "2.0.0");
    std.debug.print("✓ HELLO sent!\n", .{});

    std.debug.print("Receiving HELLO response...\n", .{});
    const hello_response = try client.receiveMessage(2000);
    defer allocator.free(hello_response);
    std.debug.print("✓ HELLO response: {s}\n", .{hello_response});

    std.debug.print("Sending test query...\n", .{});
    try client.sendRunGql(1, "RETURN 1 AS x", null);
    std.debug.print("✓ Query sent!\n", .{});

    std.debug.print("Receiving SCHEMA response...\n", .{});
    const schema_response = try client.receiveMessage(3000);
    defer allocator.free(schema_response);
    std.debug.print("✓ SCHEMA response: {s}\n", .{schema_response});

    std.debug.print("Sending PULL...\n", .{});
    try client.sendPull(1, 1000);
    std.debug.print("✓ PULL sent!\n", .{});

    std.debug.print("Receiving BINDINGS response...\n", .{});
    const bindings_response = try client.receiveMessage(3000);
    defer allocator.free(bindings_response);
    std.debug.print("✓ BINDINGS response: {s}\n", .{bindings_response});

    std.debug.print("\n✅ All tests passed!\n", .{});
}
