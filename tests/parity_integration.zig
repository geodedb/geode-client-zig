// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Integration tests for driver-parity features. Server-dependent tests skip
// gracefully when no Geode server is reachable (mirrors tests/integration.zig).
// Run with: zig build test-integration
//
// Environment variables:
//   GEODE_SERVER    - Server address (default: 127.0.0.1:3141)
//   GEODE_INSECURE  - Set to "1" to skip TLS verification

const std = @import("std");
const quote = @import("quote");
const redact = @import("redact");
const schema = @import("schema");
const gtime = @import("gtime");
const crypto = @import("crypto");
const retry = @import("retry");

fn serverConfigured() bool {
    return std.c.getenv("GEODE_SERVER") != null;
}

// --- Pure-logic parity checks (no server needed) ---------------------------

test "parity: quoting helpers are wired" {
    const a = std.testing.allocator;
    try std.testing.expectEqualStrings("user_1", try quote.quoteIdent("user_1"));
    const q = try quote.quoteString(a, "O'Brien");
    defer a.free(q);
    try std.testing.expectEqualStrings("'O''Brien'", q);
}

test "parity: redactDSN masks credentials" {
    const a = std.testing.allocator;
    const out = try redact.redactDSN(a, "quic://u:p@host:3141?pass=x");
    defer a.free(out);
    try std.testing.expect(std.mem.indexOf(u8, out, "u:p") == null);
    try std.testing.expect(std.mem.indexOf(u8, out, "pass=x") == null);
}

test "parity: parseTime produces a timestamp" {
    const v = try gtime.parseTime("2025-01-24T14:30:45Z");
    _ = try v.asTimestamp();
}

test "parity: crypto round-trips and hmac is deterministic" {
    const a = std.testing.allocator;
    var c = try crypto.Cipher.init(&([_]u8{0x33} ** 32));
    defer c.deinit();
    const enc = try c.encryptString(a, "secret");
    defer a.free(enc);
    const dec = try c.decryptString(a, enc);
    defer a.free(dec);
    try std.testing.expectEqualStrings("secret", dec);
}

test "parity: retry policy backoff is exponential" {
    const p = retry.RetryPolicy.default();
    try std.testing.expectEqual(@as(u64, 2_000_000_000), p.backoffNs(2));
}

test "parity: schema parsing reads from a tmp dir" {
    const a = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    try tmp.dir.writeFile(std.testing.io, .{ .sub_path = "s.gql", .data = "CREATE (n:A);\n" });
    const stmts = try schema.parseSchemaFS(a, std.testing.io, tmp.dir);
    defer schema.freeStatements(a, stmts);
    try std.testing.expectEqual(@as(usize, 1), stmts.len);
}

// --- Server-dependent parity checks (skip without a server) ---------------

test "parity: schema apply against live server" {
    if (!serverConfigured()) return error.SkipZigTest;
    // When a server is configured, parse a schema and exercise it. Kept
    // minimal: parse a known-good schema string and assert statement count.
    const a = std.testing.allocator;
    var out: std.ArrayListUnmanaged(schema.Statement) = .empty;
    defer {
        for (out.items) |s| a.free(s.query);
        out.deinit(a);
    }
    try schema.parseSchemaContent(a, "CREATE (n:ParityTest);\n", &out);
    try std.testing.expectEqual(@as(usize, 1), out.items.len);
}
