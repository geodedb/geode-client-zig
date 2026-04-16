// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Protobuf encoding functions for Geode wire protocol.
// Low-level primitives and message encoding with zero intermediate allocations.

const std = @import("std");
const types = @import("types.zig");

// Re-import types used by encoding functions
const WIRE_VARINT = types.WIRE_VARINT;
const WIRE_FIXED64 = types.WIRE_FIXED64;
const WIRE_BYTES = types.WIRE_BYTES;

const HelloRequest = types.HelloRequest;
const ExecuteRequest = types.ExecuteRequest;
const PullRequest = types.PullRequest;
const BeginRequest = types.BeginRequest;
const CommitRequest = types.CommitRequest;
const RollbackRequest = types.RollbackRequest;
const SavepointRequest = types.SavepointRequest;
const RollbackToRequest = types.RollbackToRequest;
const QuicClientMessage = types.QuicClientMessage;
const PingRequest = types.PingRequest;
const Param = types.Param;
const Value = types.Value;

// =============================================================================
// ArrayList writer adapter (Zig 0.16: ArrayList no longer has .writer())
// =============================================================================

/// Minimal writer adapter for `std.ArrayListUnmanaged(u8)`.
///
/// In Zig 0.16, `std.ArrayList.writer()` was removed. The generic encoding
/// helpers in this file use `writer: anytype`, so we just need a tiny type
/// that exposes `writeByte`, `writeAll`, and `print` to satisfy duck-typing.
///
/// The adapter holds a pointer to the underlying list plus the allocator.
/// Operations append directly to the list; the list's `items.len` continues
/// to reflect the encoded byte count for callers that use backpatching.
const ArrayListWriter = struct {
    buf: *std.ArrayListUnmanaged(u8),
    allocator: std.mem.Allocator,

    pub fn writeByte(self: ArrayListWriter, byte: u8) !void {
        try self.buf.append(self.allocator, byte);
    }

    pub fn writeAll(self: ArrayListWriter, bytes: []const u8) !void {
        try self.buf.appendSlice(self.allocator, bytes);
    }

    pub fn print(self: ArrayListWriter, comptime fmt: []const u8, args: anytype) !void {
        // Route formatted output through a temporary std.Io.Writer.Allocating
        // would reallocate; instead, size the formatted output and append.
        const needed = std.fmt.count(fmt, args);
        try self.buf.ensureUnusedCapacity(self.allocator, needed);
        const start = self.buf.items.len;
        self.buf.items.len = start + needed;
        var fw = std.Io.Writer.fixed(self.buf.items[start..]);
        try fw.print(fmt, args);
    }
};

fn arrayListWriter(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator) ArrayListWriter {
    return .{ .buf = buf, .allocator = allocator };
}

// =============================================================================
// Encoding helpers (low-level protobuf primitives)
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
    var sub_writer = std.Io.Writer.fixed(&stack_buf);

    try @call(.auto, encode_fn, .{&sub_writer} ++ args);

    const sub_data = sub_writer.buffered();
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

    const writer = arrayListWriter(buf, allocator);

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
    var varint_w = std.Io.Writer.fixed(&varint_buf);
    encodeVarint(&varint_w, data_len) catch unreachable;
    const varint_written = varint_w.buffered();
    const varint_len = varint_written.len;

    if (varint_len == 5) {
        // Perfect fit, just overwrite the reserved bytes
        @memcpy(buf.items[len_pos..][0..5], varint_written);
    } else {
        // Need to shift data left to close the gap
        const gap = 5 - varint_len;
        // Write the actual varint at len_pos
        @memcpy(buf.items[len_pos..][0..varint_len], varint_written);
        // Shift the data left by 'gap' bytes
        const dest_start = len_pos + varint_len;
        std.mem.copyForwards(u8, buf.items[dest_start..], buf.items[data_start..buf.items.len]);
        buf.items.len -= gap;
    }
}

