const std = @import("std");
const quic = @import("quic");
const uuid = @import("uuid");
pub const proto = @import("proto");
pub const config = @import("config");
pub const grpc = @import("grpc");

// CANARY: REQ=REQ-ZIG-CLIENT-002; FEATURE="Zig Client v2"; ASPECT=QuicPackageClient; STATUS=IMPL; OWNER=clients; UPDATED=2026-01-24
// Zig client uses the quic package from zig package manager for full compatibility with the server.
// CANARY: REQ=REQ-ZIG-CLIENT-003; FEATURE="gRPC Transport"; ASPECT=TransportAbstraction; STATUS=IMPL; OWNER=clients; UPDATED=2026-02-05
// Client now supports both QUIC and gRPC transports selectable via Config.transport.

/// Transport type for client connections
pub const Transport = config.Transport;

/// Maximum receive buffer size (16MB).
/// SECURITY: Prevents resource exhaustion from malicious server responses (CWE-400).
/// See GAP_ANALYSIS.md Finding 16.
pub const MAX_RECV_BUFFER_SIZE: usize = 16 * 1024 * 1024;

pub const GeodeClient = struct {
    allocator: std.mem.Allocator,
    host: []const u8,
    port: u16,
    insecure: bool,
    username: []const u8,
    password: []const u8,
    transport: Transport,

    // QUIC transport state
    endpoint: ?*quic.QuicEndpoint = null,
    conn: ?*quic.QuicConnection = null,
    stream_id: ?u64 = null,
    recv_buffer: std.ArrayList(u8),
    recv_offset: usize = 0,
    session_id: []const u8 = "",

    // gRPC transport state
    grpc_client: ?grpc.GrpcClient = null,

    // Request tracking
    last_request_id: ?[]const u8 = null,

    /// Initialize a QUIC client (backward compatible).
    pub fn init(allocator: std.mem.Allocator, host: []const u8, port: u16, insecure: bool, username: []const u8, password: []const u8) !GeodeClient {
        return initWithTransport(allocator, host, port, insecure, username, password, .quic);
    }

    /// Initialize a client with explicit transport selection.
    pub fn initWithTransport(allocator: std.mem.Allocator, host: []const u8, port: u16, insecure: bool, username: []const u8, password: []const u8, transport: Transport) !GeodeClient {
        const owned_username = try allocator.dupe(u8, username);
        errdefer allocator.free(owned_username);
        const owned_password = try allocator.dupe(u8, password);
        errdefer {
            std.crypto.secureZero(u8, owned_password);
            allocator.free(owned_password);
        }
        return .{
            .allocator = allocator,
            .host = host,
            .port = port,
            .insecure = insecure,
            .username = owned_username,
            .password = owned_password,
            .transport = transport,
            .endpoint = null,
            .conn = null,
            .stream_id = null,
            .recv_buffer = try std.ArrayList(u8).initCapacity(allocator, 4096),
            .grpc_client = null,
        };
    }

    /// Initialize a client from a Config struct.
    pub fn initFromConfig(allocator: std.mem.Allocator, cfg: config.Config) !GeodeClient {
        return initWithTransport(
            allocator,
            cfg.host,
            cfg.port,
            cfg.insecure,
            cfg.username orelse "",
            cfg.password orelse "",
            cfg.transport,
        );
    }

    pub fn deinit(self: *GeodeClient) void {
        self.recv_buffer.deinit(self.allocator);

        // Securely zero and free sensitive credentials (always owned copies)
        if (self.password.len > 0) {
            std.crypto.secureZero(u8, @constCast(self.password));
        }
        self.allocator.free(self.password);
        self.password = "";

        if (self.username.len > 0) {
            std.crypto.secureZero(u8, @constCast(self.username));
        }
        self.allocator.free(self.username);
        self.username = "";

        if (self.session_id.len > 0) {
            std.crypto.secureZero(u8, @constCast(self.session_id));
            self.allocator.free(self.session_id);
            self.session_id = "";
        }

        // Clean up request ID
        if (self.last_request_id) |rid| {
            self.allocator.free(rid);
            self.last_request_id = null;
        }

        // Clean up QUIC resources
        if (self.conn) |c| {
            quic.closeConnection(c, 0) catch {};
            if (self.endpoint) |ep| quic.destroy(ep, c);
            self.conn = null;
        }
        if (self.endpoint) |ep| {
            quic.endpointDeinit(ep);
            self.endpoint = null;
        }

        // Clean up gRPC resources
        if (self.grpc_client) |*gc| {
            gc.deinit();
            self.grpc_client = null;
        }
    }

    /// Generate a UUID v4 string for use as a request identifier.
    /// The returned string is heap-allocated; the client tracks and frees it
    /// automatically on the next call or on deinit.
    pub fn generateRequestId(self: *GeodeClient) ![]const u8 {
        // Free previous request ID
        if (self.last_request_id) |rid| {
            self.allocator.free(rid);
            self.last_request_id = null;
        }

        const id = try uuid.newV4();
        const str = try id.toStringAlloc(self.allocator);
        self.last_request_id = str;
        return str;
    }

    /// Return the request ID from the most recent query, or null if no query
    /// has been executed yet.
    pub fn getLastRequestId(self: *const GeodeClient) ?[]const u8 {
        return self.last_request_id;
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
        switch (self.transport) {
            .quic => try self.connectQuic(),
            .grpc => try self.connectGrpc(),
        }
    }

    /// Connect using QUIC transport.
    fn connectQuic(self: *GeodeClient) !void {
        try self.ensureEndpoint();
        const ep = self.endpoint.?;

        const server_addr = try std.fmt.allocPrint(self.allocator, "{s}:{d}", .{ self.host, self.port });
        defer self.allocator.free(server_addr);

        // When skipping verification, empty server_name is acceptable; otherwise pass host for SNI.
        // Always provide SNI; allow_insecure disables verification when requested.
        self.conn = try quic.connect(ep, server_addr, self.host);

        // Wait for handshake confirmation using poll()-based blocking.
        // poll() blocks on epoll/kqueue until packets arrive, so there is no
        // need for an additional sleep between iterations.
        const timeout_ns: u64 = 30 * std.time.ns_per_s;
        const start = std.time.nanoTimestamp();
        while (true) {
            const remaining = remainingMs(start, timeout_ns);
            if (remaining == 0) break;
            quic.poll(ep, @intCast(@min(remaining, 100))) catch {};
            if (quic.isHandshakeConfirmed(self.conn.?)) return;
        }

        return error.ConnectionTimeout;
    }

    /// Connect using gRPC transport.
    fn connectGrpc(self: *GeodeClient) !void {
        var grpc_cfg = grpc.GrpcConfig.init();
        _ = grpc_cfg.withHost(self.host);
        _ = grpc_cfg.withPort(self.port);
        _ = grpc_cfg.withInsecure(self.insecure);
        _ = grpc_cfg.withTls(!self.insecure);

        self.grpc_client = grpc.GrpcClient.init(self.allocator, grpc_cfg);
        try self.grpc_client.?.connect();
    }

    pub fn openStream(self: *GeodeClient) !void {
        // gRPC doesn't need explicit stream opening
        if (self.transport == .grpc) return;

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

    /// Compute the remaining timeout in milliseconds from a start timestamp and total timeout.
    /// Returns 0 when the deadline has already passed.
    fn remainingMs(start: i128, timeout_ns: u64) u32 {
        const elapsed_ns = std.time.nanoTimestamp() - start;
        if (elapsed_ns < 0) return 0;
        const elapsed: u64 = @intCast(elapsed_ns);
        if (elapsed >= timeout_ns) return 0;
        const remaining_ns = timeout_ns - elapsed;
        const remaining_ms = remaining_ns / std.time.ns_per_ms;
        // Clamp to u32 and ensure at least 1ms when there is remaining time
        if (remaining_ms == 0) return 1;
        if (remaining_ms > std.math.maxInt(u32)) return std.math.maxInt(u32);
        return @intCast(remaining_ms);
    }

    fn writeAll(self: *GeodeClient, data: []const u8, fin: bool) !void {
        if (self.conn == null or self.stream_id == null) return error.NoStream;
        var written: usize = 0;

        // PERF-002: Use poll()-based blocking instead of sleep-based polling.
        // quic.poll() uses epoll/kqueue internally, so it returns as soon as
        // the transport is ready rather than sleeping a fixed duration.
        const write_timeout_ns: u64 = 30 * std.time.ns_per_s;
        const start = std.time.nanoTimestamp();

        while (written < data.len or (fin and data.len == 0)) {
            const remaining = remainingMs(start, write_timeout_ns);
            if (remaining == 0) return error.WriteError;

            const slice = data[written..];
            const n = quic.writeStream(self.conn.?, self.stream_id.?, slice, fin and written + slice.len == data.len) catch |err| switch (err) {
                error.KeysNotReady, error.FlowControlBlocked, error.WouldBlock, error.OutOfStreams => blk: {
                    // Block in poll() until the transport is ready, up to remaining timeout
                    self.poll(@min(remaining, 10));
                    break :blk 0;
                },
                else => return err,
            };

            if (n == 0) {
                self.poll(@min(remaining, 10));
                continue;
            }

            written += n;
            if (written >= data.len) break;
        }
    }

    /// Send a protobuf message with 4-byte big-endian length prefix.
    pub fn sendProto(self: *GeodeClient, msg: proto.QuicClientMessage) !void {
        switch (self.transport) {
            .quic => {
                if (self.stream_id == null) try self.openStream();

                const payload = try proto.encodeWithLengthPrefix(self.allocator, msg);
                defer self.allocator.free(payload);

                try self.writeAll(payload, false);
            },
            .grpc => {
                if (self.grpc_client) |*gc| {
                    try gc.sendProto(msg);
                } else {
                    return error.NotConnected;
                }
            },
        }
    }

    /// Receive a protobuf message with 4-byte big-endian length prefix.
    pub fn receiveProto(self: *GeodeClient, timeout_ms: u64) !proto.QuicServerMessage {
        switch (self.transport) {
            .quic => return try self.receiveProtoQuic(timeout_ms),
            .grpc => {
                if (self.grpc_client) |*gc| {
                    return try gc.receiveProto();
                } else {
                    return error.NotConnected;
                }
            },
        }
    }

    /// Return the number of unconsumed bytes in the receive buffer.
    fn recvAvailable(self: *const GeodeClient) usize {
        return self.recv_buffer.items.len - self.recv_offset;
    }

    /// Compact the receive buffer by shifting unconsumed data to the front.
    /// Called when recv_offset exceeds half the buffer length to amortize copy cost.
    fn compactRecvBuffer(self: *GeodeClient) void {
        if (self.recv_offset == 0) return;
        const remaining = self.recv_buffer.items.len - self.recv_offset;
        if (remaining > 0) {
            std.mem.copyForwards(u8, self.recv_buffer.items[0..remaining], self.recv_buffer.items[self.recv_offset..]);
        }
        self.recv_buffer.items.len = remaining;
        self.recv_offset = 0;
    }

    /// Receive a protobuf message using QUIC transport.
    fn receiveProtoQuic(self: *GeodeClient, timeout_ms: u64) !proto.QuicServerMessage {
        if (self.conn == null or self.stream_id == null) return error.NoStream;

        // PERF-007: Compact only when offset exceeds half the buffer length (amortized O(1)).
        if (self.recv_offset > self.recv_buffer.items.len / 2) {
            self.compactRecvBuffer();
        }

        const timeout_ns: u64 = timeout_ms * std.time.ns_per_ms;
        const start = std.time.nanoTimestamp();

        var temp_buf: [4096]u8 = undefined;

        // PERF-001: Use poll()-based blocking instead of sleep-based polling.
        // quic.poll() uses epoll/kqueue internally and blocks until data
        // arrives or the timeout expires, eliminating the 5ms latency floor
        // that sleep-based polling imposed on every read.

        // Read until we have at least 4 bytes for length prefix
        while (self.recvAvailable() < 4) {
            const remaining = remainingMs(start, timeout_ns);
            if (remaining == 0) return error.ReceiveTimeout;

            const n = quic.readStream(self.conn.?, self.stream_id.?, temp_buf[0..]) catch |err| switch (err) {
                error.WouldBlock => blk: {
                    // Block in poll() until data arrives, up to remaining timeout
                    self.poll(@min(remaining, 100));
                    break :blk 0;
                },
                error.InvalidStream => return error.NoStream,
                else => return err,
            };

            if (n > 0) {
                if (self.recv_buffer.items.len + n > MAX_RECV_BUFFER_SIZE) {
                    return error.ResponseTooLarge;
                }
                try self.recv_buffer.appendSlice(self.allocator, temp_buf[0..n]);
            } else {
                // No data yet; let poll() block until the transport has data
                self.poll(@min(remaining, 100));
            }
        }

        // Decode length prefix (big-endian u32)
        const msg_len = proto.decodeLengthPrefix(self.recv_buffer.items[self.recv_offset..][0..4]) catch return error.InvalidMessage;

        // SECURITY: Check message size
        if (msg_len > MAX_RECV_BUFFER_SIZE - 4) {
            return error.ResponseTooLarge;
        }

        const total_len: usize = 4 + @as(usize, msg_len);

        // Read until we have the complete message
        while (self.recvAvailable() < total_len) {
            const remaining = remainingMs(start, timeout_ns);
            if (remaining == 0) return error.ReceiveTimeout;

            const n = quic.readStream(self.conn.?, self.stream_id.?, temp_buf[0..]) catch |err| switch (err) {
                error.WouldBlock => blk: {
                    self.poll(@min(remaining, 100));
                    break :blk 0;
                },
                error.InvalidStream => return error.NoStream,
                else => return err,
            };

            if (n > 0) {
                if (self.recv_buffer.items.len + n > MAX_RECV_BUFFER_SIZE) {
                    return error.ResponseTooLarge;
                }
                try self.recv_buffer.appendSlice(self.allocator, temp_buf[0..n]);
            } else {
                self.poll(@min(remaining, 100));
            }
        }

        // Decode the protobuf message
        const msg_data = self.recv_buffer.items[self.recv_offset + 4 .. self.recv_offset + total_len];
        const msg = try proto.decodeQuicServerMessage(self.allocator, msg_data);

        // PERF-007: Advance read cursor instead of shifting data.
        self.recv_offset += total_len;

        // Reset buffer when fully consumed to reclaim memory.
        if (self.recv_offset == self.recv_buffer.items.len) {
            self.recv_buffer.items.len = 0;
            self.recv_offset = 0;
        }

        return msg;
    }

    /// Attempt to read a complete buffered protobuf message without waiting for more data.
    /// Returns null when no full message is buffered yet.
    pub fn tryReceiveBufferedProto(self: *GeodeClient) !?proto.QuicServerMessage {
        if (self.recvAvailable() < 4) return null;

        const msg_len = proto.decodeLengthPrefix(self.recv_buffer.items[self.recv_offset..][0..4]) catch return null;
        const total_len: usize = 4 + @as(usize, msg_len);

        if (self.recvAvailable() < total_len) return null;

        const msg_data = self.recv_buffer.items[self.recv_offset + 4 .. self.recv_offset + total_len];
        const msg = try proto.decodeQuicServerMessage(self.allocator, msg_data);

        // PERF-007: Advance read cursor instead of shifting data.
        self.recv_offset += total_len;

        // Reset buffer when fully consumed to reclaim memory.
        if (self.recv_offset == self.recv_buffer.items.len) {
            self.recv_buffer.items.len = 0;
            self.recv_offset = 0;
        }

        return msg;
    }

    /// Send HELLO and store session_id from response.
    pub fn sendHello(self: *GeodeClient) !void {
        const msg = proto.QuicClientMessage{
            .hello = proto.HelloRequest{
                .username = self.username,
                .password = self.password,
                .tenant_id = "",
            },
        };
        try self.sendProto(msg);

        // Wait for hello response
        var response = try self.receiveProto(5000);
        defer response.deinit(self.allocator);
        if (response.hello) |hello| {
            if (hello.success) {
                // Store session ID, freeing any previous one first
                if (hello.session_id.len > 0) {
                    if (self.session_id.len > 0) {
                        std.crypto.secureZero(u8, @constCast(self.session_id));
                        self.allocator.free(self.session_id);
                    }
                    self.session_id = try self.allocator.dupe(u8, hello.session_id);
                }
            } else {
                return error.AuthenticationFailed;
            }
        } else {
            return error.InvalidResponse;
        }
    }

    /// Execute a GQL query and return the result.
    /// Automatically generates a UUID v4 request ID for tracing.
    /// The caller may pass an explicit request_id; if null, one is generated.
    pub fn query(self: *GeodeClient, gql: []const u8, params: ?std.StringHashMapUnmanaged([]const u8)) !QueryResult {
        const request_id = try self.generateRequestId();

        var execute = proto.ExecuteRequest{
            .session_id = self.session_id,
            .query = gql,
            .request_id = request_id,
        };

        // Copy parameters if provided
        if (params) |p| {
            var iter = p.iterator();
            while (iter.next()) |entry| {
                // Convert string parameters to proto.Value
                const value = proto.Value{ .string_val = entry.value_ptr.* };
                try execute.addParam(self.allocator, entry.key_ptr.*, value);
            }
        }
        defer execute.deinit(self.allocator);

        const msg = proto.QuicClientMessage{
            .execute = execute,
        };
        try self.sendProto(msg);

        // Receive response
        var response = try self.receiveProto(30000);
        defer response.deinit(self.allocator);
        return try self.parseExecutionResponse(response);
    }

    fn parseExecutionResponse(self: *GeodeClient, response: proto.QuicServerMessage) !QueryResult {
        if (response.execute) |exec| {
            if (exec.err) |err| {
                return QueryResult{
                    .allocator = self.allocator,
                    .columns = .{},
                    .rows = .{},
                    .err = err,
                };
            }

            var result = QueryResult{
                .allocator = self.allocator,
                .columns = .{},
                .rows = .{},
                .err = null,
            };

            // Parse schema columns
            if (exec.schema) |schema| {
                for (schema.columns.items) |col| {
                    try result.columns.append(self.allocator, col.name);
                }
            }

            // Parse data page rows
            if (exec.page) |page| {
                for (page.rows.items) |row| {
                    var row_values: std.ArrayListUnmanaged(proto.Value) = .{};
                    for (row.values.items) |val| {
                        try row_values.append(self.allocator, val);
                    }
                    try result.rows.append(self.allocator, row_values);
                }
            }

            return result;
        }

        return error.InvalidResponse;
    }

    /// Begin a transaction.
    pub fn begin(self: *GeodeClient) ![]const u8 {
        const msg = proto.QuicClientMessage{
            .begin = proto.BeginRequest{ .read_only = false },
        };
        try self.sendProto(msg);

        var response = try self.receiveProto(5000);
        defer response.deinit(self.allocator);
        if (response.begin) |begin_resp| {
            if (begin_resp.tx_id.len > 0) {
                return try self.allocator.dupe(u8, begin_resp.tx_id);
            }
        }
        return error.InvalidResponse;
    }

    /// Commit the current transaction.
    pub fn commit(self: *GeodeClient) !void {
        const msg = proto.QuicClientMessage{
            .commit = proto.CommitRequest{},
        };
        try self.sendProto(msg);

        var response = try self.receiveProto(5000);
        defer response.deinit(self.allocator);
        if (response.commit) |commit_resp| {
            if (!commit_resp.success) {
                return error.CommitFailed;
            }
        } else {
            return error.InvalidResponse;
        }
    }

    /// Rollback the current transaction.
    pub fn rollback(self: *GeodeClient) !void {
        const msg = proto.QuicClientMessage{
            .rollback = proto.RollbackRequest{},
        };
        try self.sendProto(msg);

        var response = try self.receiveProto(5000);
        defer response.deinit(self.allocator);
        if (response.rollback) |rollback_resp| {
            if (!rollback_resp.success) {
                return error.RollbackFailed;
            }
        } else {
            return error.InvalidResponse;
        }
    }

    /// Ping the server.
    pub fn ping(self: *GeodeClient) !bool {
        const msg = proto.QuicClientMessage{
            .ping = proto.PingRequest{},
        };
        try self.sendProto(msg);

        var response = try self.receiveProto(5000);
        defer response.deinit(self.allocator);
        if (response.ping) |ping_resp| {
            return ping_resp.ok;
        }
        return false;
    }
};

/// Result of a query execution.
pub const QueryResult = struct {
    allocator: std.mem.Allocator,
    columns: std.ArrayListUnmanaged([]const u8) = .{},
    rows: std.ArrayListUnmanaged(std.ArrayListUnmanaged(proto.Value)) = .{},
    err: ?proto.ProtoError,

    pub fn deinit(self: *QueryResult) void {
        for (self.rows.items) |*row| {
            row.deinit(self.allocator);
        }
        self.rows.deinit(self.allocator);
        self.columns.deinit(self.allocator);
    }

    pub fn hasError(self: *const QueryResult) bool {
        return self.err != null;
    }

    pub fn errorMessage(self: *const QueryResult) ?[]const u8 {
        if (self.err) |e| {
            return e.message;
        }
        return null;
    }
};

/// Helper function to execute a query.
/// Opens a connection, sends HELLO, executes the query, and returns the result.
pub fn executeQuery(
    allocator: std.mem.Allocator,
    host: []const u8,
    port: u16,
    gql: []const u8,
    params: ?std.StringHashMapUnmanaged([]const u8),
    insecure: bool,
    username: []const u8,
    password: []const u8,
) !QueryResult {
    var client = try GeodeClient.init(allocator, host, port, insecure, username, password);
    defer client.deinit();

    try client.connect();
    try client.sendHello();

    return try client.query(gql, params);
}

// =============================================================================
// Unit Tests for Protobuf Encoding
// =============================================================================

test "proto encoding: HelloRequest encodes correctly" {
    const allocator = std.testing.allocator;
    const msg = proto.QuicClientMessage{
        .hello = proto.HelloRequest{
            .username = "test_user",
            .password = "test_pass",
            .tenant_id = "",
        },
    };
    const encoded = try proto.encodeWithLengthPrefix(allocator, msg);
    defer allocator.free(encoded);

    // Verify length prefix is present (4 bytes)
    try std.testing.expect(encoded.len >= 4);

    // Verify length prefix is correct
    const length = proto.decodeLengthPrefix(encoded[0..4]) catch unreachable;
    try std.testing.expectEqual(encoded.len - 4, @as(usize, length));
}

test "proto encoding: ExecuteRequest encodes query correctly" {
    const allocator = std.testing.allocator;
    var execute = proto.ExecuteRequest.init();
    defer execute.deinit(allocator);
    execute.session_id = "session123";
    execute.query = "RETURN 1 AS x";

    const msg = proto.QuicClientMessage{
        .execute = execute,
    };
    const encoded = try proto.encodeWithLengthPrefix(allocator, msg);
    defer allocator.free(encoded);

    try std.testing.expect(encoded.len >= 4);
}

test "proto decoding: length prefix decodes correctly" {
    // Test big-endian encoding of length 256 (0x00000100)
    const data = [_]u8{ 0x00, 0x00, 0x01, 0x00 };
    const length = try proto.decodeLengthPrefix(&data);
    try std.testing.expectEqual(@as(u32, 256), length);
}

test "proto decoding: length prefix insufficient data" {
    const data = [_]u8{ 0x00, 0x00, 0x01 }; // Only 3 bytes
    const result = proto.decodeLengthPrefix(&data);
    try std.testing.expectError(error.InsufficientData, result);
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

// =============================================================================
// Transport Abstraction Tests
// =============================================================================

test "GeodeClient.init creates QUIC transport by default" {
    const allocator = std.testing.allocator;
    var client = try GeodeClient.init(allocator, "localhost", 3141, false, "", "");
    defer client.deinit();

    try std.testing.expectEqual(Transport.quic, client.transport);
}

test "GeodeClient.initWithTransport creates correct transport" {
    const allocator = std.testing.allocator;

    // QUIC transport
    var quic_client = try GeodeClient.initWithTransport(allocator, "localhost", 3141, false, "", "", .quic);
    defer quic_client.deinit();
    try std.testing.expectEqual(Transport.quic, quic_client.transport);

    // gRPC transport
    var grpc_client = try GeodeClient.initWithTransport(allocator, "localhost", 50051, false, "", "", .grpc);
    defer grpc_client.deinit();
    try std.testing.expectEqual(Transport.grpc, grpc_client.transport);
}

test "GeodeClient.initFromConfig creates client from Config" {
    const allocator = std.testing.allocator;

    // QUIC config
    var quic_cfg = config.Config.init();
    quic_cfg.host = "db.example.com";
    quic_cfg.port = 3141;
    quic_cfg.transport = .quic;

    var quic_client = try GeodeClient.initFromConfig(allocator, quic_cfg);
    defer quic_client.deinit();

    try std.testing.expectEqualStrings("db.example.com", quic_client.host);
    try std.testing.expectEqual(@as(u16, 3141), quic_client.port);
    try std.testing.expectEqual(Transport.quic, quic_client.transport);

    // gRPC config
    var grpc_cfg = config.Config.init();
    grpc_cfg.host = "grpc.example.com";
    grpc_cfg.port = 50051;
    grpc_cfg.transport = .grpc;
    grpc_cfg.username = "admin";
    grpc_cfg.password = "secret";

    var grpc_client = try GeodeClient.initFromConfig(allocator, grpc_cfg);
    defer grpc_client.deinit();

    try std.testing.expectEqualStrings("grpc.example.com", grpc_client.host);
    try std.testing.expectEqual(@as(u16, 50051), grpc_client.port);
    try std.testing.expectEqual(Transport.grpc, grpc_client.transport);
    try std.testing.expectEqualStrings("admin", grpc_client.username);
    try std.testing.expectEqualStrings("secret", grpc_client.password);
}

test "Transport enum values are correct" {
    try std.testing.expectEqual(config.Transport.quic, Transport.quic);
    try std.testing.expectEqual(config.Transport.grpc, Transport.grpc);
}
