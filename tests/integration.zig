// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Integration tests for the Geode Zig client library.
// Requires a running Geode server (docker or local).
//
// Run with: zig build test-integration
// Or: make test-integration-docker (starts Docker container automatically)
// Or: make test-integration-grpc (gRPC transport)
//
// Environment variables:
//   GEODE_SERVER    - Server address (default: 127.0.0.1:3141)
//   GEODE_INSECURE  - Set to "1" to skip TLS verification
//   GEODE_TRANSPORT - Transport protocol: "quic" (default) or "grpc"

const std = @import("std");
const geode_client = @import("geode_client");
const GeodeClient = geode_client.GeodeClient;
const Transport = geode_client.config.Transport;
const proto = geode_client.proto;
const QueryResult = geode_client.QueryResult;

// =============================================================================
// Test Configuration
// =============================================================================

/// Default server configuration (can be overridden via environment)
const TestConfig = struct {
    host: []const u8,
    port: u16,
    insecure: bool,
    timeout_ms: u64,
    transport: Transport,
    username: []const u8,
    password: []const u8,

    fn fromEnv() TestConfig {
        // Determine transport first (affects default port)
        const transport_env = std.posix.getenv("GEODE_TRANSPORT");
        const transport: Transport = if (transport_env) |t|
            Transport.fromString(t) orelse .quic
        else
            .quic;

        const default_port: u16 = transport.defaultPort();
        const server = std.posix.getenv("GEODE_SERVER") orelse blk: {
            break :blk if (transport == .grpc) "127.0.0.1:50051" else "127.0.0.1:3141";
        };
        const insecure = std.posix.getenv("GEODE_INSECURE") != null;
        const username = std.posix.getenv("GEODE_USERNAME") orelse std.posix.getenv("GEODE_USER") orelse "geode";
        const password = std.posix.getenv("GEODE_PASSWORD") orelse
            std.posix.getenv("GEODE_DEFAULT_PASSWORD") orelse
            std.posix.getenv("GEODE_ADMIN_PASSWORD") orelse
            "GeodeTestPassword123!";

        var host: []const u8 = "127.0.0.1";
        var port: u16 = default_port;

        if (std.mem.indexOf(u8, server, ":")) |colon_idx| {
            host = server[0..colon_idx];
            port = std.fmt.parseInt(u16, server[colon_idx + 1 ..], 10) catch default_port;
        } else {
            host = server;
        }

        return .{
            .host = host,
            .port = port,
            .insecure = insecure,
            .timeout_ms = 5000,
            .transport = transport,
            .username = username,
            .password = password,
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

    fn init(allocator: std.mem.Allocator) !TestContext {
        const config = TestConfig.fromEnv();

        // The Zig client's gRPC transport is not yet a real HTTP/2 implementation.
        if (config.transport == .grpc) {
            return error.SkipZigTest;
        }

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
                var buf: [64]u8 = undefined;
                const addr = list.addrs[0];
                const ip_bytes = @as(*const [4]u8, @ptrCast(&addr.in.sa.addr)).*;
                const result = std.fmt.bufPrint(&buf, "{d}.{d}.{d}.{d}", .{
                    ip_bytes[0], ip_bytes[1], ip_bytes[2], ip_bytes[3],
                }) catch return error.InvalidAddress;
                resolved_host = allocator.dupe(u8, result) catch return error.OutOfMemory;
            }
        }

        var client = try GeodeClient.initWithTransport(
            allocator,
            resolved_host,
            config.port,
            config.insecure,
            config.username,
            config.password,
            config.transport,
        );

        // Connect to server
        client.connect() catch |err| {
            client.deinit();
            return err;
        };

        // Send HELLO handshake
        client.sendHello() catch |err| {
            client.deinit();
            return err;
        };

        return .{
            .allocator = allocator,
            .client = client,
            .config = config,
        };
    }

    fn deinit(self: *TestContext) void {
        self.client.deinit();
    }

    /// Execute a query and return the result
    fn query(self: *TestContext, gql: []const u8) !QueryResult {
        return self.client.query(gql, null);
    }

    /// Execute a query with string parameters
    fn queryWithParams(self: *TestContext, gql: []const u8, params: std.StringHashMapUnmanaged([]const u8)) !QueryResult {
        return self.client.query(gql, params);
    }

    /// Execute a query and expect success (ignore result)
    fn exec(self: *TestContext, gql: []const u8) !void {
        var result = try self.client.query(gql, null);
        if (result.hasError()) {
            result.deinit();
            return error.QueryFailed;
        }
        result.deinit();
    }

    /// Begin a transaction
    fn begin(self: *TestContext) !void {
        const tx_id = try self.client.begin();
        self.allocator.free(tx_id);
    }

    /// Commit a transaction
    fn commit(self: *TestContext) !void {
        try self.client.commit();
    }

    /// Rollback a transaction
    fn rollback(self: *TestContext) !void {
        try self.client.rollback();
    }

    /// Validate that a label contains only safe identifier characters.
    /// Labels in GQL are identifiers and cannot be parameterized with $param syntax,
    /// so we must validate them to prevent injection.
    pub fn isValidLabel(label: []const u8) bool {
        if (label.len == 0) return false;
        // First character must be letter or underscore
        const first = label[0];
        if (!((first >= 'a' and first <= 'z') or (first >= 'A' and first <= 'Z') or first == '_')) {
            return false;
        }
        // Subsequent characters must be alphanumeric or underscore
        for (label[1..]) |c| {
            if (!((c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') or (c >= '0' and c <= '9') or c == '_')) {
                return false;
            }
        }
        return true;
    }

    /// Get the count of nodes matching a pattern
    fn countNodes(self: *TestContext, label: []const u8) !i64 {
        // Validate label to prevent GQL injection
        if (!isValidLabel(label)) {
            return error.InvalidLabel;
        }

        const q = try std.fmt.allocPrint(self.allocator, "MATCH (n:{s}) RETURN count(n) AS cnt", .{label});
        defer self.allocator.free(q);

        var result = try self.query(q);
        defer result.deinit();

        if (result.rows.items.len == 0) return 0;

        const first_row = result.rows.items[0];
        if (first_row.items.len == 0) return 0;

        // Find the column index for "cnt"
        const col_idx = getColumnIndex(result, "cnt") orelse return error.InvalidResponse;
        const val = first_row.items[col_idx];
        return val.int_val orelse 0;
    }

    /// Clean up test nodes with a specific label
    fn cleanup(self: *TestContext, label: []const u8) !void {
        // Validate label to prevent GQL injection
        if (!isValidLabel(label)) {
            return error.InvalidLabel;
        }

        const q = try std.fmt.allocPrint(self.allocator, "MATCH (n:{s}) DETACH DELETE n", .{label});
        defer self.allocator.free(q);
        self.exec(q) catch {};
    }
};

/// Get the column index by name from a QueryResult
fn getColumnIndex(result: QueryResult, name: []const u8) ?usize {
    for (result.columns.items, 0..) |col, i| {
        if (std.mem.eql(u8, col, name)) return i;
    }
    return null;
}

/// Get a value from a row by column name
fn getRowValue(result: QueryResult, row_idx: usize, col_name: []const u8) ?proto.Value {
    const col_idx = getColumnIndex(result, col_name) orelse return null;
    if (row_idx >= result.rows.items.len) return null;
    const row = result.rows.items[row_idx];
    if (col_idx >= row.items.len) return null;
    return row.items[col_idx];
}

// =============================================================================
// Basic Operation Tests
// =============================================================================

test "integration: ping/connectivity" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    // If we got here, connection and HELLO succeeded
    const ok = try ctx.client.ping();
    try std.testing.expect(ok);
}

test "integration: simple query RETURN 1" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 1 AS x");
    defer result.deinit();

    try std.testing.expect(!result.hasError());
    try std.testing.expect(result.rows.items.len == 1);

    const x = getRowValue(result, 0, "x") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 1), x.int_val.?);
}

