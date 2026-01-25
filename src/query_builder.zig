// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Query builder for the Geode Zig client library.
// Provides fluent API for constructing GQL queries.

const std = @import("std");
const Value = @import("types").Value;

/// Builder for constructing GQL queries with a fluent API.
pub const QueryBuilder = struct {
    allocator: std.mem.Allocator,
    clauses: std.ArrayListUnmanaged([]const u8),
    params: std.StringHashMapUnmanaged(Value),

    /// Initialize a new QueryBuilder
    pub fn init(allocator: std.mem.Allocator) QueryBuilder {
        return .{
            .allocator = allocator,
            .clauses = .{},
            .params = .{},
        };
    }

    /// Free all resources
    pub fn deinit(self: *QueryBuilder) void {
        for (self.clauses.items) |clause| {
            self.allocator.free(clause);
        }
        self.clauses.deinit(self.allocator);
        self.params.deinit(self.allocator);
    }

    /// Add a MATCH clause
    pub fn match(self: *QueryBuilder, pattern: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "MATCH {s}", .{pattern});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a MATCH clause with a PatternBuilder
    pub fn matchPattern(self: *QueryBuilder, pattern: *PatternBuilder) !*QueryBuilder {
        const pattern_str = try pattern.build();
        defer self.allocator.free(pattern_str);
        return self.match(pattern_str);
    }

    /// Add an OPTIONAL MATCH clause
    pub fn optionalMatch(self: *QueryBuilder, pattern: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "OPTIONAL MATCH {s}", .{pattern});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a WHERE clause
    pub fn where(self: *QueryBuilder, condition: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "WHERE {s}", .{condition});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a WHERE clause with a PredicateBuilder
    pub fn wherePredicate(self: *QueryBuilder, predicate: *PredicateBuilder) !*QueryBuilder {
        const pred_str = try predicate.build();
        defer self.allocator.free(pred_str);
        return self.where(pred_str);
    }

    /// Add a WITH clause
    pub fn with(self: *QueryBuilder, expressions: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "WITH {s}", .{expressions});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a RETURN clause
    pub fn ret(self: *QueryBuilder, expressions: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "RETURN {s}", .{expressions});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add an ORDER BY clause
    pub fn orderBy(self: *QueryBuilder, expressions: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "ORDER BY {s}", .{expressions});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add an ORDER BY DESC clause
    pub fn orderByDesc(self: *QueryBuilder, expressions: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "ORDER BY {s} DESC", .{expressions});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a LIMIT clause
    pub fn limit(self: *QueryBuilder, count: u64) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "LIMIT {d}", .{count});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a SKIP clause
    pub fn skip(self: *QueryBuilder, count: u64) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "SKIP {d}", .{count});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a CREATE clause
    pub fn create(self: *QueryBuilder, pattern: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "CREATE {s}", .{pattern});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a MERGE clause
    pub fn merge(self: *QueryBuilder, pattern: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "MERGE {s}", .{pattern});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a DELETE clause
    pub fn delete(self: *QueryBuilder, variables: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "DELETE {s}", .{variables});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a DETACH DELETE clause
    pub fn detachDelete(self: *QueryBuilder, variables: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "DETACH DELETE {s}", .{variables});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a SET clause
    pub fn set(self: *QueryBuilder, assignments: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "SET {s}", .{assignments});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a REMOVE clause
    pub fn remove(self: *QueryBuilder, items: []const u8) !*QueryBuilder {
        const clause = try std.fmt.allocPrint(self.allocator, "REMOVE {s}", .{items});
        try self.clauses.append(self.allocator, clause);
        return self;
    }

    /// Add a raw clause (for advanced usage)
    pub fn raw(self: *QueryBuilder, clause: []const u8) !*QueryBuilder {
        const owned = try self.allocator.dupe(u8, clause);
        try self.clauses.append(self.allocator, owned);
        return self;
    }

    /// Bind a parameter value
    pub fn param(self: *QueryBuilder, name: []const u8, value: Value) !*QueryBuilder {
        try self.params.put(self.allocator, name, value);
        return self;
    }

    /// Build the final query string
    pub fn build(self: *QueryBuilder) ![]const u8 {
        if (self.clauses.items.len == 0) {
            return error.EmptyQuery;
        }

        var total_len: usize = 0;
        for (self.clauses.items, 0..) |clause, i| {
            total_len += clause.len;
            if (i < self.clauses.items.len - 1) {
                total_len += 1; // space separator
            }
        }

        var result = try self.allocator.alloc(u8, total_len);
        var offset: usize = 0;

        for (self.clauses.items, 0..) |clause, i| {
            @memcpy(result[offset .. offset + clause.len], clause);
            offset += clause.len;
            if (i < self.clauses.items.len - 1) {
                result[offset] = ' ';
                offset += 1;
            }
        }

        return result;
    }

    /// Get the bound parameters
    pub fn getParams(self: *QueryBuilder) std.StringHashMapUnmanaged(Value) {
        return self.params;
    }
};

