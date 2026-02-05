// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Query explain and profile support for the Geode Zig client library.
// Provides query plan analysis and execution profiling.
// Note: EXPLAIN and PROFILE use the Execute message with special query prefixes.

const std = @import("std");

/// A single operation in a query execution plan.
pub const PlanOperation = struct {
    /// Operation type (e.g., "NodeScan", "Filter", "Expand")
    operation: []const u8,
    /// Description of the operation
    description: ?[]const u8,
    /// Estimated row count
    estimated_rows: ?u64,
    /// Child operations (for tree structure)
    children: []const PlanOperation,
    /// Additional operation-specific details
    details: ?std.StringHashMapUnmanaged([]const u8),

    const Self = @This();

    /// Create a new plan operation.
    pub fn init(operation: []const u8) Self {
        return Self{
            .operation = operation,
            .description = null,
            .estimated_rows = null,
            .children = &[_]PlanOperation{},
            .details = null,
        };
    }

    /// Create a plan operation with description.
    pub fn withDescription(operation: []const u8, description: []const u8) Self {
        return Self{
            .operation = operation,
            .description = description,
            .estimated_rows = null,
            .children = &[_]PlanOperation{},
            .details = null,
        };
    }

    /// Check if this operation has children.
    pub fn hasChildren(self: Self) bool {
        return self.children.len > 0;
    }

    /// Get the child count.
    pub fn childCount(self: Self) usize {
        return self.children.len;
    }
};

/// A query execution plan showing how the query will be executed.
pub const QueryPlan = struct {
    allocator: std.mem.Allocator,
    /// The original query
    query: []const u8,
    /// Root operation of the plan tree
    root: ?PlanOperation,
    /// Total estimated cost
    estimated_cost: ?f64,
    /// Planner version
    planner_version: ?[]const u8,
    /// Raw plan data from server
    raw_plan: ?[]const u8,

    const Self = @This();

    /// Create an empty query plan.
    pub fn init(allocator: std.mem.Allocator, query: []const u8) !Self {
        return Self{
            .allocator = allocator,
            .query = try allocator.dupe(u8, query),
            .root = null,
            .estimated_cost = null,
            .planner_version = null,
            .raw_plan = null,
        };
    }

    /// Free resources associated with this plan.
    pub fn deinit(self: *Self) void {
        self.allocator.free(self.query);
        if (self.raw_plan) |raw| {
            self.allocator.free(raw);
        }
        if (self.planner_version) |pv| {
            self.allocator.free(pv);
        }
    }

    /// Get the query string.
    pub fn getQuery(self: Self) []const u8 {
        return self.query;
    }

    /// Check if the plan has been populated.
    pub fn hasPlan(self: Self) bool {
        return self.root != null;
    }

    /// Get the estimated cost if available.
    pub fn getEstimatedCost(self: Self) ?f64 {
        return self.estimated_cost;
    }

    /// Set the raw plan data from the server response.
    pub fn setRawPlan(self: *Self, raw: []const u8) !void {
        if (self.raw_plan) |old| {
            self.allocator.free(old);
        }
        self.raw_plan = try self.allocator.dupe(u8, raw);
    }

    /// Format the plan as a string for display.
    pub fn format(self: Self, writer: anytype) !void {
        try writer.print("Query Plan for: {s}\n", .{self.query});
        if (self.estimated_cost) |cost| {
            try writer.print("Estimated Cost: {d:.2}\n", .{cost});
        }
        if (self.root) |root| {
            try formatOperation(root, writer, 0);
        } else if (self.raw_plan) |raw| {
            try writer.print("Raw Plan:\n{s}\n", .{raw});
        } else {
            try writer.print("(No plan available)\n", .{});
        }
    }
};

