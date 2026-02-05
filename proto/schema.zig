const std = @import("std");
const protobuf = @import("protobuf");

const fd = protobuf.fd;

// ----------------------------------------------------------------------------
// Authentication (HELLO)
// ----------------------------------------------------------------------------
pub const HelloRequest = struct {
    username: []const u8 = "",
    password: []const u8 = "",
    tenant_id: ?[]const u8 = null,

    pub const _desc_table = .{
        .username = fd(1, .{ .scalar = .string }),
        .password = fd(2, .{ .scalar = .string }),
        .tenant_id = fd(3, .{ .scalar = .string }),
    };

    pub fn deinit(self: *HelloRequest, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const HelloResponse = struct {
    success: bool = false,
    session_id: []const u8 = "",
    error_message: []const u8 = "",
    capabilities: std.ArrayList([]const u8),

    pub const _desc_table = .{
        .success = fd(1, .{ .scalar = .bool }),
        .session_id = fd(2, .{ .scalar = .string }),
        .error_message = fd(3, .{ .scalar = .string }),
        .capabilities = fd(4, .{ .repeated = .{ .scalar = .string } }),
    };

    pub fn deinit(self: *HelloResponse, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

// ----------------------------------------------------------------------------
// Query Execution (RUN_GQL)
// ----------------------------------------------------------------------------
pub const ParameterEntry = struct {
    key: []const u8,
    value: []const u8,

    pub const _desc_table = .{
        .key = fd(1, .{ .scalar = .string }),
        .value = fd(2, .{ .scalar = .string }),
    };

    pub fn deinit(self: *ParameterEntry, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const ExecuteRequest = struct {
    session_id: []const u8 = "",
    query: []const u8 = "",
    parameters: std.ArrayList(ParameterEntry),

    pub const _desc_table = .{
        .session_id = fd(1, .{ .scalar = .string }),
        .query = fd(2, .{ .scalar = .string }),
        .parameters = fd(3, .{ .repeated = .{ .submessage = {} } }),
    };

    pub fn deinit(self: *ExecuteRequest, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

// ----------------------------------------------------------------------------
// Transactions (BEGIN/COMMIT/ROLLBACK)
// ----------------------------------------------------------------------------
pub const BeginRequest = struct {
    read_only: bool = false,

    pub const _desc_table = .{
        .read_only = fd(1, .{ .scalar = .bool }),
    };

    pub fn deinit(self: *BeginRequest, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const BeginResponse = struct {
    session_id: []const u8 = "",
    tx_id: []const u8 = "",

    pub const _desc_table = .{
        .session_id = fd(1, .{ .scalar = .string }),
        .tx_id = fd(2, .{ .scalar = .string }),
    };

    pub fn deinit(self: *BeginResponse, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const CommitRequest = struct {
    pub const _desc_table = .{};
    pub fn deinit(self: *CommitRequest, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const CommitResponse = struct {
    success: bool = false,

    pub const _desc_table = .{
        .success = fd(1, .{ .scalar = .bool }),
    };

    pub fn deinit(self: *CommitResponse, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const RollbackRequest = struct {
    pub const _desc_table = .{};
    pub fn deinit(self: *RollbackRequest, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const RollbackResponse = struct {
    success: bool = false,

    pub const _desc_table = .{
        .success = fd(1, .{ .scalar = .bool }),
    };

    pub fn deinit(self: *RollbackResponse, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

// ----------------------------------------------------------------------------
// Utilities (PING)
// ----------------------------------------------------------------------------
pub const PingRequest = struct {
    pub const _desc_table = .{};
    pub fn deinit(self: *PingRequest, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const PingResponse = struct {
    ok: bool = false,

    pub const _desc_table = .{
        .ok = fd(1, .{ .scalar = .bool }),
    };

    pub fn deinit(self: *PingResponse, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

// ----------------------------------------------------------------------------
// Execution Response Types
// ----------------------------------------------------------------------------

pub const ColumnDefinition = struct {
    name: []const u8 = "",
    type: []const u8 = "",

    pub const _desc_table = .{
        .name = fd(1, .{ .scalar = .string }),
        .type = fd(2, .{ .scalar = .string }),
    };

    pub fn deinit(self: *ColumnDefinition, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const SchemaDefinition = struct {
    columns: std.ArrayList(ColumnDefinition),

    pub const _desc_table = .{
        .columns = fd(1, .{ .repeated = .{ .submessage = {} } }),
    };

    pub fn deinit(self: *SchemaDefinition, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const Error = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    type: []const u8 = "ERROR",

    pub const _desc_table = .{
        .code = fd(1, .{ .scalar = .string }),
        .message = fd(2, .{ .scalar = .string }),
        .type = fd(3, .{ .scalar = .string }),
    };

    pub fn deinit(self: *Error, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const Value = struct {
    kind: ?ValueKind,

    pub const _desc_table = .{
        .kind = fd(null, .{ .oneof = ValueKind }),
    };

    pub fn deinit(self: *Value, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const ValueKind = union(enum) {
    string_val: []const u8,
    int_val: i64,
    double_val: f64,
    bool_val: bool,
    null_val: bool,

    pub const _desc_table = .{
        .string_val = fd(1, .{ .scalar = .string }),
        .int_val = fd(2, .{ .scalar = .int64 }),
        .double_val = fd(3, .{ .scalar = .double }),
        .bool_val = fd(4, .{ .scalar = .bool }),
        .null_val = fd(5, .{ .scalar = .bool }),
    };
};

pub const Row = struct {
    values: std.ArrayList(Value),

    pub const _desc_table = .{
        .values = fd(1, .{ .repeated = .{ .submessage = {} } }),
    };

    pub fn deinit(self: *Row, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const DataPage = struct {
    rows: std.ArrayList(Row),
    last_page: bool = false,

    pub const _desc_table = .{
        .rows = fd(1, .{ .repeated = .{ .submessage = {} } }),
        .last_page = fd(2, .{ .scalar = .bool }),
    };

    pub fn deinit(self: *DataPage, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const ExecutionMetrics = struct {
    parse_duration_ns: i64 = 0,
    plan_duration_ns: i64 = 0,
    execute_duration_ns: i64 = 0,
    total_duration_ns: i64 = 0,

    pub const _desc_table = .{
        .parse_duration_ns = fd(1, .{ .scalar = .int64 }),
        .plan_duration_ns = fd(2, .{ .scalar = .int64 }),
        .execute_duration_ns = fd(3, .{ .scalar = .int64 }),
        .total_duration_ns = fd(4, .{ .scalar = .int64 }),
    };

    pub fn deinit(self: *ExecutionMetrics, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

// ----------------------------------------------------------------------------
// Top-Level Messages (Unions)
// ----------------------------------------------------------------------------

pub const QuicClientMessage = union(enum) {
    hello: HelloRequest,
    execute: ExecuteRequest,
    ping: PingRequest,
    begin: BeginRequest,
    commit: CommitRequest,
    rollback: RollbackRequest,

    pub const _desc_table = .{
        .hello = fd(1, .{ .submessage = {} }),
        .execute = fd(2, .{ .submessage = {} }),
        .ping = fd(3, .{ .submessage = {} }),
        .begin = fd(6, .{ .submessage = {} }),
        .commit = fd(7, .{ .submessage = {} }),
        .rollback = fd(8, .{ .submessage = {} }),
    };
};

pub const QuicServerMessage = union(enum) {
    hello: HelloResponse,
    execute: ExecutionResponse,
    ping: PingResponse,
    begin: BeginResponse,
    commit: CommitResponse,
    rollback: RollbackResponse,

    pub const _desc_table = .{
        .hello = fd(1, .{ .submessage = {} }),
        .execute = fd(2, .{ .submessage = {} }),
        .ping = fd(3, .{ .submessage = {} }),
        .begin = fd(6, .{ .submessage = {} }),
        .commit = fd(7, .{ .submessage = {} }),
        .rollback = fd(8, .{ .submessage = {} }),
    };
};

// Helper for Heartbeat
pub const Heartbeat = struct {
    pub const _desc_table = .{};
    pub fn deinit(self: *Heartbeat, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const ExecutionResponse = struct {
    val: ?ExecutionResponseUnion,

    pub const _desc_table = .{
        .val = fd(null, .{ .oneof = ExecutionResponseUnion }),
    };

    pub fn deinit(self: *ExecutionResponse, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const ExecutionResponseUnion = union(enum) {
    schema: SchemaDefinition,
    page: DataPage,
    @"error": Error,
    metrics: ExecutionMetrics,
    heartbeat: Heartbeat,

    pub const _desc_table = .{
        .schema = fd(1, .{ .submessage = {} }),
        .page = fd(2, .{ .submessage = {} }),
        .@"error" = fd(3, .{ .submessage = {} }),
        .metrics = fd(4, .{ .submessage = {} }),
        .heartbeat = fd(5, .{ .submessage = {} }),
    };
};

// Wrapper Structs for Top-Level Encoding (Oneof)

pub const ClientPacket = struct {
    msg: ?QuicClientMessage,
    pub const _desc_table = .{
        .msg = fd(null, .{ .oneof = QuicClientMessage }),
    };

    pub fn deinit(self: *ClientPacket, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};

pub const ServerPacket = struct {
    msg: ?QuicServerMessage,
    pub const _desc_table = .{
        .msg = fd(null, .{ .oneof = QuicServerMessage }),
    };

    pub fn deinit(self: *ServerPacket, allocator: std.mem.Allocator) void {
        protobuf.deinit(allocator, self);
    }
};