/// Builder for constructing graph patterns (nodes and relationships).
pub const PatternBuilder = struct {
    allocator: std.mem.Allocator,
    parts: std.ArrayListUnmanaged([]const u8),

    /// Initialize a new PatternBuilder
    pub fn init(allocator: std.mem.Allocator) PatternBuilder {
        return .{
            .allocator = allocator,
            .parts = .{},
        };
    }

    /// Free all resources
    pub fn deinit(self: *PatternBuilder) void {
        for (self.parts.items) |part| {
            self.allocator.free(part);
        }
        self.parts.deinit(self.allocator);
    }

    /// Add a node pattern
    pub fn node(self: *PatternBuilder, variable: ?[]const u8, labels: ?[]const []const u8, props: ?[]const u8) !*PatternBuilder {
        var buf: std.ArrayListUnmanaged(u8) = .{};
        defer buf.deinit(self.allocator);

        try buf.append(self.allocator, '(');

        if (variable) |v| {
            try buf.appendSlice(self.allocator, v);
        }

        if (labels) |lbls| {
            for (lbls) |label| {
                try buf.append(self.allocator, ':');
                try buf.appendSlice(self.allocator, label);
            }
        }

        if (props) |p| {
            try buf.append(self.allocator, ' ');
            try buf.appendSlice(self.allocator, p);
        }

        try buf.append(self.allocator, ')');

        const part = try buf.toOwnedSlice(self.allocator);
        try self.parts.append(self.allocator, part);
        return self;
    }

    /// Add a simple node with just a variable
    pub fn nodeVar(self: *PatternBuilder, variable: []const u8) !*PatternBuilder {
        return self.node(variable, null, null);
    }

    /// Add a node with a single label
    pub fn nodeLabel(self: *PatternBuilder, variable: ?[]const u8, label: []const u8) !*PatternBuilder {
        const labels = [_][]const u8{label};
        return self.node(variable, &labels, null);
    }

    /// Add a right-directed relationship
    pub fn relRight(self: *PatternBuilder, variable: ?[]const u8, rel_type: ?[]const u8, props: ?[]const u8) !*PatternBuilder {
        var buf: std.ArrayListUnmanaged(u8) = .{};
        defer buf.deinit(self.allocator);

        try buf.appendSlice(self.allocator, "-[");

        if (variable) |v| {
            try buf.appendSlice(self.allocator, v);
        }

        if (rel_type) |t| {
            try buf.append(self.allocator, ':');
            try buf.appendSlice(self.allocator, t);
        }

        if (props) |p| {
            try buf.append(self.allocator, ' ');
            try buf.appendSlice(self.allocator, p);
        }

        try buf.appendSlice(self.allocator, "]->");

        const part = try buf.toOwnedSlice(self.allocator);
        try self.parts.append(self.allocator, part);
        return self;
    }

    /// Add a left-directed relationship
    pub fn relLeft(self: *PatternBuilder, variable: ?[]const u8, rel_type: ?[]const u8, props: ?[]const u8) !*PatternBuilder {
        var buf: std.ArrayListUnmanaged(u8) = .{};
        defer buf.deinit(self.allocator);

        try buf.appendSlice(self.allocator, "<-[");

        if (variable) |v| {
            try buf.appendSlice(self.allocator, v);
        }

        if (rel_type) |t| {
            try buf.append(self.allocator, ':');
            try buf.appendSlice(self.allocator, t);
        }

        if (props) |p| {
            try buf.append(self.allocator, ' ');
            try buf.appendSlice(self.allocator, p);
        }

        try buf.appendSlice(self.allocator, "]-");

        const part = try buf.toOwnedSlice(self.allocator);
        try self.parts.append(self.allocator, part);
        return self;
    }

    /// Add an undirected relationship
    pub fn relUndirected(self: *PatternBuilder, variable: ?[]const u8, rel_type: ?[]const u8, props: ?[]const u8) !*PatternBuilder {
        var buf: std.ArrayListUnmanaged(u8) = .{};
        defer buf.deinit(self.allocator);

        try buf.appendSlice(self.allocator, "-[");

        if (variable) |v| {
            try buf.appendSlice(self.allocator, v);
        }

        if (rel_type) |t| {
            try buf.append(self.allocator, ':');
            try buf.appendSlice(self.allocator, t);
        }

        if (props) |p| {
            try buf.append(self.allocator, ' ');
            try buf.appendSlice(self.allocator, p);
        }

        try buf.appendSlice(self.allocator, "]-");

        const part = try buf.toOwnedSlice(self.allocator);
        try self.parts.append(self.allocator, part);
        return self;
    }

    /// Add a simple right-directed edge with type
    pub fn edgeRight(self: *PatternBuilder, rel_type: []const u8) !*PatternBuilder {
        return self.relRight(null, rel_type, null);
    }

    /// Add a simple left-directed edge with type
    pub fn edgeLeft(self: *PatternBuilder, rel_type: []const u8) !*PatternBuilder {
        return self.relLeft(null, rel_type, null);
    }

    /// Build the final pattern string
    pub fn build(self: *PatternBuilder) ![]const u8 {
        if (self.parts.items.len == 0) {
            return error.EmptyPattern;
        }

        var total_len: usize = 0;
        for (self.parts.items) |part| {
            total_len += part.len;
        }

        var result = try self.allocator.alloc(u8, total_len);
        var offset: usize = 0;

        for (self.parts.items) |part| {
            @memcpy(result[offset .. offset + part.len], part);
            offset += part.len;
        }

        return result;
    }
};

