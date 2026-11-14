// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// SONNY-6550: `config.redacted`, the one way the library (and its callers)
// print an address or DSN, and the DSN credential helpers behind
// `parseDSN`. The tables are geode's (tests/test_sonny6544_dsn_redaction.zig,
// SONNY-6544): the two implementations follow the same rules.

const std = @import("std");
const geode_client = @import("geode_client");
const config = geode_client.config;
const dsn = config.redact;
const testing = std.testing;

fn expectRedacted(input: []const u8, want: []const u8) !void {
    var buf: [512]u8 = undefined;
    const got = try std.fmt.bufPrint(&buf, "{f}", .{config.redacted(input)});
    testing.expectEqualStrings(want, got) catch |err| {
        std.debug.print("redacted({s})\n", .{input});
        return err;
    };
}

test "SONNY-6550: redacted() drops the userinfo and masks secret query values" {
    const cases = [_]struct { []const u8, []const u8 }{
        // No userinfo: unchanged.
        .{ "127.0.0.1:3141", "127.0.0.1:3141" },
        .{ "localhost", "localhost" },
        .{ ":3141", ":3141" },
        .{ "quic://geode.example.com:3141/social", "quic://geode.example.com:3141/social" },
        // IPv6 literals, with and without a zone.
        .{ "[::1]:3141", "[::1]:3141" },
        .{ "[fe80::1%eth0]:3141", "[fe80::1%eth0]:3141" },
        .{ "quic://admin:secret@[2001:db8::1]:3141/social", "quic://[2001:db8::1]:3141/social" },
        .{ "quic://admin:secret@[::1]", "quic://[::1]" },
        // '@' in the password: the userinfo ends at the last '@'.
        .{ "quic://admin:p@ss@localhost:3141", "quic://localhost:3141" },
        .{ "quic://admin:p@ss@[::1]:3141", "quic://[::1]:3141" },
        // ':' in the password.
        .{ "quic://admin:pa:ss:wd@localhost:3141", "quic://localhost:3141" },
        // Percent-encoded credentials.
        .{ "quic://user%40domain:p%40ss%3Dword@localhost:3141", "quic://localhost:3141" },
        // Empty user, user only, empty password.
        .{ "quic://:secret@host:3141", "quic://host:3141" },
        .{ "quic://admin@host", "quic://host" },
        .{ "quic://admin:@host:3141", "quic://host:3141" },
        // Scheme-less DSN and an address with a userinfo part.
        .{ "admin:secret@127.0.0.1:3141", "127.0.0.1:3141" },
        .{ "secret@127.0.0.1:3141", "127.0.0.1:3141" },
        // Query-string secrets.
        .{ "quic://localhost:3141?username=admin&password=secret", "quic://localhost:3141?username=admin&password=***" },
        .{ "grpc://h:50051/g?pass=s1&page_size=5&token=s2&hello_name=app", "grpc://h:50051/g?pass=***&page_size=5&token=***&hello_name=app" },
        .{ "h?PASSWORD=s&Session_Token=s&api_key=s&client_secret=s&auth=s", "h?PASSWORD=***&Session_Token=***&api_key=***&client_secret=***&auth=***" },
        .{ "https://b.example/x.gbak?X-Amz-Credential=c&X-Amz-Signature=s&v=1", "https://b.example/x.gbak?X-Amz-Credential=***&X-Amz-Signature=***&v=1" },
        .{ "h:1?flag&password=", "h:1?flag&password=***" },
        // Object-storage URIs.
        .{ "s3://AKIAFAKE:fakesecret@bucket/backups/x.gbak", "s3://bucket/backups/x.gbak" },
        // A fragment is not shown.
        .{ "quic://h:1/g#secret", "quic://h:1/g" },
        .{ "quic://h:1?a=b#secret", "quic://h:1?a=b" },
        // An '@' after the authority: an unencoded '/', '?' or '#' in a
        // credential; where it ends cannot be told, so nothing is shown.
        .{ "quic://admin:pa/ss@host:3141", "quic://" ++ dsn.redacted_marker },
        .{ "quic://admin:pa?ss@host:3141", "quic://" ++ dsn.redacted_marker },
        .{ "quic://admin:pa#ss@host:3141", "quic://" ++ dsn.redacted_marker },
        .{ "h:1?password=a@b", dsn.redacted_marker },
        // Not a scheme: '://' after a '/', '?' or '@'.
        .{ "u:p@h:1/x://y", "h:1/x://y" },
    };
    for (cases) |c| try expectRedacted(c[0], c[1]);
}

