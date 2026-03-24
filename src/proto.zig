// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Protobuf encoding/decoding for Geode wire protocol.
// Wire format: 4-byte Big Endian length prefix + protobuf message body.
// This module implements the geode.proto schema from the server.

const std = @import("std");

// Wire type constants for protobuf encoding.
pub const WIRE_VARINT: u3 = 0;
pub const WIRE_FIXED64: u3 = 1;
pub const WIRE_BYTES: u3 = 2;
pub const WIRE_FIXED32: u3 = 5;

// Security limits for decoding
pub const MAX_STRING_FIELD_SIZE: usize = 1024 * 1024; // 1 MB per string field
pub const MAX_ROWS_PER_PAGE: usize = 100_000; // matches validate.zig MAX_PAGE_SIZE

// =============================================================================
// Message Types (aligned with geode.proto)
//
// Q-007: This section could be split into a separate proto_types.zig file.
// =============================================================================

pub const HelloRequest = struct {
    username: []const u8 = "",
    password: []const u8 = "",
    tenant_id: ?[]const u8 = null,
    client_name: []const u8 = "geode-zig",
    client_version: []const u8 = "0.1.0",
    wanted_conformance: []const u8 = "minimum",
};

pub const HelloResponse = struct {
    success: bool = false,
    session_id: []u8 = &.{},
    error_message: []u8 = &.{},
    capabilities: std.ArrayListUnmanaged([]u8) = .{},

    pub fn deinit(self: *HelloResponse, allocator: std.mem.Allocator) void {
        for (self.capabilities.items) |cap| {
            allocator.free(cap);
        }
        self.capabilities.deinit(allocator);
        if (self.session_id.len > 0) {
            allocator.free(self.session_id);
        }
        if (self.error_message.len > 0) {
            allocator.free(self.error_message);
        }
    }
};

pub const Param = struct {
    name: []const u8 = "",
    value: Value = .{},
};

pub const ExecuteRequest = struct {
    session_id: []const u8 = "",
    query: []const u8 = "",
    request_id: []const u8 = "",
    params: std.ArrayListUnmanaged(Param) = .{},

    pub fn init() ExecuteRequest {
        return .{};
    }

    pub fn deinit(self: *ExecuteRequest, allocator: std.mem.Allocator) void {
        self.params.deinit(allocator);
    }

    pub fn addParam(self: *ExecuteRequest, allocator: std.mem.Allocator, name: []const u8, value: Value) !void {
        try self.params.append(allocator, .{ .name = name, .value = value });
    }
};

pub const PullRequest = struct {
    request_id: u64 = 0,
    page_size: u32 = 1000,
    session_id: []const u8 = "", // Required for gRPC; ignored for QUIC
};

pub const ColumnDefinition = struct {
    name: []const u8 = "",
    col_type: []const u8 = "",
};

pub const SchemaDefinition = struct {
    columns: std.ArrayListUnmanaged(ColumnDefinition) = .{},

    pub fn deinit(self: *SchemaDefinition, allocator: std.mem.Allocator) void {
        self.columns.deinit(allocator);
    }
};

/// Value union type matching geode.proto Value message
pub const Value = struct {
    /// Null value (field 1 in proto)
    null_val: bool = false,
    /// Integer value (field 2 in proto)
    int_val: ?i64 = null,
    /// Double value (field 3 in proto)
    double_val: ?f64 = null,
    /// Boolean value (field 4 in proto)
    bool_val: ?bool = null,
    /// String value (field 5 in proto)
    string_val: ?[]const u8 = null,

    pub fn initNull() Value {
        return .{ .null_val = true };
    }

    pub fn initInt(v: i64) Value {
        return .{ .int_val = v };
    }

    pub fn initDouble(v: f64) Value {
        return .{ .double_val = v };
    }

    pub fn initBool(v: bool) Value {
        return .{ .bool_val = v };
    }

    pub fn initString(v: []const u8) Value {
        return .{ .string_val = v };
    }

    pub fn isNull(self: Value) bool {
        return self.null_val;
    }

    pub fn isInt(self: Value) bool {
        return self.int_val != null;
    }

    pub fn isDouble(self: Value) bool {
        return self.double_val != null;
    }

    pub fn isBool(self: Value) bool {
        return self.bool_val != null;
    }

    pub fn isString(self: Value) bool {
        return self.string_val != null;
    }
};

pub const Row = struct {
    values: std.ArrayListUnmanaged(Value) = .{},

    pub fn deinit(self: *Row, allocator: std.mem.Allocator) void {
        self.values.deinit(allocator);
    }
};

pub const DataPage = struct {
    rows: std.ArrayListUnmanaged(Row) = .{},
    final: bool = false, // 'final' in proto, not 'last_page'
    ordered: bool = false,
    order_keys: std.ArrayListUnmanaged([]const u8) = .{},

    pub fn deinit(self: *DataPage, allocator: std.mem.Allocator) void {
        for (self.rows.items) |*row| {
            row.deinit(allocator);
        }
        self.rows.deinit(allocator);
        self.order_keys.deinit(allocator);
    }

    /// Alias for compatibility
    pub fn lastPage(self: DataPage) bool {
        return self.final;
    }
};

pub const ProtoError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    error_type: []const u8 = "",
    anchor: []const u8 = "",
};

pub const Status = struct {
    status_class: []const u8 = "",
    status_subclass: []const u8 = "",
    additional_statuses: std.ArrayListUnmanaged([]const u8) = .{},
    flagger_findings: std.ArrayListUnmanaged([]const u8) = .{},

    pub fn deinit(self: *Status, allocator: std.mem.Allocator) void {
        self.additional_statuses.deinit(allocator);
        self.flagger_findings.deinit(allocator);
    }
};

