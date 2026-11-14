// SPDX-License-Identifier: Apache-2.0
//! The address a GeodeClient dials over QUIC, and the endpoint family it
//! needs (SONNY-6494).
//!
//! The vendored quic library dials a numeric `ip:port` / `[ipv6]:port` from
//! a socket of one address family, so the client resolves the host itself:
//!
//!   - an IPv4 literal is dialled as written, from an IPv4 endpoint;
//!   - an IPv6 literal (brackets optional) is dialled as `[ipv6]:port` from
//!     an IPv6 endpoint; a zone (`fe80::1%eth0`) is refused with
//!     error.Ipv6ZoneUnsupported, because the quic dialer cannot parse one;
//!   - a host name is looked up in both families (hosts file and DNS); the
//!     first IPv4 address wins, otherwise the first IPv6 address.
//!
//! geode's src/client/quic_endpoint_host.zig makes the same choice for the
//! CLI. The TLS server name stays the host the caller gave.
const std = @import("std");

pub const Family = enum { ip4, ip6 };

/// The wildcard bind address of an endpoint that dials `family`.
pub fn bindAddress(family: Family) []const u8 {
    return switch (family) {
        .ip4 => "0.0.0.0:0",
        .ip6 => "[::]:0",
    };
}

/// `host` without surrounding brackets (`[::1]` -> `::1`).
pub fn unbracket(host: []const u8) []const u8 {
    if (host.len >= 2 and host[0] == '[' and host[host.len - 1] == ']') return host[1 .. host.len - 1];
    return host;
}

fn isIpv6Literal(text: []const u8) bool {
    return switch (std.Io.net.Ip6Address.Unresolved.parse(text)) {
        .success => true,
        else => false,
    };
}

/// The family of an address literal, or null for a host name.
pub fn literalFamily(host: []const u8) ?Family {
    const h = unbracket(host);
    if (std.Io.net.Ip4Address.parse(h, 0)) |_| return .ip4 else |_| {}
    if (isIpv6Literal(h)) return .ip6;
    return null;
}

pub const DialHost = struct {
    /// Numeric address, without brackets.
    ip: []u8,
    family: Family,

    pub fn deinit(self: *DialHost, allocator: std.mem.Allocator) void {
        allocator.free(self.ip);
        self.* = undefined;
    }

    /// `ip:port`, or `[ip]:port` for IPv6: what quic.connect parses.
    pub fn formatAlloc(self: DialHost, allocator: std.mem.Allocator, port: u16) ![]u8 {
        return switch (self.family) {
            .ip4 => std.fmt.allocPrint(allocator, "{s}:{d}", .{ self.ip, port }),
            .ip6 => std.fmt.allocPrint(allocator, "[{s}]:{d}", .{ self.ip, port }),
        };
    }
};

/// Resolve `host` (see the module comment). The caller owns the result.
pub fn resolveAlloc(allocator: std.mem.Allocator, host: []const u8) !DialHost {
    // A private single-threaded Io with an allocator for the resolver: the
    // global one uses a failing allocator, and a transient Threaded.init
    // would install and restore process-wide signal handlers.
    var threaded: std.Io.Threaded = .init_single_threaded;
    threaded.allocator = allocator;
    defer threaded.deinit();
    return resolveWithIoAlloc(allocator, threaded.io(), host);
}

pub fn resolveWithIoAlloc(allocator: std.mem.Allocator, io: std.Io, host: []const u8) !DialHost {
    const h = unbracket(host);
    if (literalFamily(h)) |family| {
        if (family == .ip6 and std.mem.indexOfScalar(u8, h, '%') != null) return error.Ipv6ZoneUnsupported;
        return .{ .ip = try allocator.dupe(u8, h), .family = family };
    }

    const name = try std.Io.net.HostName.init(h);
    var storage: [32]std.Io.net.HostName.LookupResult = undefined;
    var results: std.Io.Queue(std.Io.net.HostName.LookupResult) = .init(&storage);
    // A queue of 32 cannot make this synchronous lookup block.
    try name.lookup(io, &results, .{ .port = 0, .family = null });
    var first_ip6: ?[16]u8 = null;
    while (results.getOne(io)) |result| switch (result) {
        .address => |address| switch (address) {
            .ip4 => |ip| return .{
                .ip = try std.fmt.allocPrint(allocator, "{d}.{d}.{d}.{d}", .{ ip.bytes[0], ip.bytes[1], ip.bytes[2], ip.bytes[3] }),
                .family = .ip4,
            },
            .ip6 => |ip| {
                if (first_ip6 == null) first_ip6 = ip.bytes;
            },
        },
        .canonical_name => continue,
    } else |err| switch (err) {
        error.Canceled => return error.Canceled,
        error.Closed => {},
    }
    const bytes = first_ip6 orelse return error.NoAddressReturned;
    const text: std.Io.net.Ip6Address.Unresolved = .{ .bytes = bytes, .interface_name = null };
    return .{ .ip = try std.fmt.allocPrint(allocator, "{f}", .{text}), .family = .ip6 };
}

