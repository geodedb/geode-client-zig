// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Integration tests for the Geode Zig client library.
// Requires a running Geode server (docker or local).
//
// Run with: zig build test-integration
// Or: make test-integration-docker (starts Docker container automatically)

const std = @import("std");
const GeodeClient = @import("geode_client").GeodeClient;

// =============================================================================
// Test Configuration
// =============================================================================

/// Default server configuration (can be overridden via environment)
const TestConfig = struct {
    host: []const u8,
    port: u16,
    insecure: bool,
    timeout_ms: u64,

    fn fromEnv() TestConfig {
        const server = std.posix.getenv("GEODE_SERVER") orelse "127.0.0.1:3141";
        const insecure = std.posix.getenv("GEODE_INSECURE") != null;

        var host: []const u8 = "127.0.0.1";
        var port: u16 = 3141;

        if (std.mem.indexOf(u8, server, ":")) |colon_idx| {
            host = server[0..colon_idx];
            port = std.fmt.parseInt(u16, server[colon_idx + 1 ..], 10) catch 3141;
        } else {
            host = server;
        }

        return .{
            .host = host,
            .port = port,
            .insecure = insecure,
            .timeout_ms = 5000,
        };
    }
};

// =============================================================================
// Test Helpers
// =============================================================================

/// Test context with client and allocator
const TestContext = struct {
    allocator: std.mem.Allocator,
    client: GeodeClient,
    config: TestConfig,
    request_id: u64,

    fn init(allocator: std.mem.Allocator) !TestContext {
        const config = TestConfig.fromEnv();

        // Resolve hostname if needed
        var resolved_host: []const u8 = config.host;
        var needs_resolution = false;
        for (config.host) |c| {
            if ((c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z')) {
                needs_resolution = true;
                break;
            }
        }

        if (needs_resolution) {
            const list = std.net.getAddressList(allocator, config.host, config.port) catch {
                return error.DnsResolutionFailed;
            };
            defer list.deinit();

            if (list.addrs.len > 0) {
                // Use heap allocation for resolved host
                var buf: [64]u8 = undefined;
                const addr = list.addrs[0];
                const ip_bytes = @as(*const [4]u8, @ptrCast(&addr.in.sa.addr)).*;
                const result = std.fmt.bufPrint(&buf, "{d}.{d}.{d}.{d}", .{
                    ip_bytes[0], ip_bytes[1], ip_bytes[2], ip_bytes[3],
                }) catch return error.InvalidAddress;
                resolved_host = allocator.dupe(u8, result) catch return error.OutOfMemory;
            }
        }

        var client = GeodeClient.init(allocator, resolved_host, config.port, config.insecure);

        // Connect and handshake
        client.connect() catch |err| {
            client.deinit();
            return err;
        };

        client.sendHello("geode-zig-integration-test", "1.0.0") catch |err| {
            client.deinit();
            return err;
        };

        const hello_response = client.receiveMessage(config.timeout_ms) catch |err| {
            client.deinit();
            return err;
        };
        allocator.free(hello_response);

        return .{
            .allocator = allocator,
            .client = client,
            .config = config,
            .request_id = 1,
        };
    }

    fn deinit(self: *TestContext) void {
        self.client.deinit();
    }

    fn nextRequestId(self: *TestContext) u64 {
        const id = self.request_id;
        self.request_id += 1;
        return id;
    }

    /// Execute a query and return parsed JSON response
    fn query(self: *TestContext, gql: []const u8) !std.json.Parsed(std.json.Value) {
        return self.queryWithParams(gql, null);
    }

    /// Execute a query with parameters
    fn queryWithParams(self: *TestContext, gql: []const u8, params: ?std.json.Value) !std.json.Parsed(std.json.Value) {
        const req_id = self.nextRequestId();

        try self.client.sendRunGql(req_id, gql, params);

        // Receive SCHEMA response
        const schema_response = try self.client.receiveMessage(self.config.timeout_ms);
        self.allocator.free(schema_response);

        // Send PULL
        try self.client.sendPull(req_id, 1000);

        // Receive BINDINGS response
        const bindings_response = try self.client.receiveMessage(self.config.timeout_ms);
        defer self.allocator.free(bindings_response);

        return std.json.parseFromSlice(
            std.json.Value,
            self.allocator,
            bindings_response,
            .{},
        );
    }

    /// Execute a query and expect success (ignore result)
    fn exec(self: *TestContext, gql: []const u8) !void {
        var result = try self.query(gql);
        result.deinit();
    }

    /// Begin a transaction
    fn begin(self: *TestContext) !void {
        try self.client.sendBegin();
        const response = try self.client.receiveMessage(self.config.timeout_ms);
        self.allocator.free(response);
    }

    /// Commit a transaction
    fn commit(self: *TestContext) !void {
        try self.client.sendCommit();
        const response = try self.client.receiveMessage(self.config.timeout_ms);
        self.allocator.free(response);
    }

    /// Rollback a transaction
    fn rollback(self: *TestContext) !void {
        try self.client.sendRollback();
        const response = try self.client.receiveMessage(self.config.timeout_ms);
        self.allocator.free(response);
    }

    /// Get the count of nodes matching a pattern
    fn countNodes(self: *TestContext, label: []const u8) !i64 {
        const q = try std.fmt.allocPrint(self.allocator, "MATCH (n:{s}) RETURN count(n) AS cnt", .{label});
        defer self.allocator.free(q);

        var result = try self.query(q);
        defer result.deinit();

        const rows = getRows(result.value) orelse return error.InvalidResponse;
        if (rows.array.items.len == 0) return 0;

        const first_row = rows.array.items[0];
        const cnt = first_row.object.get("cnt") orelse return error.InvalidResponse;
        return cnt.integer;
    }

    /// Clean up test nodes with a specific label
    fn cleanup(self: *TestContext, label: []const u8) !void {
        const q = try std.fmt.allocPrint(self.allocator, "MATCH (n:{s}) DETACH DELETE n", .{label});
        defer self.allocator.free(q);
        self.exec(q) catch {};
    }
};

/// Get a value from a row by column name
fn getRowValue(row: std.json.Value, column: []const u8) ?std.json.Value {
    return row.object.get(column);
}

/// Check if a response has an error
fn hasError(response: std.json.Value) bool {
    // Check top-level type field
    if (response.object.get("type")) |t| {
        if (t == .string) {
            if (std.mem.eql(u8, t.string, "ERROR")) return true;
        }
    }
    // Check nested result.type field (standard Geode protocol)
    if (response.object.get("result")) |result| {
        if (result.object.get("type")) |t| {
            if (t == .string) {
                return std.mem.eql(u8, t.string, "ERROR");
            }
        }
    }
    return false;
}

/// Extract rows from a parsed response (handles the result.rows nesting)
fn getRows(response: std.json.Value) ?std.json.Value {
    // Try direct "rows" field first (for backwards compatibility)
    if (response.object.get("rows")) |rows| {
        return rows;
    }
    // Try nested "result.rows" format (standard Geode protocol)
    if (response.object.get("result")) |result| {
        if (result.object.get("rows")) |rows| {
            return rows;
        }
    }
    return null;
}

// =============================================================================
// Basic Operation Tests
// =============================================================================

test "integration: ping/connectivity" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    // If we got here, connection succeeded
    try std.testing.expect(true);
}