pub const ExecutionMetrics = struct {
    parse_duration_ns: i64 = 0,
    plan_duration_ns: i64 = 0,
    execute_duration_ns: i64 = 0,
    total_duration_ns: i64 = 0,
};

pub const ExecutionResponse = struct {
    status: ?Status = null,
    schema: ?SchemaDefinition = null,
    page: ?DataPage = null,
    err: ?ProtoError = null,
    metrics: ?ExecutionMetrics = null,

    pub fn deinit(self: *ExecutionResponse, allocator: std.mem.Allocator) void {
        if (self.status) |*s| s.deinit(allocator);
        if (self.schema) |*s| s.deinit(allocator);
        if (self.page) |*p| p.deinit(allocator);
    }
};

pub const PullResponse = struct {
    response: ?ExecutionResponse = null,
};

pub const PingRequest = struct {};
pub const PingResponse = struct {
    ok: bool = false,
};

pub const BeginRequest = struct {
    read_only: bool = false,
    session_id: []const u8 = "", // Required for gRPC; ignored for QUIC
};

pub const BeginResponse = struct {
    session_id: []const u8 = "",
    tx_id: []const u8 = "",
};

pub const CommitRequest = struct {
    session_id: []const u8 = "", // Required for gRPC; ignored for QUIC
};

pub const CommitResponse = struct {
    success: bool = false,
};

pub const RollbackRequest = struct {
    session_id: []const u8 = "", // Required for gRPC; ignored for QUIC
};

pub const RollbackResponse = struct {
    success: bool = false,
};

pub const SavepointRequest = struct {
    name: []const u8 = "",
    session_id: []const u8 = "",
};

pub const SavepointResponse = struct {
    success: bool = false,
};

pub const RollbackToRequest = struct {
    name: []const u8 = "",
    session_id: []const u8 = "",
};

pub const RollbackToResponse = struct {
    success: bool = false,
};

/// Top-level QUIC client message wrapper
pub const QuicClientMessage = struct {
    hello: ?HelloRequest = null,
    execute: ?ExecuteRequest = null,
    pull: ?PullRequest = null,
    ping: ?PingRequest = null,
    begin: ?BeginRequest = null,
    commit: ?CommitRequest = null,
    rollback: ?RollbackRequest = null,
    savepoint: ?SavepointRequest = null,
    rollback_to: ?RollbackToRequest = null,
};

/// Top-level QUIC server message wrapper
pub const QuicServerMessage = struct {
    hello: ?HelloResponse = null,
    execute: ?ExecutionResponse = null,
    pull: ?PullResponse = null,
    ping: ?PingResponse = null,
    begin: ?BeginResponse = null,
    commit: ?CommitResponse = null,
    rollback: ?RollbackResponse = null,
    savepoint: ?SavepointResponse = null,
    rollback_to: ?RollbackToResponse = null,

    pub fn deinit(self: *QuicServerMessage, allocator: std.mem.Allocator) void {
        if (self.hello) |*h| h.deinit(allocator);
        if (self.execute) |*e| e.deinit(allocator);
    }
};

// =============================================================================
// Encoding helpers (low-level protobuf primitives)
//
// Q-007: This section could be split into a separate proto_encode.zig file
// along with the message encoding section below.
// =============================================================================

pub fn encodeVarint(writer: anytype, v: u64) !void {
    var val = v;
    while (val > 127) {
        try writer.writeByte(@as(u8, @truncate(val & 0x7F)) | 0x80);
        val >>= 7;
    }
    try writer.writeByte(@as(u8, @truncate(val)));
}

pub fn encodeTag(writer: anytype, field_num: u32, wire_type: u3) !void {
    try encodeVarint(writer, (@as(u64, field_num) << 3) | wire_type);
}

pub fn encodeString(writer: anytype, field_num: u32, s: []const u8) !void {
    if (s.len == 0) return;
    try encodeTag(writer, field_num, WIRE_BYTES);
    try encodeVarint(writer, s.len);
    try writer.writeAll(s);
}

pub fn encodeBool(writer: anytype, field_num: u32, v: bool) !void {
    if (!v) return;
    try encodeTag(writer, field_num, WIRE_VARINT);
    try encodeVarint(writer, 1);
}

pub fn encodeInt64(writer: anytype, field_num: u32, v: i64) !void {
    if (v == 0) return;
    try encodeTag(writer, field_num, WIRE_VARINT);
    try encodeVarint(writer, @bitCast(v));
}

pub fn encodeUint32(writer: anytype, field_num: u32, v: u32) !void {
    if (v == 0) return;
    try encodeTag(writer, field_num, WIRE_VARINT);
    try encodeVarint(writer, v);
}

pub fn encodeUint64(writer: anytype, field_num: u32, v: u64) !void {
    if (v == 0) return;
    try encodeTag(writer, field_num, WIRE_VARINT);
    try encodeVarint(writer, v);
}

pub fn encodeDouble(writer: anytype, field_num: u32, v: f64) !void {
    try encodeTag(writer, field_num, WIRE_FIXED64);
    const bytes: [8]u8 = @bitCast(v);
    try writer.writeAll(&bytes);
}

pub fn encodeSubmessage(writer: anytype, field_num: u32, data: []const u8) !void {
    if (data.len == 0) return;
    try encodeTag(writer, field_num, WIRE_BYTES);
    try encodeVarint(writer, data.len);
    try writer.writeAll(data);
}

// =============================================================================
// Message encoding (writer-based, zero intermediate allocations)
//
// Q-007: This section could be split into a separate proto_encode.zig file.
// All functions below write directly into a caller-provided writer, eliminating
// the N+1 allocation pattern where each encode function allocated its own buffer.
// =============================================================================

/// Stack buffer size for encoding leaf submessages that contain only primitive
/// fields (IntValue, DoubleValue, StringValue wrappers). These are always
/// small: a tag (1-2 bytes) + a varint/fixed64/string-length + the data.
const LEAF_SUBMESSAGE_STACK_BUF_SIZE = 32;

