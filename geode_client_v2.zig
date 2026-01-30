const std = @import("std");
const quic = @import("quic");
const protocol = @import("protocol");

// CANARY: REQ=REQ-ZIG-CLIENT-002; FEATURE="Zig Client v2"; ASPECT=QuicPackageClient; STATUS=IMPL; OWNER=clients; UPDATED=2026-01-24
// Zig client uses the quic package from zig package manager for full compatibility with the server.

/// Maximum receive buffer size (16MB).
/// SECURITY: Prevents resource exhaustion from malicious server responses (CWE-400).
/// See GAP_ANALYSIS.md Finding 16.
pub const MAX_RECV_BUFFER_SIZE: usize = 16 * 1024 * 1024;

pub const GeodeClient = struct {
    allocator: std.mem.Allocator,
    host: []const u8,
    port: u16,
    insecure: bool,

    endpoint: ?*quic.QuicEndpoint = null,
    conn: ?*quic.QuicConnection = null,
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
                // SECURITY: Check buffer size limit to prevent resource exhaustion (CWE-400)
                if (self.recv_buffer.items.len + n > MAX_RECV_BUFFER_SIZE) {
                    return error.ResponseTooLarge;
                }
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

    /// Attempt to read a complete buffered message without waiting for more data.
    /// Returns null when no full line is buffered yet.
    pub fn tryReceiveBufferedMessage(self: *GeodeClient) !?[]u8 {
        if (std.mem.indexOfScalar(u8, self.recv_buffer.items, '\n')) |idx| {
            const msg_len = idx;
            const msg = try self.allocator.alloc(u8, msg_len);
            @memcpy(msg, self.recv_buffer.items[0..msg_len]);

            const remaining = self.recv_buffer.items.len - (msg_len + 1);
            if (remaining > 0) {
                std.mem.copyForwards(u8, self.recv_buffer.items[0..remaining], self.recv_buffer.items[msg_len + 1 ..]);
                self.recv_buffer.items = self.recv_buffer.items[0..remaining];
            } else {
                self.recv_buffer.items = self.recv_buffer.items[0..0];
            }

            return msg;
        }
        return null;
    }

    pub fn sendHello(self: *GeodeClient, client_name: []const u8, client_version: []const u8) !void {
        const msg = try protocol.buildHello(
            self.allocator,
            client_name,
            client_version,
            protocol.CONFORMANCE_MINIMUM,
            protocol.DEFAULT_PAGE_SIZE,
            null,
            null,
        );
        defer self.allocator.free(msg);
        try self.sendMessage(msg);
    }

    pub fn sendRunGql(self: *GeodeClient, request_id: u64, query: []const u8, params: ?std.json.Value) !void {
        const params_json = if (params) |p|
            try std.json.Stringify.valueAlloc(self.allocator, p, .{})
        else
            try self.allocator.dupe(u8, "{}");
        defer self.allocator.free(params_json);

        // Build JSON message with proper escaping for query string
        var msg: std.ArrayListUnmanaged(u8) = .{};
        errdefer msg.deinit(self.allocator);

        try msg.appendSlice(self.allocator, "{\"type\":\"RUN_GQL\",\"request_id\":");
        var req_id_buf: [24]u8 = undefined;
        const req_id_str = std.fmt.bufPrint(&req_id_buf, "{d}", .{request_id}) catch unreachable;
        try msg.appendSlice(self.allocator, req_id_str);
        try msg.appendSlice(self.allocator, ",\"text\":\"");
        try appendEscapedJsonString(self.allocator, &msg, query);
        try msg.appendSlice(self.allocator, "\",\"params\":");
        try msg.appendSlice(self.allocator, params_json);
        try msg.appendSlice(self.allocator, "}");

        const final_msg = try msg.toOwnedSlice(self.allocator);
        defer self.allocator.free(final_msg);
        try self.sendMessage(final_msg);
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

/// Append a JSON-escaped string to a buffer.
/// Properly escapes quotes, backslashes, and control characters.
fn appendEscapedJsonString(allocator: std.mem.Allocator, buf: *std.ArrayListUnmanaged(u8), s: []const u8) !void {
    for (s) |c| {
        switch (c) {
            '"' => try buf.appendSlice(allocator, "\\\""),
            '\\' => try buf.appendSlice(allocator, "\\\\"),
            '\n' => try buf.appendSlice(allocator, "\\n"),
            '\r' => try buf.appendSlice(allocator, "\\r"),
            '\t' => try buf.appendSlice(allocator, "\\t"),
            else => {
                if (c < 0x20) {
                    // Control characters as \uXXXX
                    var escape_buf: [6]u8 = undefined;
                    _ = std.fmt.bufPrint(&escape_buf, "\\u{x:0>4}", .{c}) catch unreachable;
                    try buf.appendSlice(allocator, &escape_buf);
                } else {
                    try buf.append(allocator, c);
                }
            },
        }
    }
}

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

    // Inline RUN+PULL: check for buffered bindings before sending PULL.
    if (try client.tryReceiveBufferedMessage()) |inline_response| {
        defer allocator.free(inline_response);
        return try std.json.parseFromSlice(
            std.json.Value,
            allocator,
            inline_response,
            .{},
        );
    }

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

// =============================================================================
// Unit Tests for JSON Escaping
// =============================================================================

test "appendEscapedJsonString: plain ASCII string unchanged" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedJsonString(std.testing.allocator, &buf, "hello world");
    try std.testing.expectEqualStrings("hello world", buf.items);
}

test "appendEscapedJsonString: empty string" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedJsonString(std.testing.allocator, &buf, "");
    try std.testing.expectEqual(@as(usize, 0), buf.items.len);
}

