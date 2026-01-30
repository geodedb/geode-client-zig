// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Wire protocol handling for the Geode Zig client library.
// Provides message types, builders, and parsers for the JSON line protocol.

const std = @import("std");
const types = @import("types");
const Value = types.Value;

// =============================================================================
// Message Types
// =============================================================================

/// Client message types sent to the server
pub const MessageType = enum {
    HELLO,
    RUN_GQL,
    PULL,
    BEGIN,
    COMMIT,
    ROLLBACK,
    PING,
    PREPARE,
    EXECUTE,
    BATCH,
    EXPLAIN,
    PROFILE,

    pub fn toString(self: MessageType) []const u8 {
        return switch (self) {
            .HELLO => "HELLO",
            .RUN_GQL => "RUN_GQL",
            .PULL => "PULL",
            .BEGIN => "BEGIN",
            .COMMIT => "COMMIT",
            .ROLLBACK => "ROLLBACK",
            .PING => "PING",
            .PREPARE => "PREPARE",
            .EXECUTE => "EXECUTE",
            .BATCH => "BATCH",
            .EXPLAIN => "EXPLAIN",
            .PROFILE => "PROFILE",
        };
    }
};

/// Server response types received from the server
pub const ResponseType = enum {
    HELLO_ACK,
    SCHEMA,
    BINDINGS,
    ERROR,
    SUCCESS,
    EXPLAIN_RESULT,
    PROFILE_RESULT,
    PONG,

    pub fn fromString(s: []const u8) ?ResponseType {
        if (std.mem.eql(u8, s, "HELLO_ACK")) return .HELLO_ACK;
        if (std.mem.eql(u8, s, "SCHEMA")) return .SCHEMA;
        if (std.mem.eql(u8, s, "BINDINGS")) return .BINDINGS;
        if (std.mem.eql(u8, s, "ERROR")) return .ERROR;
        if (std.mem.eql(u8, s, "SUCCESS")) return .SUCCESS;
        if (std.mem.eql(u8, s, "EXPLAIN")) return .EXPLAIN_RESULT;
        if (std.mem.eql(u8, s, "PROFILE")) return .PROFILE_RESULT;
        if (std.mem.eql(u8, s, "PONG")) return .PONG;
        return null;
    }
};

// =============================================================================
// Message Builders
// =============================================================================

/// Builds a HELLO handshake message
pub fn buildHello(
    allocator: std.mem.Allocator,
    client_name: []const u8,
    client_version: []const u8,
    conformance: []const u8,
    page_size: u32,
    username: ?[]const u8,
    password: ?[]const u8,
) ![]u8 {
    var msg: std.ArrayListUnmanaged(u8) = .{};
    errdefer msg.deinit(allocator);

    try msg.appendSlice(allocator, "{\"type\":\"HELLO\"");
    try msg.appendSlice(allocator, ",\"hello_name\":\"");
    // SECURITY: Escape client_name to prevent JSON injection (CWE-116)
    try appendEscapedString(allocator, &msg, client_name);
    try msg.appendSlice(allocator, "\",\"hello_ver\":\"");
    // SECURITY: Escape client_version to prevent JSON injection (CWE-116)
    try appendEscapedString(allocator, &msg, client_version);
    try msg.appendSlice(allocator, "\",\"conformance\":\"");
    // SECURITY: Escape conformance to prevent JSON injection (CWE-116)
    try appendEscapedString(allocator, &msg, conformance);
    try msg.appendSlice(allocator, "\",\"page_size\":");
    var buf: [16]u8 = undefined;
    const page_str = std.fmt.bufPrint(&buf, "{d}", .{page_size}) catch unreachable;
    try msg.appendSlice(allocator, page_str);

    if (username) |u| {
        try msg.appendSlice(allocator, ",\"username\":\"");
        try appendEscapedString(allocator, &msg, u);
        try msg.appendSlice(allocator, "\"");
    }
    if (password) |p| {
        try msg.appendSlice(allocator, ",\"password\":\"");
        try appendEscapedString(allocator, &msg, p);
        try msg.appendSlice(allocator, "\"");
    }

    try msg.appendSlice(allocator, "}");
    return msg.toOwnedSlice(allocator);
}

