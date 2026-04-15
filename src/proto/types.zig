// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Protobuf message type definitions for Geode wire protocol.
// Structs, enums, and constants aligned with geode.proto schema.

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
// =============================================================================

pub const HelloRequest = struct {
    username: []const u8 = "",
    password: []const u8 = "",
    tenant_id: ?[]const u8 = null,
    client_name: []const u8 = "geode-zig",
    client_version: []const u8 = "0.1.0",
    wanted_conformance: []const u8 = "minimum",
    graph: ?[]const u8 = null,
};

pub const HelloResponse = struct {
    success: bool = false,
    session_id: []u8 = &.{},
    error_message: []u8 = &.{},
    capabilities: std.ArrayListUnmanaged([]u8) = .{},
    password_reset_required: bool = false,
    graph: ?[]const u8 = null,

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
        if (self.graph) |graph| {
            allocator.free(graph);
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

    pub fn deinit(self: *ColumnDefinition, allocator: std.mem.Allocator) void {
        if (self.name.len > 0) allocator.free(self.name);
        if (self.col_type.len > 0) allocator.free(self.col_type);
    }
};

pub const SchemaDefinition = struct {
    columns: std.ArrayListUnmanaged(ColumnDefinition) = .{},

    pub fn deinit(self: *SchemaDefinition, allocator: std.mem.Allocator) void {
        for (self.columns.items) |*col| {
            col.deinit(allocator);
        }
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

    pub fn deinit(self: *Value, allocator: std.mem.Allocator) void {
        if (self.string_val) |s| {
            allocator.free(s);
            self.string_val = null;
        }
    }
};

pub const Row = struct {
    values: std.ArrayListUnmanaged(Value) = .{},

    pub fn deinit(self: *Row, allocator: std.mem.Allocator) void {
        for (self.values.items) |*value| {
            value.deinit(allocator);
        }
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

    pub fn deinit(self: *ProtoError, allocator: std.mem.Allocator) void {
        if (self.code.len > 0) allocator.free(self.code);
        if (self.message.len > 0) allocator.free(self.message);
        if (self.error_type.len > 0) allocator.free(self.error_type);
        if (self.anchor.len > 0) allocator.free(self.anchor);
    }
};

pub const Status = struct {
    status_class: []const u8 = "",
    status_subclass: []const u8 = "",
    additional_statuses: std.ArrayListUnmanaged([]const u8) = .{},
    flagger_findings: std.ArrayListUnmanaged([]const u8) = .{},

    pub fn deinit(self: *Status, allocator: std.mem.Allocator) void {
        if (self.status_class.len > 0) allocator.free(self.status_class);
        if (self.status_subclass.len > 0) allocator.free(self.status_subclass);
        for (self.additional_statuses.items) |status| {
            allocator.free(status);
        }
        self.additional_statuses.deinit(allocator);
        for (self.flagger_findings.items) |finding| {
            allocator.free(finding);
        }
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
        if (self.err) |*e| e.deinit(allocator);
    }
};

pub const PullResponse = struct {
    response: ?ExecutionResponse = null,

    pub fn deinit(self: *PullResponse, allocator: std.mem.Allocator) void {
        if (self.response) |*response| response.deinit(allocator);
    }
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

    pub fn deinit(self: *BeginResponse, allocator: std.mem.Allocator) void {
        if (self.session_id.len > 0) allocator.free(self.session_id);
        if (self.tx_id.len > 0) allocator.free(self.tx_id);
    }
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
        if (self.pull) |*pull| pull.deinit(allocator);
        if (self.begin) |*begin| begin.deinit(allocator);
    }
};

// =============================================================================
// Unit Tests
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

test "DataPage.lastPage returns final" {
    const page = DataPage{ .final = true };
    try std.testing.expect(page.lastPage());
}
