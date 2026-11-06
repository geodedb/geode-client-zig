const std = @import("std");
const GeodeClient = @import("geode_client").GeodeClient;
const config = @import("geode_client").config;

fn getEnvOr(name: [*:0]const u8, default: []const u8) []const u8 {
    if (std.c.getenv(name)) |v| return std.mem.span(v);
    return default;
}

fn authUsername() []const u8 {
    return getEnvOr("GEODE_USERNAME", getEnvOr("GEODE_USER", "geode"));
}

fn authPassword() []const u8 {
    return getEnvOr("GEODE_PASSWORD", getEnvOr("GEODE_DEFAULT_PASSWORD", getEnvOr("GEODE_ADMIN_PASSWORD", "geode-test-password")));
}

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;
    const io = init.io;

    // Read server address from environment, with defaults
    const env_server = getEnvOr("GEODE_SERVER", "127.0.0.1:8443");
    var host: []const u8 = "127.0.0.1";
    var port: u16 = 8443;

    // Parse host:port
    if (std.mem.indexOf(u8, env_server, ":")) |colon_idx| {
        host = env_server[0..colon_idx];
        port = std.fmt.parseInt(u16, env_server[colon_idx + 1 ..], 10) catch 8443;
    } else {
        host = env_server;
    }

    const insecure = std.c.getenv("GEODE_INSECURE") != null;
    const username = authUsername();
    const password = authPassword();

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
        const ip = std.Io.net.IpAddress.resolve(io, host, port) catch |e| {
            std.debug.print("DNS resolution failed: {}\n", .{e});
            return e;
        };
        var fbs = std.Io.Writer.fixed(&resolved_host_buf);
        ip.format(&fbs) catch return error.InvalidAddress;
        const written = fbs.buffered();
        // Strip trailing :port suffix if present so caller can re-add port
        if (std.mem.lastIndexOfScalar(u8, written, ':')) |colon| {
            resolved_host = written[0..colon];
        } else {
            resolved_host = written;
        }
        std.debug.print("Resolved to: {s}\n", .{resolved_host});
    }

    std.debug.print("Creating Geode client...\n", .{});
    std.debug.print("Connecting to {s}:{d} (insecure={})\n", .{ resolved_host, port, insecure });
    var cfg = config.Config.initWithTransport(resolved_host, port, .quic);
    defer cfg.deinit(allocator);
    cfg.insecure = insecure;
    cfg.server_name = try allocator.dupe(u8, host);
    if (std.c.getenv("GEODE_CA_CERT")) |path| {
        cfg.ca_cert = try allocator.dupe(u8, std.mem.span(path));
    }
    _ = try cfg.withCredentials(allocator, username, password);
    var client = try GeodeClient.initFromConfig(allocator, cfg);
    defer client.deinit();

    std.debug.print("Connecting to server...\n", .{});
    try client.connect();
    std.debug.print("✓ Connected successfully!\n", .{});

    std.debug.print("Opening stream...\n", .{});
    try client.openStream();
    std.debug.print("✓ Stream opened successfully!\n", .{});

    std.debug.print("Sending HELLO...\n", .{});
    try client.sendHello();
    std.debug.print("✓ HELLO handshake completed!\n", .{});

    std.debug.print("Sending test query...\n", .{});
    var result = try client.query("RETURN 1 AS x", null);
    defer result.deinit();

    if (result.hasError()) {
        std.debug.print("✗ Query error: {s}\n", .{result.errorMessage() orelse "unknown"});
        return error.QueryFailed;
    }

    std.debug.print("✓ Query result:\n", .{});
    std.debug.print("  Columns: ", .{});
    for (result.columns.items, 0..) |col, i| {
        if (i > 0) std.debug.print(", ", .{});
        std.debug.print("{s}", .{col});
    }
    std.debug.print("\n", .{});
    std.debug.print("  Rows: {d}\n", .{result.rows.items.len});

    std.debug.print("\n✅ All tests passed!\n", .{});
}