/// Builder for constructing predicates (WHERE conditions).
pub const PredicateBuilder = struct {
    allocator: std.mem.Allocator,
    conditions: std.ArrayListUnmanaged([]const u8),
    operators: std.ArrayListUnmanaged([]const u8),

    /// Initialize a new PredicateBuilder
    pub fn init(allocator: std.mem.Allocator) PredicateBuilder {
        return .{
            .allocator = allocator,
            .conditions = .{},
            .operators = .{},
        };
    }

    /// Free all resources
    pub fn deinit(self: *PredicateBuilder) void {
        for (self.conditions.items) |cond| {
            self.allocator.free(cond);
        }
        self.conditions.deinit(self.allocator);
        for (self.operators.items) |op| {
            self.allocator.free(op);
        }
        self.operators.deinit(self.allocator);
    }

    /// Add an equality condition
    pub fn eq(self: *PredicateBuilder, property: []const u8, param_name: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} = ${s}", .{ property, param_name });
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add a not-equal condition
    pub fn neq(self: *PredicateBuilder, property: []const u8, param_name: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} <> ${s}", .{ property, param_name });
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add a less-than condition
    pub fn lt(self: *PredicateBuilder, property: []const u8, param_name: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} < ${s}", .{ property, param_name });
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add a less-than-or-equal condition
    pub fn lte(self: *PredicateBuilder, property: []const u8, param_name: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} <= ${s}", .{ property, param_name });
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add a greater-than condition
    pub fn gt(self: *PredicateBuilder, property: []const u8, param_name: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} > ${s}", .{ property, param_name });
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add a greater-than-or-equal condition
    pub fn gte(self: *PredicateBuilder, property: []const u8, param_name: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} >= ${s}", .{ property, param_name });
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add an IS NULL condition
    pub fn isNull(self: *PredicateBuilder, property: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} IS NULL", .{property});
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add an IS NOT NULL condition
    pub fn isNotNull(self: *PredicateBuilder, property: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} IS NOT NULL", .{property});
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add a CONTAINS condition
    pub fn contains(self: *PredicateBuilder, property: []const u8, param_name: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} CONTAINS ${s}", .{ property, param_name });
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add a STARTS WITH condition
    pub fn startsWith(self: *PredicateBuilder, property: []const u8, param_name: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} STARTS WITH ${s}", .{ property, param_name });
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add an ENDS WITH condition
    pub fn endsWith(self: *PredicateBuilder, property: []const u8, param_name: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} ENDS WITH ${s}", .{ property, param_name });
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add an IN condition
    pub fn in(self: *PredicateBuilder, property: []const u8, param_name: []const u8) !*PredicateBuilder {
        const cond = try std.fmt.allocPrint(self.allocator, "{s} IN ${s}", .{ property, param_name });
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Add a raw condition
    pub fn raw(self: *PredicateBuilder, condition: []const u8) !*PredicateBuilder {
        const cond = try self.allocator.dupe(u8, condition);
        try self.conditions.append(self.allocator, cond);
        return self;
    }

    /// Combine with AND
    pub fn andOp(self: *PredicateBuilder) !*PredicateBuilder {
        const op = try self.allocator.dupe(u8, " AND ");
        try self.operators.append(self.allocator, op);
        return self;
    }

    /// Combine with OR
    pub fn orOp(self: *PredicateBuilder) !*PredicateBuilder {
        const op = try self.allocator.dupe(u8, " OR ");
        try self.operators.append(self.allocator, op);
        return self;
    }

    /// Build the final predicate string
    pub fn build(self: *PredicateBuilder) ![]const u8 {
        if (self.conditions.items.len == 0) {
            return error.EmptyPredicate;
        }

        var total_len: usize = 0;
        for (self.conditions.items, 0..) |cond, i| {
            total_len += cond.len;
            if (i < self.operators.items.len) {
                total_len += self.operators.items[i].len;
            }
        }

        var result = try self.allocator.alloc(u8, total_len);
        var offset: usize = 0;

        for (self.conditions.items, 0..) |cond, i| {
            @memcpy(result[offset .. offset + cond.len], cond);
            offset += cond.len;
            if (i < self.operators.items.len) {
                const op = self.operators.items[i];
                @memcpy(result[offset .. offset + op.len], op);
                offset += op.len;
            }
        }

        return result;
    }
};

// =============================================================================
// Unit Tests
// =============================================================================

test "QueryBuilder basic construction" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n)");
    _ = try qb.ret("n");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n) RETURN n", query);
}