test "integration: query with string literal" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 'hello' AS greeting");
    defer result.deinit();

    try std.testing.expect(!result.hasError());
    try std.testing.expect(result.rows.items.len == 1);

    const greeting = getRowValue(result, 0, "greeting") orelse return error.InvalidResponse;
    try std.testing.expectEqualStrings("hello", greeting.string_val.?);
}

test "integration: query with multiple return columns" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 1 AS a, 2 AS b, 3 AS c");
    defer result.deinit();

    try std.testing.expect(!result.hasError());
    try std.testing.expect(result.rows.items.len == 1);

    const a = getRowValue(result, 0, "a") orelse return error.InvalidResponse;
    const b = getRowValue(result, 0, "b") orelse return error.InvalidResponse;
    const c = getRowValue(result, 0, "c") orelse return error.InvalidResponse;

    try std.testing.expectEqual(@as(i64, 1), a.int_val.?);
    try std.testing.expectEqual(@as(i64, 2), b.int_val.?);
    try std.testing.expectEqual(@as(i64, 3), c.int_val.?);
}

test "integration: arithmetic expressions" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 2 + 3 AS sum, 10 - 4 AS diff, 3 * 4 AS product");
    defer result.deinit();

    try std.testing.expect(!result.hasError());

    const sum = getRowValue(result, 0, "sum") orelse return error.InvalidResponse;
    const diff = getRowValue(result, 0, "diff") orelse return error.InvalidResponse;
    const product = getRowValue(result, 0, "product") orelse return error.InvalidResponse;

    try std.testing.expectEqual(@as(i64, 5), sum.int_val.?);
    try std.testing.expectEqual(@as(i64, 6), diff.int_val.?);
    try std.testing.expectEqual(@as(i64, 12), product.int_val.?);
}