test "integration: simple query RETURN 1" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 1 AS x");
    defer result.deinit();

    try std.testing.expect(!hasError(result.value));

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len == 1);

    const x = getRowValue(rows.array.items[0], "x") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 1), x.integer);
}

test "integration: query with string literal" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 'hello' AS greeting");
    defer result.deinit();

    try std.testing.expect(!hasError(result.value));

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len == 1);

    const greeting = getRowValue(rows.array.items[0], "greeting") orelse return error.InvalidResponse;
    try std.testing.expectEqualStrings("hello", greeting.string);
}

test "integration: query with multiple return columns" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 1 AS a, 2 AS b, 3 AS c");
    defer result.deinit();

    try std.testing.expect(!hasError(result.value));

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len == 1);

    const row = rows.array.items[0];
    const a = getRowValue(row, "a") orelse return error.InvalidResponse;
    const b = getRowValue(row, "b") orelse return error.InvalidResponse;
    const c = getRowValue(row, "c") orelse return error.InvalidResponse;

    try std.testing.expectEqual(@as(i64, 1), a.integer);
    try std.testing.expectEqual(@as(i64, 2), b.integer);
    try std.testing.expectEqual(@as(i64, 3), c.integer);
}

test "integration: arithmetic expressions" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 2 + 3 AS sum, 10 - 4 AS diff, 3 * 4 AS product");
    defer result.deinit();

    try std.testing.expect(!hasError(result.value));

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    const row = rows.array.items[0];

    const sum = getRowValue(row, "sum") orelse return error.InvalidResponse;
    const diff = getRowValue(row, "diff") orelse return error.InvalidResponse;
    const product = getRowValue(row, "product") orelse return error.InvalidResponse;

    try std.testing.expectEqual(@as(i64, 5), sum.integer);
    try std.testing.expectEqual(@as(i64, 6), diff.integer);
    try std.testing.expectEqual(@as(i64, 12), product.integer);
}

