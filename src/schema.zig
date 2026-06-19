// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Schema-file (.gql) parsing for the Geode Zig client. Ported from
// geode-client-go schema.go. Reads .gql files from a directory and splits
// their contents into individual GQL statements suitable for batch/pipeline
// execution.

const std = @import("std");

/// A parsed GQL statement. `query` is owned by the allocator passed to the
/// parsing function.
pub const Statement = struct {
    query: []const u8,
};

const keywords = [_][]const u8{ "CREATE", "MERGE", "MATCH", "DELETE" };

fn startsWithKeyword(trimmed: []const u8) bool {
    for (keywords) |kw| {
        if (trimmed.len >= kw.len and std.ascii.eqlIgnoreCase(trimmed[0..kw.len], kw)) {
            return true;
        }
    }
    return false;
}

/// Parse one file's content into Statements, appending to `out`. Lines are
/// trimmed; blank lines and `//`/`--` comment lines are dropped; only lines
/// beginning with a recognised GQL keyword are kept; each kept line is split
/// on ';' into one or more statements. Each appended `query` is allocator-owned.
pub fn parseSchemaContent(
    allocator: std.mem.Allocator,
    content: []const u8,
    out: *std.ArrayListUnmanaged(Statement),
) !void {
    var lines = std.mem.splitScalar(u8, content, '\n');
    while (lines.next()) |raw_line| {
        const trimmed = std.mem.trim(u8, raw_line, " \t\r");
        if (trimmed.len == 0) continue;
        if (std.mem.startsWith(u8, trimmed, "//") or std.mem.startsWith(u8, trimmed, "--")) continue;
        if (!startsWithKeyword(trimmed)) continue;

        var parts = std.mem.splitScalar(u8, trimmed, ';');
        while (parts.next()) |part| {
            const stmt = std.mem.trim(u8, part, " \t\r");
            if (stmt.len == 0) continue;
            const owned = try allocator.dupe(u8, stmt);
            errdefer allocator.free(owned);
            try out.append(allocator, .{ .query = owned });
        }
    }
}

/// Read all direct-child `*.gql` files from `dir` (in lexicographic name
/// order) and return their parsed Statements as an owned slice. Caller frees
/// via `freeStatements`.
///
/// NOTE: Zig 0.16 uses `std.Io.Dir` and requires an explicit `io` handle for
/// all I/O operations. The `io` parameter must be a `std.Io` instance
/// (e.g. `std.testing.io` in tests, or `std.Io.Threaded.global_single_threaded.io()`
/// in production code).
pub fn parseSchemaFS(allocator: std.mem.Allocator, io: std.Io, dir: std.Io.Dir) ![]Statement {
    // Collect .gql filenames.
    var names: std.ArrayListUnmanaged([]u8) = .empty;
    defer {
        for (names.items) |n| allocator.free(n);
        names.deinit(allocator);
    }
    // Re-open "." with iterate:true so that dir.iterate() works regardless of
    // how the caller opened `dir`. The original `dir` handle is left open.
    var iter_dir = try dir.openDir(io, ".", .{ .iterate = true });
    defer iter_dir.close(io);
    var it = iter_dir.iterate();
    while (try it.next(io)) |entry| {
        if (entry.kind == .directory) continue;
        if (!std.mem.endsWith(u8, entry.name, ".gql")) continue;
        const name_copy = try allocator.dupe(u8, entry.name);
        errdefer allocator.free(name_copy);
        try names.append(allocator, name_copy);
    }
    std.mem.sort([]u8, names.items, {}, struct {
        fn lessThan(_: void, lhs: []u8, rhs: []u8) bool {
            return std.mem.lessThan(u8, lhs, rhs);
        }
    }.lessThan);

    var out: std.ArrayListUnmanaged(Statement) = .empty;
    errdefer {
        for (out.items) |s| allocator.free(s.query);
        out.deinit(allocator);
    }
    for (names.items) |name| {
        const data = try dir.readFileAlloc(io, name, allocator, .limited(16 * 1024 * 1024));
        defer allocator.free(data);
        try parseSchemaContent(allocator, data, &out);
    }
    return out.toOwnedSlice(allocator);
}

/// Free a slice of Statements returned by `parseSchemaFS`.
pub fn freeStatements(allocator: std.mem.Allocator, stmts: []Statement) void {
    for (stmts) |s| allocator.free(s.query);
    allocator.free(stmts);
}

test "parseSchemaContent keeps GQL statements and drops comments" {
    const a = std.testing.allocator;
    const content =
        "// a comment\n" ++
        "-- another comment\n" ++
        "\n" ++
        "CREATE (n:Person {name: 'Alice'});\n" ++
        "MATCH (n) RETURN n;\n" ++
        "SELECT * FROM x;\n" ++ // dropped: not a GQL keyword
        "MERGE (m:Node); DELETE (m);\n"; // two statements on one line

    var out: std.ArrayListUnmanaged(Statement) = .empty;
    defer {
        for (out.items) |s| a.free(s.query);
        out.deinit(a);
    }
    try parseSchemaContent(a, content, &out);

    try std.testing.expectEqual(@as(usize, 4), out.items.len);
    try std.testing.expectEqualStrings("CREATE (n:Person {name: 'Alice'})", out.items[0].query);
    try std.testing.expectEqualStrings("MATCH (n) RETURN n", out.items[1].query);
    try std.testing.expectEqualStrings("MERGE (m:Node)", out.items[2].query);
    try std.testing.expectEqualStrings("DELETE (m)", out.items[3].query);
}

test "parseSchemaContent is case-insensitive on keywords" {
    const a = std.testing.allocator;
    var out: std.ArrayListUnmanaged(Statement) = .empty;
    defer {
        for (out.items) |s| a.free(s.query);
        out.deinit(a);
    }
    try parseSchemaContent(a, "create (n);\nmatch (n) return n;\n", &out);
    try std.testing.expectEqual(@as(usize, 2), out.items.len);
}

test "parseSchemaFS reads .gql files from a tmp dir in name order" {
    const a = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    try tmp.dir.writeFile(std.testing.io, .{ .sub_path = "01_nodes.gql", .data = "CREATE (a:A);\n" });
    try tmp.dir.writeFile(std.testing.io, .{ .sub_path = "02_edges.gql", .data = "MERGE (b:B);\n" });
    try tmp.dir.writeFile(std.testing.io, .{ .sub_path = "ignore.txt", .data = "CREATE (c:C);\n" });

    const stmts = try parseSchemaFS(a, std.testing.io, tmp.dir);
    defer freeStatements(a, stmts);

    try std.testing.expectEqual(@as(usize, 2), stmts.len);
    try std.testing.expectEqualStrings("CREATE (a:A)", stmts[0].query);
    try std.testing.expectEqualStrings("MERGE (b:B)", stmts[1].query);
}

test "parseSchemaFS returns empty for dir with no gql files" {
    const a = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    try tmp.dir.writeFile(std.testing.io, .{ .sub_path = "readme.md", .data = "hi" });

    const stmts = try parseSchemaFS(a, std.testing.io, tmp.dir);
    defer freeStatements(a, stmts);
    try std.testing.expectEqual(@as(usize, 0), stmts.len);
}