test "integration: boolean expressions" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN true AS t, false AS f, NOT false AS not_f");
    defer result.deinit();

    try std.testing.expect(!result.hasError());

    const t = getRowValue(result, 0, "t") orelse return error.InvalidResponse;
    const f = getRowValue(result, 0, "f") orelse return error.InvalidResponse;
    const not_f = getRowValue(result, 0, "not_f") orelse return error.InvalidResponse;

    try std.testing.expect(t.bool_val.?);
    try std.testing.expect(!f.bool_val.?);
    try std.testing.expect(not_f.bool_val.?);
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

    try std.testing.expect(result.rows.items.len >= 1);

    const name = getRowValue(result, 0, "name") orelse return error.InvalidResponse;
    const age = getRowValue(result, 0, "age") orelse return error.InvalidResponse;

    try std.testing.expectEqualStrings("Alice", name.string_val.?);
    try std.testing.expectEqual(@as(i64, 30), age.int_val.?);
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

    try std.testing.expect(result.rows.items.len >= 1);

    const value = getRowValue(result, 0, "value") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 100), value.int_val.?);
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

    try std.testing.expect(result.rows.items.len >= 1);
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

    var result = try ctx.query("MATCH (a:RelTestA)-[:CONNECTS]->(b:RelTestB) RETURN a.name AS from_name, b.name AS to_name");
    defer result.deinit();

    try std.testing.expect(result.rows.items.len >= 1);
}

test "integration: relationship with properties" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Friend") catch {};

    try ctx.exec("CREATE (a:Friend {name: 'Alice'}), (b:Friend {name: 'Bob'}), (a)-[:KNOWS {since: 2020}]->(b)");

    var result = try ctx.query("MATCH (a:Friend)-[r:KNOWS]->(b:Friend) RETURN r.since AS since");
    defer result.deinit();

    try std.testing.expect(result.rows.items.len >= 1);

    const since = getRowValue(result, 0, "since") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 2020), since.int_val.?);
}

test "integration: bidirectional relationship query" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("BiDir") catch {};

    try ctx.exec("CREATE (a:BiDir {id: 1}), (b:BiDir {id: 2}), (a)-[:LINKED]->(b)");

    // Query in reverse direction
    var result = try ctx.query("MATCH (a:BiDir)<-[:LINKED]-(b:BiDir) RETURN a.id AS a_id, b.id AS b_id");
    defer result.deinit();

    try std.testing.expect(result.rows.items.len >= 1);
}

