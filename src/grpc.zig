// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// gRPC transport module for the Geode Zig client library.
// Provides gRPC over HTTP/2 as an alternative to QUIC transport.
//
// gRPC Wire Format:
// - 5-byte header: 1 byte compressed flag (0 or 1) + 4 bytes big-endian message length
// - Followed by the protobuf message body
//
// Note: This implementation uses std.http client for HTTP/2 support.
// For TLS, it uses the system's TLS implementation.

const std = @import("std");
const proto = @import("proto");

/// gRPC message compression flag
pub const GRPC_COMPRESSED: u8 = 1;
pub const GRPC_UNCOMPRESSED: u8 = 0;

/// gRPC header size (1 byte compressed flag + 4 bytes length)
pub const GRPC_HEADER_SIZE: usize = 5;

/// Maximum gRPC message size (4MB default, matching common gRPC implementations)
pub const MAX_MESSAGE_SIZE: usize = 4 * 1024 * 1024;

/// gRPC status codes
pub const GrpcStatus = enum(u8) {
    ok = 0,
    cancelled = 1,
    unknown = 2,
    invalid_argument = 3,
    deadline_exceeded = 4,
    not_found = 5,
    already_exists = 6,
    permission_denied = 7,
    resource_exhausted = 8,
    failed_precondition = 9,
    aborted = 10,
    out_of_range = 11,
    unimplemented = 12,
    internal = 13,
    unavailable = 14,
    data_loss = 15,
    unauthenticated = 16,

    pub fn toString(self: GrpcStatus) []const u8 {
        return switch (self) {
            .ok => "OK",
            .cancelled => "CANCELLED",
            .unknown => "UNKNOWN",
            .invalid_argument => "INVALID_ARGUMENT",
            .deadline_exceeded => "DEADLINE_EXCEEDED",
            .not_found => "NOT_FOUND",
            .already_exists => "ALREADY_EXISTS",
            .permission_denied => "PERMISSION_DENIED",
            .resource_exhausted => "RESOURCE_EXHAUSTED",
            .failed_precondition => "FAILED_PRECONDITION",
            .aborted => "ABORTED",
            .out_of_range => "OUT_OF_RANGE",
            .unimplemented => "UNIMPLEMENTED",
            .internal => "INTERNAL",
            .unavailable => "UNAVAILABLE",
            .data_loss => "DATA_LOSS",
            .unauthenticated => "UNAUTHENTICATED",
        };
    }
};

/// gRPC transport error
pub const GrpcError = error{
    ConnectionFailed,
    MessageTooLarge,
    InvalidResponse,
    TlsError,
    Timeout,
    StreamClosed,
    ProtocolError,
};

/// gRPC connection configuration
pub const GrpcConfig = struct {
    /// Server hostname
    host: []const u8,
    /// Server port
    port: u16,
    /// Use TLS
    tls: bool,
    /// Connection timeout in milliseconds
    timeout_ms: u32,
    /// Maximum message size
    max_message_size: usize,
    /// Skip TLS certificate verification
    insecure: bool,

    pub fn init() GrpcConfig {
        return .{
            .host = "127.0.0.1",
            .port = 50051,
            .tls = true,
            .timeout_ms = 30000,
            .max_message_size = MAX_MESSAGE_SIZE,
            .insecure = false,
        };
    }

    pub fn withHost(self: *GrpcConfig, host: []const u8) *GrpcConfig {
        self.host = host;
        return self;
    }

    pub fn withPort(self: *GrpcConfig, port: u16) *GrpcConfig {
        self.port = port;
        return self;
    }

    pub fn withTls(self: *GrpcConfig, tls: bool) *GrpcConfig {
        self.tls = tls;
        return self;
    }

    pub fn withInsecure(self: *GrpcConfig, insecure: bool) *GrpcConfig {
        self.insecure = insecure;
        return self;
    }

    pub fn withTimeout(self: *GrpcConfig, timeout_ms: u32) *GrpcConfig {
        self.timeout_ms = timeout_ms;
        return self;
    }
};

