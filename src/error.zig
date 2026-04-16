// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Error types for the Geode Zig client library.
// Provides structured error handling with ISO GQL status codes.

const std = @import("std");

/// ISO GQL Status Code categories (ISO/IEC 39075)
pub const StatusCategory = enum {
    /// Successful completion (00xxx)
    success,
    /// Warning (01xxx)
    warning,
    /// No data (02xxx)
    no_data,
    /// Connection exception (08xxx)
    connection,
    /// Feature not supported (0Axxx)
    feature_not_supported,
    /// Invalid transaction state (25xxx)
    invalid_transaction_state,
    /// Invalid authorization (28xxx)
    invalid_authorization,
    /// Syntax error (42xxx)
    syntax_error,
    /// Data exception (22xxx)
    data_exception,
    /// Constraint violation (23xxx)
    constraint_violation,
    /// System error (58xxx)
    system_error,
    /// Unknown error category
    unknown,

    /// Parse a status category from an ISO code string
    pub fn fromCode(code: []const u8) StatusCategory {
        if (code.len < 2) return .unknown;

        const prefix = code[0..2];
        if (std.mem.eql(u8, prefix, "00")) return .success;
        if (std.mem.eql(u8, prefix, "01")) return .warning;
        if (std.mem.eql(u8, prefix, "02")) return .no_data;
        if (std.mem.eql(u8, prefix, "08")) return .connection;
        if (std.mem.eql(u8, prefix, "0A")) return .feature_not_supported;
        if (std.mem.eql(u8, prefix, "22")) return .data_exception;
        if (std.mem.eql(u8, prefix, "23")) return .constraint_violation;
        if (std.mem.eql(u8, prefix, "25")) return .invalid_transaction_state;
        if (std.mem.eql(u8, prefix, "28")) return .invalid_authorization;
        if (std.mem.eql(u8, prefix, "42")) return .syntax_error;
        if (std.mem.eql(u8, prefix, "58")) return .system_error;
        return .unknown;
    }

    /// Check if this category represents a retryable error
    pub fn isRetryable(self: StatusCategory) bool {
        return switch (self) {
            .connection, .system_error => true,
            else => false,
        };
    }
};