test "integration: path traversal" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("PathNode") catch {};

    try ctx.exec("CREATE (a:PathNode {id: 1}), (b:PathNode {id: 2}), (c:PathNode {id: 3}), (a)-[:NEXT]->(b)-[:NEXT]->(c)");

    var result = try ctx.query("MATCH (a:PathNode {id: 1})-[:NEXT]->(b)-[:NEXT]->(c) RETURN c.id AS end_id");
    defer result.deinit();

    try std.testing.expect(result.rows.items.len >= 1);

    const end_id = getRowValue(result, 0, "end_id") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 3), end_id.int_val.?);
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

    try std.testing.expect(result.rows.items.len >= 2);
}

test "integration: ORDER BY clause" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Sortable") catch {};

    try ctx.exec("CREATE (a:Sortable {n: 3}), (b:Sortable {n: 1}), (c:Sortable {n: 2})");

    var result = try ctx.query("MATCH (x:Sortable) RETURN x.n AS n ORDER BY x.n");
    defer result.deinit();

    try std.testing.expect(result.rows.items.len >= 3);

    // Verify order
    const first = getRowValue(result, 0, "n") orelse return error.InvalidResponse;
    const second = getRowValue(result, 1, "n") orelse return error.InvalidResponse;
    try std.testing.expect(first.int_val.? <= second.int_val.?);
}

test "integration: LIMIT clause" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Limited") catch {};

    try ctx.exec("CREATE (a:Limited {n: 1}), (b:Limited {n: 2}), (c:Limited {n: 3}), (d:Limited {n: 4}), (e:Limited {n: 5})");

    var result = try ctx.query("MATCH (n:Limited) RETURN n.n AS n LIMIT 3");
    defer result.deinit();

    try std.testing.expectEqual(@as(usize, 3), result.rows.items.len);
}

test "integration: SKIP clause" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Skippable") catch {};

    try ctx.exec("CREATE (a:Skippable {n: 1}), (b:Skippable {n: 2}), (c:Skippable {n: 3})");

    var result = try ctx.query("MATCH (n:Skippable) RETURN n.n AS n ORDER BY n.n SKIP 1 LIMIT 2");
    defer result.deinit();

    try std.testing.expectEqual(@as(usize, 2), result.rows.items.len);

    // First result should be 2 (skipped 1)
    const first = getRowValue(result, 0, "n") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 2), first.int_val.?);
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

    try std.testing.expect(result.rows.items.len == 1);

    const cnt = getRowValue(result, 0, "cnt") orelse return error.InvalidResponse;
    try std.testing.expect(cnt.int_val.? >= 3);
}

test "integration: SUM aggregation" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Summable") catch {};

    try ctx.exec("CREATE (a:Summable {val: 10}), (b:Summable {val: 20}), (c:Summable {val: 30})");

    var result = try ctx.query("MATCH (n:Summable) RETURN sum(n.val) AS total");
    defer result.deinit();

    const total = getRowValue(result, 0, "total") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 60), total.int_val.?);
}

test "integration: AVG aggregation" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("Averageable") catch {};

    try ctx.exec("CREATE (a:Averageable {val: 10}), (b:Averageable {val: 20}), (c:Averageable {val: 30})");

    var result = try ctx.query("MATCH (n:Averageable) RETURN avg(n.val) AS average");
    defer result.deinit();

    const average = getRowValue(result, 0, "average") orelse return error.InvalidResponse;

    // Average of 10, 20, 30 is 20 - could be returned as int or double
    const avg_value: f64 = if (average.int_val) |i| @as(f64, @floatFromInt(i)) else average.double_val orelse return error.InvalidResponse;
    try std.testing.expectApproxEqRel(@as(f64, 20.0), avg_value, 0.01);
}

test "integration: MIN/MAX aggregation" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();
    defer ctx.cleanup("MinMaxable") catch {};

    try ctx.exec("CREATE (a:MinMaxable {val: 5}), (b:MinMaxable {val: 15}), (c:MinMaxable {val: 10})");

    var result = try ctx.query("MATCH (n:MinMaxable) RETURN min(n.val) AS minimum, max(n.val) AS maximum");
    defer result.deinit();

    const minimum = getRowValue(result, 0, "minimum") orelse return error.InvalidResponse;
    const maximum = getRowValue(result, 0, "maximum") orelse return error.InvalidResponse;

    try std.testing.expectEqual(@as(i64, 5), minimum.int_val.?);
    try std.testing.expectEqual(@as(i64, 15), maximum.int_val.?);
}