/// Builds a RUN_GQL query message
pub fn buildRunGql(
    allocator: std.mem.Allocator,
    query: []const u8,
    params: ?std.StringHashMap(Value),
) ![]u8 {
    var msg: std.ArrayListUnmanaged(u8) = .{};
    errdefer msg.deinit(allocator);

    try msg.appendSlice(allocator, "{\"type\":\"RUN_GQL\",\"query\":\"");
    try appendEscapedString(allocator, &msg, query);
    try msg.appendSlice(allocator, "\"");

    if (params) |p| {
        if (p.count() > 0) {
            try msg.appendSlice(allocator, ",\"params\":{");
            var first = true;
            var iter = p.iterator();
            while (iter.next()) |entry| {
                if (!first) try msg.appendSlice(allocator, ",");
                first = false;
                try msg.appendSlice(allocator, "\"");
                try appendEscapedString(allocator, &msg, entry.key_ptr.*);
                try msg.appendSlice(allocator, "\":");
                try appendJsonValue(allocator, &msg, entry.value_ptr.*);
            }
            try msg.appendSlice(allocator, "}");
        }
    }

    try msg.appendSlice(allocator, "}");
    return msg.toOwnedSlice(allocator);
}

/// Builds a PULL message to fetch more results
pub fn buildPull(allocator: std.mem.Allocator, n: i64) ![]u8 {
    return std.fmt.allocPrint(allocator, "{{\"type\":\"PULL\",\"n\":{d}}}", .{n});
}

/// Builds a BEGIN transaction message
pub fn buildBegin(allocator: std.mem.Allocator) ![]u8 {
    return std.fmt.allocPrint(allocator, "{{\"type\":\"BEGIN\"}}", .{});
}

/// Builds a COMMIT transaction message
pub fn buildCommit(allocator: std.mem.Allocator) ![]u8 {
    return std.fmt.allocPrint(allocator, "{{\"type\":\"COMMIT\"}}", .{});
}

/// Builds a ROLLBACK transaction message
pub fn buildRollback(allocator: std.mem.Allocator) ![]u8 {
    return std.fmt.allocPrint(allocator, "{{\"type\":\"ROLLBACK\"}}", .{});
}

/// Builds a PING keep-alive message
pub fn buildPing(allocator: std.mem.Allocator) ![]u8 {
    return std.fmt.allocPrint(allocator, "{{\"type\":\"PING\"}}", .{});
}

/// Builds an EXPLAIN message for query plan analysis
pub fn buildExplain(allocator: std.mem.Allocator, query: []const u8) ![]u8 {
    var msg: std.ArrayListUnmanaged(u8) = .{};
    errdefer msg.deinit(allocator);

    try msg.appendSlice(allocator, "{\"type\":\"EXPLAIN\",\"query\":\"");
    try appendEscapedString(allocator, &msg, query);
    try msg.appendSlice(allocator, "\"}");

    return msg.toOwnedSlice(allocator);
}

/// Builds a PROFILE message for query profiling
pub fn buildProfile(allocator: std.mem.Allocator, query: []const u8) ![]u8 {
    var msg: std.ArrayListUnmanaged(u8) = .{};
    errdefer msg.deinit(allocator);

    try msg.appendSlice(allocator, "{\"type\":\"PROFILE\",\"query\":\"");
    try appendEscapedString(allocator, &msg, query);
    try msg.appendSlice(allocator, "\"}");

    return msg.toOwnedSlice(allocator);
}

/// Builds a BATCH message for executing multiple queries
pub fn buildBatch(
    allocator: std.mem.Allocator,
    queries: []const []const u8,
    stop_on_error: bool,
    transactional: bool,
) ![]u8 {
    var msg: std.ArrayListUnmanaged(u8) = .{};
    errdefer msg.deinit(allocator);

    try msg.appendSlice(allocator, "{\"type\":\"BATCH\",\"queries\":[");

    for (queries, 0..) |query, i| {
        if (i > 0) {
            try msg.appendSlice(allocator, ",");
        }
        try msg.appendSlice(allocator, "\"");
        try appendEscapedString(allocator, &msg, query);
        try msg.appendSlice(allocator, "\"");
    }

    try msg.appendSlice(allocator, "],\"stop_on_error\":");
    try msg.appendSlice(allocator, if (stop_on_error) "true" else "false");
    try msg.appendSlice(allocator, ",\"transactional\":");
    try msg.appendSlice(allocator, if (transactional) "true" else "false");
    try msg.appendSlice(allocator, "}");

    return msg.toOwnedSlice(allocator);
}

