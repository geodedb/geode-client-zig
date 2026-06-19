// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// DSN credential redaction for safe logging. Ported from
// geode-client-go internal/redact/redact.go. Masks URI userinfo and
// credential query parameters before a DSN is written to a log sink.

const std = @import("std");

const masked = "***";

fn isCredentialParam(key: []const u8) bool {
    return std.ascii.eqlIgnoreCase(key, "user") or
        std.ascii.eqlIgnoreCase(key, "username") or
        std.ascii.eqlIgnoreCase(key, "pass") or
        std.ascii.eqlIgnoreCase(key, "password");
}

/// Append the userinfo segment (everything up to and including the last
/// '@') of `authority` to `out`, with user and password masked.
fn appendMaskedUserinfo(allocator: std.mem.Allocator, out: *std.ArrayListUnmanaged(u8), userinfo: []const u8) !void {
    if (std.mem.indexOfScalar(u8, userinfo, ':') == null) {
        try out.appendSlice(allocator, masked);
    } else {
        try out.appendSlice(allocator, masked ++ ":" ++ masked);
    }
}

/// Mask the userinfo portion of the base part of a DSN (before any '?').
fn redactBase(allocator: std.mem.Allocator, out: *std.ArrayListUnmanaged(u8), base: []const u8) !void {
    const scheme_marker = "://";
    if (std.mem.indexOf(u8, base, scheme_marker)) |scheme_end| {
        const authority_start = scheme_end + scheme_marker.len;
        const authority = base[authority_start..];
        if (std.mem.lastIndexOfScalar(u8, authority, '@')) |at_idx| {
            try out.appendSlice(allocator, base[0..authority_start]);
            try appendMaskedUserinfo(allocator, out, authority[0..at_idx]);
            try out.appendSlice(allocator, authority[at_idx..]);
            return;
        }
        try out.appendSlice(allocator, base);
        return;
    }
    // No scheme: bare user@host pattern.
    if (std.mem.lastIndexOfScalar(u8, base, '@')) |at_idx| {
        try appendMaskedUserinfo(allocator, out, base[0..at_idx]);
        try out.appendSlice(allocator, base[at_idx..]);
        return;
    }
    try out.appendSlice(allocator, base);
}

/// Mask credential query parameters in `query`, preserving order and
/// non-credential params.
fn redactQuery(allocator: std.mem.Allocator, out: *std.ArrayListUnmanaged(u8), query: []const u8) !void {
    var first = true;
    var iter = std.mem.splitScalar(u8, query, '&');
    while (iter.next()) |param| {
        if (!first) try out.append(allocator, '&');
        first = false;
        if (std.mem.indexOfScalar(u8, param, '=')) |eq| {
            const key = param[0..eq];
            if (isCredentialParam(key)) {
                try out.appendSlice(allocator, key);
                try out.append(allocator, '=');
                try out.appendSlice(allocator, masked);
                continue;
            }
        }
        try out.appendSlice(allocator, param);
    }
}

/// Return `dsn` with credentials masked for safe logging. Caller owns the
/// returned slice. Empty input returns an empty owned slice.
pub fn redactDSN(allocator: std.mem.Allocator, dsn: []const u8) std.mem.Allocator.Error![]u8 {
    var out: std.ArrayListUnmanaged(u8) = .empty;
    errdefer out.deinit(allocator);
    if (dsn.len == 0) return out.toOwnedSlice(allocator);

    const q_idx = std.mem.indexOfScalar(u8, dsn, '?');
    const base = if (q_idx) |i| dsn[0..i] else dsn;
    try redactBase(allocator, &out, base);
    if (q_idx) |i| {
        try out.append(allocator, '?');
        try redactQuery(allocator, &out, dsn[i + 1 ..]);
    }
    return out.toOwnedSlice(allocator);
}

test "redactDSN masks URI userinfo" {
    const a = std.testing.allocator;
    {
        const out = try redactDSN(a, "quic://user:pass@host:3141");
        defer a.free(out);
        try std.testing.expectEqualStrings("quic://***:***@host:3141", out);
    }
    {
        const out = try redactDSN(a, "quic://user@host:3141");
        defer a.free(out);
        try std.testing.expectEqualStrings("quic://***@host:3141", out);
    }
}

test "redactDSN masks credential query params" {
    const a = std.testing.allocator;
    const out = try redactDSN(a, "quic://host:3141?user=bob&pass=secret&graph=g");
    defer a.free(out);
    try std.testing.expectEqualStrings("quic://host:3141?user=***&pass=***&graph=g", out);
}

test "redactDSN handles both userinfo and params" {
    const a = std.testing.allocator;
    const out = try redactDSN(a, "grpc://u:p@host:50051?password=x&tls=0");
    defer a.free(out);
    try std.testing.expectEqualStrings("grpc://***:***@host:50051?password=***&tls=0", out);
}

test "redactDSN passes through credential-free DSN" {
    const a = std.testing.allocator;
    const out = try redactDSN(a, "localhost:3141");
    defer a.free(out);
    try std.testing.expectEqualStrings("localhost:3141", out);
}

test "redactDSN is empty-safe" {
    const a = std.testing.allocator;
    const out = try redactDSN(a, "");
    defer a.free(out);
    try std.testing.expectEqualStrings("", out);
}