test "QueryBuilder MATCH clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n:Person)");
    _ = try qb.ret("n.name");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n:Person) RETURN n.name", query);
}

test "QueryBuilder OPTIONAL MATCH clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n:Person)");
    _ = try qb.optionalMatch("(n)-[:KNOWS]->(m)");
    _ = try qb.ret("n, m");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n:Person) OPTIONAL MATCH (n)-[:KNOWS]->(m) RETURN n, m", query);
}

test "QueryBuilder WHERE clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n:Person)");
    _ = try qb.where("n.age > 30");
    _ = try qb.ret("n");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n:Person) WHERE n.age > 30 RETURN n", query);
}

test "QueryBuilder WITH clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n:Person)");
    _ = try qb.with("n, count(*) AS cnt");
    _ = try qb.ret("n, cnt");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n:Person) WITH n, count(*) AS cnt RETURN n, cnt", query);
}

test "QueryBuilder ORDER BY clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n:Person)");
    _ = try qb.ret("n");
    _ = try qb.orderBy("n.name");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n:Person) RETURN n ORDER BY n.name", query);
}

test "QueryBuilder ORDER BY DESC clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n:Person)");
    _ = try qb.ret("n");
    _ = try qb.orderByDesc("n.age");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n:Person) RETURN n ORDER BY n.age DESC", query);
}

