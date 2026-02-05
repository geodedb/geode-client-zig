// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Prepared statement support for the Geode Zig client library.
// Provides parameter extraction, validation, and efficient repeated execution.
// Uses protobuf wire format (JSON protocol removed).

const std = @import("std");
const types = @import("types");
const Value = types.Value;
const validate = @import("validate");

/// A prepared statement for efficient repeated query execution.
/// Parses the query once and validates parameters before each execution.
pub const PreparedStatement = struct {
    allocator: std.mem.Allocator,
    /// The original query string
    query: []const u8,
    /// Extracted parameter names from the query
    parameters: []const []const u8,
    /// Whether the statement has been prepared on the server
    is_prepared: bool,
    /// Server-assigned statement ID (if supported)
    statement_id: ?[]const u8,

    const Self = @This();

    /// Create a new prepared statement from a query string.
    /// Extracts all parameter placeholders ($name) from the query.
    pub fn init(allocator: std.mem.Allocator, query: []const u8) !Self {
        // Validate the query first
        try validate.query(query);

        // Extract parameter names
        var params = std.ArrayListUnmanaged([]const u8){};
        errdefer {
            for (params.items) |p| {
                allocator.free(p);
            }
            params.deinit(allocator);
        }

        var i: usize = 0;
        while (i < query.len) {
            if (query[i] == '$') {
                // Found a parameter placeholder
                const start = i + 1;
                var end = start;

                // Find the end of the parameter name
                while (end < query.len and isParamChar(query[end])) {
                    end += 1;
                }

                if (end > start) {
                    const param_name = query[start..end];

                    // Check if we already have this parameter
                    var found = false;
                    for (params.items) |existing| {
                        if (std.mem.eql(u8, existing, param_name)) {
                            found = true;
                            break;
                        }
                    }

                    if (!found) {
                        // Validate parameter name
                        try validate.paramName(param_name);

                        // Store a copy
                        const param_copy = try allocator.dupe(u8, param_name);
                        try params.append(allocator, param_copy);
                    }

                    i = end;
                    continue;
                }
            }
            i += 1;
        }

        // Store query copy
        const query_copy = try allocator.dupe(u8, query);

        return Self{
            .allocator = allocator,
            .query = query_copy,
            .parameters = try params.toOwnedSlice(allocator),
            .is_prepared = false,
            .statement_id = null,
        };
    }

    /// Free resources associated with this prepared statement.
    pub fn deinit(self: *Self) void {
        for (self.parameters) |p| {
            self.allocator.free(p);
        }
        self.allocator.free(self.parameters);
        self.allocator.free(self.query);
        if (self.statement_id) |id| {
            self.allocator.free(id);
        }
    }

    /// Get the query string.
    pub fn getQuery(self: Self) []const u8 {
        return self.query;
    }

    /// Get the list of parameter names extracted from the query.
    pub fn getParameters(self: Self) []const []const u8 {
        return self.parameters;
    }

    /// Get the number of parameters.
    pub fn parameterCount(self: Self) usize {
        return self.parameters.len;
    }

    /// Check if a parameter name is required by this statement.
    pub fn hasParameter(self: Self, name: []const u8) bool {
        for (self.parameters) |p| {
            if (std.mem.eql(u8, p, name)) {
                return true;
            }
        }
        return false;
    }

    /// Validate that all required parameters are provided.
    /// Returns error if any required parameter is missing.
    pub fn validateParams(self: Self, params: ?std.StringHashMap(Value)) !void {
        if (self.parameters.len == 0) {
            return; // No parameters required
        }

        const p = params orelse return error.MissingParameters;

        for (self.parameters) |required| {
            if (!p.contains(required)) {
                return error.MissingParameter;
            }
        }
    }

    /// Mark this statement as prepared on the server.
    pub fn markPrepared(self: *Self, statement_id: ?[]const u8) !void {
        self.is_prepared = true;
        if (statement_id) |id| {
            self.statement_id = try self.allocator.dupe(u8, id);
        }
    }
};

/// Errors specific to prepared statement operations
pub const PreparedError = error{
    /// One or more required parameters are missing
    MissingParameters,
    /// A specific parameter is missing
    MissingParameter,
    /// Parameter value type mismatch
    ParameterTypeMismatch,
    /// Statement has not been prepared
    NotPrepared,
    /// Statement ID is invalid
    InvalidStatementId,
};