/// Encode a leaf submessage (containing only primitive fields) using a stack
/// buffer. Only suitable for IntValue, DoubleValue, StringValue inner wrappers
/// where the encoded size is bounded and small.
fn writeLeafSubmessage(writer: anytype, field_num: u32, encode_fn: anytype, args: anytype) !void {
    var stack_buf: [LEAF_SUBMESSAGE_STACK_BUF_SIZE]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&stack_buf);
    const sub_writer = fbs.writer();

    try @call(.auto, encode_fn, .{sub_writer} ++ args);

    const sub_data = fbs.getWritten();
    if (sub_data.len == 0) return;

    try encodeTag(writer, field_num, WIRE_BYTES);
    try encodeVarint(writer, sub_data.len);
    try writer.writeAll(sub_data);
}

/// Encode a potentially large submessage directly into an ArrayListUnmanaged
/// buffer using the backpatch approach: write the tag, reserve 5 bytes for
/// the varint length (maximum for u32), encode the submessage, then
/// backpatch the actual length and shift data if fewer bytes were needed.
///
/// This is the primary submessage encoding strategy. It avoids intermediate
/// heap allocations entirely by writing directly into the output buffer and
/// fixing up the length prefix afterward.
fn writeSubmessageToList(
    buf: *std.ArrayListUnmanaged(u8),
    allocator: std.mem.Allocator,
    field_num: u32,
    encode_fn: anytype,
    args: anytype,
) !void {
    // Record starting position before we write anything
    const start_pos = buf.items.len;

    const writer = buf.writer(allocator);

    // Write the tag
    try encodeTag(writer, field_num, WIRE_BYTES);

    // Reserve 5 bytes for varint length (max varint32 size)
    const len_pos = buf.items.len;
    try writer.writeAll(&[5]u8{ 0, 0, 0, 0, 0 });
    const data_start = buf.items.len;

    // Encode submessage content directly into the buffer.
    // The encode_fn receives (buf, allocator) so nested submessages can also
    // use writeSubmessageToList for backpatching.
    try @call(.auto, encode_fn, .{ buf, allocator } ++ args);

    const data_len = buf.items.len - data_start;

    if (data_len == 0) {
        // No content written; remove the tag and reserved bytes
        buf.items.len = start_pos;
        return;
    }

    // Compute actual varint length encoding
    var varint_buf: [5]u8 = undefined;
    var varint_fbs = std.io.fixedBufferStream(&varint_buf);
    encodeVarint(varint_fbs.writer(), data_len) catch unreachable;
    const varint_len = varint_fbs.getWritten().len;

    if (varint_len == 5) {
        // Perfect fit, just overwrite the reserved bytes
        @memcpy(buf.items[len_pos..][0..5], varint_fbs.getWritten());
    } else {
        // Need to shift data left to close the gap
        const gap = 5 - varint_len;
        // Write the actual varint at len_pos
        @memcpy(buf.items[len_pos..][0..varint_len], varint_fbs.getWritten());
        // Shift the data left by 'gap' bytes
        const dest_start = len_pos + varint_len;
        std.mem.copyForwards(u8, buf.items[dest_start..], buf.items[data_start..buf.items.len]);
        buf.items.len -= gap;
    }
}

fn writeValueTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, val: Value) !void {
    const writer = buf.writer(allocator);
    // Value uses oneof, so only one field should be set
    if (val.null_val) {
        // NullValue is an empty message, encode as field 1
        try encodeTag(writer, 1, WIRE_BYTES);
        try encodeVarint(writer, 0); // Empty message
    } else if (val.int_val) |i| {
        // IntValue message with value field - leaf submessage on stack
        try writeLeafSubmessage(writer, 2, writeIntValue, .{i});
    } else if (val.double_val) |d| {
        // DoubleValue message with value field - leaf submessage on stack
        try writeLeafSubmessage(writer, 3, writeDoubleValue, .{d});
    } else if (val.bool_val) |b| {
        // bool_val is a scalar bool in the oneof (not a submessage).
        // Must always encode, even for false, since this is inside a oneof.
        try encodeTag(writer, 4, WIRE_VARINT);
        try encodeVarint(writer, if (b) 1 else 0);
    } else if (val.string_val) |s| {
        // StringValue: the inner message just wraps a string field.
        // Encode directly without intermediate allocation: write the outer
        // submessage tag + length, then the inner string field.
        // Inner content = encodeString(field 1, s) = tag(1, WIRE_BYTES) + varint(s.len) + s
        // For field 1 with WIRE_BYTES, the tag is always 1 byte (0x0A).
        // Varint of s.len is 1-5 bytes. Total inner = 1 + varint_len(s.len) + s.len.
        var inner_len_buf: [5]u8 = undefined;
        var inner_len_fbs = std.io.fixedBufferStream(&inner_len_buf);
        encodeVarint(inner_len_fbs.writer(), s.len) catch unreachable;
        const str_varint_len = inner_len_fbs.getWritten().len;
        const inner_total = 1 + str_varint_len + s.len; // tag + varint + data

        try encodeTag(writer, 5, WIRE_BYTES);
        try encodeVarint(writer, inner_total);
        // Inner: field 1, WIRE_BYTES
        try writer.writeByte(0x0A); // tag for field 1, wire type 2
        try writer.writeAll(inner_len_fbs.getWritten());
        try writer.writeAll(s);
    }
}

fn writeIntValue(writer: anytype, val: i64) !void {
    try encodeInt64(writer, 1, val);
}

fn writeDoubleValue(writer: anytype, val: f64) !void {
    try encodeDouble(writer, 1, val);
}

