// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Fuzz tests for QueryBuilder, PatternBuilder, and PredicateBuilder
// in the Geode Zig client library.

const std = @import("std");
const query_builder = @import("query_builder");
const QueryBuilder = query_builder.QueryBuilder;
const PatternBuilder = query_builder.PatternBuilder;
const PredicateBuilder = query_builder.PredicateBuilder;

/// Fuzz test for QueryBuilder
pub fn main() !void {
    var buffer: [256 * 1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const stdin = std.Io.getStdIn();
    const input = stdin.readToEndAlloc(allocator, 1024 * 1024) catch return;

    // Use input as various clause contents
    var qb = QueryBuilder.init(allocator);
    defer qb.deinit();

    _ = qb.match(input) catch {};
    _ = qb.where(input) catch {};
    _ = qb.ret(input) catch {};
    _ = qb.build() catch {};
}

// Note: Zig's std.testing.fuzz requires specific setup.
// These property-based tests provide similar coverage.

// =============================================================================
// Property-Based Tests for QueryBuilder
// =============================================================================

test "property: empty builder returns EmptyQuery error" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    try std.testing.expectError(error.EmptyQuery, qb.build());
}

test "property: single MATCH clause builds successfully" {
    const patterns = [_][]const u8{
        "(n)",
        "(n:Person)",
        "(n:Person:Employee)",
        "(n {name: 'Alice'})",
        "(n:Person {age: 30})",
        "(a)-[r]->(b)",
        "(a:Person)-[:KNOWS]->(b:Person)",
    };

    for (patterns) |pattern| {
        var qb = QueryBuilder.init(std.testing.allocator);
        defer qb.deinit();

        _ = try qb.match(pattern);
        _ = try qb.ret("n");

        const query = try qb.build();
        defer std.testing.allocator.free(query);

        // Query should start with MATCH
        try std.testing.expect(std.mem.startsWith(u8, query, "MATCH "));
        // Query should contain RETURN
        try std.testing.expect(std.mem.indexOf(u8, query, "RETURN") != null);
    }
}

test "property: clauses are joined with spaces" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n)");
    _ = try qb.where("n.x > 0");
    _ = try qb.ret("n");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    // Should contain spaces between clauses
    try std.testing.expectEqualStrings("MATCH (n) WHERE n.x > 0 RETURN n", query);
}

test "property: all clause types work" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n)");
    _ = try qb.optionalMatch("(n)-[r]->(m)");
    _ = try qb.where("n.age > 0");
    _ = try qb.with("n, count(*) AS c");
    _ = try qb.orderBy("c");
    _ = try qb.skip(10);
    _ = try qb.limit(100);
    _ = try qb.ret("n, c");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    // Verify all clauses are present
    try std.testing.expect(std.mem.indexOf(u8, query, "MATCH (n)") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "OPTIONAL MATCH") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "WHERE") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "WITH") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "ORDER BY") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "SKIP 10") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "LIMIT 100") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "RETURN") != null);
}

test "property: mutation clauses work" {
    // CREATE
    {
        var qb = QueryBuilder.init(std.testing.allocator);
        defer qb.deinit();
        _ = try qb.create("(n:Person)");
        _ = try qb.ret("n");
        const query = try qb.build();
        defer std.testing.allocator.free(query);
        try std.testing.expect(std.mem.startsWith(u8, query, "CREATE "));
    }

    // MERGE
    {
        var qb = QueryBuilder.init(std.testing.allocator);
        defer qb.deinit();
        _ = try qb.merge("(n:Person)");
        _ = try qb.ret("n");
        const query = try qb.build();
        defer std.testing.allocator.free(query);
        try std.testing.expect(std.mem.startsWith(u8, query, "MERGE "));
    }

    // DELETE
    {
        var qb = QueryBuilder.init(std.testing.allocator);
        defer qb.deinit();
        _ = try qb.match("(n:Temp)");
        _ = try qb.delete("n");
        const query = try qb.build();
        defer std.testing.allocator.free(query);
        try std.testing.expect(std.mem.indexOf(u8, query, "DELETE n") != null);
    }

    // DETACH DELETE
    {
        var qb = QueryBuilder.init(std.testing.allocator);
        defer qb.deinit();
        _ = try qb.match("(n:Temp)");
        _ = try qb.detachDelete("n");
        const query = try qb.build();
        defer std.testing.allocator.free(query);
        try std.testing.expect(std.mem.indexOf(u8, query, "DETACH DELETE n") != null);
    }

    // SET
    {
        var qb = QueryBuilder.init(std.testing.allocator);
        defer qb.deinit();
        _ = try qb.match("(n)");
        _ = try qb.set("n.x = 1");
        _ = try qb.ret("n");
        const query = try qb.build();
        defer std.testing.allocator.free(query);
        try std.testing.expect(std.mem.indexOf(u8, query, "SET n.x = 1") != null);
    }

    // REMOVE
    {
        var qb = QueryBuilder.init(std.testing.allocator);
        defer qb.deinit();
        _ = try qb.match("(n)");
        _ = try qb.remove("n.x");
        _ = try qb.ret("n");
        const query = try qb.build();
        defer std.testing.allocator.free(query);
        try std.testing.expect(std.mem.indexOf(u8, query, "REMOVE n.x") != null);
    }
}