/// Builds a PREPARE message for prepared statements
pub fn buildPrepare(allocator: std.mem.Allocator, query: []const u8) ![]u8 {
    var msg: std.ArrayListUnmanaged(u8) = .{};
    errdefer msg.deinit(allocator);

    try msg.appendSlice(allocator, "{\"type\":\"PREPARE\",\"query\":\"");
    try appendEscapedString(allocator, &msg, query);
    try msg.appendSlice(allocator, "\"}");

    return msg.toOwnedSlice(allocator);
}

/// Builds an EXECUTE message for executing prepared statements
pub fn buildExecute(
    allocator: std.mem.Allocator,
    statement_id: []const u8,
    params: ?std.StringHashMap(Value),
) ![]u8 {
    var msg: std.ArrayListUnmanaged(u8) = .{};
    errdefer msg.deinit(allocator);

    try msg.appendSlice(allocator, "{\"type\":\"EXECUTE\",\"statement_id\":\"");
    try appendEscapedString(allocator, &msg, statement_id);
    try msg.appendSlice(allocator, "\"");

    if (params) |p| {
        if (p.count() > 0) {
            try msg.appendSlice(allocator, ",\"params\":{");
            var first = true;
            var iter = p.iterator();
            while (iter.next()) |entry| {
                if (!first) try msg.appendSlice(allocator, ",");
                first = false;
                try msg.appendSlice(allocator, "\"");
                try appendEscapedString(allocator, &msg, entry.key_ptr.*);
                try msg.appendSlice(allocator, "\":");
                try appendJsonValue(allocator, &msg, entry.value_ptr.*);
            }
            try msg.appendSlice(allocator, "}");
        }
    }

    try msg.appendSlice(allocator, "}");
    return msg.toOwnedSlice(allocator);
}

// =============================================================================
// Response Parsing
// =============================================================================

/// Parsed server response
pub const Response = struct {
    type: ResponseType,
    raw: []const u8,
    allocator: std.mem.Allocator,

    pub fn deinit(self: *Response) void {
        self.allocator.free(self.raw);
    }

    /// Check if response is an error
    pub fn isError(self: Response) bool {
        return self.type == .ERROR;
    }

    /// Check if response is a success
    pub fn isSuccess(self: Response) bool {
        return self.type == .SUCCESS or self.type == .HELLO_ACK;
    }
};

/// Parse a server response to determine its type
pub fn parseResponseType(allocator: std.mem.Allocator, data: []const u8) !Response {
    // Find the "type" field
    const type_key = "\"type\":\"";
    if (std.mem.indexOf(u8, data, type_key)) |start| {
        const value_start = start + type_key.len;
        if (std.mem.indexOfScalarPos(u8, data, value_start, '"')) |end| {
            const type_str = data[value_start..end];
            const response_type = ResponseType.fromString(type_str) orelse .ERROR;

            const owned_data = try allocator.dupe(u8, data);
            return Response{
                .type = response_type,
                .raw = owned_data,
                .allocator = allocator,
            };
        }
    }

    // Default to ERROR if we can't parse
    const owned_data = try allocator.dupe(u8, data);
    return Response{
        .type = .ERROR,
        .raw = owned_data,
        .allocator = allocator,
    };
}

// =============================================================================
// Helper Functions
// =============================================================================