test "SONNY-6550: splitAuthority ends the userinfo at the last '@' of the authority" {
    const a = try dsn.splitAuthority("admin:p@ss:w@rd@[::1]:3141/g?x=1");
    try testing.expectEqualStrings("admin:p@ss:w@rd", a.userinfo.?);
    try testing.expectEqualStrings("[::1]:3141", a.host_port);
    try testing.expectEqualStrings("/g?x=1", a.rest);

    const b = try dsn.splitAuthority("localhost:3141?page_size=5");
    try testing.expect(b.userinfo == null);
    try testing.expectEqualStrings("localhost:3141", b.host_port);
    try testing.expectEqualStrings("?page_size=5", b.rest);

    const c = try dsn.splitAuthority("@host");
    try testing.expectEqualStrings("", c.userinfo.?);
    try testing.expectEqualStrings("host", c.host_port);

    for ([_][]const u8{ "u:a/b@host", "u:a?b@host", "u:a#b@host", "host:1?hello_name=me@x", "host/g@x" }) |text| {
        try testing.expectError(error.UnencodedCredentialDelimiter, dsn.splitAuthority(text));
    }
}

test "SONNY-6550: decodeUserinfo splits at the first ':' and percent-decodes both parts" {
    const a = testing.allocator;
    const cases = [_]struct { []const u8, []const u8, ?[]const u8 }{
        .{ "admin:secret", "admin", "secret" },
        .{ "admin:p@ss:word", "admin", "p@ss:word" },
        .{ "admin:p%40ss%3Aword", "admin", "p@ss:word" },
        .{ "user%40domain:p%40ss%3Dword", "user@domain", "p@ss=word" },
        .{ "us%3Aer:pw", "us:er", "pw" },
        .{ ":pw", "", "pw" },
        .{ "admin", "admin", null },
        .{ "admin:", "admin", "" },
        .{ "a:b+c%20d%25", "a", "b+c d%" },
        .{ "a:%e2%9c%93", "a", "\u{2713}" },
    };
    for (cases) |c| {
        var creds = try dsn.decodeUserinfo(a, c[0]);
        defer creds.deinit(a);
        try testing.expectEqualStrings(c[1], creds.username);
        if (c[2]) |want| {
            try testing.expectEqualStrings(want, creds.password.?);
        } else try testing.expect(creds.password == null);
    }
}

test "SONNY-6550: a malformed percent-escape is refused, in the user name or the password" {
    const a = testing.allocator;
    for ([_][]const u8{ "a:%", "a:%4", "a:%zz", "a:b%g1", "a%:b", "a:%%41", "a:50%off" }) |text| {
        try testing.expectError(error.InvalidPercentEncoding, dsn.decodeUserinfo(a, text));
    }
}

test "SONNY-6550: isSecretKey names the secret query parameters" {
    for ([_][]const u8{ "pass", "password", "PASSWORD", "pwd", "token", "access_token", "client_secret", "api_key", "auth", "authorization", "credential", "session", "cookie", "X-Amz-Signature" }) |k| {
        try testing.expect(dsn.isSecretKey(k));
    }
    for ([_][]const u8{ "username", "user", "page_size", "hello_name", "hello_ver", "conformance", "insecure", "ca", "timeout" }) |k| {
        try testing.expect(!dsn.isSecretKey(k));
    }
}

test "SONNY-6550: redacted(toDSN(cfg)) never shows the password; {f} on a Config shows no credentials" {
    var prng = std.Random.DefaultPrng.init(0x6550);
    const r = prng.random();
    const alphabet = "abcdefghijklmnopqrstuvwxyz0123456789@:/?#%+&=[] ~!$'()*,;";
    for (0..500) |_| {
        var pass_buf: [24]u8 = undefined;
        for (&pass_buf) |*b| b.* = alphabet[r.uintLessThan(usize, alphabet.len)];
        // A marker the host, port and query keys cannot hold.
        @memcpy(pass_buf[0..4], "ZQXJ");
        var cfg = config.Config.initWithHost("db.example.com", 3141);
        // With a user name the password is userinfo; without one, toDSN
        // writes it as `pass=`.
        if (r.boolean()) {
            _ = try cfg.withCredentials(testing.allocator, "admin", &pass_buf);
        } else {
            cfg.password = try testing.allocator.dupe(u8, &pass_buf);
        }
        defer cfg.deinit(testing.allocator);
        const text = try cfg.toDSN(testing.allocator);
        defer testing.allocator.free(text);
        var buf: [1024]u8 = undefined;
        const shown = try std.fmt.bufPrint(&buf, "{f}", .{config.redacted(text)});
        try testing.expect(std.mem.indexOf(u8, shown, "ZQXJ") == null);
        try testing.expect(std.mem.indexOf(u8, shown, "admin") == null);
    }

    var cfg = config.Config.initWithHost("::1", 3141);
    _ = try cfg.withCredentials(testing.allocator, "admin", "ZQXJ-pw");
    defer cfg.deinit(testing.allocator);
    var buf: [256]u8 = undefined;
    const shown = try std.fmt.bufPrint(&buf, "{f}", .{cfg});
    try testing.expectEqualStrings("quic://[::1]:3141", shown);
}