test "property: raw clause works" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.raw("CALL db.info()");
    _ = try qb.raw("YIELD *");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("CALL db.info() YIELD *", query);
}

test "property: special characters in clauses don't crash" {
    const inputs = [_][]const u8{
        "",
        " ",
        "\t\n\r",
        "'single quotes'",
        "\"double quotes\"",
        "back\\slash",
        "null: \x00",
        "unicode: \u{1F600}",
        "very long " ++ "x" ** 1000,
    };

    for (inputs) |input| {
        var qb = QueryBuilder.init(std.testing.allocator);
        defer qb.deinit();

        _ = qb.match(input) catch continue;
        _ = qb.ret("n") catch continue;
        if (qb.build()) |query| {
            std.testing.allocator.free(query);
        } else |_| {}
    }
}

// =============================================================================
// Property-Based Tests for PatternBuilder
// =============================================================================

test "property: empty PatternBuilder returns EmptyPattern error" {
    var pb = PatternBuilder.init(std.testing.allocator);
    defer pb.deinit();

    try std.testing.expectError(error.EmptyPattern, pb.build());
}

test "property: nodeVar creates correct pattern" {
    const vars = [_][]const u8{ "n", "a", "node", "x1", "_underscore" };

    for (vars) |v| {
        var pb = PatternBuilder.init(std.testing.allocator);
        defer pb.deinit();

        _ = try pb.nodeVar(v);
        const pattern = try pb.build();
        defer std.testing.allocator.free(pattern);

        var expected: [256]u8 = undefined;
        const expected_str = std.fmt.bufPrint(&expected, "({s})", .{v}) catch unreachable;
        try std.testing.expectEqualStrings(expected_str, pattern);
    }
}

test "property: nodeLabel creates correct pattern" {
    const cases = [_]struct { var_name: ?[]const u8, label: []const u8, expected: []const u8 }{
        .{ .var_name = "n", .label = "Person", .expected = "(n:Person)" },
        .{ .var_name = null, .label = "Person", .expected = "(:Person)" },
        .{ .var_name = "x", .label = "Node", .expected = "(x:Node)" },
    };

    for (cases) |tc| {
        var pb = PatternBuilder.init(std.testing.allocator);
        defer pb.deinit();

        _ = try pb.nodeLabel(tc.var_name, tc.label);
        const pattern = try pb.build();
        defer std.testing.allocator.free(pattern);

        try std.testing.expectEqualStrings(tc.expected, pattern);
    }
}

test "property: relationship directions are correct" {
    // Right direction
    {
        var pb = PatternBuilder.init(std.testing.allocator);
        defer pb.deinit();

        _ = try pb.nodeVar("a");
        _ = try pb.edgeRight("KNOWS");
        _ = try pb.nodeVar("b");

        const pattern = try pb.build();
        defer std.testing.allocator.free(pattern);

        try std.testing.expectEqualStrings("(a)-[:KNOWS]->(b)", pattern);
    }

    // Left direction
    {
        var pb = PatternBuilder.init(std.testing.allocator);
        defer pb.deinit();

        _ = try pb.nodeVar("a");
        _ = try pb.edgeLeft("KNOWS");
        _ = try pb.nodeVar("b");

        const pattern = try pb.build();
        defer std.testing.allocator.free(pattern);

        try std.testing.expectEqualStrings("(a)<-[:KNOWS]-(b)", pattern);
    }

    // Undirected
    {
        var pb = PatternBuilder.init(std.testing.allocator);
        defer pb.deinit();

        _ = try pb.nodeVar("a");
        _ = try pb.relUndirected(null, "CONNECTED", null);
        _ = try pb.nodeVar("b");

        const pattern = try pb.build();
        defer std.testing.allocator.free(pattern);

        try std.testing.expectEqualStrings("(a)-[:CONNECTED]-(b)", pattern);
    }
}

test "property: complex patterns build correctly" {
    var pb = PatternBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.nodeLabel("a", "Person");
    _ = try pb.relRight("r1", "WORKS_AT", null);
    _ = try pb.nodeLabel("c", "Company");
    _ = try pb.relLeft("r2", "LOCATED_IN", null);
    _ = try pb.nodeLabel("city", "City");

    const pattern = try pb.build();
    defer std.testing.allocator.free(pattern);

    try std.testing.expectEqualStrings("(a:Person)-[r1:WORKS_AT]->(c:Company)<-[r2:LOCATED_IN]-(city:City)", pattern);
}