/// Geode client error with optional ISO status code
pub const GeodeError = struct {
    /// Error kind
    kind: ErrorKind,
    /// Human-readable error message
    message: []const u8,
    /// ISO GQL status code (e.g., "42000" for syntax error)
    iso_code: ?[]const u8,
    /// Original source error message from server
    source: ?[]const u8,

    pub const ErrorKind = enum {
        /// Connection failed or was lost
        connection,
        /// Query execution failed
        query,
        /// Protocol/wire format error
        protocol,
        /// Transaction error
        transaction,
        /// Authentication/authorization error
        auth,
        /// Timeout waiting for response
        timeout,
        /// Configuration error
        config,
        /// Type conversion error
        type_conversion,
        /// Validation error
        validation,
        /// Resource exhausted (pool, memory)
        resource_exhausted,
        /// Internal client error
        internal,
        /// Unknown/unclassified error
        unknown,
    };

    /// Create a connection error
    pub fn connection(message: []const u8) GeodeError {
        return .{
            .kind = .connection,
            .message = message,
            .iso_code = "08000",
            .source = null,
        };
    }

    /// Create a query error with ISO code
    pub fn query(message: []const u8, iso_code: ?[]const u8) GeodeError {
        return .{
            .kind = .query,
            .message = message,
            .iso_code = iso_code,
            .source = null,
        };
    }

    /// Create a syntax error
    pub fn syntax(message: []const u8) GeodeError {
        return .{
            .kind = .query,
            .message = message,
            .iso_code = "42000",
            .source = null,
        };
    }

    /// Create a protocol error
    pub fn protocol(message: []const u8) GeodeError {
        return .{
            .kind = .protocol,
            .message = message,
            .iso_code = null,
            .source = null,
        };
    }

    /// Create a transaction error
    pub fn transaction(message: []const u8, iso_code: ?[]const u8) GeodeError {
        return .{
            .kind = .transaction,
            .message = message,
            .iso_code = iso_code orelse "25000",
            .source = null,
        };
    }

    /// Create an authentication error
    pub fn auth(message: []const u8) GeodeError {
        return .{
            .kind = .auth,
            .message = message,
            .iso_code = "28000",
            .source = null,
        };
    }

    /// Create a timeout error
    pub fn timeout(message: []const u8) GeodeError {
        return .{
            .kind = .timeout,
            .message = message,
            .iso_code = "08006",
            .source = null,
        };
    }

    /// Create a configuration error
    pub fn config(message: []const u8) GeodeError {
        return .{
            .kind = .config,
            .message = message,
            .iso_code = null,
            .source = null,
        };
    }

    /// Create a type conversion error
    pub fn typeConversion(message: []const u8) GeodeError {
        return .{
            .kind = .type_conversion,
            .message = message,
            .iso_code = "22000",
            .source = null,
        };
    }

    /// Create a validation error
    pub fn validation(message: []const u8) GeodeError {
        return .{
            .kind = .validation,
            .message = message,
            .iso_code = null,
            .source = null,
        };
    }

    /// Create a resource exhausted error
    pub fn resourceExhausted(message: []const u8) GeodeError {
        return .{
            .kind = .resource_exhausted,
            .message = message,
            .iso_code = "53000",
            .source = null,
        };
    }

    /// Create an error from a server error response
    pub fn fromServerError(message: []const u8, iso_code: ?[]const u8, source: ?[]const u8) GeodeError {
        const kind: ErrorKind = if (iso_code) |code| blk: {
            const category = StatusCategory.fromCode(code);
            break :blk switch (category) {
                .connection => .connection,
                .syntax_error => .query,
                .invalid_transaction_state => .transaction,
                .invalid_authorization => .auth,
                .data_exception => .type_conversion,
                .system_error => .internal,
                else => .query,
            };
        } else .unknown;

        return .{
            .kind = kind,
            .message = message,
            .iso_code = iso_code,
            .source = source,
        };
    }

    /// Check if this error is retryable
    pub fn isRetryable(self: GeodeError) bool {
        return switch (self.kind) {
            .connection, .timeout, .resource_exhausted => true,
            else => if (self.iso_code) |code|
                StatusCategory.fromCode(code).isRetryable()
            else
                false,
        };
    }

    /// Get the status category for this error
    pub fn statusCategory(self: GeodeError) StatusCategory {
        if (self.iso_code) |code| {
            return StatusCategory.fromCode(code);
        }
        return .unknown;
    }

    /// Format the error for display
    pub fn format(self: GeodeError, writer: anytype) !void {
        try writer.print("GeodeError({s})", .{@tagName(self.kind)});
        if (self.iso_code) |code| {
            try writer.print(" [{s}]", .{code});
        }
        try writer.print(": {s}", .{self.message});
        if (self.source) |src| {
            try writer.print(" (source: {s})", .{src});
        }
    }
};

/// Result type for operations that can fail with GeodeError
pub fn Result(comptime T: type) type {
    return union(enum) {
        ok: T,
        err: GeodeError,

        const Self = @This();

        pub fn isOk(self: Self) bool {
            return self == .ok;
        }

        pub fn isErr(self: Self) bool {
            return self == .err;
        }

        pub fn unwrap(self: Self) T {
            return switch (self) {
                .ok => |value| value,
                .err => |e| std.debug.panic("called unwrap on err: {any}", .{e}),
            };
        }

        pub fn unwrapOr(self: Self, default: T) T {
            return switch (self) {
                .ok => |value| value,
                .err => default,
            };
        }

        pub fn unwrapErr(self: Self) GeodeError {
            return switch (self) {
                .ok => std.debug.panic("called unwrapErr on ok value", .{}),
                .err => |e| e,
            };
        }
    };
}

// =============================================================================
// Unit Tests
// =============================================================================