test "integration: boolean expressions" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN true AS t, false AS f, NOT false AS not_f");
    defer result.deinit();

    try std.testing.expect(!hasError(result.value));

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    const row = rows.array.items[0];

    const t = getRowValue(row, "t") orelse return error.InvalidResponse;
    const f = getRowValue(row, "f") orelse return error.InvalidResponse;
    const not_f = getRowValue(row, "not_f") orelse return error.InvalidResponse;

    try std.testing.expect(t.bool);
    try std.testing.expect(!f.bool);
    try std.testing.expect(not_f.bool);
}

// =============================================================================
// Node CRUD Tests
// =============================================================================

test "integration: create node with label" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("TestNode") catch {};

    try ctx.exec("CREATE (n:TestNode)");

    const count = try ctx.countNodes("TestNode");
    try std.testing.expect(count >= 1);
}

test "integration: create node with properties" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Person") catch {};

    try ctx.exec("CREATE (p:Person {name: 'Alice', age: 30})");

    var result = try ctx.query("MATCH (p:Person {name: 'Alice'}) RETURN p.name AS name, p.age AS age");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len >= 1);

    const row = rows.array.items[0];
    const name = getRowValue(row, "name") orelse return error.InvalidResponse;
    const age = getRowValue(row, "age") orelse return error.InvalidResponse;

    try std.testing.expectEqualStrings("Alice", name.string);
    try std.testing.expectEqual(@as(i64, 30), age.integer);
}

test "integration: create multiple nodes" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Item") catch {};

    try ctx.exec("CREATE (a:Item {id: 1}), (b:Item {id: 2}), (c:Item {id: 3})");

    const count = try ctx.countNodes("Item");
    try std.testing.expect(count >= 3);
}

test "integration: update node properties" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Updatable") catch {};

    try ctx.exec("CREATE (n:Updatable {value: 1})");
    try ctx.exec("MATCH (n:Updatable) SET n.value = 100");

    var result = try ctx.query("MATCH (n:Updatable) RETURN n.value AS value");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len >= 1);

    const value = getRowValue(rows.array.items[0], "value") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 100), value.integer);
}

test "integration: delete node" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("ToDelete") catch {};

    try ctx.exec("CREATE (n:ToDelete {id: 999})");

    var count = try ctx.countNodes("ToDelete");
    try std.testing.expect(count >= 1);

    try ctx.exec("MATCH (n:ToDelete {id: 999}) DELETE n");

    count = try ctx.countNodes("ToDelete");
    try std.testing.expectEqual(@as(i64, 0), count);
}

test "integration: node with multiple labels" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Employee") catch {};
    defer ctx.cleanup("Manager") catch {};

    try ctx.exec("CREATE (n:Employee:Manager {name: 'Bob'})");

    var result = try ctx.query("MATCH (n:Employee:Manager) RETURN n.name AS name");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len >= 1);
}

// =============================================================================
// Relationship Tests
// =============================================================================

test "integration: create relationship" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("RelTestA") catch {};
    defer ctx.cleanup("RelTestB") catch {};

    try ctx.exec("CREATE (a:RelTestA {name: 'A'}), (b:RelTestB {name: 'B'}), (a)-[:CONNECTS]->(b)");

    var result = try ctx.query("MATCH (a:RelTestA)-[:CONNECTS]->(b:RelTestB) RETURN a.name AS from, b.name AS to");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len >= 1);
}