test "appendEscapedJsonString: escapes double quotes" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedJsonString(std.testing.allocator, &buf, "say \"hello\"");
    try std.testing.expectEqualStrings("say \\\"hello\\\"", buf.items);
}

test "appendEscapedJsonString: escapes backslashes" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedJsonString(std.testing.allocator, &buf, "path\\to\\file");
    try std.testing.expectEqualStrings("path\\\\to\\\\file", buf.items);
}

test "appendEscapedJsonString: escapes newlines" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedJsonString(std.testing.allocator, &buf, "line1\nline2");
    try std.testing.expectEqualStrings("line1\\nline2", buf.items);
}

test "appendEscapedJsonString: escapes carriage returns" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedJsonString(std.testing.allocator, &buf, "line1\rline2");
    try std.testing.expectEqualStrings("line1\\rline2", buf.items);
}

test "appendEscapedJsonString: escapes tabs" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedJsonString(std.testing.allocator, &buf, "col1\tcol2");
    try std.testing.expectEqualStrings("col1\\tcol2", buf.items);
}

test "appendEscapedJsonString: escapes mixed special characters" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedJsonString(std.testing.allocator, &buf, "\"quoted\"\n\ttabbed\\slashed");
    try std.testing.expectEqualStrings("\\\"quoted\\\"\\n\\ttabbed\\\\slashed", buf.items);
}

test "appendEscapedJsonString: escapes control characters as unicode" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    // ASCII control character 0x01 (SOH)
    try appendEscapedJsonString(std.testing.allocator, &buf, "before\x01after");
    try std.testing.expectEqualStrings("before\\u0001after", buf.items);
}

test "appendEscapedJsonString: escapes null character" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedJsonString(std.testing.allocator, &buf, "hello\x00world");
    try std.testing.expectEqualStrings("hello\\u0000world", buf.items);
}

test "appendEscapedJsonString: escapes form feed" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    // Form feed is 0x0C
    try appendEscapedJsonString(std.testing.allocator, &buf, "page\x0cbreak");
    try std.testing.expectEqualStrings("page\\u000cbreak", buf.items);
}

test "appendEscapedJsonString: preserves high ASCII and UTF-8" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    // UTF-8 encoded "café" - bytes above 0x1F should not be escaped
    try appendEscapedJsonString(std.testing.allocator, &buf, "café");
    try std.testing.expectEqualStrings("café", buf.items);
}