test "StatusCategory.fromCode parses success codes" {
    try std.testing.expectEqual(StatusCategory.success, StatusCategory.fromCode("00000"));
    try std.testing.expectEqual(StatusCategory.success, StatusCategory.fromCode("00001"));
}

test "StatusCategory.fromCode parses error codes" {
    try std.testing.expectEqual(StatusCategory.connection, StatusCategory.fromCode("08000"));
    try std.testing.expectEqual(StatusCategory.syntax_error, StatusCategory.fromCode("42000"));
    try std.testing.expectEqual(StatusCategory.data_exception, StatusCategory.fromCode("22000"));
    try std.testing.expectEqual(StatusCategory.invalid_authorization, StatusCategory.fromCode("28000"));
    try std.testing.expectEqual(StatusCategory.invalid_transaction_state, StatusCategory.fromCode("25000"));
    try std.testing.expectEqual(StatusCategory.constraint_violation, StatusCategory.fromCode("23000"));
    try std.testing.expectEqual(StatusCategory.system_error, StatusCategory.fromCode("58000"));
    try std.testing.expectEqual(StatusCategory.feature_not_supported, StatusCategory.fromCode("0A000"));
    try std.testing.expectEqual(StatusCategory.warning, StatusCategory.fromCode("01000"));
    try std.testing.expectEqual(StatusCategory.no_data, StatusCategory.fromCode("02000"));
}

test "StatusCategory.fromCode handles invalid codes" {
    try std.testing.expectEqual(StatusCategory.unknown, StatusCategory.fromCode(""));
    try std.testing.expectEqual(StatusCategory.unknown, StatusCategory.fromCode("X"));
    try std.testing.expectEqual(StatusCategory.unknown, StatusCategory.fromCode("99999"));
}

test "StatusCategory.isRetryable identifies retryable categories" {
    try std.testing.expect(StatusCategory.connection.isRetryable());
    try std.testing.expect(StatusCategory.system_error.isRetryable());
    try std.testing.expect(!StatusCategory.syntax_error.isRetryable());
    try std.testing.expect(!StatusCategory.invalid_authorization.isRetryable());
    try std.testing.expect(!StatusCategory.success.isRetryable());
}

test "GeodeError.connection creates connection error" {
    const err = GeodeError.connection("connection refused");
    try std.testing.expectEqual(GeodeError.ErrorKind.connection, err.kind);
    try std.testing.expectEqualStrings("connection refused", err.message);
    try std.testing.expectEqualStrings("08000", err.iso_code.?);
}

test "GeodeError.query creates query error" {
    const err = GeodeError.query("invalid query", "42601");
    try std.testing.expectEqual(GeodeError.ErrorKind.query, err.kind);
    try std.testing.expectEqualStrings("invalid query", err.message);
    try std.testing.expectEqualStrings("42601", err.iso_code.?);
}

test "GeodeError.syntax creates syntax error" {
    const err = GeodeError.syntax("unexpected token");
    try std.testing.expectEqual(GeodeError.ErrorKind.query, err.kind);
    try std.testing.expectEqualStrings("42000", err.iso_code.?);
}

test "GeodeError.protocol creates protocol error" {
    const err = GeodeError.protocol("invalid frame");
    try std.testing.expectEqual(GeodeError.ErrorKind.protocol, err.kind);
    try std.testing.expect(err.iso_code == null);
}

test "GeodeError.transaction creates transaction error" {
    const err = GeodeError.transaction("transaction aborted", null);
    try std.testing.expectEqual(GeodeError.ErrorKind.transaction, err.kind);
    try std.testing.expectEqualStrings("25000", err.iso_code.?);
}

test "GeodeError.auth creates auth error" {
    const err = GeodeError.auth("invalid credentials");
    try std.testing.expectEqual(GeodeError.ErrorKind.auth, err.kind);
    try std.testing.expectEqualStrings("28000", err.iso_code.?);
}