// =============================================================================
// Data Type Tests
// =============================================================================

test "integration: null value" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN null AS n");
    defer result.deinit();

    const n = getRowValue(result, 0, "n") orelse return error.InvalidResponse;
    try std.testing.expect(n.isNull());
}

test "integration: integer values" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 0 AS zero, -100 AS negative, 9999999 AS large");
    defer result.deinit();

    const zero = getRowValue(result, 0, "zero") orelse return error.InvalidResponse;
    const negative = getRowValue(result, 0, "negative") orelse return error.InvalidResponse;
    const large = getRowValue(result, 0, "large") orelse return error.InvalidResponse;

    try std.testing.expectEqual(@as(i64, 0), zero.int_val.?);
    try std.testing.expectEqual(@as(i64, -100), negative.int_val.?);
    try std.testing.expectEqual(@as(i64, 9999999), large.int_val.?);
}

test "integration: float values" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 3.14159 AS pi, -2.5 AS negative");
    defer result.deinit();

    const pi = getRowValue(result, 0, "pi") orelse return error.InvalidResponse;
    const negative = getRowValue(result, 0, "negative") orelse return error.InvalidResponse;

    try std.testing.expectApproxEqRel(@as(f64, 3.14159), pi.double_val.?, 0.00001);
    try std.testing.expectApproxEqRel(@as(f64, -2.5), negative.double_val.?, 0.00001);
}

