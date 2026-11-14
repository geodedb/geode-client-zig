// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// The credentials in a DSN, and the ways an address or DSN is printed.
//
// SONNY-6550: the rules are geode's (src/client/dsn_credentials.zig,
// SONNY-6544), so the client library and the geode binary read and print a
// DSN the same way.
//
// RFC 3986 §3.2: the authority runs from after `scheme://` (or from the
// start of a scheme-less DSN) to the first `/`, `?` or `#`; its userinfo is
// everything before the LAST `@` of the authority (a raw `@` in a password
// is therefore read correctly), and splits into user and password at its
// FIRST `:` (a user name cannot hold a raw `:`). Both are percent-decoded
// (§2.1): `%` must be followed by two hex digits, and `+` is a literal plus.
// An `@` after the authority (a credential holding an unencoded `/`, `?` or
// `#`) is refused: where the credential ends cannot be told.
//
// `redacted(text)` prints an address or DSN with its userinfo removed and
// the value of every secret-looking query parameter (`pass=`, `password=`,
// `token=`, ...) replaced by `***`. `redactDSN` (ported from
// geode-client-go internal/redact/redact.go) keeps the userinfo's place as
// `***:***@` and also masks `user=` / `username=`.
//
// The module depends only on std.

const std = @import("std");

const masked = "***";

pub const Error = error{
    /// A `%` not followed by two hex digits.
    InvalidPercentEncoding,
    /// An `@` after the authority: a credential holding an unencoded `/`,
    /// `?` or `#`, whose end cannot be found.
    UnencodedCredentialDelimiter,
    OutOfMemory,
};

pub const Authority = struct {
    /// Before the last `@` of the authority; null when it has none.
    userinfo: ?[]const u8,
    /// The authority after the userinfo: `host[:port]`.
    host_port: []const u8,
    /// Everything after the authority: empty, or starting with `/`, `?` or
    /// `#`.
    rest: []const u8,
};

/// Split `text` (a DSN without its `scheme://`) into userinfo, host:port and
/// the rest. `error.UnencodedCredentialDelimiter` when an `@` follows the
/// authority.
pub fn splitAuthority(text: []const u8) error{UnencodedCredentialDelimiter}!Authority {
    const end = std.mem.indexOfAny(u8, text, "/?#") orelse text.len;
    const authority = text[0..end];
    const rest = text[end..];
    if (std.mem.indexOfScalar(u8, rest, '@') != null) return error.UnencodedCredentialDelimiter;
    if (std.mem.lastIndexOfScalar(u8, authority, '@')) |at| {
        return .{ .userinfo = authority[0..at], .host_port = authority[at + 1 ..], .rest = rest };
    }
    return .{ .userinfo = null, .host_port = authority, .rest = rest };
}

/// The index of the `://` that ends `text`'s scheme, or null when `text` has
/// no scheme: a `://` after a `/`, `?`, `#` or `@` is not one.
pub fn schemeEnd(text: []const u8) ?usize {
    const sep = std.mem.indexOf(u8, text, "://") orelse return null;
    if (std.mem.indexOfAny(u8, text[0..sep], "/?#@") != null) return null;
    return sep;
}

/// A decoded user name and password; `deinit` zeroes them before freeing.
pub const Credentials = struct {
    username: []u8,
    password: ?[]u8,

    pub fn deinit(self: *Credentials, allocator: std.mem.Allocator) void {
        std.crypto.secureZero(u8, self.username);
        allocator.free(self.username);
        if (self.password) |p| {
            std.crypto.secureZero(u8, p);
            allocator.free(p);
        }
        self.* = undefined;
    }
};

