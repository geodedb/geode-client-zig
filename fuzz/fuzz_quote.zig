// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Fuzz/property tests for GQL quoting helpers. The invariants: quoting
// never crashes, quoteString output is always single-quote wrapped when it
// succeeds, and quoteIdent never returns a string with a leading hyphen.

const std = @import("std");
const quote = @import("quote");

pub fn main() !void {
    var buffer: [128 * 1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const stdin = std.Io.getStdIn();
    const input = stdin.readToEndAlloc(allocator, 64 * 1024) catch return;

    _ = quote.quoteIdent(input) catch {};
    if (quote.quoteString(allocator, input)) |out| {
        allocator.free(out);
    } else |_| {}
    if (quote.sanitizeGraphName(allocator, input)) |out| {
        allocator.free(out);
    } else |_| {}
}

test "property: quoteString output is single-quote wrapped or rejected" {
    const a = std.testing.allocator;
    const inputs = [_][]const u8{ "", "abc", "a'b", "a\\b", "x\x01" };
    for (inputs) |in| {
        if (quote.quoteString(a, in)) |out| {
            defer a.free(out);
            try std.testing.expect(out.len >= 2);
            try std.testing.expectEqual(@as(u8, '\''), out[0]);
            try std.testing.expectEqual(@as(u8, '\''), out[out.len - 1]);
        } else |err| {
            try std.testing.expectEqual(quote.QuoteError.InvalidString, err);
        }
    }
}

test "property: quoteIdent never accepts leading hyphen" {
    try std.testing.expectError(quote.QuoteError.InvalidIdent, quote.quoteIdent("-x"));
    try std.testing.expectError(quote.QuoteError.InvalidIdent, quote.quoteIdent("-"));
}

test "property: sanitizeGraphName output contains only allowed chars" {
    const a = std.testing.allocator;
    const out = try quote.sanitizeGraphName(a, "a b!c@d#-_1");
    defer a.free(out);
    for (out) |c| {
        const ok = (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') or
            (c >= '0' and c <= '9') or c == '_' or c == '-';
        try std.testing.expect(ok);
    }
}
