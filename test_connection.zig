const std = @import("std");
const GeodeClient = @import("geode_client").GeodeClient;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    std.debug.print("Creating Geode client...\n", .{});
    var host: []const u8 = "127.0.0.1";
    var port: u16 = 3141;

    if (std.process.getEnvVarOwned(allocator, "GEODE_SERVER")) |env_addr| {
        defer allocator.free(env_addr);
        if (std.mem.indexOf(u8, env_addr, ":")) |idx| {
            // We need to duplicate the host part because env_addr will be freed
            host = try allocator.dupe(u8, env_addr[0..idx]);
            port = try std.fmt.parseInt(u16, env_addr[idx + 1 ..], 10);
        }
    } else |_| {}

    var client = GeodeClient.init(allocator, host, port, true);
    defer client.deinit();

    std.debug.print("Attempting to connect...\n", .{});
    client.connect() catch |err| {
        std.debug.print("Connection failed: {}\n", .{err});
        return err;
    };

    std.debug.print("✓ Connected successfully!\n", .{});

    std.debug.print("Opening stream...\n", .{});
    client.openStream() catch |err| {
        std.debug.print("Stream open failed: {}\n", .{err});
        return err;
    };

    std.debug.print("✓ Stream opened successfully!\n", .{});

    std.debug.print("Sending HELLO...\n", .{});
    client.sendHello("test-client", "1.0.0") catch |err| {
        std.debug.print("Send HELLO failed: {}\n", .{err});
        return err;
    };

    std.debug.print("✓ HELLO sent!\n", .{});

    std.debug.print("Receiving response...\n", .{});
    const response = client.receiveMessage(30000) catch |err| {
        std.debug.print("Receive failed: {}\n", .{err});
        return err;
    };
    defer allocator.free(response);

    std.debug.print("✓ Received response: {s}\n", .{response});
}
