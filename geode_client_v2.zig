const std = @import("std");
const quic = @import("vendor_quic");

// CANARY: REQ=REQ-ZIG-CLIENT-002; FEATURE="Zig Client v2"; ASPECT=VendorQuicClient; STATUS=IMPL; OWNER=clients; UPDATED=2025-11-21
// Zig client now uses the shared vendor/quic transport for full compatibility with the server.

pub const GeodeClient = struct {
    allocator: std.mem.Allocator,
    host: []const u8,
    port: u16,
    insecure: bool,

    endpoint: ?*quic.QuicEndpoint = null,
    conn: ?*quic.Connection = null,
    stream_id: ?u64 = null,
    recv_buffer: std.ArrayList(u8),

    pub fn init(allocator: std.mem.Allocator, host: []const u8, port: u16, insecure: bool) GeodeClient {
        return .{
            .allocator = allocator,
            .host = host,
            .port = port,
            .insecure = insecure,
            .endpoint = null,
            .conn = null,
            .stream_id = null,
            .recv_buffer = std.ArrayList(u8).initCapacity(allocator, 0) catch unreachable,
        };
    }

    pub fn deinit(self: *GeodeClient) void {
        self.recv_buffer.deinit(self.allocator);
        if (self.conn) |c| {
            quic.closeConnection(c, 0) catch {};
            if (self.endpoint) |ep| quic.destroy(ep, c);
            self.conn = null;
        }
        if (self.endpoint) |ep| {
            quic.endpointDeinit(ep);
            self.endpoint = null;
        }
    }

    fn ensureEndpoint(self: *GeodeClient) !void {
        if (self.endpoint != null) return;

        var cfg = quic.QuicConfig{
            .version = .v1,
            .alpn = &[_][]const u8{"geode/1"},
            .cc = .cubic,
            .enable_datagram = false,
            .enable_spin_bit = false,
            .grease = true,
            .compatible_vn = false,
            .enable_retry = false,
            .token_secret = null,
            .token_expiry_ms = 60000,
            .enable_pacing = false,
            .max_datagram_size = 1200,
            .max_idle_timeout_ms = 30000,
            .max_udp_payload = 1350,
            .cert_path = null,
            .key_path = null,
            .ca_path = null,
            .allow_insecure = self.insecure,
            .aead_confidentiality_limit_override = null,
            .aead_integrity_limit_override = null,
            .inline_server_cert_der = null,
            .inline_server_priv_p256 = null,
        };

        self.endpoint = try quic.endpointInit(&self.allocator, "0.0.0.0:0", &cfg);
    }

    pub fn connect(self: *GeodeClient) !void {
        try self.ensureEndpoint();
        const ep = self.endpoint.?;

        const server_addr = try std.fmt.allocPrint(self.allocator, "{s}:{d}", .{ self.host, self.port });
        defer self.allocator.free(server_addr);

        // When skipping verification, empty server_name is acceptable; otherwise pass host for SNI.
        // Always provide SNI; allow_insecure disables verification when requested.
        self.conn = try quic.connect(ep, server_addr, self.host);

        // Wait for handshake confirmation
        const timeout_ns: u64 = 30 * std.time.ns_per_s;
        const start = std.time.nanoTimestamp();
        while (std.time.nanoTimestamp() - start < timeout_ns) {
            quic.poll(ep, 10) catch {};
            if (quic.isHandshakeConfirmed(self.conn.?)) return;
            std.Thread.sleep(10 * std.time.ns_per_ms);
        }

        return error.ConnectionTimeout;
    }

    pub fn openStream(self: *GeodeClient) !void {
        if (self.conn == null) return error.NotConnected;
        if (self.stream_id != null) return;

        const sid = try quic.openStream(self.conn.?, true);
        self.stream_id = sid;
    }

    fn poll(self: *GeodeClient, timeout_ms: u32) void {
        if (self.endpoint) |ep| {
            quic.poll(ep, @intCast(timeout_ms)) catch {};
        }
    }

    fn writeAll(self: *GeodeClient, data: []const u8, fin: bool) !void {
        if (self.conn == null or self.stream_id == null) return error.NoStream;
        var written: usize = 0;
        var attempts: usize = 0;
        const max_attempts: usize = 2000;

        while (written < data.len or (fin and data.len == 0 and attempts < max_attempts)) : (attempts += 1) {
            const slice = data[written..];
            const n = quic.writeStream(self.conn.?, self.stream_id.?, slice, fin and written + slice.len == data.len) catch |err| switch (err) {
                error.KeysNotReady, error.FlowControlBlocked, error.WouldBlock, error.OutOfStreams => blk: {
                    self.poll(10);
                    std.Thread.sleep(1 * std.time.ns_per_ms);
                    break :blk 0;
                },
                else => return err,
            };

            if (n == 0) {
                self.poll(10);
                std.Thread.sleep(1 * std.time.ns_per_ms);
                continue;
            }

            written += n;
            if (written >= data.len) break;
        }

        if (attempts >= max_attempts and written < data.len) return error.WriteError;
    }

    pub fn sendMessage(self: *GeodeClient, message: []const u8) !void {
        if (self.stream_id == null) try self.openStream();

        const payload = try self.allocator.alloc(u8, message.len + 1);
        defer self.allocator.free(payload);
        @memcpy(payload[0..message.len], message);
        payload[payload.len - 1] = '\n';

        try self.writeAll(payload, false);
    }

    pub fn receiveMessage(self: *GeodeClient, timeout_ms: u64) ![]u8 {
        if (self.conn == null or self.stream_id == null) return error.NoStream;

        const timeout_ns: u64 = timeout_ms * std.time.ns_per_ms;
        const start = std.time.nanoTimestamp();

        var temp_buf: [4096]u8 = undefined;
        while (std.time.nanoTimestamp() - start < timeout_ns) {
            const n = quic.readStream(self.conn.?, self.stream_id.?, temp_buf[0..]) catch |err| switch (err) {
                error.WouldBlock => blk: {
                    self.poll(10);
                    std.Thread.sleep(5 * std.time.ns_per_ms);
                    break :blk 0;
                },
                error.InvalidStream => return error.NoStream,
                else => return err,
            };

            if (n > 0) {
                try self.recv_buffer.appendSlice(self.allocator, temp_buf[0..n]);
            }

            if (std.mem.indexOfScalar(u8, self.recv_buffer.items, '\n')) |idx| {
                const msg_len = idx;
                const msg = try self.allocator.alloc(u8, msg_len);
                @memcpy(msg, self.recv_buffer.items[0..msg_len]);

                // remove consumed data + newline
                const remaining = self.recv_buffer.items.len - (msg_len + 1);
                if (remaining > 0) {
                    std.mem.copyForwards(u8, self.recv_buffer.items[0..remaining], self.recv_buffer.items[msg_len + 1 ..]);
                    self.recv_buffer.items = self.recv_buffer.items[0..remaining];
                } else {
                    self.recv_buffer.items = self.recv_buffer.items[0..0];
                }

                return msg;
            }

            self.poll(10);
            std.Thread.sleep(5 * std.time.ns_per_ms);
        }

        return error.ReceiveTimeout;
    }

    pub fn sendHello(self: *GeodeClient, client_name: []const u8, client_version: []const u8) !void {
        const msg = try std.fmt.allocPrint(
            self.allocator,
            "{{\"type\":\"HELLO\",\"client_name\":\"{s}\",\"client_ver\":\"{s}\",\"wanted_conformance\":\"min\"}}",
            .{ client_name, client_version },
        );
        defer self.allocator.free(msg);
        try self.sendMessage(msg);
    }

    pub fn sendRunGql(self: *GeodeClient, request_id: u64, query: []const u8, params: ?std.json.Value) !void {
        const params_json = if (params) |p|
            try std.json.Stringify.valueAlloc(self.allocator, p, .{})
        else
            try self.allocator.dupe(u8, "null");
        defer self.allocator.free(params_json);

        const msg = try std.fmt.allocPrint(
            self.allocator,
            "{{\"type\":\"RUN_GQL\",\"request_id\":{d},\"text\":\"{s}\",\"params\":{s}}}",
            .{ request_id, query, params_json },
        );
        defer self.allocator.free(msg);
        try self.sendMessage(msg);
    }

    pub fn sendPull(self: *GeodeClient, request_id: u64, page_size: usize) !void {
        const msg = try std.fmt.allocPrint(
            self.allocator,
            "{{\"type\":\"PULL\",\"request_id\":{d},\"page_size\":{d}}}",
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
};

/// Helper function to execute a query
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

    // Send HELLO
    try client.sendHello("geode-zig-client", "2.0.0");
    const hello_response = try client.receiveMessage(2000);
    defer allocator.free(hello_response);

    // Send query
        const request_id: u64 = 1;
        try client.sendRunGql(request_id, query, params);
        const schema_response = try client.receiveMessage(3000);
        defer allocator.free(schema_response);

    // Pull results
        try client.sendPull(request_id, 1000);
    const bindings_response = try client.receiveMessage(3000);

    // Parse and return
    return try std.json.parseFromSlice(
        std.json.Value,
        allocator,
        bindings_response,
        .{},
    );
}