fn writeParamTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, param: Param) !void {
    const writer = buf.writer(allocator);
    try encodeString(writer, 1, param.name);
    // Encode value as submessage via backpatch
    try writeSubmessageToList(buf, allocator, 2, writeValueTo, .{param.value});
}

fn writeHelloRequestTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, req: HelloRequest) !void {
    const writer = buf.writer(allocator);
    try encodeString(writer, 1, req.username);
    try encodeString(writer, 2, req.password);
    if (req.tenant_id) |tid| {
        try encodeString(writer, 3, tid);
    }
    try encodeString(writer, 4, req.client_name);
    try encodeString(writer, 5, req.client_version);
    try encodeString(writer, 6, req.wanted_conformance);
}

fn writeExecuteRequestTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, req: ExecuteRequest) !void {
    const writer = buf.writer(allocator);
    try encodeString(writer, 1, req.session_id);
    try encodeString(writer, 2, req.query);

    // Encode params as repeated Param submessages via backpatch
    for (req.params.items) |param| {
        try writeSubmessageToList(buf, allocator, 3, writeParamTo, .{param});
    }

    // Encode optional request_id for request tracing
    if (req.request_id.len > 0) {
        try encodeString(buf.writer(allocator), 4, req.request_id);
    }
}

fn writePullRequestTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, req: PullRequest) !void {
    const writer = buf.writer(allocator);
    try encodeUint64(writer, 1, req.request_id);
    try encodeUint32(writer, 2, req.page_size);
    try encodeString(writer, 3, req.session_id);
}

fn writeBeginRequestTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, req: BeginRequest) !void {
    const writer = buf.writer(allocator);
    try encodeBool(writer, 1, req.read_only);
    try encodeString(writer, 2, req.session_id);
}

/// Shared encoder for messages with up to two string fields.
/// field1 is encoded as protobuf field 1, field2 (if non-empty) as field 2.
fn writeTwoStringFieldsTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, field1: []const u8, field2: []const u8) !void {
    const writer = buf.writer(allocator);
    try encodeString(writer, 1, field1);
    try encodeString(writer, 2, field2);
}

fn writeCommitRequestTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, req: CommitRequest) !void {
    try writeTwoStringFieldsTo(buf, allocator, req.session_id, "");
}

fn writeRollbackRequestTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, req: RollbackRequest) !void {
    try writeTwoStringFieldsTo(buf, allocator, req.session_id, "");
}

fn writeSavepointRequestTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, req: SavepointRequest) !void {
    try writeTwoStringFieldsTo(buf, allocator, req.name, req.session_id);
}

fn writeRollbackToRequestTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, req: RollbackToRequest) !void {
    try writeTwoStringFieldsTo(buf, allocator, req.name, req.session_id);
}

/// Write a QuicClientMessage directly into a buffer (no intermediate allocations).
/// Uses writeSubmessageToList for potentially large submessages (execute with
/// queries), and writeSubmessage with stack buffers for small fixed-size messages.
fn writeQuicClientMessageToList(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, msg: QuicClientMessage) !void {
    // Field numbers match QuicClientMessage in geode.proto
    if (msg.hello) |hello| {
        // HelloRequest has bounded fields (usernames, version strings) - use stack buffer
        try writeSubmessageToList(buf, allocator, 1, writeHelloRequestTo, .{hello});
    }
    if (msg.execute) |execute| {
        // ExecuteRequest can contain arbitrarily long queries - must use list backpatch
        try writeSubmessageToList(buf, allocator, 2, writeExecuteRequestTo, .{execute});
    }
    if (msg.pull) |pull| {
        try writeSubmessageToList(buf, allocator, 3, writePullRequestTo, .{pull});
    }
    if (msg.ping != null) {
        // Ping is an empty submessage. Write tag + zero length to indicate
        // the field is present in the oneof. The server detects ping by the
        // presence of field 4 in QuicClientMessage.
        const writer = buf.writer(allocator);
        try encodeTag(writer, 4, WIRE_BYTES);
        try encodeVarint(writer, 0);
    }
    if (msg.begin) |begin| {
        try writeSubmessageToList(buf, allocator, 7, writeBeginRequestTo, .{begin});
    }
    if (msg.commit) |commit| {
        try writeSubmessageToList(buf, allocator, 8, writeCommitRequestTo, .{commit});
    }
    if (msg.rollback) |rollback| {
        try writeSubmessageToList(buf, allocator, 9, writeRollbackRequestTo, .{rollback});
    }
    if (msg.savepoint) |savepoint| {
        try writeSubmessageToList(buf, allocator, 10, writeSavepointRequestTo, .{savepoint});
    }
    if (msg.rollback_to) |rollback_to| {
        try writeSubmessageToList(buf, allocator, 11, writeRollbackToRequestTo, .{rollback_to});
    }
}

/// Encode a QuicClientMessage to protobuf bytes (single allocation).
/// Public API preserved for backward compatibility with benchmarks and callers.
pub fn encodeQuicClientMessage(allocator: std.mem.Allocator, msg: QuicClientMessage) ![]u8 {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    errdefer buf.deinit(allocator);

    try writeQuicClientMessageToList(&buf, allocator, msg);

    return buf.toOwnedSlice(allocator);
}

// =============================================================================
// Decoding helpers
//
// Q-007: This section could be split into a separate proto_decode.zig file.
// =============================================================================

pub fn decodeVarint(data: []const u8, pos: *usize) !u64 {
    var result: u64 = 0;
    var shift: u6 = 0;
    while (pos.* < data.len) {
        const b = data[pos.*];
        pos.* += 1;
        result |= @as(u64, b & 0x7F) << shift;
        if (b & 0x80 == 0) {
            return result;
        }
        shift += 7;
        if (shift > 63) {
            return error.VarintTooLong;
        }
    }
    return error.Truncated;
}