test "appendEscapedJsonString: handles GQL query with quotes" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedJsonString(std.testing.allocator, &buf, "RETURN \"hello\" AS greeting");
    try std.testing.expectEqualStrings("RETURN \\\"hello\\\" AS greeting", buf.items);
}

test "appendEscapedJsonString: handles GQL query with single quotes" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    // Single quotes should NOT be escaped in JSON
    try appendEscapedJsonString(std.testing.allocator, &buf, "RETURN 'hello' AS greeting");
    try std.testing.expectEqualStrings("RETURN 'hello' AS greeting", buf.items);
}

test "appendEscapedJsonString: handles complex GQL query" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    const query = "MATCH (n:Person) WHERE n.name = \"Alice\\Bob\" RETURN n";
    try appendEscapedJsonString(std.testing.allocator, &buf, query);
    try std.testing.expectEqualStrings("MATCH (n:Person) WHERE n.name = \\\"Alice\\\\Bob\\\" RETURN n", buf.items);
}

test "appendEscapedJsonString: multiple calls append correctly" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedJsonString(std.testing.allocator, &buf, "first");
    try appendEscapedJsonString(std.testing.allocator, &buf, " ");
    try appendEscapedJsonString(std.testing.allocator, &buf, "second");
    try std.testing.expectEqualStrings("first second", buf.items);
}

test "appendEscapedJsonString: injection attempt with quotes" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    // Attempt to break out of JSON string and inject new field
    const malicious = "value\",\"injected\":\"attack";
    try appendEscapedJsonString(std.testing.allocator, &buf, malicious);
    // The quotes should be escaped, preventing injection
    try std.testing.expectEqualStrings("value\\\",\\\"injected\\\":\\\"attack", buf.items);
}

test "appendEscapedJsonString: injection attempt with backslash-quote" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    // Attempt to escape the escape character
    const malicious = "value\\\"injected";
    try appendEscapedJsonString(std.testing.allocator, &buf, malicious);
    // Both backslash and quote should be escaped
    try std.testing.expectEqualStrings("value\\\\\\\"injected", buf.items);
}

test "appendEscapedJsonString: all control characters 0x00-0x1F" {
    // Test all control characters are properly escaped
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    // Test specific known control character escapes
    const test_cases = [_]struct { input: []const u8, expected: []const u8 }{
        .{ .input = "\x00", .expected = "\\u0000" }, // NUL
        .{ .input = "\x01", .expected = "\\u0001" }, // SOH
        .{ .input = "\x02", .expected = "\\u0002" }, // STX
        .{ .input = "\x07", .expected = "\\u0007" }, // BEL
        .{ .input = "\x08", .expected = "\\u0008" }, // BS
        .{ .input = "\x09", .expected = "\\t" }, // TAB (special case)
        .{ .input = "\x0A", .expected = "\\n" }, // LF (special case)
        .{ .input = "\x0B", .expected = "\\u000b" }, // VT
        .{ .input = "\x0C", .expected = "\\u000c" }, // FF
        .{ .input = "\x0D", .expected = "\\r" }, // CR (special case)
        .{ .input = "\x0E", .expected = "\\u000e" }, // SO
        .{ .input = "\x1F", .expected = "\\u001f" }, // Unit separator
    };

    for (test_cases) |tc| {
        buf.clearRetainingCapacity();
        try appendEscapedJsonString(std.testing.allocator, &buf, tc.input);
        try std.testing.expectEqualStrings(tc.expected, buf.items);
    }
}

// =============================================================================
// Unit Tests for Message Building
// =============================================================================

