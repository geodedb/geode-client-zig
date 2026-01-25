// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Batch query support for the Geode Zig client library.
// Provides efficient execution of multiple queries in a single round-trip.

const std = @import("std");
const types = @import("types");
const Value = types.Value;
const validate = @import("validate");
const protocol = @import("protocol");

/// A single query in a batch operation.
pub const BatchQuery = struct {
    /// The GQL query string
    query: []const u8,
    /// Optional parameters for this query
    params: ?std.StringHashMap(Value),

    const Self = @This();

    /// Create a batch query without parameters.
    pub fn init(query: []const u8) Self {
        return Self{
            .query = query,
            .params = null,
        };
    }

    /// Create a batch query with parameters.
    pub fn withParams(query: []const u8, params: std.StringHashMap(Value)) Self {
        return Self{
            .query = query,
            .params = params,
        };
    }
};

/// Result of a single query in a batch.
pub const BatchResult = struct {
    /// Query index in the batch (0-based)
    index: usize,
    /// Whether this query succeeded
    success: bool,
    /// Number of rows affected or returned
    rows_affected: u64,
    /// Error message if failed
    error_message: ?[]const u8,
    /// Status code if failed
    status_code: ?[]const u8,

    const Self = @This();

    /// Create a successful result.
    pub fn ok(index: usize, rows_affected: u64) Self {
        return Self{
            .index = index,
            .success = true,
            .rows_affected = rows_affected,
            .error_message = null,
            .status_code = null,
        };
    }

    /// Create a failed result.
    pub fn err(index: usize, message: []const u8, code: ?[]const u8) Self {
        return Self{
            .index = index,
            .success = false,
            .rows_affected = 0,
            .error_message = message,
            .status_code = code,
        };
    }
};

/// A batch of queries to execute together.
pub const Batch = struct {
    allocator: std.mem.Allocator,
    /// List of queries in the batch
    queries: std.ArrayListUnmanaged(BatchQuery),
    /// Whether to stop on first error
    stop_on_error: bool,
    /// Whether to execute in a transaction
    transactional: bool,

    const Self = @This();

    /// Create a new empty batch.
    pub fn init(allocator: std.mem.Allocator) Self {
        return Self{
            .allocator = allocator,
            .queries = .{},
            .stop_on_error = false,
            .transactional = false,
        };
    }

    /// Free resources associated with this batch.
    pub fn deinit(self: *Self) void {
        self.queries.deinit(self.allocator);
    }

    /// Add a query to the batch.
    pub fn add(self: *Self, query: []const u8) !*Self {
        try validate.query(query);
        try self.queries.append(self.allocator, BatchQuery.init(query));
        return self;
    }

    /// Add a query with parameters to the batch.
    pub fn addWithParams(self: *Self, query: []const u8, params: std.StringHashMap(Value)) !*Self {
        try validate.query(query);
        try self.queries.append(self.allocator, BatchQuery.withParams(query, params));
        return self;
    }

    /// Set whether to stop on first error.
    pub fn withStopOnError(self: *Self, stop: bool) *Self {
        self.stop_on_error = stop;
        return self;
    }

    /// Set whether to execute in a transaction.
    pub fn withTransaction(self: *Self, transactional: bool) *Self {
        self.transactional = transactional;
        return self;
    }

    /// Get the number of queries in the batch.
    pub fn count(self: Self) usize {
        return self.queries.items.len;
    }

    /// Check if the batch is empty.
    pub fn isEmpty(self: Self) bool {
        return self.queries.items.len == 0;
    }

    /// Clear all queries from the batch.
    pub fn clear(self: *Self) void {
        self.queries.clearRetainingCapacity();
    }

    /// Build the BATCH message for this batch.
    pub fn buildMessage(self: Self) ![]u8 {
        if (self.isEmpty()) {
            return error.BatchEmpty;
        }

        // Build array of queries
        var query_strings = std.ArrayListUnmanaged([]const u8){};
        defer query_strings.deinit(self.allocator);

        for (self.queries.items) |q| {
            try query_strings.append(self.allocator, q.query);
        }

        return protocol.buildBatch(
            self.allocator,
            query_strings.items,
            self.stop_on_error,
            self.transactional,
        );
    }
};

