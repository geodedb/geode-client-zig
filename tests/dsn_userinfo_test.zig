// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// SONNY-6550: the credentials in a DSN (RFC 3986 §3.2, the rule geode's
// src/client/dsn_credentials.zig applies, SONNY-6544).
//
// The authority runs from after `scheme://` (or from the start of a
// scheme-less DSN) to the first `/`, `?` or `#`. Its userinfo is everything
// before the LAST `@` of the authority and splits into user name and
// password at its FIRST `:`. Both are strictly percent-decoded: `%` must be
// followed by two hex digits and `+` is a literal plus. An `@` after the
// authority, a malformed escape, a fragment and port 0 are refused.
//
// parseDSN used to take the first `@` anywhere in the DSN, so a password
// holding `@` was cut short and its tail became the host the client looked
// up and dialled. The last test drives a real GeodeClient from such a DSN
// to a loopback QUIC server and proves it reaches the intended host.

const std = @import("std");
const builtin = @import("builtin");
const geode_client = @import("geode_client");
const fixture = @import("quic_echo_fixture.zig");
const config = geode_client.config;
const GeodeClient = geode_client.GeodeClient;

const testing = std.testing;

fn parse(strict: bool, dsn: []const u8) !config.Config {
    return if (strict) config.parseDSNStrict(testing.allocator, dsn) else config.parseDSN(testing.allocator, dsn);
}

fn modeName(strict: bool) []const u8 {
    return if (strict) "parseDSNStrict" else "parseDSN";
}

test "SONNY-6550: the userinfo ends at the last '@' of the authority and splits at its first ':'" {
    const Case = struct {
        dsn: []const u8,
        user: ?[]const u8,
        pass: ?[]const u8,
        host: []const u8,
        port: u16 = 3141,
        graph: ?[]const u8 = null,
        transport: config.Transport = .quic,
    };
    const cases = [_]Case{
        // No userinfo.
        .{ .dsn = "quic://localhost:3141", .user = null, .pass = null, .host = "localhost" },
        .{ .dsn = "localhost", .user = null, .pass = null, .host = "localhost" },
        .{ .dsn = "quic://[fe80::1%eth0]:3141/g", .user = null, .pass = null, .host = "fe80::1%eth0", .graph = "g" },
        // '@' in the password: never the host.
        .{ .dsn = "quic://admin:p@ss@localhost:3141", .user = "admin", .pass = "p@ss", .host = "localhost" },
        .{ .dsn = "quic://admin:s3@decoy.invalid@127.0.0.1:3141", .user = "admin", .pass = "s3@decoy.invalid", .host = "127.0.0.1" },
        .{ .dsn = "quic://admin:p@ss:w@rd@[::1]:3141/g?page_size=5", .user = "admin", .pass = "p@ss:w@rd", .host = "::1", .graph = "g" },
        .{ .dsn = "grpc://admin:p@ss@[2001:db8::1]:50051", .user = "admin", .pass = "p@ss", .host = "2001:db8::1", .port = 50051, .transport = .grpc },
        // ':' in the password.
        .{ .dsn = "quic://admin:pa:ss:wd@localhost:3141", .user = "admin", .pass = "pa:ss:wd", .host = "localhost" },
        // Percent-encoded credentials.
        .{ .dsn = "quic://user%40domain:p%40ss%3Dword@localhost:3141", .user = "user@domain", .pass = "p@ss=word", .host = "localhost" },
        .{ .dsn = "quic://us%3Aer:pw@h", .user = "us:er", .pass = "pw", .host = "h" },
        .{ .dsn = "quic://a:b+c%20d%25@h", .user = "a", .pass = "b+c d%", .host = "h" },
        .{ .dsn = "quic://a:%e2%9c%93@h", .user = "a", .pass = "\u{2713}", .host = "h" },
        .{ .dsn = "quic://a:%2F%3F%23@h", .user = "a", .pass = "/?#", .host = "h" },
        // Empty user, user only, empty password, empty userinfo.
        .{ .dsn = "quic://:secret@host:3141", .user = "", .pass = "secret", .host = "host" },
        .{ .dsn = "quic://admin@host", .user = "admin", .pass = null, .host = "host" },
        .{ .dsn = "quic://admin:@host:3141", .user = "admin", .pass = "", .host = "host" },
        .{ .dsn = "quic://@host", .user = "", .pass = null, .host = "host" },
        // Scheme-less DSNs take the same rule.
        .{ .dsn = "admin:p@ss@127.0.0.1:3141", .user = "admin", .pass = "p@ss", .host = "127.0.0.1" },
        .{ .dsn = "admin:secret@[::1]:3141/g", .user = "admin", .pass = "secret", .host = "::1", .graph = "g" },
        .{ .dsn = "secret@127.0.0.1:3141", .user = "secret", .pass = null, .host = "127.0.0.1" },
        // Query-string credentials are decoded the same way: '+' is literal.
        .{ .dsn = "h:1?username=admin&password=a%40b", .user = "admin", .pass = "a@b", .host = "h", .port = 1 },
        .{ .dsn = "h:1?user=a&pass=a+b", .user = "a", .pass = "a+b", .host = "h", .port = 1 },
        // '://' after a '/', '?' or '@' is not a scheme.
        .{ .dsn = "h:1?ca=file://x", .user = null, .pass = null, .host = "h", .port = 1 },
    };
    for (cases) |c| {
        for ([_]bool{ false, true }) |strict| {
            var cfg = parse(strict, c.dsn) catch |err| {
                std.debug.print("{s}(\"{s}\") failed: {s}\n", .{ modeName(strict), c.dsn, @errorName(err) });
                return err;
            };
            defer cfg.deinit(testing.allocator);
            errdefer std.debug.print("{s}(\"{s}\") parsed wrong: host={s} user={?s} pass={?s}\n", .{ modeName(strict), c.dsn, cfg.host, cfg.username, cfg.password });
            try testing.expectEqualStrings(c.host, cfg.host);
            try testing.expectEqual(c.port, cfg.port);
            try testing.expectEqual(c.transport, cfg.transport);
            if (c.user) |u| try testing.expectEqualStrings(u, cfg.username orelse return error.UserMissing) else try testing.expect(cfg.username == null);
            if (c.pass) |p| try testing.expectEqualStrings(p, cfg.password orelse return error.PasswordMissing) else try testing.expect(cfg.password == null);
            if (c.graph) |g| try testing.expectEqualStrings(g, cfg.graph orelse return error.GraphMissing) else try testing.expect(cfg.graph == null);
        }
    }
}