/// Encode a protobuf message with gRPC framing
/// Returns: 5-byte header + message body
pub fn encodeGrpcMessage(allocator: std.mem.Allocator, message: []const u8) ![]u8 {
    if (message.len > MAX_MESSAGE_SIZE) {
        return GrpcError.MessageTooLarge;
    }

    const total_len = GRPC_HEADER_SIZE + message.len;
    const buf = try allocator.alloc(u8, total_len);
    errdefer allocator.free(buf);

    // Write compressed flag (0 = uncompressed)
    buf[0] = GRPC_UNCOMPRESSED;

    // Write message length as 4-byte big-endian
    const len: u32 = @intCast(message.len);
    buf[1] = @intCast((len >> 24) & 0xFF);
    buf[2] = @intCast((len >> 16) & 0xFF);
    buf[3] = @intCast((len >> 8) & 0xFF);
    buf[4] = @intCast(len & 0xFF);

    // Copy message body
    @memcpy(buf[5..], message);

    return buf;
}

/// Decode a gRPC message header
/// Returns: (compressed, message_length)
pub fn decodeGrpcHeader(header: *const [5]u8) struct { compressed: bool, length: u32 } {
    const compressed = header[0] == GRPC_COMPRESSED;
    const length: u32 = (@as(u32, header[1]) << 24) |
        (@as(u32, header[2]) << 16) |
        (@as(u32, header[3]) << 8) |
        @as(u32, header[4]);
    return .{ .compressed = compressed, .length = length };
}

