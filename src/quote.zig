// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// GQL identifier and string-literal quoting helpers for the Geode Zig
// client. Ported from geode-client-go quote.go. Used to safely inline
// user-supplied data into GQL admin statements (CWE-89).

const std = @import("std");

/// Errors returned by the quoting helpers.
pub const QuoteError = error{
    /// Identifier contains characters that cannot appear in a bare GQL identifier.
    InvalidIdent,
    /// String literal contains ASCII control characters that cannot be safely escaped.
    InvalidString,
};

fn isIdentLetter(c: u8) bool {
    return (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') or c == '_';
}

fn isIdentDigit(c: u8) bool {
    return c >= '0' and c <= '9';
}

/// Validate `name` and return it unchanged if it is a safe bare GQL
/// identifier. Valid identifiers consist of letters, digits, underscore,
/// and hyphen; hyphen may not be the first character. Digits are permitted
/// anywhere, including first (digit-prefixed migration names). Empty input
/// is rejected.
pub fn quoteIdent(name: []const u8) QuoteError![]const u8 {
    if (name.len == 0) return QuoteError.InvalidIdent;
    for (name, 0..) |c, i| {
        if (isIdentLetter(c) or isIdentDigit(c)) continue;
        if (c == '-') {
            if (i == 0) return QuoteError.InvalidIdent;
            continue;
        }
        return QuoteError.InvalidIdent;
    }
    return name;
}

/// Return `s` wrapped in GQL single quotes with backslashes and single
/// quotes escaped. ASCII control characters (< 0x20 or 0x7f) are rejected
/// with InvalidString. Escape order: backslash first (\ -> \\), then single
/// quote (' -> ''). Caller owns the returned slice.
pub fn quoteString(allocator: std.mem.Allocator, s: []const u8) (QuoteError || std.mem.Allocator.Error)![]u8 {
    for (s) |c| {
        if (c < 0x20 or c == 0x7f) return QuoteError.InvalidString;
    }
    var out: std.ArrayListUnmanaged(u8) = .empty;
    errdefer out.deinit(allocator);
    try out.append(allocator, '\'');
    for (s) |c| {
        switch (c) {
            '\\' => try out.appendSlice(allocator, "\\\\"),
            '\'' => try out.appendSlice(allocator, "''"),
            else => try out.append(allocator, c),
        }
    }
    try out.append(allocator, '\'');
    return out.toOwnedSlice(allocator);
}

/// Return `name` stripped of any character that is not alphanumeric,
/// underscore, or hyphen, so it can be inlined safely into a USE GRAPH
/// statement. Caller owns the returned slice.
pub fn sanitizeGraphName(allocator: std.mem.Allocator, name: []const u8) std.mem.Allocator.Error![]u8 {
    var out: std.ArrayListUnmanaged(u8) = .empty;
    errdefer out.deinit(allocator);
    for (name) |c| {
        const keep = (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') or
            (c >= '0' and c <= '9') or c == '_' or c == '-';
        if (keep) try out.append(allocator, c);
    }
    return out.toOwnedSlice(allocator);
}

test "quoteIdent accepts valid identifiers" {
    try std.testing.expectEqualStrings("user_name", try quoteIdent("user_name"));
    try std.testing.expectEqualStrings("User1", try quoteIdent("User1"));
    try std.testing.expectEqualStrings("005_add_index", try quoteIdent("005_add_index"));
    try std.testing.expectEqualStrings("a-b-c", try quoteIdent("a-b-c"));
    try std.testing.expectEqualStrings("_private", try quoteIdent("_private"));
}

test "quoteIdent rejects empty and bad identifiers" {
    try std.testing.expectError(QuoteError.InvalidIdent, quoteIdent(""));
    try std.testing.expectError(QuoteError.InvalidIdent, quoteIdent("-leading-hyphen"));
    try std.testing.expectError(QuoteError.InvalidIdent, quoteIdent("has space"));
    try std.testing.expectError(QuoteError.InvalidIdent, quoteIdent("semi;colon"));
    try std.testing.expectError(QuoteError.InvalidIdent, quoteIdent("dot.dot"));
}

test "quoteString wraps and escapes" {
    const a = std.testing.allocator;
    {
        const out = try quoteString(a, "hello");
        defer a.free(out);
        try std.testing.expectEqualStrings("'hello'", out);
    }
    {
        const out = try quoteString(a, "O'Brien");
        defer a.free(out);
        try std.testing.expectEqualStrings("'O''Brien'", out);
    }
    {
        const out = try quoteString(a, "back\\slash");
        defer a.free(out);
        try std.testing.expectEqualStrings("'back\\\\slash'", out);
    }
    {
        // Backslash escaped BEFORE quote: \' -> \\''
        const out = try quoteString(a, "\\'");
        defer a.free(out);
        try std.testing.expectEqualStrings("'\\\\'''", out);
    }
}

test "quoteString rejects control characters" {
    const a = std.testing.allocator;
    try std.testing.expectError(QuoteError.InvalidString, quoteString(a, "bad\x00null"));
    try std.testing.expectError(QuoteError.InvalidString, quoteString(a, "tab\there"));
    try std.testing.expectError(QuoteError.InvalidString, quoteString(a, "del\x7f"));
}

test "sanitizeGraphName strips disallowed chars" {
    const a = std.testing.allocator;
    {
        const out = try sanitizeGraphName(a, "my-graph_1");
        defer a.free(out);
        try std.testing.expectEqualStrings("my-graph_1", out);
    }
    {
        const out = try sanitizeGraphName(a, "bad name; DROP");
        defer a.free(out);
        try std.testing.expectEqualStrings("badnameDROP", out);
    }
    {
        const out = try sanitizeGraphName(a, "");
        defer a.free(out);
        try std.testing.expectEqualStrings("", out);
    }
}