test "QueryBuilder LIMIT clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n)");
    _ = try qb.ret("n");
    _ = try qb.limit(10);

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n) RETURN n LIMIT 10", query);
}

test "QueryBuilder SKIP clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n)");
    _ = try qb.ret("n");
    _ = try qb.skip(5);
    _ = try qb.limit(10);

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n) RETURN n SKIP 5 LIMIT 10", query);
}

test "QueryBuilder CREATE clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.create("(n:Person {name: 'Alice'})");
    _ = try qb.ret("n");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("CREATE (n:Person {name: 'Alice'}) RETURN n", query);
}

test "QueryBuilder MERGE clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.merge("(n:Person {name: 'Bob'})");
    _ = try qb.ret("n");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MERGE (n:Person {name: 'Bob'}) RETURN n", query);
}

test "QueryBuilder DELETE clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n:Temp)");
    _ = try qb.delete("n");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n:Temp) DELETE n", query);
}

test "QueryBuilder DETACH DELETE clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n:Temp)");
    _ = try qb.detachDelete("n");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n:Temp) DETACH DELETE n", query);
}

test "QueryBuilder SET clause" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n:Person)");
    _ = try qb.set("n.age = 30");
    _ = try qb.ret("n");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n:Person) SET n.age = 30 RETURN n", query);
}

test "QueryBuilder parameter binding" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(n:Person)");
    _ = try qb.where("n.name = $name");
    _ = try qb.ret("n");
    _ = try qb.param("name", Value.initString("Alice"));

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("MATCH (n:Person) WHERE n.name = $name RETURN n", query);

    const params = qb.getParams();
    const name_param = params.get("name");
    try std.testing.expect(name_param != null);
    try std.testing.expectEqualStrings("Alice", try name_param.?.asString());
}

test "QueryBuilder complex query" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    _ = try qb.match("(p:Person)-[:WORKS_AT]->(c:Company)");
    _ = try qb.where("p.age > 25");
    _ = try qb.with("p, c, count(*) AS cnt");
    _ = try qb.orderByDesc("cnt");
    _ = try qb.limit(10);
    _ = try qb.ret("p.name, c.name, cnt");

    const query = try qb.build();
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings(
        "MATCH (p:Person)-[:WORKS_AT]->(c:Company) WHERE p.age > 25 WITH p, c, count(*) AS cnt ORDER BY cnt DESC LIMIT 10 RETURN p.name, c.name, cnt",
        query,
    );
}

test "QueryBuilder empty query error" {
    var qb = QueryBuilder.init(std.testing.allocator);
    defer qb.deinit();

    try std.testing.expectError(error.EmptyQuery, qb.build());
}

test "PatternBuilder simple node" {
    var pb = PatternBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.nodeVar("n");

    const pattern = try pb.build();
    defer std.testing.allocator.free(pattern);

    try std.testing.expectEqualStrings("(n)", pattern);
}

test "PatternBuilder node with label" {
    var pb = PatternBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.nodeLabel("n", "Person");

    const pattern = try pb.build();
    defer std.testing.allocator.free(pattern);

    try std.testing.expectEqualStrings("(n:Person)", pattern);
}

test "PatternBuilder node with multiple labels" {
    var pb = PatternBuilder.init(std.testing.allocator);
    defer pb.deinit();

    const labels = [_][]const u8{ "Person", "Employee" };
    _ = try pb.node("n", &labels, null);

    const pattern = try pb.build();
    defer std.testing.allocator.free(pattern);

    try std.testing.expectEqualStrings("(n:Person:Employee)", pattern);
}