// ---------------------------------------------------------------------------
// Tests (the real system resolver; a name the host does not map is skipped)
// ---------------------------------------------------------------------------

fn expectResolved(host: []const u8, ip: []const u8, family: Family) !void {
    var got = try resolveAlloc(std.testing.allocator, host);
    defer got.deinit(std.testing.allocator);
    try std.testing.expectEqualStrings(ip, got.ip);
    try std.testing.expectEqual(family, got.family);
}

test "literals are dialled as written, from an endpoint of their family" {
    try expectResolved("127.0.0.1", "127.0.0.1", .ip4);
    try expectResolved("192.0.2.10", "192.0.2.10", .ip4);
    try expectResolved("::1", "::1", .ip6);
    try expectResolved("[::1]", "::1", .ip6);
    try expectResolved("2001:db8::1", "2001:db8::1", .ip6);
    try std.testing.expectError(error.Ipv6ZoneUnsupported, resolveAlloc(std.testing.allocator, "fe80::1%lo"));
    try std.testing.expectError(error.Ipv6ZoneUnsupported, resolveAlloc(std.testing.allocator, "[fe80::1%lo]"));
}

test "dial and bind addresses are bracketed for IPv6" {
    var v4: DialHost = .{ .ip = try std.testing.allocator.dupe(u8, "127.0.0.1"), .family = .ip4 };
    defer v4.deinit(std.testing.allocator);
    var v6: DialHost = .{ .ip = try std.testing.allocator.dupe(u8, "::1"), .family = .ip6 };
    defer v6.deinit(std.testing.allocator);
    const a4 = try v4.formatAlloc(std.testing.allocator, 3141);
    defer std.testing.allocator.free(a4);
    const a6 = try v6.formatAlloc(std.testing.allocator, 3141);
    defer std.testing.allocator.free(a6);
    try std.testing.expectEqualStrings("127.0.0.1:3141", a4);
    try std.testing.expectEqualStrings("[::1]:3141", a6);
    try std.testing.expectEqualStrings("0.0.0.0:0", bindAddress(.ip4));
    try std.testing.expectEqualStrings("[::]:0", bindAddress(.ip6));
    try std.testing.expectEqual(@as(?Family, null), literalFamily("localhost"));
}

const Families = struct { ip4: ?[]const u8 = null, ip6: bool = false };

/// Look `name` up independently: the first IPv4 address (formatted), and
/// whether any IPv6 address came back.
fn families(buf: []u8, name: []const u8) !Families {
    var threaded: std.Io.Threaded = .init_single_threaded;
    threaded.allocator = std.testing.allocator;
    defer threaded.deinit();
    const tio = threaded.io();
    const host = try std.Io.net.HostName.init(name);
    var storage: [32]std.Io.net.HostName.LookupResult = undefined;
    var results: std.Io.Queue(std.Io.net.HostName.LookupResult) = .init(&storage);
    host.lookup(tio, &results, .{ .port = 0, .family = null }) catch return .{};
    var out: Families = .{};
    while (results.getOne(tio)) |r| switch (r) {
        .address => |a| switch (a) {
            .ip4 => |ip| if (out.ip4 == null) {
                out.ip4 = try std.fmt.bufPrint(buf, "{d}.{d}.{d}.{d}", .{ ip.bytes[0], ip.bytes[1], ip.bytes[2], ip.bytes[3] });
            },
            .ip6 => out.ip6 = true,
        },
        .canonical_name => {},
    } else |_| {}
    return out;
}

test "a host name prefers its IPv4 address" {
    var buf: [16]u8 = undefined;
    const fam = try families(&buf, "localhost");
    const want = fam.ip4 orelse return error.SkipZigTest;
    try expectResolved("localhost", want, .ip4);
}

test "a host name with only IPv6 addresses falls back to IPv6" {
    var buf: [16]u8 = undefined;
    // Debian/Ubuntu /etc/hosts maps ip6-localhost to ::1 only.
    const fam = try families(&buf, "ip6-localhost");
    if (fam.ip4 != null or !fam.ip6) return error.SkipZigTest;
    try expectResolved("ip6-localhost", "::1", .ip6);
}