// =============================================================================
// Property-Based Tests for PredicateBuilder
// =============================================================================

test "property: empty PredicateBuilder returns EmptyPredicate error" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    try std.testing.expectError(error.EmptyPredicate, pb.build());
}

test "property: comparison operators work" {
    const ops = [_]struct {
        name: []const u8,
        func: *const fn (*PredicateBuilder, []const u8, []const u8) anyerror!*PredicateBuilder,
        symbol: []const u8,
    }{
        .{ .name = "eq", .func = PredicateBuilder.eq, .symbol = "=" },
        .{ .name = "neq", .func = PredicateBuilder.neq, .symbol = "<>" },
        .{ .name = "lt", .func = PredicateBuilder.lt, .symbol = "<" },
        .{ .name = "lte", .func = PredicateBuilder.lte, .symbol = "<=" },
        .{ .name = "gt", .func = PredicateBuilder.gt, .symbol = ">" },
        .{ .name = "gte", .func = PredicateBuilder.gte, .symbol = ">=" },
    };

    for (ops) |op| {
        var pb = PredicateBuilder.init(std.testing.allocator);
        defer pb.deinit();

        _ = try op.func(&pb, "n.prop", "param");
        const pred = try pb.build();
        defer std.testing.allocator.free(pred);

        var expected: [256]u8 = undefined;
        const expected_str = std.fmt.bufPrint(&expected, "n.prop {s} $param", .{op.symbol}) catch unreachable;
        try std.testing.expectEqualStrings(expected_str, pred);
    }
}

test "property: null checks work" {
    // IS NULL
    {
        var pb = PredicateBuilder.init(std.testing.allocator);
        defer pb.deinit();
        _ = try pb.isNull("n.prop");
        const pred = try pb.build();
        defer std.testing.allocator.free(pred);
        try std.testing.expectEqualStrings("n.prop IS NULL", pred);
    }

    // IS NOT NULL
    {
        var pb = PredicateBuilder.init(std.testing.allocator);
        defer pb.deinit();
        _ = try pb.isNotNull("n.prop");
        const pred = try pb.build();
        defer std.testing.allocator.free(pred);
        try std.testing.expectEqualStrings("n.prop IS NOT NULL", pred);
    }
}

test "property: string predicates work" {
    // CONTAINS
    {
        var pb = PredicateBuilder.init(std.testing.allocator);
        defer pb.deinit();
        _ = try pb.contains("n.name", "substr");
        const pred = try pb.build();
        defer std.testing.allocator.free(pred);
        try std.testing.expectEqualStrings("n.name CONTAINS $substr", pred);
    }

    // STARTS WITH
    {
        var pb = PredicateBuilder.init(std.testing.allocator);
        defer pb.deinit();
        _ = try pb.startsWith("n.name", "prefix");
        const pred = try pb.build();
        defer std.testing.allocator.free(pred);
        try std.testing.expectEqualStrings("n.name STARTS WITH $prefix", pred);
    }

    // ENDS WITH
    {
        var pb = PredicateBuilder.init(std.testing.allocator);
        defer pb.deinit();
        _ = try pb.endsWith("n.name", "suffix");
        const pred = try pb.build();
        defer std.testing.allocator.free(pred);
        try std.testing.expectEqualStrings("n.name ENDS WITH $suffix", pred);
    }

    // IN
    {
        var pb = PredicateBuilder.init(std.testing.allocator);
        defer pb.deinit();
        _ = try pb.in("n.status", "statuses");
        const pred = try pb.build();
        defer std.testing.allocator.free(pred);
        try std.testing.expectEqualStrings("n.status IN $statuses", pred);
    }
}

test "property: AND combination works" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.eq("a", "x");
    _ = try pb.andOp();
    _ = try pb.eq("b", "y");
    _ = try pb.andOp();
    _ = try pb.eq("c", "z");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("a = $x AND b = $y AND c = $z", pred);
}

test "property: OR combination works" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.eq("a", "x");
    _ = try pb.orOp();
    _ = try pb.eq("b", "y");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("a = $x OR b = $y", pred);
}

test "property: mixed AND/OR works" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.eq("a", "x");
    _ = try pb.andOp();
    _ = try pb.eq("b", "y");
    _ = try pb.orOp();
    _ = try pb.eq("c", "z");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("a = $x AND b = $y OR c = $z", pred);
}

test "property: raw predicate works" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.raw("EXISTS(n.prop)");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("EXISTS(n.prop)", pred);
}
