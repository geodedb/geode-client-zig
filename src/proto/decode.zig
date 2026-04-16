// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Protobuf decoding functions for Geode wire protocol.
// Low-level primitives and message decoding.

const std = @import("std");
const types = @import("types.zig");
const encode = @import("encode.zig");

// Re-import types used by decoding functions
const WIRE_VARINT = types.WIRE_VARINT;
const WIRE_FIXED64 = types.WIRE_FIXED64;
const WIRE_BYTES = types.WIRE_BYTES;
const WIRE_FIXED32 = types.WIRE_FIXED32;
const MAX_STRING_FIELD_SIZE = types.MAX_STRING_FIELD_SIZE;
const MAX_ROWS_PER_PAGE = types.MAX_ROWS_PER_PAGE;

const HelloResponse = types.HelloResponse;
const ColumnDefinition = types.ColumnDefinition;
const SchemaDefinition = types.SchemaDefinition;
const Value = types.Value;
const Row = types.Row;
const DataPage = types.DataPage;
const ProtoError = types.ProtoError;
const Status = types.Status;
const ExecutionMetrics = types.ExecutionMetrics;
const ExecutionResponse = types.ExecutionResponse;
const PullResponse = types.PullResponse;
const PingResponse = types.PingResponse;
const BeginResponse = types.BeginResponse;
const CommitResponse = types.CommitResponse;
const RollbackResponse = types.RollbackResponse;
const SavepointResponse = types.SavepointResponse;
const RollbackToResponse = types.RollbackToResponse;
const QuicServerMessage = types.QuicServerMessage;

// =============================================================================
// Decoding helpers
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
// Message decoding
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
                val.int_val = 0;
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
                val.double_val = 0;
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
                val.string_val = try allocator.dupe(u8, "");
                var str_pos: usize = 0;
                while (str_pos < str_data.len) {
                    const str_tag = try decodeTag(str_data, &str_pos);
                    if (str_tag.field_num == 1 and str_tag.wire_type == WIRE_BYTES) {
                        if (val.string_val) |s| allocator.free(s);
                        val.string_val = try decodeString(allocator, str_data, &str_pos);
                    } else {
                        try skipField(str_data, &str_pos, str_tag.wire_type);
                    }
                }
            } else try skipField(val_data, &val_pos, tag.wire_type),
            6 => if (tag.wire_type == WIRE_BYTES) {
                const dec_data = try decodeBytesField(val_data, &val_pos);
                val.double_val = try decodeDecimalAsFloat(allocator, dec_data);
            } else try skipField(val_data, &val_pos, tag.wire_type),
            else => try skipField(val_data, &val_pos, tag.wire_type),
        }
    }
    return val;
}

fn decodeDecimalAsFloat(allocator: std.mem.Allocator, data: []const u8) !f64 {
    var coeff: ?[]u8 = null;
    defer if (coeff) |buf| allocator.free(buf);

    var orig_repr: ?[]u8 = null;
    defer if (orig_repr) |buf| allocator.free(buf);

    var scale: u32 = 0;
    var pos: usize = 0;
    while (pos < data.len) {
        const tag = try decodeTag(data, &pos);
        switch (tag.field_num) {
            1 => if (tag.wire_type == WIRE_BYTES) {
                coeff = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            2 => if (tag.wire_type == WIRE_VARINT) {
                scale = try decodeUint32(data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            3 => if (tag.wire_type == WIRE_VARINT) {
                _ = try decodeUint32(data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            4 => if (tag.wire_type == WIRE_BYTES) {
                orig_repr = try decodeString(allocator, data, &pos);
            } else try skipField(data, &pos, tag.wire_type),
            else => try skipField(data, &pos, tag.wire_type),
        }
    }

    if (orig_repr) |repr| {
        return try std.fmt.parseFloat(f64, repr);
    }

    const coeff_str = coeff orelse return 0;
    if (scale == 0) {
        return try std.fmt.parseFloat(f64, coeff_str);
    }

    const negative = coeff_str.len > 0 and coeff_str[0] == '-';
    const digits = if (negative) coeff_str[1..] else coeff_str;
    const split = if (digits.len > scale) digits.len - scale else 0;

    var text = std.ArrayList(u8).initCapacity(allocator, digits.len + 4) catch return error.OutOfMemory;
    defer text.deinit(allocator);

    if (negative) {
        try text.append(allocator, '-');
    }

    if (split == 0) {
        try text.appendSlice(allocator, "0.");
        const zeros = scale - @as(u32, @intCast(digits.len));
        for (0..zeros) |_| {
            try text.append(allocator, '0');
        }
        try text.appendSlice(allocator, digits);
    } else {
        try text.appendSlice(allocator, digits[0..split]);
        try text.append(allocator, '.');
        try text.appendSlice(allocator, digits[split..]);
    }

    return try std.fmt.parseFloat(f64, text.items);
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

// =============================================================================
// Unit Tests
// =============================================================================

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

test "decodeString rejects oversized string field" {
    // Craft a varint encoding of MAX_STRING_FIELD_SIZE + 1
    const oversized_len: u64 = MAX_STRING_FIELD_SIZE + 1;
    var len_buf: [10]u8 = undefined;
    var len_fbs = std.Io.fixedBufferStream(&len_buf);
    encode.encodeVarint(len_fbs.writer(), oversized_len) catch unreachable;
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
        try encode.encodeTag(writer, 1, WIRE_BYTES);
        try encode.encodeVarint(writer, 0); // empty row submessage
    }

    const result = decodeDataPage(allocator, buf.items);
    try std.testing.expectError(error.TooManyRows, result);
}