// Helper function to check if a character is valid in a parameter name
fn isParamChar(c: u8) bool {
    return (c >= 'a' and c <= 'z') or
        (c >= 'A' and c <= 'Z') or
        (c >= '0' and c <= '9') or
        c == '_';
}

// =============================================================================
// Unit Tests
// =============================================================================

test "PreparedStatement extracts parameters" {
    const stmt = try PreparedStatement.init(
        std.testing.allocator,
        "MATCH (n:Person) WHERE n.name = $name AND n.age > $minAge RETURN n",
    );
    defer @constCast(&stmt).deinit();

    try std.testing.expectEqual(@as(usize, 2), stmt.parameterCount());
    try std.testing.expect(stmt.hasParameter("name"));
    try std.testing.expect(stmt.hasParameter("minAge"));
    try std.testing.expect(!stmt.hasParameter("other"));
}

test "PreparedStatement handles no parameters" {
    const stmt = try PreparedStatement.init(
        std.testing.allocator,
        "MATCH (n) RETURN n",
    );
    defer @constCast(&stmt).deinit();

    try std.testing.expectEqual(@as(usize, 0), stmt.parameterCount());
}

test "PreparedStatement handles duplicate parameters" {
    const stmt = try PreparedStatement.init(
        std.testing.allocator,
        "MATCH (n) WHERE n.x = $val OR n.y = $val RETURN n",
    );
    defer @constCast(&stmt).deinit();

    // Should only count unique parameters
    try std.testing.expectEqual(@as(usize, 1), stmt.parameterCount());
    try std.testing.expect(stmt.hasParameter("val"));
}

test "PreparedStatement validates parameters" {
    const stmt = try PreparedStatement.init(
        std.testing.allocator,
        "MATCH (n) WHERE n.name = $name RETURN n",
    );
    defer @constCast(&stmt).deinit();

    // Missing parameters should fail
    try std.testing.expectError(error.MissingParameters, stmt.validateParams(null));

    // Empty map should fail
    var empty_params = std.StringHashMap(Value).init(std.testing.allocator);
    defer empty_params.deinit();
    try std.testing.expectError(error.MissingParameter, stmt.validateParams(empty_params));

    // Correct parameters should succeed
    var params = std.StringHashMap(Value).init(std.testing.allocator);
    defer params.deinit();
    try params.put("name", Value.initString("Alice"));
    try stmt.validateParams(params);
}

test "PreparedStatement getQuery returns original query" {
    const query = "MATCH (n:Person) RETURN n.name";
    const stmt = try PreparedStatement.init(std.testing.allocator, query);
    defer @constCast(&stmt).deinit();

    try std.testing.expectEqualStrings(query, stmt.getQuery());
}

test "PreparedStatement rejects invalid query" {
    // Empty query should fail
    try std.testing.expectError(error.QueryEmpty, PreparedStatement.init(std.testing.allocator, ""));
}

test "PreparedStatement markPrepared updates state" {
    var stmt = try PreparedStatement.init(
        std.testing.allocator,
        "MATCH (n) RETURN n",
    );
    defer stmt.deinit();

    try std.testing.expect(!stmt.is_prepared);
    try std.testing.expect(stmt.statement_id == null);

    try stmt.markPrepared("stmt-123");

    try std.testing.expect(stmt.is_prepared);
    try std.testing.expectEqualStrings("stmt-123", stmt.statement_id.?);
}

test "isParamChar identifies valid parameter characters" {
    try std.testing.expect(isParamChar('a'));
    try std.testing.expect(isParamChar('z'));
    try std.testing.expect(isParamChar('A'));
    try std.testing.expect(isParamChar('Z'));
    try std.testing.expect(isParamChar('0'));
    try std.testing.expect(isParamChar('9'));
    try std.testing.expect(isParamChar('_'));

    try std.testing.expect(!isParamChar(' '));
    try std.testing.expect(!isParamChar('-'));
    try std.testing.expect(!isParamChar('.'));
    try std.testing.expect(!isParamChar('$'));
}