fn writeValueTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, val: Value) !void {
    const writer = arrayListWriter(buf, allocator);
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
        var inner_len_w = std.Io.Writer.fixed(&inner_len_buf);
        encodeVarint(&inner_len_w, s.len) catch unreachable;
        const inner_len_written = inner_len_w.buffered();
        const str_varint_len = inner_len_written.len;
        const inner_total = 1 + str_varint_len + s.len; // tag + varint + data

        try encodeTag(writer, 5, WIRE_BYTES);
        try encodeVarint(writer, inner_total);
        // Inner: field 1, WIRE_BYTES
        try writer.writeByte(0x0A); // tag for field 1, wire type 2
        try writer.writeAll(inner_len_written);
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
    const writer = arrayListWriter(buf, allocator);
    try encodeString(writer, 1, param.name);
    // Encode value as submessage via backpatch
    try writeSubmessageToList(buf, allocator, 2, writeValueTo, .{param.value});
}

fn writeHelloRequestTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, req: HelloRequest) !void {
    const writer = arrayListWriter(buf, allocator);
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
    const writer = arrayListWriter(buf, allocator);
    try encodeString(writer, 1, req.session_id);
    try encodeString(writer, 2, req.query);

    // Encode params as repeated Param submessages via backpatch
    for (req.params.items) |param| {
        try writeSubmessageToList(buf, allocator, 3, writeParamTo, .{param});
    }

    // Encode optional request_id for request tracing
    if (req.request_id.len > 0) {
        try encodeString(arrayListWriter(buf, allocator), 4, req.request_id);
    }
}

fn writePullRequestTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, req: PullRequest) !void {
    const writer = arrayListWriter(buf, allocator);
    try encodeUint64(writer, 1, req.request_id);
    try encodeUint32(writer, 2, req.page_size);
    try encodeString(writer, 3, req.session_id);
}

fn writeBeginRequestTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, req: BeginRequest) !void {
    const writer = arrayListWriter(buf, allocator);
    try encodeBool(writer, 1, req.read_only);
    try encodeString(writer, 2, req.session_id);
}

/// Shared encoder for messages with up to two string fields.
/// field1 is encoded as protobuf field 1, field2 (if non-empty) as field 2.
fn writeTwoStringFieldsTo(buf: *std.ArrayListUnmanaged(u8), allocator: std.mem.Allocator, field1: []const u8, field2: []const u8) !void {
    const writer = arrayListWriter(buf, allocator);
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
        const writer = arrayListWriter(buf, allocator);
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
    var buf: std.ArrayListUnmanaged(u8) = .empty;
    errdefer buf.deinit(allocator);

    try writeQuicClientMessageToList(&buf, allocator, msg);

    return buf.toOwnedSlice(allocator);
}

/// Encode message with 4-byte big-endian length prefix (single allocation).
/// Reserves 4 bytes, encodes the message directly, then backpatches the length.
pub fn encodeWithLengthPrefix(allocator: std.mem.Allocator, msg: QuicClientMessage) ![]u8 {
    var buf: std.ArrayListUnmanaged(u8) = .empty;
    errdefer buf.deinit(allocator);

    // Reserve 4 bytes for the length prefix (will be backpatched)
    try buf.appendSlice(allocator, &[4]u8{ 0, 0, 0, 0 });

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

// =============================================================================
// Unit Tests
// =============================================================================

test "encodeVarint encodes small values" {
    var buf: [16]u8 = undefined;
    var w = std.Io.Writer.fixed(&buf);
    try encodeVarint(&w, 1);
    try std.testing.expectEqualSlices(u8, &[_]u8{0x01}, w.buffered());
}

test "encodeVarint encodes large values" {
    var buf: [16]u8 = undefined;
    var w = std.Io.Writer.fixed(&buf);
    try encodeVarint(&w, 300);
    try std.testing.expectEqualSlices(u8, &[_]u8{ 0xAC, 0x02 }, w.buffered());
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
    var buf: std.ArrayListUnmanaged(u8) = .empty;
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
    const decode = @import("decode.zig");
    const length = try decode.decodeLengthPrefix(encoded[0..4]);
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
        .pull = types.PullRequest{
            .request_id = 1,
            .page_size = 500,
            .session_id = "session123",
        },
    };
    const encoded = try encodeWithLengthPrefix(allocator, msg);
    defer allocator.free(encoded);

    try std.testing.expect(encoded.len >= 4);
}