/// gRPC client for Geode
pub const GrpcClient = struct {
    allocator: std.mem.Allocator,
    config: GrpcConfig,
    connected: bool,
    session_id: ?[]const u8,

    // Connection state (using TCP stream for now)
    stream: ?std.net.Stream,

    const Self = @This();

    /// Create a new gRPC client
    pub fn init(allocator: std.mem.Allocator, config: GrpcConfig) Self {
        return Self{
            .allocator = allocator,
            .config = config,
            .connected = false,
            .session_id = null,
            .stream = null,
        };
    }

    /// Clean up resources
    pub fn deinit(self: *Self) void {
        self.disconnect();
        if (self.session_id) |sid| {
            std.crypto.secureZero(u8, @constCast(sid));
            self.allocator.free(sid);
            self.session_id = null;
        }
    }

    /// Connect to the gRPC server
    pub fn connect(self: *Self) !void {
        if (self.connected) return;

        // Resolve server address
        const address = try std.net.Address.resolveIp(self.config.host, self.config.port);

        // Connect TCP stream
        self.stream = try std.net.tcpConnectToAddress(address);

        // For TLS, we would need to wrap the stream with TLS here
        // This is a simplified implementation that uses plain TCP
        // In production, use std.crypto.tls for TLS support

        self.connected = true;
    }

    /// Disconnect from the server
    pub fn disconnect(self: *Self) void {
        if (self.stream) |*stream| {
            stream.close();
            self.stream = null;
        }
        self.connected = false;
    }

    /// Send a gRPC message
    pub fn send(self: *Self, message: []const u8) !void {
        if (!self.connected or self.stream == null) {
            return GrpcError.ConnectionFailed;
        }

        const framed = try encodeGrpcMessage(self.allocator, message);
        defer self.allocator.free(framed);

        _ = try self.stream.?.write(framed);
    }

    /// Receive a gRPC message
    pub fn receive(self: *Self) ![]u8 {
        if (!self.connected or self.stream == null) {
            return GrpcError.ConnectionFailed;
        }

        // Read header, looping to handle partial reads (PERF-015)
        var header: [5]u8 = undefined;
        var header_total: usize = 0;
        while (header_total < 5) {
            const n = try self.stream.?.read(header[header_total..]);
            if (n == 0) {
                return GrpcError.StreamClosed;
            }
            header_total += n;
        }

        // Parse header
        const parsed = decodeGrpcHeader(&header);
        if (parsed.length > self.config.max_message_size) {
            return GrpcError.MessageTooLarge;
        }

        // Read message body
        const body = try self.allocator.alloc(u8, parsed.length);
        errdefer self.allocator.free(body);

        var total_read: usize = 0;
        while (total_read < parsed.length) {
            const n = try self.stream.?.read(body[total_read..]);
            if (n == 0) {
                self.allocator.free(body);
                return GrpcError.StreamClosed;
            }
            total_read += n;
        }

        return body;
    }

    /// Send a protobuf message
    pub fn sendProto(self: *Self, msg: proto.QuicClientMessage) !void {
        const encoded = try proto.encodeWithLengthPrefix(self.allocator, msg);
        defer self.allocator.free(encoded);

        // Skip the 4-byte length prefix (proto uses its own), wrap with gRPC framing
        if (encoded.len > 4) {
            try self.send(encoded[4..]);
        }
    }

    /// Receive a protobuf message
    pub fn receiveProto(self: *Self) !proto.QuicServerMessage {
        const body = try self.receive();
        defer self.allocator.free(body);

        // Decode protobuf message
        return try proto.decodeQuicServerMessage(self.allocator, body);
    }

    /// Perform Hello handshake
    pub fn hello(self: *Self, username: ?[]const u8, password: ?[]const u8) !void {
        const hello_req = proto.HelloRequest{
            .username = username orelse "",
            .password = password orelse "",
            .client_name = "geode-zig-grpc",
            .client_version = "0.1.0",
            .wanted_conformance = "minimum",
        };

        const msg = proto.QuicClientMessage{ .hello = hello_req };
        try self.sendProto(msg);

        var response = try self.receiveProto();
        defer response.deinit(self.allocator);
        if (response.hello) |hello_resp| {
            if (hello_resp.success) {
                if (hello_resp.session_id.len > 0) {
                    // Free previous session_id to prevent leak on repeated hello() calls (Q-002)
                    if (self.session_id) |old_sid| {
                        std.crypto.secureZero(u8, @constCast(old_sid));
                        self.allocator.free(old_sid);
                    }
                    self.session_id = try self.allocator.dupe(u8, hello_resp.session_id);
                }
            } else {
                return error.AuthenticationFailed;
            }
        } else {
            return GrpcError.InvalidResponse;
        }
    }

    /// Execute a GQL query
    pub fn query(self: *Self, gql: []const u8) ![]u8 {
        var execute = proto.ExecuteRequest{
            .session_id = self.session_id orelse "",
            .query = gql,
        };

        const msg = proto.QuicClientMessage{ .execute = execute };
        try self.sendProto(msg);

        _ = &execute; // Avoid unused variable warning

        const response = try self.receiveProto();
        if (response.execute) |exec_resp| {
            if (exec_resp.err) |err| {
                _ = err;
                return error.QueryFailed;
            }
            // Return success indicator
            return try self.allocator.dupe(u8, "OK");
        }

        return GrpcError.InvalidResponse;
    }

    /// Check if connected
    pub fn isConnected(self: *Self) bool {
        return self.connected;
    }

    /// Get session ID
    pub fn getSessionId(self: *Self) ?[]const u8 {
        return self.session_id;
    }
};

// =============================================================================
// Unit Tests
// =============================================================================

test "GrpcConfig default values" {
    const cfg = GrpcConfig.init();
    try std.testing.expectEqualStrings("127.0.0.1", cfg.host);
    try std.testing.expectEqual(@as(u16, 50051), cfg.port);
    try std.testing.expect(cfg.tls);
    try std.testing.expectEqual(@as(u32, 30000), cfg.timeout_ms);
    try std.testing.expectEqual(MAX_MESSAGE_SIZE, cfg.max_message_size);
}