test "buildRunGql message produces valid JSON with escaped query" {
    // This test verifies that sendRunGql builds proper JSON
    // We can't test sendRunGql directly without a connection, but we can
    // verify the escaping produces valid JSON when used in the same pattern

    const allocator = std.testing.allocator;
    var msg: std.ArrayListUnmanaged(u8) = .{};
    defer msg.deinit(allocator);

    const query = "RETURN \"hello\" AS greeting";

    try msg.appendSlice(allocator, "{\"type\":\"RUN_GQL\",\"request_id\":1,\"text\":\"");
    try appendEscapedJsonString(allocator, &msg, query);
    try msg.appendSlice(allocator, "\",\"params\":{}}");

    const json_str = msg.items;

    // Parse to verify it's valid JSON
    var parsed = try std.json.parseFromSlice(std.json.Value, allocator, json_str, .{});
    defer parsed.deinit();

    // Verify structure
    try std.testing.expectEqualStrings("RUN_GQL", parsed.value.object.get("type").?.string);
    try std.testing.expectEqual(@as(i64, 1), parsed.value.object.get("request_id").?.integer);
    try std.testing.expectEqualStrings("RETURN \"hello\" AS greeting", parsed.value.object.get("text").?.string);
}

test "buildRunGql message with newlines in query" {
    const allocator = std.testing.allocator;
    var msg: std.ArrayListUnmanaged(u8) = .{};
    defer msg.deinit(allocator);

    const query = "MATCH (n)\nWHERE n.name = 'test'\nRETURN n";

    try msg.appendSlice(allocator, "{\"type\":\"RUN_GQL\",\"text\":\"");
    try appendEscapedJsonString(allocator, &msg, query);
    try msg.appendSlice(allocator, "\"}");

    // Parse to verify it's valid JSON
    var parsed = try std.json.parseFromSlice(std.json.Value, allocator, msg.items, .{});
    defer parsed.deinit();

    // Verify the query is preserved correctly after JSON parsing
    try std.testing.expectEqualStrings(query, parsed.value.object.get("text").?.string);
}

test "buildRunGql message with backslashes in query" {
    const allocator = std.testing.allocator;
    var msg: std.ArrayListUnmanaged(u8) = .{};
    defer msg.deinit(allocator);

    const query = "RETURN 'C:\\Users\\test' AS path";

    try msg.appendSlice(allocator, "{\"text\":\"");
    try appendEscapedJsonString(allocator, &msg, query);
    try msg.appendSlice(allocator, "\"}");

    // Parse to verify it's valid JSON
    var parsed = try std.json.parseFromSlice(std.json.Value, allocator, msg.items, .{});
    defer parsed.deinit();

    // Verify the query is preserved correctly
    try std.testing.expectEqualStrings(query, parsed.value.object.get("text").?.string);
}

test "buildRunGql message with mixed special characters" {
    const allocator = std.testing.allocator;
    var msg: std.ArrayListUnmanaged(u8) = .{};
    defer msg.deinit(allocator);

    const query = "RETURN \"line1\\nline2\\\"\ttab\" AS value";

    try msg.appendSlice(allocator, "{\"query\":\"");
    try appendEscapedJsonString(allocator, &msg, query);
    try msg.appendSlice(allocator, "\"}");

    // Parse to verify it's valid JSON
    var parsed = try std.json.parseFromSlice(std.json.Value, allocator, msg.items, .{});
    defer parsed.deinit();

    // Verify the query is preserved correctly
    try std.testing.expectEqualStrings(query, parsed.value.object.get("query").?.string);
}

// =============================================================================
// Security Tests - Receive Buffer Size Limit (CWE-400)
// =============================================================================

test "MAX_RECV_BUFFER_SIZE constant is defined" {
    // Verify the constant exists and has a reasonable value
    try std.testing.expect(MAX_RECV_BUFFER_SIZE > 0);
    try std.testing.expectEqual(@as(usize, 16 * 1024 * 1024), MAX_RECV_BUFFER_SIZE);
}

test "MAX_RECV_BUFFER_SIZE is 16MB" {
    // Verify the specific limit matches documentation
    const expected_mb: usize = 16;
    const expected_bytes = expected_mb * 1024 * 1024;
    try std.testing.expectEqual(expected_bytes, MAX_RECV_BUFFER_SIZE);
}