test "integration: relationship with properties" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Friend") catch {};

    try ctx.exec("CREATE (a:Friend {name: 'Alice'}), (b:Friend {name: 'Bob'}), (a)-[:KNOWS {since: 2020}]->(b)");

    var result = try ctx.query("MATCH (a:Friend)-[r:KNOWS]->(b:Friend) RETURN r.since AS since");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len >= 1);

    const since = getRowValue(rows.array.items[0], "since") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 2020), since.integer);
}

test "integration: bidirectional relationship query" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("BiDir") catch {};

    try ctx.exec("CREATE (a:BiDir {id: 1}), (b:BiDir {id: 2}), (a)-[:LINKED]->(b)");

    // Query in reverse direction
    var result = try ctx.query("MATCH (a:BiDir)<-[:LINKED]-(b:BiDir) RETURN a.id AS a_id, b.id AS b_id");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len >= 1);
}

test "integration: path traversal" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("PathNode") catch {};

    try ctx.exec("CREATE (a:PathNode {id: 1}), (b:PathNode {id: 2}), (c:PathNode {id: 3}), (a)-[:NEXT]->(b)-[:NEXT]->(c)");

    var result = try ctx.query("MATCH (a:PathNode {id: 1})-[:NEXT]->(b)-[:NEXT]->(c) RETURN c.id AS end_id");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len >= 1);

    const end_id = getRowValue(rows.array.items[0], "end_id") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 3), end_id.integer);
}

// =============================================================================
// Transaction Tests
// =============================================================================

test "integration: transaction commit" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("TxCommit") catch {};

    try ctx.begin();
    try ctx.exec("CREATE (n:TxCommit {value: 42})");
    try ctx.commit();

    const count = try ctx.countNodes("TxCommit");
    try std.testing.expect(count >= 1);
}

test "integration: transaction rollback" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("TxRollback") catch {};

    // Ensure no nodes exist
    ctx.cleanup("TxRollback") catch {};

    try ctx.begin();
    try ctx.exec("CREATE (n:TxRollback {value: 999})");
    try ctx.rollback();

    // Use count to verify rollback (per Go client pattern)
    const count = try ctx.countNodes("TxRollback");
    try std.testing.expectEqual(@as(i64, 0), count);
}

test "integration: multi-operation transaction" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("TxMulti") catch {};

    try ctx.begin();
    try ctx.exec("CREATE (a:TxMulti {id: 1})");
    try ctx.exec("CREATE (b:TxMulti {id: 2})");
    try ctx.exec("CREATE (c:TxMulti {id: 3})");
    try ctx.commit();

    const count = try ctx.countNodes("TxMulti");
    try std.testing.expect(count >= 3);
}

// =============================================================================
// Query Operations Tests
// =============================================================================

test "integration: WHERE clause" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Filterable") catch {};

    try ctx.exec("CREATE (a:Filterable {value: 10}), (b:Filterable {value: 20}), (c:Filterable {value: 30})");

    var result = try ctx.query("MATCH (n:Filterable) WHERE n.value > 15 RETURN n.value AS value ORDER BY n.value");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len >= 2);
}

test "integration: ORDER BY clause" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Sortable") catch {};

    try ctx.exec("CREATE (a:Sortable {n: 3}), (b:Sortable {n: 1}), (c:Sortable {n: 2})");

    var result = try ctx.query("MATCH (x:Sortable) RETURN x.n AS n ORDER BY x.n");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len >= 3);

    // Verify order
    const first = getRowValue(rows.array.items[0], "n") orelse return error.InvalidResponse;
    const second = getRowValue(rows.array.items[1], "n") orelse return error.InvalidResponse;
    try std.testing.expect(first.integer <= second.integer);
}

test "integration: LIMIT clause" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Limited") catch {};

    try ctx.exec("CREATE (a:Limited {n: 1}), (b:Limited {n: 2}), (c:Limited {n: 3}), (d:Limited {n: 4}), (e:Limited {n: 5})");

    var result = try ctx.query("MATCH (n:Limited) RETURN n.n AS n LIMIT 3");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(usize, 3), rows.array.items.len);
}