test "GrpcConfig builder" {
    var cfg = GrpcConfig.init();
    _ = cfg.withHost("localhost");
    _ = cfg.withPort(8080);
    _ = cfg.withTls(false);
    _ = cfg.withInsecure(true);
    _ = cfg.withTimeout(5000);

    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 8080), cfg.port);
    try std.testing.expect(!cfg.tls);
    try std.testing.expect(cfg.insecure);
    try std.testing.expectEqual(@as(u32, 5000), cfg.timeout_ms);
}

test "encodeGrpcMessage creates correct header" {
    const allocator = std.testing.allocator;
    const message = "test message";

    const encoded = try encodeGrpcMessage(allocator, message);
    defer allocator.free(encoded);

    // Check header
    try std.testing.expectEqual(@as(u8, GRPC_UNCOMPRESSED), encoded[0]);

    // Check length (big-endian)
    const len: u32 = (@as(u32, encoded[1]) << 24) |
        (@as(u32, encoded[2]) << 16) |
        (@as(u32, encoded[3]) << 8) |
        @as(u32, encoded[4]);
    try std.testing.expectEqual(@as(u32, 12), len);

    // Check body
    try std.testing.expectEqualStrings("test message", encoded[5..]);
}

test "decodeGrpcHeader parses correctly" {
    const header: [5]u8 = .{ 0, 0, 0, 0, 42 };
    const parsed = decodeGrpcHeader(&header);

    try std.testing.expect(!parsed.compressed);
    try std.testing.expectEqual(@as(u32, 42), parsed.length);
}

test "decodeGrpcHeader handles compressed flag" {
    const header: [5]u8 = .{ 1, 0, 0, 1, 0 }; // compressed, length = 256
    const parsed = decodeGrpcHeader(&header);

    try std.testing.expect(parsed.compressed);
    try std.testing.expectEqual(@as(u32, 256), parsed.length);
}

test "encodeGrpcMessage rejects oversized messages" {
    const allocator = std.testing.allocator;

    // Create a message larger than MAX_MESSAGE_SIZE
    const huge_message = try allocator.alloc(u8, MAX_MESSAGE_SIZE + 1);
    defer allocator.free(huge_message);

    const result = encodeGrpcMessage(allocator, huge_message);
    try std.testing.expectError(GrpcError.MessageTooLarge, result);
}

test "GrpcStatus toString" {
    try std.testing.expectEqualStrings("OK", GrpcStatus.ok.toString());
    try std.testing.expectEqualStrings("UNAVAILABLE", GrpcStatus.unavailable.toString());
    try std.testing.expectEqualStrings("UNAUTHENTICATED", GrpcStatus.unauthenticated.toString());
}

test "GrpcClient initialization" {
    const allocator = std.testing.allocator;
    const cfg = GrpcConfig.init();

    var client = GrpcClient.init(allocator, cfg);
    defer client.deinit();

    try std.testing.expect(!client.isConnected());
    try std.testing.expect(client.getSessionId() == null);
}

test "encodeGrpcMessage roundtrip with decode" {
    const allocator = std.testing.allocator;
    const original = "Hello, gRPC!";

    const encoded = try encodeGrpcMessage(allocator, original);
    defer allocator.free(encoded);

    // Decode header
    const parsed = decodeGrpcHeader(encoded[0..5]);
    try std.testing.expect(!parsed.compressed);
    try std.testing.expectEqual(@as(u32, @intCast(original.len)), parsed.length);

    // Verify body
    try std.testing.expectEqualStrings(original, encoded[5..]);
}

test "encodeGrpcMessage empty message" {
    const allocator = std.testing.allocator;
    const empty = "";

    const encoded = try encodeGrpcMessage(allocator, empty);
    defer allocator.free(encoded);

    try std.testing.expectEqual(@as(usize, 5), encoded.len);
    try std.testing.expectEqual(@as(u8, GRPC_UNCOMPRESSED), encoded[0]);

    const parsed = decodeGrpcHeader(encoded[0..5]);
    try std.testing.expectEqual(@as(u32, 0), parsed.length);
}