test "PatternBuilder node with properties" {
    var pb = PatternBuilder.init(std.testing.allocator);
    defer pb.deinit();

    const labels = [_][]const u8{"Person"};
    _ = try pb.node("n", &labels, "{name: 'Alice'}");

    const pattern = try pb.build();
    defer std.testing.allocator.free(pattern);

    try std.testing.expectEqualStrings("(n:Person {name: 'Alice'})", pattern);
}

test "PatternBuilder right-directed relationship" {
    var pb = PatternBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.nodeVar("a");
    _ = try pb.relRight("r", "KNOWS", null);
    _ = try pb.nodeVar("b");

    const pattern = try pb.build();
    defer std.testing.allocator.free(pattern);

    try std.testing.expectEqualStrings("(a)-[r:KNOWS]->(b)", pattern);
}

test "PatternBuilder left-directed relationship" {
    var pb = PatternBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.nodeVar("a");
    _ = try pb.relLeft("r", "KNOWS", null);
    _ = try pb.nodeVar("b");

    const pattern = try pb.build();
    defer std.testing.allocator.free(pattern);

    try std.testing.expectEqualStrings("(a)<-[r:KNOWS]-(b)", pattern);
}

test "PatternBuilder undirected relationship" {
    var pb = PatternBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.nodeVar("a");
    _ = try pb.relUndirected("r", "CONNECTED", null);
    _ = try pb.nodeVar("b");

    const pattern = try pb.build();
    defer std.testing.allocator.free(pattern);

    try std.testing.expectEqualStrings("(a)-[r:CONNECTED]-(b)", pattern);
}

test "PatternBuilder simple edge" {
    var pb = PatternBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.nodeLabel("a", "Person");
    _ = try pb.edgeRight("KNOWS");
    _ = try pb.nodeLabel("b", "Person");

    const pattern = try pb.build();
    defer std.testing.allocator.free(pattern);

    try std.testing.expectEqualStrings("(a:Person)-[:KNOWS]->(b:Person)", pattern);
}

test "PatternBuilder empty pattern error" {
    var pb = PatternBuilder.init(std.testing.allocator);
    defer pb.deinit();

    try std.testing.expectError(error.EmptyPattern, pb.build());
}

test "PredicateBuilder equality condition" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.eq("n.name", "name");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("n.name = $name", pred);
}

test "PredicateBuilder not-equal condition" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.neq("n.status", "status");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("n.status <> $status", pred);
}

test "PredicateBuilder comparison conditions" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.gt("n.age", "minAge");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("n.age > $minAge", pred);
}

test "PredicateBuilder IS NULL condition" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.isNull("n.deletedAt");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("n.deletedAt IS NULL", pred);
}

test "PredicateBuilder IS NOT NULL condition" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.isNotNull("n.email");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("n.email IS NOT NULL", pred);
}

test "PredicateBuilder string predicates" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.startsWith("n.name", "prefix");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("n.name STARTS WITH $prefix", pred);
}

test "PredicateBuilder AND combination" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.gt("n.age", "minAge");
    _ = try pb.andOp();
    _ = try pb.lt("n.age", "maxAge");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("n.age > $minAge AND n.age < $maxAge", pred);
}

test "PredicateBuilder OR combination" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.eq("n.status", "active");
    _ = try pb.orOp();
    _ = try pb.eq("n.status", "pending");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("n.status = $active OR n.status = $pending", pred);
}

test "PredicateBuilder complex combination" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    _ = try pb.gt("n.age", "minAge");
    _ = try pb.andOp();
    _ = try pb.isNotNull("n.email");
    _ = try pb.andOp();
    _ = try pb.startsWith("n.name", "prefix");

    const pred = try pb.build();
    defer std.testing.allocator.free(pred);

    try std.testing.expectEqualStrings("n.age > $minAge AND n.email IS NOT NULL AND n.name STARTS WITH $prefix", pred);
}

test "PredicateBuilder empty predicate error" {
    var pb = PredicateBuilder.init(std.testing.allocator);
    defer pb.deinit();

    try std.testing.expectError(error.EmptyPredicate, pb.build());
}