/// Decode `userinfo` (`user[:password]`, percent-encoded).
pub fn decodeUserinfo(allocator: std.mem.Allocator, userinfo: []const u8) Error!Credentials {
    const colon = std.mem.indexOfScalar(u8, userinfo, ':');
    const user_text = if (colon) |c| userinfo[0..c] else userinfo;
    const username = try percentDecode(allocator, user_text);
    errdefer {
        std.crypto.secureZero(u8, username);
        allocator.free(username);
    }
    const password = if (colon) |c| try percentDecode(allocator, userinfo[c + 1 ..]) else null;
    return .{ .username = username, .password = password };
}

/// RFC 3986 §2.1 percent-decoding. The caller owns the result. The text is
/// checked before anything is allocated and the result is allocated at its
/// exact size, so no partial or resized copy of a credential is ever freed.
pub fn percentDecode(allocator: std.mem.Allocator, text: []const u8) Error![]u8 {
    var n: usize = 0;
    var i: usize = 0;
    while (i < text.len) : (n += 1) {
        if (text[i] != '%') {
            i += 1;
            continue;
        }
        if (i + 2 >= text.len) return error.InvalidPercentEncoding;
        if (hexValue(text[i + 1]) == null or hexValue(text[i + 2]) == null) return error.InvalidPercentEncoding;
        i += 3;
    }
    const out = try allocator.alloc(u8, n);
    n = 0;
    i = 0;
    while (i < text.len) : (n += 1) {
        if (text[i] != '%') {
            out[n] = text[i];
            i += 1;
            continue;
        }
        out[n] = (hexValue(text[i + 1]).? << 4) | hexValue(text[i + 2]).?;
        i += 3;
    }
    return out;
}

fn hexValue(c: u8) ?u8 {
    return switch (c) {
        '0'...'9' => c - '0',
        'a'...'f' => c - 'a' + 10,
        'A'...'F' => c - 'A' + 10,
        else => null,
    };
}

/// Write `text` percent-encoded: RFC 3986 unreserved bytes (`A-Z a-z 0-9
/// - . _ ~`) and the bytes in `keep` as they are, every other byte as `%XX`.
/// With `keep` empty the result is safe in a userinfo, a path segment and a
/// query value, and `percentDecode` reads it back.
pub fn writePercentEncoded(w: *std.Io.Writer, text: []const u8, keep: []const u8) std.Io.Writer.Error!void {
    const hex = "0123456789ABCDEF";
    for (text) |c| {
        const raw = std.ascii.isAlphanumeric(c) or c == '-' or c == '.' or c == '_' or c == '~' or
            std.mem.indexOfScalar(u8, keep, c) != null;
        if (raw) {
            try w.writeByte(c);
        } else {
            try w.writeAll(&.{ '%', hex[c >> 4], hex[c & 0xf] });
        }
    }
}

/// Printed instead of an address or DSN whose credentials cannot be told
/// apart from the rest of it.
pub const redacted_marker = "<address redacted>";

/// `{f}` formatter: `text` without credentials. See the module comment.
pub const Redacted = struct {
    text: []const u8,

    pub fn format(self: Redacted, w: *std.Io.Writer) std.Io.Writer.Error!void {
        var text = self.text;
        if (schemeEnd(text)) |sep| {
            try w.writeAll(text[0 .. sep + 3]);
            text = text[sep + 3 ..];
        }
        const a = splitAuthority(text) catch return w.writeAll(redacted_marker);
        try w.writeAll(a.host_port);
        var rest = a.rest;
        const path_end = std.mem.indexOfAny(u8, rest, "?#") orelse rest.len;
        try w.writeAll(rest[0..path_end]);
        rest = rest[path_end..];
        if (rest.len == 0 or rest[0] != '?') return; // a fragment is not shown
        const query_end = std.mem.indexOfScalar(u8, rest, '#') orelse rest.len;
        try w.writeByte('?');
        var params = std.mem.splitScalar(u8, rest[1..query_end], '&');
        var first = true;
        while (params.next()) |param| {
            if (!first) try w.writeByte('&');
            first = false;
            const eq = std.mem.indexOfScalar(u8, param, '=') orelse {
                try w.writeAll(param);
                continue;
            };
            try w.writeAll(param[0 .. eq + 1]);
            try w.writeAll(if (isSecretKey(param[0..eq])) masked else param[eq + 1 ..]);
        }
    }
};