pub fn decodeTag(data: []const u8, pos: *usize) !struct { field_num: u32, wire_type: u3 } {
    const tag = try decodeVarint(data, pos);
    return .{
        .field_num = @intCast(tag >> 3),
        .wire_type = @intCast(tag & 0x7),
    };
}

pub fn skipField(data: []const u8, pos: *usize, wire_type: u3) !void {
    switch (wire_type) {
        WIRE_VARINT => {
            _ = try decodeVarint(data, pos);
        },
        WIRE_FIXED64 => {
            pos.* += 8;
        },
        WIRE_BYTES => {
            const length = try decodeVarint(data, pos);
            pos.* += @intCast(length);
        },
        WIRE_FIXED32 => {
            pos.* += 4;
        },
        else => return error.UnknownWireType,
    }
    if (pos.* > data.len) {
        return error.Truncated;
    }
}

pub fn decodeString(allocator: std.mem.Allocator, data: []const u8, pos: *usize) ![]u8 {
    const length: usize = @intCast(try decodeVarint(data, pos));
    if (length > MAX_STRING_FIELD_SIZE) {
        return error.StringTooLarge;
    }
    if (pos.* + length > data.len) {
        return error.Truncated;
    }
    const result = try allocator.alloc(u8, length);
    @memcpy(result, data[pos.*..][0..length]);
    pos.* += length;
    return result;
}

pub fn decodeBytesField(data: []const u8, pos: *usize) ![]const u8 {
    const length: usize = @intCast(try decodeVarint(data, pos));
    if (pos.* + length > data.len) {
        return error.Truncated;
    }
    const result = data[pos.*..][0..length];
    pos.* += length;
    return result;
}

pub fn decodeBool(data: []const u8, pos: *usize) !bool {
    const v = try decodeVarint(data, pos);
    return v != 0;
}

pub fn decodeInt64(data: []const u8, pos: *usize) !i64 {
    const v = try decodeVarint(data, pos);
    return @bitCast(v);
}

pub fn decodeUint32(data: []const u8, pos: *usize) !u32 {
    const v = try decodeVarint(data, pos);
    return @intCast(v);
}

pub fn decodeUint64(data: []const u8, pos: *usize) !u64 {
    return try decodeVarint(data, pos);
}

pub fn decodeDoubleFixed(data: []const u8, pos: *usize) !f64 {
    if (pos.* + 8 > data.len) {
        return error.Truncated;
    }
    const bytes = data[pos.*..][0..8];
    pos.* += 8;
    return @bitCast(bytes.*);
}

// =============================================================================
// Message decoding
//
// Q-007: This section could remain in proto_decode.zig with the decoding helpers.
// =============================================================================