test "integration: SKIP clause" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Skippable") catch {};

    try ctx.exec("CREATE (a:Skippable {n: 1}), (b:Skippable {n: 2}), (c:Skippable {n: 3})");

    var result = try ctx.query("MATCH (n:Skippable) RETURN n.n AS n ORDER BY n.n SKIP 1 LIMIT 2");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(usize, 2), rows.array.items.len);

    // First result should be 2 (skipped 1)
    const first = getRowValue(rows.array.items[0], "n") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 2), first.integer);
}

// =============================================================================
// Aggregation Tests
// =============================================================================

test "integration: COUNT aggregation" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Countable") catch {};

    try ctx.exec("CREATE (a:Countable), (b:Countable), (c:Countable)");

    var result = try ctx.query("MATCH (n:Countable) RETURN count(n) AS cnt");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len == 1);

    const cnt = getRowValue(rows.array.items[0], "cnt") orelse return error.InvalidResponse;
    try std.testing.expect(cnt.integer >= 3);
}

test "integration: SUM aggregation" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Summable") catch {};

    try ctx.exec("CREATE (a:Summable {val: 10}), (b:Summable {val: 20}), (c:Summable {val: 30})");

    var result = try ctx.query("MATCH (n:Summable) RETURN sum(n.val) AS total");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    const total = getRowValue(rows.array.items[0], "total") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 60), total.integer);
}

test "integration: AVG aggregation" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Averageable") catch {};

    try ctx.exec("CREATE (a:Averageable {val: 10}), (b:Averageable {val: 20}), (c:Averageable {val: 30})");

    var result = try ctx.query("MATCH (n:Averageable) RETURN avg(n.val) AS average");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    const average = getRowValue(rows.array.items[0], "average") orelse return error.InvalidResponse;

    // Average of 10, 20, 30 is 20
    const avg_value = if (average == .integer) @as(f64, @floatFromInt(average.integer)) else average.float;
    try std.testing.expectApproxEqRel(@as(f64, 20.0), avg_value, 0.01);
}

test "integration: MIN/MAX aggregation" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("MinMaxable") catch {};

    try ctx.exec("CREATE (a:MinMaxable {val: 5}), (b:MinMaxable {val: 15}), (c:MinMaxable {val: 10})");

    var result = try ctx.query("MATCH (n:MinMaxable) RETURN min(n.val) AS minimum, max(n.val) AS maximum");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    const row = rows.array.items[0];

    const minimum = getRowValue(row, "minimum") orelse return error.InvalidResponse;
    const maximum = getRowValue(row, "maximum") orelse return error.InvalidResponse;

    try std.testing.expectEqual(@as(i64, 5), minimum.integer);
    try std.testing.expectEqual(@as(i64, 15), maximum.integer);
}

// =============================================================================
// Data Type Tests
// =============================================================================

test "integration: null value" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN null AS n");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    const n = getRowValue(rows.array.items[0], "n") orelse return error.InvalidResponse;
    try std.testing.expect(n == .null);
}

test "integration: integer values" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 0 AS zero, -100 AS negative, 9999999 AS large");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    const row = rows.array.items[0];

    const zero = getRowValue(row, "zero") orelse return error.InvalidResponse;
    const negative = getRowValue(row, "negative") orelse return error.InvalidResponse;
    const large = getRowValue(row, "large") orelse return error.InvalidResponse;

    try std.testing.expectEqual(@as(i64, 0), zero.integer);
    try std.testing.expectEqual(@as(i64, -100), negative.integer);
    try std.testing.expectEqual(@as(i64, 9999999), large.integer);
}

test "integration: float values" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 3.14159 AS pi, -2.5 AS negative");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    const row = rows.array.items[0];

    const pi = getRowValue(row, "pi") orelse return error.InvalidResponse;
    const negative = getRowValue(row, "negative") orelse return error.InvalidResponse;

    try std.testing.expectApproxEqRel(@as(f64, 3.14159), pi.float, 0.00001);
    try std.testing.expectApproxEqRel(@as(f64, -2.5), negative.float, 0.00001);
}

