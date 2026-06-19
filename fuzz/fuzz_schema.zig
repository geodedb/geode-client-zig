// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Fuzz/property tests for schema-content parsing. Invariant: parsing never
// crashes and every emitted statement is non-empty and begins with a
// recognised GQL keyword.

const std = @import("std");
const schema = @import("schema");

pub fn main() !void {
    var buffer: [256 * 1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const stdin = std.Io.getStdIn();
    const input = stdin.readToEndAlloc(allocator, 128 * 1024) catch return;

    var out: std.ArrayListUnmanaged(schema.Statement) = .empty;
    schema.parseSchemaContent(allocator, input, &out) catch return;
    // FixedBufferAllocator frees on reset; no explicit free needed.
}

fn startsWithKeyword(s: []const u8) bool {
    const kws = [_][]const u8{ "CREATE", "MERGE", "MATCH", "DELETE" };
    for (kws) |kw| {
        if (s.len >= kw.len and std.ascii.eqlIgnoreCase(s[0..kw.len], kw)) return true;
    }
    return false;
}

test "property: every parsed statement is non-empty and keyword-prefixed" {
    const a = std.testing.allocator;
    const inputs = [_][]const u8{
        "CREATE (a);\nMATCH (b);",
        "// only comments\n-- here\n",
        "garbage line\nMERGE (x); DELETE (y);",
        ";;;\nCREATE (z);;;",
    };
    for (inputs) |in| {
        var out: std.ArrayListUnmanaged(schema.Statement) = .empty;
        defer {
            for (out.items) |s| a.free(s.query);
            out.deinit(a);
        }
        try schema.parseSchemaContent(a, in, &out);
        for (out.items) |s| {
            try std.testing.expect(s.query.len > 0);
            try std.testing.expect(startsWithKeyword(s.query));
        }
    }
}