/// Append a JSON-escaped string to a buffer
fn appendEscapedString(allocator: std.mem.Allocator, buf: *std.ArrayListUnmanaged(u8), s: []const u8) !void {
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

/// Append a Value as JSON to a buffer
fn appendJsonValue(allocator: std.mem.Allocator, buf: *std.ArrayListUnmanaged(u8), value: Value) !void {
    switch (value) {
        .null => try buf.appendSlice(allocator, "null"),
        .boolean => |b| {
            try buf.appendSlice(allocator, if (b) "true" else "false");
        },
        .integer => |i| {
            var num_buf: [24]u8 = undefined;
            const num_str = std.fmt.bufPrint(&num_buf, "{d}", .{i}) catch unreachable;
            try buf.appendSlice(allocator, num_str);
        },
        .float => |f| {
            var num_buf: [32]u8 = undefined;
            const num_str = std.fmt.bufPrint(&num_buf, "{d}", .{f}) catch unreachable;
            try buf.appendSlice(allocator, num_str);
        },
        .string => |s| {
            try buf.appendSlice(allocator, "\"");
            try appendEscapedString(allocator, buf, s);
            try buf.appendSlice(allocator, "\"");
        },
        else => try buf.appendSlice(allocator, "null"),
    }
}

// =============================================================================
// Protocol Constants
// =============================================================================

/// Default protocol version
pub const PROTOCOL_VERSION: []const u8 = "1.0";

/// Default client name
pub const DEFAULT_CLIENT_NAME: []const u8 = "geode-zig";

/// Minimum conformance level
pub const CONFORMANCE_MINIMUM: []const u8 = "minimum";

/// Full conformance level
pub const CONFORMANCE_FULL: []const u8 = "full";

/// Default page size for result pagination
pub const DEFAULT_PAGE_SIZE: u32 = 1000;

/// Maximum page size
pub const MAX_PAGE_SIZE: u32 = 100000;

/// Default timeout in milliseconds
pub const DEFAULT_TIMEOUT_MS: u32 = 30000;

/// QUIC ALPN protocol identifier
pub const ALPN_GEODE: []const u8 = "geode/1";

// =============================================================================
// Unit Tests
// =============================================================================

test "MessageType.toString returns correct strings" {
    try std.testing.expectEqualStrings("HELLO", MessageType.HELLO.toString());
    try std.testing.expectEqualStrings("RUN_GQL", MessageType.RUN_GQL.toString());
    try std.testing.expectEqualStrings("PULL", MessageType.PULL.toString());
    try std.testing.expectEqualStrings("BEGIN", MessageType.BEGIN.toString());
    try std.testing.expectEqualStrings("COMMIT", MessageType.COMMIT.toString());
    try std.testing.expectEqualStrings("ROLLBACK", MessageType.ROLLBACK.toString());
    try std.testing.expectEqualStrings("PING", MessageType.PING.toString());
}

test "ResponseType.fromString parses correctly" {
    try std.testing.expectEqual(ResponseType.HELLO_ACK, ResponseType.fromString("HELLO_ACK").?);
    try std.testing.expectEqual(ResponseType.SCHEMA, ResponseType.fromString("SCHEMA").?);
    try std.testing.expectEqual(ResponseType.BINDINGS, ResponseType.fromString("BINDINGS").?);
    try std.testing.expectEqual(ResponseType.ERROR, ResponseType.fromString("ERROR").?);
    try std.testing.expectEqual(ResponseType.SUCCESS, ResponseType.fromString("SUCCESS").?);
    try std.testing.expect(ResponseType.fromString("UNKNOWN") == null);
}

test "buildHello creates valid JSON" {
    const msg = try buildHello(
        std.testing.allocator,
        "geode-zig",
        "0.1.0",
        "minimum",
        1000,
        null,
        null,
    );
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"HELLO\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"hello_name\":\"geode-zig\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"page_size\":1000") != null);
}

test "buildHello with credentials" {
    const msg = try buildHello(
        std.testing.allocator,
        "geode-zig",
        "0.1.0",
        "minimum",
        1000,
        "admin",
        "secret",
    );
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"username\":\"admin\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"password\":\"secret\"") != null);
}

test "buildHello escapes metadata fields to prevent JSON injection" {
    // Test that client_name, client_version, and conformance are properly escaped
    // This prevents CWE-116 (Improper Encoding or Escaping of Output)
    const msg = try buildHello(
        std.testing.allocator,
        "client\"with\"quotes", // Malicious client_name
        "1.0\",\"injected\":\"true", // Malicious client_version with injection attempt
        "min\\imal", // client_version with backslash
        1000,
        null,
        null,
    );
    defer std.testing.allocator.free(msg);

    // Verify quotes are escaped in client_name
    try std.testing.expect(std.mem.indexOf(u8, msg, "client\\\"with\\\"quotes") != null);

    // Verify injection attempt is neutralized (quotes escaped)
    try std.testing.expect(std.mem.indexOf(u8, msg, "1.0\\\",\\\"injected\\\":\\\"true") != null);

    // Verify backslash is escaped in conformance
    try std.testing.expect(std.mem.indexOf(u8, msg, "min\\\\imal") != null);

    // Verify no unescaped injection succeeded - the injected field should NOT appear
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"injected\":\"true\"") == null);
}

test "buildHello escapes control characters in metadata" {
    // Test control character escaping (newlines, tabs)
    const msg = try buildHello(
        std.testing.allocator,
        "client\nname", // Newline in client_name
        "ver\tsion", // Tab in client_version
        "conf\rormance", // Carriage return in conformance
        1000,
        null,
        null,
    );
    defer std.testing.allocator.free(msg);

    // Verify control characters are escaped
    try std.testing.expect(std.mem.indexOf(u8, msg, "client\\nname") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "ver\\tsion") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "conf\\rormance") != null);
}