fn expectRefused(want: anyerror, dsn: []const u8) !void {
    for ([_]bool{ false, true }) |strict| {
        const result = parse(strict, dsn);
        if (result) |cfg_const| {
            var cfg = cfg_const;
            std.debug.print("{s}(\"{s}\") was accepted (host={s} port={d}), want {s}\n", .{ modeName(strict), dsn, cfg.host, cfg.port, @errorName(want) });
            cfg.deinit(testing.allocator);
            return error.TestExpectedError;
        } else |err| {
            if (err != want) {
                std.debug.print("{s}(\"{s}\") failed with {s}, want {s}\n", .{ modeName(strict), dsn, @errorName(err), @errorName(want) });
                return error.TestUnexpectedError;
            }
        }
    }
}

test "SONNY-6550: an '@' after the authority is InvalidDSN, never part of the host" {
    for ([_][]const u8{
        // An unencoded '/', '?' or '#' in a password ends the authority.
        "quic://admin:pa/ss@host:3141",
        "quic://admin:pa?ss@host:3141",
        "quic://admin:pa#ss@host:3141",
        "admin:pa/ss@host:3141",
        // An '@' in the path or the query.
        "quic://h:1/g@x",
        "quic://h:1?hello_name=me@x",
        "h:1?password=a@b",
        "quic://admin:secret@h:1/g?user=a@b",
    }) |dsn| try expectRefused(error.InvalidDSN, dsn);
}

test "SONNY-6550: a malformed percent-escape is InvalidDSN, in the userinfo or the query" {
    for ([_][]const u8{
        "quic://a:%@h",
        "quic://a:%4@h",
        "quic://a:%zz@h",
        "quic://a:b%g1@h",
        "quic://a%:b@h",
        "quic://a:%%41@h",
        "quic://a:50%off@h",
        "a:50%off@h:1",
        "h:1?password=50%off",
        "h:1?hello_name=%",
        "h:1?graph=%G0",
    }) |dsn| try expectRefused(error.InvalidDSN, dsn);
}