/// Query execution profile with timing information.
pub const QueryProfile = struct {
    allocator: std.mem.Allocator,
    /// The original query
    query: []const u8,
    /// Total execution time in nanoseconds
    total_time_ns: u64,
    /// Planning time in nanoseconds
    planning_time_ns: ?u64,
    /// Execution time in nanoseconds
    execution_time_ns: ?u64,
    /// Number of rows returned
    rows_returned: u64,
    /// Number of rows processed
    rows_processed: ?u64,
    /// Memory usage in bytes
    memory_bytes: ?u64,
    /// Per-operation timing
    operation_times: ?std.StringHashMapUnmanaged(u64),
    /// Raw profile data from server
    raw_profile: ?[]const u8,

    const Self = @This();

    /// Create a new query profile.
    pub fn init(allocator: std.mem.Allocator, query: []const u8) !Self {
        return Self{
            .allocator = allocator,
            .query = try allocator.dupe(u8, query),
            .total_time_ns = 0,
            .planning_time_ns = null,
            .execution_time_ns = null,
            .rows_returned = 0,
            .rows_processed = null,
            .memory_bytes = null,
            .operation_times = null,
            .raw_profile = null,
        };
    }

    /// Free resources associated with this profile.
    pub fn deinit(self: *Self) void {
        self.allocator.free(self.query);
        if (self.raw_profile) |raw| {
            self.allocator.free(raw);
        }
    }

    /// Get the query string.
    pub fn getQuery(self: Self) []const u8 {
        return self.query;
    }

    /// Get total execution time in milliseconds.
    pub fn totalTimeMs(self: Self) f64 {
        return @as(f64, @floatFromInt(self.total_time_ns)) / 1_000_000.0;
    }

    /// Get planning time in milliseconds if available.
    pub fn planningTimeMs(self: Self) ?f64 {
        if (self.planning_time_ns) |ns| {
            return @as(f64, @floatFromInt(ns)) / 1_000_000.0;
        }
        return null;
    }

    /// Get execution time in milliseconds if available.
    pub fn executionTimeMs(self: Self) ?f64 {
        if (self.execution_time_ns) |ns| {
            return @as(f64, @floatFromInt(ns)) / 1_000_000.0;
        }
        return null;
    }

    /// Set the raw profile data from the server response.
    pub fn setRawProfile(self: *Self, raw: []const u8) !void {
        if (self.raw_profile) |old| {
            self.allocator.free(old);
        }
        self.raw_profile = try self.allocator.dupe(u8, raw);
    }

    /// Format the profile as a string for display.
    pub fn format(self: Self, writer: anytype) !void {
        try writer.print("Query Profile for: {s}\n", .{self.query});
        try writer.print("Total Time: {d:.3} ms\n", .{self.totalTimeMs()});
        if (self.planningTimeMs()) |pt| {
            try writer.print("Planning Time: {d:.3} ms\n", .{pt});
        }
        if (self.executionTimeMs()) |et| {
            try writer.print("Execution Time: {d:.3} ms\n", .{et});
        }
        try writer.print("Rows Returned: {d}\n", .{self.rows_returned});
        if (self.rows_processed) |rp| {
            try writer.print("Rows Processed: {d}\n", .{rp});
        }
        if (self.memory_bytes) |mb| {
            try writer.print("Memory Used: {d} bytes\n", .{mb});
        }
    }
};

/// Build an EXPLAIN query string.
/// Returns the query with EXPLAIN prefix for use with Execute message.
pub fn buildExplainQuery(allocator: std.mem.Allocator, query: []const u8) ![]u8 {
    return std.fmt.allocPrint(allocator, "EXPLAIN {s}", .{query});
}

/// Build a PROFILE query string.
/// Returns the query with PROFILE prefix for use with Execute message.
pub fn buildProfileQuery(allocator: std.mem.Allocator, query: []const u8) ![]u8 {
    return std.fmt.allocPrint(allocator, "PROFILE {s}", .{query});
}