/// Builder for creating batches with a fluent API.
pub const BatchBuilder = struct {
    batch: Batch,

    const Self = @This();

    /// Create a new batch builder.
    pub fn init(allocator: std.mem.Allocator) Self {
        return Self{
            .batch = Batch.init(allocator),
        };
    }

    /// Free resources.
    pub fn deinit(self: *Self) void {
        self.batch.deinit();
    }

    /// Add a query.
    pub fn query(self: *Self, q: []const u8) !*Self {
        _ = try self.batch.add(q);
        return self;
    }

    /// Add a query with parameters.
    pub fn queryWithParams(self: *Self, q: []const u8, params: std.StringHashMap(Value)) !*Self {
        _ = try self.batch.addWithParams(q, params);
        return self;
    }

    /// Set stop on error.
    pub fn stopOnError(self: *Self) *Self {
        _ = self.batch.withStopOnError(true);
        return self;
    }

    /// Set transactional mode.
    pub fn transactional(self: *Self) *Self {
        _ = self.batch.withTransaction(true);
        return self;
    }

    /// Build the batch message.
    pub fn build(self: Self) ![]u8 {
        return self.batch.buildMessage();
    }

    /// Get the underlying batch.
    pub fn getBatch(self: *Self) *Batch {
        return &self.batch;
    }
};

/// Errors specific to batch operations.
pub const BatchError = error{
    /// Batch contains no queries
    BatchEmpty,
    /// Batch exceeds maximum size
    BatchTooLarge,
    /// Query in batch failed validation
    InvalidQuery,
};

// =============================================================================
// Unit Tests
// =============================================================================

test "Batch basic creation" {
    var batch = Batch.init(std.testing.allocator);
    defer batch.deinit();

    try std.testing.expect(batch.isEmpty());
    try std.testing.expectEqual(@as(usize, 0), batch.count());
}

test "Batch add queries" {
    var batch = Batch.init(std.testing.allocator);
    defer batch.deinit();

    _ = try batch.add("MATCH (n) RETURN n");
    _ = try batch.add("CREATE (n:Person {name: 'Alice'})");

    try std.testing.expectEqual(@as(usize, 2), batch.count());
    try std.testing.expect(!batch.isEmpty());
}

test "Batch clear" {
    var batch = Batch.init(std.testing.allocator);
    defer batch.deinit();

    _ = try batch.add("MATCH (n) RETURN n");
    try std.testing.expectEqual(@as(usize, 1), batch.count());

    batch.clear();
    try std.testing.expect(batch.isEmpty());
}

test "Batch options" {
    var batch = Batch.init(std.testing.allocator);
    defer batch.deinit();

    _ = batch.withStopOnError(true);
    _ = batch.withTransaction(true);

    try std.testing.expect(batch.stop_on_error);
    try std.testing.expect(batch.transactional);
}

test "Batch rejects empty queries" {
    var batch = Batch.init(std.testing.allocator);
    defer batch.deinit();

    try std.testing.expectError(error.QueryEmpty, batch.add(""));
}

test "Batch buildMessage fails when empty" {
    var batch = Batch.init(std.testing.allocator);
    defer batch.deinit();

    try std.testing.expectError(error.BatchEmpty, batch.buildMessage());
}

test "Batch buildMessage creates valid JSON" {
    var batch = Batch.init(std.testing.allocator);
    defer batch.deinit();

    _ = try batch.add("MATCH (n) RETURN n");
    _ = try batch.add("CREATE (m:Node)");

    const msg = try batch.buildMessage();
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"BATCH\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "MATCH (n) RETURN n") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "CREATE (m:Node)") != null);
}

test "BatchBuilder fluent API" {
    var builder = BatchBuilder.init(std.testing.allocator);
    defer builder.deinit();

    _ = try builder.query("MATCH (n) RETURN n");
    _ = try builder.query("CREATE (m:Node)");
    _ = builder.stopOnError();
    _ = builder.transactional();

    try std.testing.expectEqual(@as(usize, 2), builder.getBatch().count());
    try std.testing.expect(builder.getBatch().stop_on_error);
    try std.testing.expect(builder.getBatch().transactional);
}

test "BatchResult ok" {
    const result = BatchResult.ok(0, 42);
    try std.testing.expect(result.success);
    try std.testing.expectEqual(@as(usize, 0), result.index);
    try std.testing.expectEqual(@as(u64, 42), result.rows_affected);
    try std.testing.expect(result.error_message == null);
}

test "BatchResult err" {
    const result = BatchResult.err(1, "Query failed", "42000");
    try std.testing.expect(!result.success);
    try std.testing.expectEqual(@as(usize, 1), result.index);
    try std.testing.expectEqualStrings("Query failed", result.error_message.?);
    try std.testing.expectEqualStrings("42000", result.status_code.?);
}

test "BatchQuery init" {
    const q = BatchQuery.init("MATCH (n) RETURN n");
    try std.testing.expectEqualStrings("MATCH (n) RETURN n", q.query);
    try std.testing.expect(q.params == null);
}