test "SONNY-6550: a fragment is InvalidDSN" {
    for ([_][]const u8{ "quic://h:1#x", "quic://h:1/g#x", "quic://h:1?a=b#x", "h#x" }) |dsn| try expectRefused(error.InvalidDSN, dsn);
}

test "SONNY-6550: port 0 is InvalidPort in both modes" {
    for ([_][]const u8{ "h:0", "h:00000", "quic://h:0", "quic://admin:pw@h:0/g", "[::1]:0", "grpc://[::1]:0", "admin:pw@h:0" }) |dsn| try expectRefused(error.InvalidPort, dsn);
}

test "SONNY-6550: toDSN percent-encodes credentials so parseDSN reads them back" {
    const creds = [_][2][]const u8{
        .{ "admin", "p@ss" },
        .{ "us:er@x", "a:b:c" },
        .{ "u", "/?#[]" },
        .{ "u", "%41%" },
        .{ "u", "a+b c&d=e" },
        .{ "", "pw" },
        .{ "u", "" },
        .{ "\x00\xff", "\u{2713}\x7f" },
    };
    for (creds) |c| {
        var cfg = config.Config.initWithHost("::1", 3141);
        _ = try cfg.withCredentials(testing.allocator, c[0], c[1]);
        defer cfg.deinit(testing.allocator);
        _ = try cfg.withGraph(testing.allocator, "g/@?#&=+%");
        const dsn = try cfg.toDSN(testing.allocator);
        defer testing.allocator.free(dsn);
        for ([_]bool{ false, true }) |strict| {
            var back = parse(strict, dsn) catch |err| {
                std.debug.print("{s}(toDSN(user=\"{s}\" pass=\"{s}\") = \"{s}\") failed: {s}\n", .{ modeName(strict), c[0], c[1], dsn, @errorName(err) });
                return err;
            };
            defer back.deinit(testing.allocator);
            try testing.expectEqualStrings("::1", back.host);
            try testing.expectEqualStrings(c[0], back.username.?);
            try testing.expectEqualStrings(c[1], back.password.?);
            try testing.expectEqualStrings("g/@?#&=+%", back.graph.?);
        }
    }
}

/// Wraps the testing allocator and counts freed buffers that still hold one
/// of `needles`. Shrinking in place is refused and remap is declined, so
/// every buffer the code under test gives back passes `free`.
const FreedSecretScanner = struct {
    child: std.mem.Allocator,
    needles: []const []const u8,
    hits: usize = 0,

    fn allocator(self: *FreedSecretScanner) std.mem.Allocator {
        return .{ .ptr = self, .vtable = &.{ .alloc = alloc, .resize = resize, .remap = remap, .free = free } };
    }

    fn alloc(ctx: *anyopaque, len: usize, alignment: std.mem.Alignment, ra: usize) ?[*]u8 {
        const self: *FreedSecretScanner = @ptrCast(@alignCast(ctx));
        return self.child.rawAlloc(len, alignment, ra);
    }

    fn resize(ctx: *anyopaque, memory: []u8, alignment: std.mem.Alignment, new_len: usize, ra: usize) bool {
        const self: *FreedSecretScanner = @ptrCast(@alignCast(ctx));
        if (new_len < memory.len) return false;
        return self.child.rawResize(memory, alignment, new_len, ra);
    }

    fn remap(_: *anyopaque, _: []u8, _: std.mem.Alignment, _: usize, _: usize) ?[*]u8 {
        return null;
    }

    fn free(ctx: *anyopaque, memory: []u8, alignment: std.mem.Alignment, ra: usize) void {
        const self: *FreedSecretScanner = @ptrCast(@alignCast(ctx));
        for (self.needles) |needle| {
            if (std.mem.indexOf(u8, memory, needle) != null) {
                self.hits += 1;
                break;
            }
        }
        self.child.rawFree(memory, alignment, ra);
    }
};

// The decoded credentials; the DSNs below spell them with an escape, so the
// DSN text itself never holds them.
const user_needle = "user-needle-6550";
const pass_needle = "pass-needle-6550";