test "buildRunGql creates valid JSON" {
    const msg = try buildRunGql(std.testing.allocator, "MATCH (n) RETURN n", null);
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"RUN_GQL\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"query\":\"MATCH (n) RETURN n\"") != null);
}

test "buildRunGql with parameters" {
    var params = std.StringHashMap(Value).init(std.testing.allocator);
    defer params.deinit();
    try params.put("name", Value.initString("Alice"));
    try params.put("age", Value.initInt(30));

    const msg = try buildRunGql(std.testing.allocator, "MATCH (n) WHERE n.name = $name RETURN n", params);
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"params\":{") != null);
}

test "buildPull creates valid JSON" {
    const msg = try buildPull(std.testing.allocator, 100);
    defer std.testing.allocator.free(msg);

    try std.testing.expectEqualStrings("{\"type\":\"PULL\",\"n\":100}", msg);
}

test "buildBegin creates valid JSON" {
    const msg = try buildBegin(std.testing.allocator);
    defer std.testing.allocator.free(msg);

    try std.testing.expectEqualStrings("{\"type\":\"BEGIN\"}", msg);
}

test "buildCommit creates valid JSON" {
    const msg = try buildCommit(std.testing.allocator);
    defer std.testing.allocator.free(msg);

    try std.testing.expectEqualStrings("{\"type\":\"COMMIT\"}", msg);
}

test "buildRollback creates valid JSON" {
    const msg = try buildRollback(std.testing.allocator);
    defer std.testing.allocator.free(msg);

    try std.testing.expectEqualStrings("{\"type\":\"ROLLBACK\"}", msg);
}

test "buildPing creates valid JSON" {
    const msg = try buildPing(std.testing.allocator);
    defer std.testing.allocator.free(msg);

    try std.testing.expectEqualStrings("{\"type\":\"PING\"}", msg);
}

test "buildExplain creates valid JSON" {
    const msg = try buildExplain(std.testing.allocator, "MATCH (n) RETURN n");
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"EXPLAIN\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"query\":\"MATCH (n) RETURN n\"") != null);
}

test "buildProfile creates valid JSON" {
    const msg = try buildProfile(std.testing.allocator, "MATCH (n) RETURN n");
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"PROFILE\"") != null);
}

test "parseResponseType identifies response types" {
    const hello_response = "{\"type\":\"HELLO_ACK\",\"server\":\"geode\"}";
    var resp = try parseResponseType(std.testing.allocator, hello_response);
    defer resp.deinit();
    try std.testing.expectEqual(ResponseType.HELLO_ACK, resp.type);

    const error_response = "{\"type\":\"ERROR\",\"code\":\"42601\",\"message\":\"Syntax error\"}";
    var resp2 = try parseResponseType(std.testing.allocator, error_response);
    defer resp2.deinit();
    try std.testing.expectEqual(ResponseType.ERROR, resp2.type);
    try std.testing.expect(resp2.isError());
}

test "appendEscapedString escapes special characters" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedString(std.testing.allocator, &buf, "hello\"world");
    try std.testing.expectEqualStrings("hello\\\"world", buf.items);

    buf.clearRetainingCapacity();
    try appendEscapedString(std.testing.allocator, &buf, "line1\nline2");
    try std.testing.expectEqualStrings("line1\\nline2", buf.items);

    buf.clearRetainingCapacity();
    try appendEscapedString(std.testing.allocator, &buf, "tab\there");
    try std.testing.expectEqualStrings("tab\\there", buf.items);

    buf.clearRetainingCapacity();
    try appendEscapedString(std.testing.allocator, &buf, "back\\slash");
    try std.testing.expectEqualStrings("back\\\\slash", buf.items);
}

test "Response.isSuccess returns correct values" {
    const success_data = "{\"type\":\"SUCCESS\"}";
    var resp = try parseResponseType(std.testing.allocator, success_data);
    defer resp.deinit();
    try std.testing.expect(resp.isSuccess());
    try std.testing.expect(!resp.isError());

    const hello_ack_data = "{\"type\":\"HELLO_ACK\"}";
    var resp2 = try parseResponseType(std.testing.allocator, hello_ack_data);
    defer resp2.deinit();
    try std.testing.expect(resp2.isSuccess());
}