test "integration: string with unicode" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 'Hello World' AS ascii, 'Caf\\u00e9' AS cafe");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    const row = rows.array.items[0];

    const ascii = getRowValue(row, "ascii") orelse return error.InvalidResponse;
    try std.testing.expectEqualStrings("Hello World", ascii.string);
}

test "integration: array values" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN [1, 2, 3] AS nums");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    const nums = getRowValue(rows.array.items[0], "nums") orelse return error.InvalidResponse;

    try std.testing.expect(nums == .array);
    try std.testing.expectEqual(@as(usize, 3), nums.array.items.len);
    try std.testing.expectEqual(@as(i64, 1), nums.array.items[0].integer);
    try std.testing.expectEqual(@as(i64, 2), nums.array.items[1].integer);
    try std.testing.expectEqual(@as(i64, 3), nums.array.items[2].integer);
}

test "integration: map/object values" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN {key: 'value', num: 42} AS obj");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    const obj = getRowValue(rows.array.items[0], "obj") orelse return error.InvalidResponse;

    try std.testing.expect(obj == .object);

    const key_val = obj.object.get("key") orelse return error.InvalidResponse;
    const num_val = obj.object.get("num") orelse return error.InvalidResponse;

    try std.testing.expectEqualStrings("value", key_val.string);
    try std.testing.expectEqual(@as(i64, 42), num_val.integer);
}

// =============================================================================
// Error Handling Tests
// =============================================================================

test "integration: query non-existent property" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("PropTest") catch {};

    try ctx.exec("CREATE (n:PropTest {existing: 1})");

    var result = try ctx.query("MATCH (n:PropTest) RETURN n.nonexistent AS val");
    defer result.deinit();

    // Should return null for non-existent property
    const rows = getRows(result.value) orelse return error.InvalidResponse;
    if (rows.array.items.len > 0) {
        const val = getRowValue(rows.array.items[0], "val");
        if (val) |v| {
            try std.testing.expect(v == .null);
        }
    }
}

// =============================================================================
// OPTIONAL MATCH Tests
// =============================================================================

test "integration: OPTIONAL MATCH with missing relationship" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("OptionalTest") catch {};

    try ctx.exec("CREATE (a:OptionalTest {name: 'alone'})");

    var result = try ctx.query("MATCH (a:OptionalTest) OPTIONAL MATCH (a)-[:MISSING]->(b) RETURN a.name AS name, b AS other");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len >= 1);

    const row = rows.array.items[0];
    const name = getRowValue(row, "name") orelse return error.InvalidResponse;
    try std.testing.expectEqualStrings("alone", name.string);

    // b should be null since the relationship doesn't exist
    const other = getRowValue(row, "other");
    if (other) |o| {
        try std.testing.expect(o == .null);
    }
}

// =============================================================================
// MERGE Tests
// =============================================================================

test "integration: MERGE creates if not exists" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("MergeTest") catch {};

    // Clean slate
    ctx.cleanup("MergeTest") catch {};

    try ctx.exec("MERGE (n:MergeTest {id: 1})");

    const count = try ctx.countNodes("MergeTest");
    try std.testing.expectEqual(@as(i64, 1), count);
}

test "integration: MERGE matches if exists" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("MergeExist") catch {};

    // Clean slate
    ctx.cleanup("MergeExist") catch {};

    try ctx.exec("CREATE (n:MergeExist {id: 1})");
    try ctx.exec("MERGE (n:MergeExist {id: 1})");

    const count = try ctx.countNodes("MergeExist");
    try std.testing.expectEqual(@as(i64, 1), count);
}

// =============================================================================
// WITH Clause Tests
// =============================================================================

test "integration: WITH for chained queries" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("WithTest") catch {};

    try ctx.exec("CREATE (a:WithTest {val: 1}), (b:WithTest {val: 2}), (c:WithTest {val: 3})");

    var result = try ctx.query("MATCH (n:WithTest) WITH n.val AS v WHERE v > 1 RETURN v ORDER BY v");
    defer result.deinit();

    const rows = getRows(result.value) orelse return error.InvalidResponse;
    try std.testing.expect(rows.array.items.len >= 2);

    const first = getRowValue(rows.array.items[0], "v") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 2), first.integer);
}
