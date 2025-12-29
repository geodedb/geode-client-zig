const std = @import("std");

// CANARY: REQ=REQ-ZIG-CLIENT-001; FEATURE="Zig Client"; ASPECT=VendorQuicIntegration; STATUS=IMPL; OWNER=clients; UPDATED=2025-12-22
// Zig client using vendor/quic for guaranteed server compatibility

// Import the transport layer which wraps vendor/quic
const quic = @import("transport_quic");
const QuicClient = quic.QuicClient;
const QuicClientStream = quic.QuicClientStream;

/// GeodeClient provides a QUIC-based client for connecting to Geode servers
pub const GeodeClient = struct {
    allocator: std.mem.Allocator,
    quic_client: QuicClient,
    stream: ?*QuicClientStream = null,
    host: []const u8,
    port: u16,
    insecure: bool,

    pub fn init(allocator: std.mem.Allocator, host: []const u8, port: u16, insecure: bool) GeodeClient {
        return .{
            .allocator = allocator,
            .quic_client = QuicClient.init(allocator),
            .host = host,
            .port = port,
            .insecure = insecure,
        };
    }

    pub fn connect(self: *GeodeClient) !void {
        // Connect using vendor/quic client
        try self.quic_client.connectInsecure(self.host, self.port, self.insecure);

        // Wait for TLS handshake to complete
        try self.quic_client.waitForHandshake(30);
    }

    pub fn openStream(self: *GeodeClient) !void {
        // Open a bidirectional stream
        self.stream = try self.quic_client.openStream(true);
    }

    pub fn sendMessage(self: *GeodeClient, message: []const u8) !void {
        const stream = self.stream orelse return error.NoStream;

        // Allocate buffer for message + newline
        const data = try self.allocator.alloc(u8, message.len + 1);
        defer self.allocator.free(data);

        @memcpy(data[0..message.len], message);
        data[message.len] = '\n';

        try stream.writeAll(data);

        // Poll to ensure data is sent
        try self.quic_client.poll(10);
    }

    pub fn receiveMessage(self: *GeodeClient) ![]u8 {
        const stream = self.stream orelse return error.NoStream;

        var result = std.ArrayList(u8).init(self.allocator);
        errdefer result.deinit();

        const timeout_ns: u64 = 30 * std.time.ns_per_s;
        const start = std.time.nanoTimestamp();

        var buffer: [4096]u8 = undefined;

        while (@as(u64, @intCast(std.time.nanoTimestamp() - start)) < timeout_ns) {
            // Poll to receive data
            self.quic_client.poll(10) catch {};

            const n = stream.read(&buffer) catch |err| {
                if (err == error.WouldBlock) {
                    std.Thread.sleep(10 * std.time.ns_per_ms);
                    continue;
                }
                return err;
            };

            if (n > 0) {
                try result.appendSlice(buffer[0..n]);

                // Check for complete message (ends with newline)
                if (result.items.len > 0 and result.items[result.items.len - 1] == '\n') {
                    // Remove the trailing newline
                    return result.toOwnedSlice()[0 .. result.items.len - 1];
                }
            }
        }

        return error.ReceiveTimeout;
    }

    pub fn sendHello(self: *GeodeClient, client_name: []const u8, client_version: []const u8) !void {
        const msg = try std.fmt.allocPrint(
            self.allocator,
            "{{\"type\":\"HELLO\",\"client_name\":\"{s}\",\"client_ver\":\"{s}\",\"wanted_conformance\":\"minimum\"}}",
            .{ client_name, client_version },
        );
        defer self.allocator.free(msg);

        try self.sendMessage(msg);
    }

    pub fn sendRunGql(self: *GeodeClient, request_id: []const u8, query: []const u8, params: ?std.json.Value) !void {
        const params_json = if (params) |p| blk: {
            var output = std.ArrayList(u8).init(self.allocator);
            try std.json.stringify(p, .{}, output.writer());
            break :blk try output.toOwnedSlice();
        } else try self.allocator.dupe(u8, "null");
        defer self.allocator.free(params_json);

        const msg = try std.fmt.allocPrint(
            self.allocator,
            "{{\"type\":\"RUN_GQL\",\"request_id\":\"{s}\",\"text\":\"{s}\",\"params\":{s}}}",
            .{ request_id, query, params_json },
        );
        defer self.allocator.free(msg);

        try self.sendMessage(msg);
    }

    pub fn sendPull(self: *GeodeClient, request_id: []const u8, page_size: usize) !void {
        const msg = try std.fmt.allocPrint(
            self.allocator,
            "{{\"type\":\"PULL\",\"request_id\":\"{s}\",\"page_size\":{d}}}",
            .{ request_id, page_size },
        );
        defer self.allocator.free(msg);

        try self.sendMessage(msg);
    }

    pub fn sendBegin(self: *GeodeClient) !void {
        try self.sendMessage("{\"type\":\"BEGIN\"}");
    }

    pub fn sendCommit(self: *GeodeClient) !void {
        try self.sendMessage("{\"type\":\"COMMIT\"}");
    }

    pub fn sendRollback(self: *GeodeClient) !void {
        try self.sendMessage("{\"type\":\"ROLLBACK\"}");
    }

    pub fn deinit(self: *GeodeClient) void {
        if (self.stream) |stream| {
            stream.close();
            self.stream = null;
        }
        self.quic_client.deinit();
    }
};

/// Simple query execution helper
pub fn executeQuery(
    allocator: std.mem.Allocator,
    host: []const u8,
    port: u16,
    query: []const u8,
    params: ?std.json.Value,
    insecure: bool,
) !std.json.Parsed(std.json.Value) {
    var client = GeodeClient.init(allocator, host, port, insecure);
    defer client.deinit();

    try client.connect();
    try client.openStream();

    // Send HELLO
    try client.sendHello("geode-zig-client", "1.0.0");
    const hello_response = try client.receiveMessage();
    defer allocator.free(hello_response);

    // Send query
    const request_id = "req_1";
    try client.sendRunGql(request_id, query, params);
    const schema_response = try client.receiveMessage();
    defer allocator.free(schema_response);

    // Pull results
    try client.sendPull(request_id, 1000);
    const bindings_response = try client.receiveMessage();

    // Parse and return results
    return try std.json.parseFromSlice(
        std.json.Value,
        allocator,
        bindings_response,
        .{},
    );
}