test "GeodeError.timeout creates timeout error" {
    const err = GeodeError.timeout("request timed out");
    try std.testing.expectEqual(GeodeError.ErrorKind.timeout, err.kind);
    try std.testing.expectEqualStrings("08006", err.iso_code.?);
}

test "GeodeError.config creates config error" {
    const err = GeodeError.config("invalid DSN");
    try std.testing.expectEqual(GeodeError.ErrorKind.config, err.kind);
    try std.testing.expect(err.iso_code == null);
}

test "GeodeError.typeConversion creates type conversion error" {
    const err = GeodeError.typeConversion("cannot convert string to integer");
    try std.testing.expectEqual(GeodeError.ErrorKind.type_conversion, err.kind);
    try std.testing.expectEqualStrings("22000", err.iso_code.?);
}

test "GeodeError.validation creates validation error" {
    const err = GeodeError.validation("query too long");
    try std.testing.expectEqual(GeodeError.ErrorKind.validation, err.kind);
    try std.testing.expect(err.iso_code == null);
}

test "GeodeError.resourceExhausted creates resource error" {
    const err = GeodeError.resourceExhausted("connection pool exhausted");
    try std.testing.expectEqual(GeodeError.ErrorKind.resource_exhausted, err.kind);
    try std.testing.expectEqualStrings("53000", err.iso_code.?);
}

test "GeodeError.fromServerError infers kind from ISO code" {
    const conn_err = GeodeError.fromServerError("connection lost", "08003", null);
    try std.testing.expectEqual(GeodeError.ErrorKind.connection, conn_err.kind);

    const syntax_err = GeodeError.fromServerError("syntax error", "42601", null);
    try std.testing.expectEqual(GeodeError.ErrorKind.query, syntax_err.kind);

    const auth_err = GeodeError.fromServerError("access denied", "28000", null);
    try std.testing.expectEqual(GeodeError.ErrorKind.auth, auth_err.kind);

    const tx_err = GeodeError.fromServerError("transaction failed", "25001", null);
    try std.testing.expectEqual(GeodeError.ErrorKind.transaction, tx_err.kind);
}

test "GeodeError.isRetryable identifies retryable errors" {
    try std.testing.expect(GeodeError.connection("lost").isRetryable());
    try std.testing.expect(GeodeError.timeout("timed out").isRetryable());
    try std.testing.expect(GeodeError.resourceExhausted("pool full").isRetryable());
    try std.testing.expect(!GeodeError.syntax("bad query").isRetryable());
    try std.testing.expect(!GeodeError.auth("denied").isRetryable());
}

test "GeodeError.statusCategory returns correct category" {
    const conn_err = GeodeError.connection("lost");
    try std.testing.expectEqual(StatusCategory.connection, conn_err.statusCategory());

    const syntax_err = GeodeError.syntax("bad");
    try std.testing.expectEqual(StatusCategory.syntax_error, syntax_err.statusCategory());

    const proto_err = GeodeError.protocol("invalid");
    try std.testing.expectEqual(StatusCategory.unknown, proto_err.statusCategory());
}

test "Result.isOk and isErr work correctly" {
    const ok_result: Result(i32) = .{ .ok = 42 };
    const err_result: Result(i32) = .{ .err = GeodeError.connection("failed") };

    try std.testing.expect(ok_result.isOk());
    try std.testing.expect(!ok_result.isErr());
    try std.testing.expect(!err_result.isOk());
    try std.testing.expect(err_result.isErr());
}

test "Result.unwrap returns value for ok" {
    const result: Result(i32) = .{ .ok = 42 };
    try std.testing.expectEqual(@as(i32, 42), result.unwrap());
}

test "Result.unwrapOr returns default for err" {
    const result: Result(i32) = .{ .err = GeodeError.connection("failed") };
    try std.testing.expectEqual(@as(i32, -1), result.unwrapOr(-1));
}

test "Result.unwrapErr returns error for err" {
    const result: Result(i32) = .{ .err = GeodeError.connection("failed") };
    const err = result.unwrapErr();
    try std.testing.expectEqual(GeodeError.ErrorKind.connection, err.kind);
}