// Helper function to format a plan operation with indentation
fn formatOperation(op: PlanOperation, writer: anytype, indent: usize) !void {
    // Write indentation
    for (0..indent) |_| {
        try writer.writeAll("  ");
    }

    try writer.print("- {s}", .{op.operation});
    if (op.description) |desc| {
        try writer.print(": {s}", .{desc});
    }
    if (op.estimated_rows) |rows| {
        try writer.print(" (est. {d} rows)", .{rows});
    }
    try writer.writeAll("\n");

    // Recursively format children
    for (op.children) |child| {
        try formatOperation(child, writer, indent + 1);
    }
}

// =============================================================================
// Unit Tests
// =============================================================================

test "PlanOperation basic creation" {
    const op = PlanOperation.init("NodeScan");
    try std.testing.expectEqualStrings("NodeScan", op.operation);
    try std.testing.expect(op.description == null);
    try std.testing.expect(!op.hasChildren());
}

test "PlanOperation with description" {
    const op = PlanOperation.withDescription("Filter", "n.age > 21");
    try std.testing.expectEqualStrings("Filter", op.operation);
    try std.testing.expectEqualStrings("n.age > 21", op.description.?);
}

test "QueryPlan basic creation" {
    var plan = try QueryPlan.init(std.testing.allocator, "MATCH (n) RETURN n");
    defer plan.deinit();

    try std.testing.expectEqualStrings("MATCH (n) RETURN n", plan.getQuery());
    try std.testing.expect(!plan.hasPlan());
    try std.testing.expect(plan.getEstimatedCost() == null);
}

test "QueryPlan setRawPlan" {
    var plan = try QueryPlan.init(std.testing.allocator, "MATCH (n) RETURN n");
    defer plan.deinit();

    try plan.setRawPlan("plan data here");
    try std.testing.expect(plan.raw_plan != null);
}

test "QueryProfile basic creation" {
    var profile = try QueryProfile.init(std.testing.allocator, "MATCH (n) RETURN n");
    defer profile.deinit();

    try std.testing.expectEqualStrings("MATCH (n) RETURN n", profile.getQuery());
    try std.testing.expectEqual(@as(f64, 0.0), profile.totalTimeMs());
}

test "QueryProfile time conversions" {
    var profile = try QueryProfile.init(std.testing.allocator, "MATCH (n) RETURN n");
    defer profile.deinit();

    profile.total_time_ns = 1_500_000; // 1.5 ms
    profile.planning_time_ns = 500_000; // 0.5 ms
    profile.execution_time_ns = 1_000_000; // 1.0 ms

    try std.testing.expectApproxEqRel(@as(f64, 1.5), profile.totalTimeMs(), 0.001);
    try std.testing.expectApproxEqRel(@as(f64, 0.5), profile.planningTimeMs().?, 0.001);
    try std.testing.expectApproxEqRel(@as(f64, 1.0), profile.executionTimeMs().?, 0.001);
}

test "QueryProfile format" {
    var profile = try QueryProfile.init(std.testing.allocator, "MATCH (n) RETURN n");
    defer profile.deinit();

    profile.total_time_ns = 2_000_000;
    profile.rows_returned = 100;

    var buf: [1024]u8 = undefined;
    var stream = std.io.fixedBufferStream(&buf);
    try profile.format(stream.writer());

    const output = stream.getWritten();
    try std.testing.expect(std.mem.indexOf(u8, output, "Query Profile for:") != null);
    try std.testing.expect(std.mem.indexOf(u8, output, "Total Time:") != null);
    try std.testing.expect(std.mem.indexOf(u8, output, "Rows Returned: 100") != null);
}

test "buildExplainQuery creates prefixed query" {
    const query = try buildExplainQuery(std.testing.allocator, "MATCH (n) RETURN n");
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("EXPLAIN MATCH (n) RETURN n", query);
}

test "buildProfileQuery creates prefixed query" {
    const query = try buildProfileQuery(std.testing.allocator, "MATCH (n) RETURN n");
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("PROFILE MATCH (n) RETURN n", query);
}
