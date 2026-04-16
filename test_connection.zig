const std = @import("std");
const GeodeClient = @import("geode_client").GeodeClient;

fn getEnvOr(name: [*:0]const u8, default: []const u8) []const u8 {
    if (std.c.getenv(name)) |v| return std.mem.span(v);
    return default;
}

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;

    std.debug.print("Creating Geode client...\n", .{});
    var host: []const u8 = "127.0.0.1";
    var port: u16 = 3141;
    const username = getEnvOr("GEODE_USER", "");
    const password = getEnvOr("GEODE_PASSWORD", "");

    if (init.environ_map.get("GEODE_SERVER")) |env_addr| {
        if (std.mem.indexOf(u8, env_addr, ":")) |idx| {
            host = try allocator.dupe(u8, env_addr[0..idx]);
            port = try std.fmt.parseInt(u16, env_addr[idx + 1 ..], 10);
        } else {
            host = try allocator.dupe(u8, env_addr);
        }
    }

    var client = try GeodeClient.init(allocator, host, port, true, username, password);
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
    client.sendHello() catch |err| {
        std.debug.print("Send HELLO failed: {}\n", .{err});
        return err;
    };

    std.debug.print("✓ HELLO handshake completed!\n", .{});

    std.debug.print("Executing test query...\n", .{});
    var result = client.query("RETURN 1 AS x", null) catch |err| {
        std.debug.print("Query failed: {}\n", .{err});
        return err;
    };
    defer result.deinit();

    if (result.hasError()) {
        std.debug.print("Query returned error: {s}\n", .{result.errorMessage() orelse "unknown"});
    } else {
        std.debug.print("✓ Query succeeded with {d} rows\n", .{result.rows.items.len});
    }
}