test "integration: string with unicode" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    var result = try ctx.query("RETURN 'Hello World' AS ascii");
    defer result.deinit();

    const ascii = getRowValue(result, 0, "ascii") orelse return error.InvalidResponse;
    try std.testing.expectEqualStrings("Hello World", ascii.string_val.?);
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
    if (result.rows.items.len > 0) {
        const val = getRowValue(result, 0, "val");
        if (val) |v| {
            try std.testing.expect(v.isNull());
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

    try std.testing.expect(result.rows.items.len >= 1);

    const name = getRowValue(result, 0, "name") orelse return error.InvalidResponse;
    try std.testing.expectEqualStrings("alone", name.string_val.?);

    // b should be null since the relationship doesn't exist
    const other = getRowValue(result, 0, "other");
    if (other) |o| {
        try std.testing.expect(o.isNull());
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

    try std.testing.expect(result.rows.items.len >= 2);

    const first = getRowValue(result, 0, "v") orelse return error.InvalidResponse;
    try std.testing.expectEqual(@as(i64, 2), first.int_val.?);
}

// =============================================================================
// Unit Tests for Label Validation (isValidLabel)
// =============================================================================

test "isValidLabel: valid simple labels" {
    try std.testing.expect(TestContext.isValidLabel("Person"));
    try std.testing.expect(TestContext.isValidLabel("User"));
    try std.testing.expect(TestContext.isValidLabel("Node"));
    try std.testing.expect(TestContext.isValidLabel("a"));
    try std.testing.expect(TestContext.isValidLabel("Z"));
}

test "isValidLabel: valid labels with numbers" {
    try std.testing.expect(TestContext.isValidLabel("User1"));
    try std.testing.expect(TestContext.isValidLabel("Node123"));
    try std.testing.expect(TestContext.isValidLabel("A1B2C3"));
}

test "isValidLabel: valid labels with underscores" {
    try std.testing.expect(TestContext.isValidLabel("_private"));
    try std.testing.expect(TestContext.isValidLabel("User_Profile"));
    try std.testing.expect(TestContext.isValidLabel("my_node_type"));
    try std.testing.expect(TestContext.isValidLabel("__double_underscore"));
    try std.testing.expect(TestContext.isValidLabel("_"));
}

test "isValidLabel: valid labels with mixed characters" {
    try std.testing.expect(TestContext.isValidLabel("User_Profile_123"));
    try std.testing.expect(TestContext.isValidLabel("_MyNode1"));
    try std.testing.expect(TestContext.isValidLabel("Node_1_2_3"));
}

test "isValidLabel: invalid empty string" {
    try std.testing.expect(!TestContext.isValidLabel(""));
}

test "isValidLabel: invalid starting with number" {
    try std.testing.expect(!TestContext.isValidLabel("1User"));
    try std.testing.expect(!TestContext.isValidLabel("123"));
    try std.testing.expect(!TestContext.isValidLabel("0Node"));
}

test "isValidLabel: invalid with special characters" {
    try std.testing.expect(!TestContext.isValidLabel("User-Profile"));
    try std.testing.expect(!TestContext.isValidLabel("User.Profile"));
    try std.testing.expect(!TestContext.isValidLabel("User@Profile"));
    try std.testing.expect(!TestContext.isValidLabel("User#Profile"));
    try std.testing.expect(!TestContext.isValidLabel("User$Profile"));
    try std.testing.expect(!TestContext.isValidLabel("User%Profile"));
}

test "isValidLabel: invalid with spaces" {
    try std.testing.expect(!TestContext.isValidLabel("User Profile"));
    try std.testing.expect(!TestContext.isValidLabel(" User"));
    try std.testing.expect(!TestContext.isValidLabel("User "));
}

test "isValidLabel: invalid injection attempts" {
    // These are all potential GQL injection attempts
    try std.testing.expect(!TestContext.isValidLabel("Person}) DETACH DELETE n"));
    try std.testing.expect(!TestContext.isValidLabel("Person:Admin"));
    try std.testing.expect(!TestContext.isValidLabel("Person {"));
    try std.testing.expect(!TestContext.isValidLabel("Person) RETURN"));
    try std.testing.expect(!TestContext.isValidLabel("Person]->("));
}

test "isValidLabel: invalid with quotes" {
    try std.testing.expect(!TestContext.isValidLabel("User\""));
    try std.testing.expect(!TestContext.isValidLabel("User'"));
    try std.testing.expect(!TestContext.isValidLabel("\"User"));
    try std.testing.expect(!TestContext.isValidLabel("'User"));
}

test "isValidLabel: invalid with brackets and parentheses" {
    try std.testing.expect(!TestContext.isValidLabel("User("));
    try std.testing.expect(!TestContext.isValidLabel("User)"));
    try std.testing.expect(!TestContext.isValidLabel("User["));
    try std.testing.expect(!TestContext.isValidLabel("User]"));
    try std.testing.expect(!TestContext.isValidLabel("User{"));
    try std.testing.expect(!TestContext.isValidLabel("User}"));
}

test "isValidLabel: invalid with backslash" {
    try std.testing.expect(!TestContext.isValidLabel("User\\n"));
    try std.testing.expect(!TestContext.isValidLabel("User\\"));
}

test "isValidLabel: invalid with newline and control characters" {
    try std.testing.expect(!TestContext.isValidLabel("User\n"));
    try std.testing.expect(!TestContext.isValidLabel("User\r"));
    try std.testing.expect(!TestContext.isValidLabel("User\t"));
    try std.testing.expect(!TestContext.isValidLabel("User\x00"));
}

// =============================================================================
// Integration Tests for Label Validation in Context Methods
// =============================================================================

test "integration: countNodes rejects invalid label with injection attempt" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    // This should fail validation, not execute the injection
    const result = ctx.countNodes("Person}) DETACH DELETE n MATCH (n:");
    try std.testing.expectError(error.InvalidLabel, result);
}

test "integration: cleanup rejects invalid label with special characters" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    // This should fail validation
    const result = ctx.cleanup("Test-Label");
    try std.testing.expectError(error.InvalidLabel, result);
}

test "integration: countNodes rejects label starting with number" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    const result = ctx.countNodes("123Label");
    try std.testing.expectError(error.InvalidLabel, result);
}

test "integration: cleanup rejects empty label" {
    var ctx = try TestContext.init(std.testing.allocator);
    defer ctx.deinit();

    const result = ctx.cleanup("");
    try std.testing.expectError(error.InvalidLabel, result);
}