/// `text` (an address, `host:port`, or a DSN) for printing: `{f}`.
pub fn redacted(text: []const u8) Redacted {
    return .{ .text = text };
}

/// A query parameter whose value is or may be a secret.
pub fn isSecretKey(key: []const u8) bool {
    const words = [_][]const u8{ "pass", "pwd", "secret", "token", "auth", "credential", "key", "session", "cookie", "signature" };
    for (words) |word| {
        if (std.ascii.findIgnoreCase(key, word) != null) return true;
    }
    return false;
}

fn isCredentialParam(key: []const u8) bool {
    return std.ascii.eqlIgnoreCase(key, "user") or
        std.ascii.eqlIgnoreCase(key, "username") or
        isSecretKey(key);
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

/// Return `dsn` with credentials masked for safe logging: the userinfo
/// (found by `splitAuthority`) becomes `***:***@` or `***@`, and the value
/// of `user=`, `username=` and every `isSecretKey` parameter becomes `***`.
/// A fragment is dropped, and a DSN with an `@` after its authority prints
/// as `redacted_marker` after its scheme. Caller owns the returned slice.
/// Empty input returns an empty owned slice.
pub fn redactDSN(allocator: std.mem.Allocator, dsn: []const u8) std.mem.Allocator.Error![]u8 {
    var out: std.ArrayListUnmanaged(u8) = .empty;
    errdefer out.deinit(allocator);
    if (dsn.len == 0) return out.toOwnedSlice(allocator);

    const start = if (schemeEnd(dsn)) |sep| sep + 3 else 0;
    try out.appendSlice(allocator, dsn[0..start]);
    const a = splitAuthority(dsn[start..]) catch {
        try out.appendSlice(allocator, redacted_marker);
        return out.toOwnedSlice(allocator);
    };
    if (a.userinfo) |userinfo| {
        try out.appendSlice(allocator, if (std.mem.indexOfScalar(u8, userinfo, ':') == null) masked ++ "@" else masked ++ ":" ++ masked ++ "@");
    }
    try out.appendSlice(allocator, a.host_port);
    const rest = a.rest[0 .. std.mem.indexOfScalar(u8, a.rest, '#') orelse a.rest.len];
    const q_idx = std.mem.indexOfScalar(u8, rest, '?');
    try out.appendSlice(allocator, rest[0 .. q_idx orelse rest.len]);
    if (q_idx) |i| {
        try out.append(allocator, '?');
        try redactQuery(allocator, &out, rest[i + 1 ..]);
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

test "redactDSN shows no userinfo cut short by an unencoded '/', '?' or '#' (SONNY-6550)" {
    const a = std.testing.allocator;
    for ([_][]const u8{
        "quic://admin:pa?ss@host:3141",
        "quic://admin:pa/ss@host:3141",
        "quic://admin:pa#ss@host:3141",
        "admin:pa?ss@host:3141",
    }) |dsn| {
        const out = try redactDSN(a, dsn);
        defer a.free(out);
        std.testing.expect(std.mem.indexOf(u8, out, "admin") == null and std.mem.indexOf(u8, out, "pa") == null) catch |err| {
            std.debug.print("redactDSN(\"{s}\") = \"{s}\"\n", .{ dsn, out });
            return err;
        };
    }
}

test "redactDSN masks every secret-looking query parameter (SONNY-6550)" {
    const a = std.testing.allocator;
    const out = try redactDSN(a, "quic://host:3141?token=t&api_key=k&client_secret=s&page_size=5");
    defer a.free(out);
    try std.testing.expectEqualStrings("quic://host:3141?token=***&api_key=***&client_secret=***&page_size=5", out);
}