fn decodeHelloResponse(allocator: std.mem.Allocator, data: []const u8) !HelloResponse {
    var resp = HelloResponse{};
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_VARINT) {
                resp.success = try decodeBool(data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            2 => if (tag.wire_type == WIRE_BYTES) {
                resp.session_id = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            3 => if (tag.wire_type == WIRE_BYTES) {
                resp.error_message = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            4 => if (tag.wire_type == WIRE_BYTES) {
                const cap = try decodeString(allocator, data, &pos);
                try resp.capabilities.append(allocator, cap);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return resp;
}

fn decodeColumnDefinition(allocator: std.mem.Allocator, data: []const u8) !ColumnDefinition {
    var col = ColumnDefinition{};
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                col.name = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            2 => if (tag.wire_type == WIRE_BYTES) {
                col.col_type = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return col;
}

fn decodeSchemaDefinition(allocator: std.mem.Allocator, data: []const u8) !SchemaDefinition {
    var schema = SchemaDefinition{};
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                const col_data = try decodeBytesField(data, &pos);
                const col = try decodeColumnDefinition(allocator, col_data);
                try schema.columns.append(allocator, col);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return schema;
}

fn decodeValue(allocator: std.mem.Allocator, data: []const u8, pos: *usize) !Value {
    var val = Value{};
    const val_data = try decodeBytesField(data, pos);
    var val_pos: usize = 0;
    while (val_pos < val_data.len) {
        const tag = try decodeTag(val_data, &val_pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                // NullValue - empty submessage
                _ = try decodeBytesField(val_data, &val_pos);
                val.null_val = true;
            } else try skipField(val_data, &val_pos, tag.wire_type),
            2 => if (tag.wire_type == WIRE_BYTES) {
                // IntValue submessage
                const int_data = try decodeBytesField(val_data, &val_pos);
                var int_pos: usize = 0;
                while (int_pos < int_data.len) {
                    const int_tag = try decodeTag(int_data, &int_pos);
                    if (int_tag.field_num == 1 and int_tag.wire_type == WIRE_VARINT) {
                        val.int_val = try decodeInt64(int_data, &int_pos);
                    } else {
                        try skipField(int_data, &int_pos, int_tag.wire_type);
                    }
                }
            } else try skipField(val_data, &val_pos, tag.wire_type),
            3 => if (tag.wire_type == WIRE_BYTES) {
                // DoubleValue submessage
                const dbl_data = try decodeBytesField(val_data, &val_pos);
                var dbl_pos: usize = 0;
                while (dbl_pos < dbl_data.len) {
                    const dbl_tag = try decodeTag(dbl_data, &dbl_pos);
                    if (dbl_tag.field_num == 1 and dbl_tag.wire_type == WIRE_FIXED64) {
                        val.double_val = try decodeDoubleFixed(dbl_data, &dbl_pos);
                    } else {
                        try skipField(dbl_data, &dbl_pos, dbl_tag.wire_type);
                    }
                }
            } else try skipField(val_data, &val_pos, tag.wire_type),
            4 => if (tag.wire_type == WIRE_VARINT) {
                // bool_val is a scalar bool in the oneof (not a submessage)
                val.bool_val = try decodeBool(val_data, &val_pos);
            } else try skipField(val_data, &val_pos, tag.wire_type),
            5 => if (tag.wire_type == WIRE_BYTES) {
                // StringValue submessage - allocate copy to avoid dangling slice
                const str_data = try decodeBytesField(val_data, &val_pos);
                var str_pos: usize = 0;
                while (str_pos < str_data.len) {
                    const str_tag = try decodeTag(str_data, &str_pos);
                    if (str_tag.field_num == 1 and str_tag.wire_type == WIRE_BYTES) {
                        val.string_val = try decodeString(allocator, str_data, &str_pos);
                    } else {
                        try skipField(str_data, &str_pos, str_tag.wire_type);
                    }
                }
            } else try skipField(val_data, &val_pos, tag.wire_type),
            else => try skipField(val_data, &val_pos, tag.wire_type),
        }
    }
    return val;
}

fn decodeRow(allocator: std.mem.Allocator, data: []const u8) !Row {
    var row = Row{};
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                const val = try decodeValue(allocator, data, &pos);
                try row.values.append(allocator, val);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return row;
}

fn decodeDataPage(allocator: std.mem.Allocator, data: []const u8) !DataPage {
    var page = DataPage{};
    errdefer page.rows.deinit(allocator);
    errdefer page.order_keys.deinit(allocator);
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                if (page.rows.items.len >= MAX_ROWS_PER_PAGE) {
                    return error.TooManyRows;
                }
                const row_data = try decodeBytesField(data, &pos);
                const row = try decodeRow(allocator, row_data);
                try page.rows.append(allocator, row);
            } else try skipField(data, &pos, tag.wire_type),
            2 => if (tag.wire_type == WIRE_VARINT) {
                page.final = try decodeBool(data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            3 => if (tag.wire_type == WIRE_VARINT) {
                page.ordered = try decodeBool(data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            4 => if (tag.wire_type == WIRE_BYTES) {
                const key = try decodeBytesField(data, &pos);
                try page.order_keys.append(allocator, key);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return page;
}

fn decodeProtoError(allocator: std.mem.Allocator, data: []const u8) !ProtoError {
    var err = ProtoError{};
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                err.code = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            2 => if (tag.wire_type == WIRE_BYTES) {
                err.message = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            3 => if (tag.wire_type == WIRE_BYTES) {
                err.error_type = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            4 => if (tag.wire_type == WIRE_BYTES) {
                err.anchor = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return err;
}

fn decodeExecutionMetrics(data: []const u8, pos: *usize) !ExecutionMetrics {
    var metrics = ExecutionMetrics{};
    const metrics_data = try decodeBytesField(data, pos);
    var m_pos: usize = 0;
    while (m_pos < metrics_data.len) {
        const tag = try decodeTag(metrics_data, &m_pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_VARINT) {
                metrics.parse_duration_ns = try decodeInt64(metrics_data, &m_pos);
            } else try skipField(metrics_data, &m_pos, tag.wire_type),
            2 => if (tag.wire_type == WIRE_VARINT) {
                metrics.plan_duration_ns = try decodeInt64(metrics_data, &m_pos);
            } else try skipField(metrics_data, &m_pos, tag.wire_type),
            3 => if (tag.wire_type == WIRE_VARINT) {
                metrics.execute_duration_ns = try decodeInt64(metrics_data, &m_pos);
            } else try skipField(metrics_data, &m_pos, tag.wire_type),
            4 => if (tag.wire_type == WIRE_VARINT) {
                metrics.total_duration_ns = try decodeInt64(metrics_data, &m_pos);
            } else try skipField(metrics_data, &m_pos, tag.wire_type),
            else => try skipField(metrics_data, &m_pos, tag.wire_type),
        }
    }
    return metrics;
}

fn decodeStatus(allocator: std.mem.Allocator, data: []const u8) !Status {
    var status = Status{};
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                status.status_class = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            2 => if (tag.wire_type == WIRE_BYTES) {
                status.status_subclass = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            3 => if (tag.wire_type == WIRE_BYTES) {
                const s = try decodeString(allocator, data, &pos);
                try status.additional_statuses.append(allocator, s);
            } else try skipField(data, &pos, tag.wire_type),
            4 => if (tag.wire_type == WIRE_BYTES) {
                const f = try decodeString(allocator, data, &pos);
                try status.flagger_findings.append(allocator, f);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return status;
}

fn decodeExecutionResponse(allocator: std.mem.Allocator, data: []const u8) !ExecutionResponse {
    var resp = ExecutionResponse{};
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                const status_data = try decodeBytesField(data, &pos);
                resp.status = try decodeStatus(allocator, status_data);
            } else try skipField(data, &pos, tag.wire_type),
            2 => if (tag.wire_type == WIRE_BYTES) {
                const schema_data = try decodeBytesField(data, &pos);
                resp.schema = try decodeSchemaDefinition(allocator, schema_data);
            } else try skipField(data, &pos, tag.wire_type),
            3 => if (tag.wire_type == WIRE_BYTES) {
                const page_data = try decodeBytesField(data, &pos);
                resp.page = try decodeDataPage(allocator, page_data);
            } else try skipField(data, &pos, tag.wire_type),
            4 => if (tag.wire_type == WIRE_BYTES) {
                const err_data = try decodeBytesField(data, &pos);
                resp.err = try decodeProtoError(allocator, err_data);
            } else try skipField(data, &pos, tag.wire_type),
            5 => if (tag.wire_type == WIRE_BYTES) {
                resp.metrics = try decodeExecutionMetrics(data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return resp;
}

fn decodePullResponse(allocator: std.mem.Allocator, data: []const u8) !PullResponse {
    var resp = PullResponse{};
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                const exec_data = try decodeBytesField(data, &pos);
                resp.response = try decodeExecutionResponse(allocator, exec_data);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return resp;
}

fn decodePingResponse(data: []const u8, pos: *usize) !PingResponse {
    var resp = PingResponse{};
    const ping_data = try decodeBytesField(data, pos);
    var ping_pos: usize = 0;
    while (ping_pos < ping_data.len) {
        const tag = try decodeTag(ping_data, &ping_pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_VARINT) {
                resp.ok = try decodeBool(ping_data, &ping_pos);
            } else try skipField(ping_data, &ping_pos, tag.wire_type),
            else => try skipField(ping_data, &ping_pos, tag.wire_type),
        }
    }
    return resp;
}

fn decodeBeginResponse(allocator: std.mem.Allocator, data: []const u8) !BeginResponse {
    var resp = BeginResponse{};
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                resp.session_id = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            2 => if (tag.wire_type == WIRE_BYTES) {
                resp.tx_id = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return resp;
}

/// Shared decoder for response messages containing a single bool "success" field (field 1).
/// Returns the decoded bool value.
fn decodeSingleBoolResponse(data: []const u8) !bool {
    var pos: usize = 0;
    var success: bool = false;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_VARINT) {
                success = try decodeBool(data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return success;
}

fn decodeCommitResponse(data: []const u8) !CommitResponse {
    return .{ .success = try decodeSingleBoolResponse(data) };
}

fn decodeRollbackResponse(data: []const u8) !RollbackResponse {
    return .{ .success = try decodeSingleBoolResponse(data) };
}

fn decodeSavepointResponse(data: []const u8) !SavepointResponse {
    return .{ .success = try decodeSingleBoolResponse(data) };
}

fn decodeRollbackToResponse(data: []const u8) !RollbackToResponse {
    return .{ .success = try decodeSingleBoolResponse(data) };
}

/// Decode a QuicServerMessage from protobuf bytes.
pub fn decodeQuicServerMessage(allocator: std.mem.Allocator, data: []const u8) !QuicServerMessage {
    var msg = QuicServerMessage{};
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                const hello_data = try decodeBytesField(data, &pos);
                msg.hello = try decodeHelloResponse(allocator, hello_data);
            } else try skipField(data, &pos, tag.wire_type),
            2 => if (tag.wire_type == WIRE_BYTES) {
                const exec_data = try decodeBytesField(data, &pos);
                msg.execute = try decodeExecutionResponse(allocator, exec_data);
            } else try skipField(data, &pos, tag.wire_type),
            3 => if (tag.wire_type == WIRE_BYTES) {
                const pull_data = try decodeBytesField(data, &pos);
                msg.pull = try decodePullResponse(allocator, pull_data);
            } else try skipField(data, &pos, tag.wire_type),
            4 => if (tag.wire_type == WIRE_BYTES) {
                msg.ping = try decodePingResponse(data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            7 => if (tag.wire_type == WIRE_BYTES) {
                const begin_data = try decodeBytesField(data, &pos);
                msg.begin = try decodeBeginResponse(allocator, begin_data);
            } else try skipField(data, &pos, tag.wire_type),
            8 => if (tag.wire_type == WIRE_BYTES) {
                const commit_data = try decodeBytesField(data, &pos);
                msg.commit = try decodeCommitResponse(commit_data);
            } else try skipField(data, &pos, tag.wire_type),
            9 => if (tag.wire_type == WIRE_BYTES) {
                const rollback_data = try decodeBytesField(data, &pos);
                msg.rollback = try decodeRollbackResponse(rollback_data);
            } else try skipField(data, &pos, tag.wire_type),
            10 => if (tag.wire_type == WIRE_BYTES) {
                const sp_data = try decodeBytesField(data, &pos);
                msg.savepoint = try decodeSavepointResponse(sp_data);
            } else try skipField(data, &pos, tag.wire_type),
            11 => if (tag.wire_type == WIRE_BYTES) {
                const rt_data = try decodeBytesField(data, &pos);
                msg.rollback_to = try decodeRollbackToResponse(rt_data);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }
    return msg;
}

/// Encode message with 4-byte big-endian length prefix (single allocation).
/// Reserves 4 bytes, encodes the message directly, then backpatches the length.
pub fn encodeWithLengthPrefix(allocator: std.mem.Allocator, msg: QuicClientMessage) ![]u8 {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    errdefer buf.deinit(allocator);

    // Reserve 4 bytes for the length prefix (will be backpatched)
    try buf.writer(allocator).writeAll(&[4]u8{ 0, 0, 0, 0 });

    // Encode message directly into the same buffer
    try writeQuicClientMessageToList(&buf, allocator, msg);

    // Backpatch the 4-byte big-endian length prefix
    const msg_len: u32 = @intCast(buf.items.len - 4);
    buf.items[0] = @truncate(msg_len >> 24);
    buf.items[1] = @truncate(msg_len >> 16);
    buf.items[2] = @truncate(msg_len >> 8);
    buf.items[3] = @truncate(msg_len);

    return buf.toOwnedSlice(allocator);
}

/// Decode 4-byte big-endian length prefix.
pub fn decodeLengthPrefix(data: []const u8) !u32 {
    if (data.len < 4) {
        return error.InsufficientData;
    }
    return @as(u32, data[0]) << 24 |
        @as(u32, data[1]) << 16 |
        @as(u32, data[2]) << 8 |
        @as(u32, data[3]);
}

// =============================================================================
// Unit Tests
//
// Q-007: Tests would move with their respective sections when the file is split.
// =============================================================================

test "Value.initNull creates null value" {
    const v = Value.initNull();
    try std.testing.expect(v.isNull());
    try std.testing.expect(!v.isInt());
    try std.testing.expect(!v.isString());
}

test "Value.initInt creates integer value" {
    const v = Value.initInt(42);
    try std.testing.expect(v.isInt());
    try std.testing.expectEqual(@as(i64, 42), v.int_val.?);
}

test "Value.initString creates string value" {
    const v = Value.initString("hello");
    try std.testing.expect(v.isString());
    try std.testing.expectEqualStrings("hello", v.string_val.?);
}

test "Value.initDouble creates double value" {
    const v = Value.initDouble(3.14);
    try std.testing.expect(v.isDouble());
    try std.testing.expectApproxEqAbs(@as(f64, 3.14), v.double_val.?, 0.001);
}

test "Value.initBool creates boolean value" {
    const v = Value.initBool(true);
    try std.testing.expect(v.isBool());
    try std.testing.expect(v.bool_val.?);
}

test "encodeVarint encodes small values" {
    var buf: [16]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&buf);
    try encodeVarint(fbs.writer(), 1);
    try std.testing.expectEqualSlices(u8, &[_]u8{0x01}, fbs.getWritten());
}

test "encodeVarint encodes large values" {
    var buf: [16]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&buf);
    try encodeVarint(fbs.writer(), 300);
    try std.testing.expectEqualSlices(u8, &[_]u8{ 0xAC, 0x02 }, fbs.getWritten());
}

test "decodeVarint decodes small values" {
    const data = [_]u8{0x01};
    var pos: usize = 0;
    const val = try decodeVarint(&data, &pos);
    try std.testing.expectEqual(@as(u64, 1), val);
}

test "decodeVarint decodes large values" {
    const data = [_]u8{ 0xAC, 0x02 };
    var pos: usize = 0;
    const val = try decodeVarint(&data, &pos);
    try std.testing.expectEqual(@as(u64, 300), val);
}

test "decodeLengthPrefix decodes correctly" {
    const data = [_]u8{ 0x00, 0x00, 0x01, 0x00 };
    const length = try decodeLengthPrefix(&data);
    try std.testing.expectEqual(@as(u32, 256), length);
}

test "decodeLengthPrefix returns error for insufficient data" {
    const data = [_]u8{ 0x00, 0x00, 0x01 };
    try std.testing.expectError(error.InsufficientData, decodeLengthPrefix(&data));
}

test "HelloRequest encodes with all fields" {
    const allocator = std.testing.allocator;
    const req = HelloRequest{
        .username = "admin",
        .password = "secret",
        .client_name = "test-client",
        .client_version = "1.0.0",
        .wanted_conformance = "full",
    };
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(allocator);
    try writeHelloRequestTo(&buf, allocator, req);
    try std.testing.expect(buf.items.len > 0);
}

test "QuicClientMessage with hello encodes" {
    const allocator = std.testing.allocator;
    const msg = QuicClientMessage{
        .hello = HelloRequest{
            .username = "test",
            .password = "pass",
        },
    };
    const encoded = try encodeWithLengthPrefix(allocator, msg);
    defer allocator.free(encoded);

    try std.testing.expect(encoded.len >= 4);
    const length = try decodeLengthPrefix(encoded[0..4]);
    try std.testing.expectEqual(encoded.len - 4, @as(usize, length));
}

test "QuicClientMessage with ping encodes" {
    const allocator = std.testing.allocator;
    const msg = QuicClientMessage{
        .ping = PingRequest{},
    };
    const encoded = try encodeWithLengthPrefix(allocator, msg);
    defer allocator.free(encoded);

    try std.testing.expect(encoded.len >= 4);
}

test "ExecuteRequest with params encodes" {
    const allocator = std.testing.allocator;
    var execute = ExecuteRequest.init();
    defer execute.deinit(allocator);
    execute.session_id = "session123";
    execute.query = "RETURN $x AS result";
    try execute.addParam(allocator, "x", Value.initInt(42));

    const msg = QuicClientMessage{ .execute = execute };
    const encoded = try encodeWithLengthPrefix(allocator, msg);
    defer allocator.free(encoded);

    try std.testing.expect(encoded.len >= 4);
}

test "PullRequest encodes" {
    const allocator = std.testing.allocator;
    const msg = QuicClientMessage{
        .pull = PullRequest{
            .request_id = 1,
            .page_size = 500,
            .session_id = "session123",
        },
    };
    const encoded = try encodeWithLengthPrefix(allocator, msg);
    defer allocator.free(encoded);

    try std.testing.expect(encoded.len >= 4);
}

test "DataPage.lastPage returns final" {
    const page = DataPage{ .final = true };
    try std.testing.expect(page.lastPage());
}

test "decodeString rejects oversized string field" {
    // Craft a varint encoding of MAX_STRING_FIELD_SIZE + 1
    const oversized_len: u64 = MAX_STRING_FIELD_SIZE + 1;
    var len_buf: [10]u8 = undefined;
    var len_fbs = std.io.fixedBufferStream(&len_buf);
    encodeVarint(len_fbs.writer(), oversized_len) catch unreachable;
    const varint_bytes = len_fbs.getWritten();

    var pos: usize = 0;
    const result = decodeString(std.testing.allocator, varint_bytes, &pos);
    try std.testing.expectError(error.StringTooLarge, result);
}

test "decodeDataPage rejects too many rows" {
    // Build a protobuf payload with MAX_ROWS_PER_PAGE + 1 row fields.
    // Each row is an empty submessage: tag(field=1, wire=WIRE_BYTES) + varint(0).
    const allocator = std.testing.allocator;
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(allocator);
    const writer = buf.writer(allocator);

    // Each empty row: tag byte 0x0A (field 1, wire type 2) + length 0
    const row_count = MAX_ROWS_PER_PAGE + 1;
    for (0..row_count) |_| {
        try encodeTag(writer, 1, WIRE_BYTES);
        try encodeVarint(writer, 0); // empty row submessage
    }

    const result = decodeDataPage(allocator, buf.items);
    try std.testing.expectError(error.TooManyRows, result);
}