test "SONNY-6550: no freed buffer keeps a decoded user name or password" {
    const dsns = [_][]const u8{
        "quic://u%73er-needle-6550:p%61ss-needle-6550@h:1",
        "quic://u%73er-needle-6550:p%61ss-needle-6550@h:1?page_size=5",
        // Given twice: the first copy is freed when the second replaces it.
        "h:1?user=u%73er-needle-6550&password=p%61ss-needle-6550&password=p%61ss-needle-6550&user=u%73er-needle-6550",
        "quic://u%73er-needle-6550:p%61ss-needle-6550@h:1?user=u%73er-needle-6550&pass=p%61ss-needle-6550",
    };
    for (dsns) |dsn| {
        var scanner: FreedSecretScanner = .{ .child = testing.allocator, .needles = &.{ user_needle, pass_needle } };
        const a = scanner.allocator();
        var cfg = try config.parseDSN(a, dsn);
        try testing.expectEqualStrings(user_needle, cfg.username.?);
        try testing.expectEqualStrings(pass_needle, cfg.password.?);
        cfg.deinit(a);
        testing.expectEqual(@as(usize, 0), scanner.hits) catch |err| {
            std.debug.print("parseDSN(\"{s}\") + deinit left {d} freed buffer(s) holding a credential\n", .{ dsn, scanner.hits });
            return err;
        };
    }
    // A DSN refused after its credentials were decoded frees them zeroed.
    for ([_][]const u8{
        "quic://u%73er-needle-6550:p%61ss-needle-6550@h:http",
        "quic://u%73er-needle-6550:p%61ss-needle-6550@h:1?password=%G0",
        "quic://u%73er-needle-6550:p%61ss-needle-6550@h:0",
    }) |dsn| {
        var scanner: FreedSecretScanner = .{ .child = testing.allocator, .needles = &.{ user_needle, pass_needle } };
        if (config.parseDSNStrict(scanner.allocator(), dsn)) |cfg_const| {
            var cfg = cfg_const;
            cfg.deinit(scanner.allocator());
            std.debug.print("parseDSNStrict(\"{s}\") was accepted\n", .{dsn});
            return error.TestExpectedError;
        } else |_| {}
        testing.expectEqual(@as(usize, 0), scanner.hits) catch |err| {
            std.debug.print("refused parseDSNStrict(\"{s}\") left {d} freed buffer(s) holding a credential\n", .{ dsn, scanner.hits });
            return err;
        };
    }
    // Replacing credentials zeroes the old ones.
    {
        var scanner: FreedSecretScanner = .{ .child = testing.allocator, .needles = &.{ user_needle, pass_needle } };
        const a = scanner.allocator();
        var cfg = config.Config.init();
        _ = try cfg.withCredentials(a, user_needle, pass_needle);
        _ = try cfg.withCredentials(a, "other", "other");
        cfg.deinit(a);
        try testing.expectEqual(@as(usize, 0), scanner.hits);
    }
}

test "SONNY-6550: a password holding '@' does not redirect the client (real QUIC dial)" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var pki = try fixture.makePki();
    defer pki.deinit();
    var server: fixture.EchoServer = undefined;
    try fixture.startServer(&server, "127.0.0.1:0", &pki);
    defer server.stop();

    // The password's tail ("decoy.invalid") is what the old parser took for
    // the host and handed to the resolver.
    const forms = [_][]const u8{
        "quic://admin:s3@decoy.invalid@127.0.0.1:{d}/g?ca={s}",
        "admin:s3@decoy.invalid@127.0.0.1:{d}/g?ca={s}",
    };
    inline for (forms) |form| {
        const dsn = try std.fmt.allocPrint(testing.allocator, form, .{ server.port(), pki.ca_path });
        defer testing.allocator.free(dsn);
        var cfg = try config.parseDSNStrict(testing.allocator, dsn);
        defer cfg.deinit(testing.allocator);
        try testing.expectEqualStrings("127.0.0.1", cfg.host);
        try testing.expectEqualStrings("admin", cfg.username.?);
        try testing.expectEqualStrings("s3@decoy.invalid", cfg.password.?);
        var client = try GeodeClient.initFromConfig(testing.allocator, cfg);
        defer client.deinit();
        try testing.expectEqualStrings("127.0.0.1", client.host);
        try fixture.roundTrip(&client);
    }
}
