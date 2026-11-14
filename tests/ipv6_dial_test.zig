// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// SONNY-6494: a GeodeClient reaches a QUIC server on an IPv6 address.
//
// GeodeClient bound its endpoint to 0.0.0.0:0 whatever the destination and
// formatted the dial address as "{host}:{port}" without brackets, so `::1`
// became the unparseable "::1:3141" and an IPv6 server was unreachable.
//
// Each test runs a real QUIC server endpoint from the vendored quic library
// on loopback (a CA-signed certificate made by openssl, carrying IP SANs for
// ::1 and 127.0.0.1) that echoes every byte it reads, and drives the real
// GeodeClient through connect -> sendRawFramed -> receiveRawFrame with
// certificate verification ON. This proves the transport path (endpoint
// family, dial address, TLS name check against an IPv6 IP SAN, stream round
// trip). It does not run a geode server, so HELLO/query handling over IPv6
// is covered by geode's own tests once it pins this library.
//
// Skipped (with a message) when openssl is missing or the host cannot bind
// ::1.

const std = @import("std");
const builtin = @import("builtin");
const geode_client = @import("geode_client");
const fixture = @import("quic_echo_fixture.zig");
const GeodeClient = geode_client.GeodeClient;
const Pki = fixture.Pki;
const EchoServer = fixture.EchoServer;
const makePki = fixture.makePki;
const startServer = fixture.startServer;
const roundTrip = fixture.roundTrip;
const verifyingClient = fixture.verifyingClient;

const Families = struct { ip4: bool, ip6: bool };

/// Which address families `name` resolves to.
fn lookupFamilies(name: []const u8) !Families {
    var threaded: std.Io.Threaded = .init_single_threaded;
    threaded.allocator = std.testing.allocator;
    defer threaded.deinit();
    const tio = threaded.io();
    const host = try std.Io.net.HostName.init(name);
    var storage: [32]std.Io.net.HostName.LookupResult = undefined;
    var results: std.Io.Queue(std.Io.net.HostName.LookupResult) = .init(&storage);
    host.lookup(tio, &results, .{ .port = 0, .family = null }) catch return .{ .ip4 = false, .ip6 = false };
    var out: Families = .{ .ip4 = false, .ip6 = false };
    while (results.getOne(tio)) |r| switch (r) {
        .address => |a| switch (a) {
            .ip4 => out.ip4 = true,
            .ip6 => out.ip6 = true,
        },
        .canonical_name => {},
    } else |_| {}
    return out;
}

test "SONNY-6494: a GeodeClient round-trips over QUIC to a server on [::1]" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var pki = try makePki();
    defer pki.deinit();
    var server: EchoServer = undefined;
    try startServer(&server, "[::1]:0", &pki);
    defer server.stop();

    // Both spellings a caller can hand the client: the DSN form leaves the
    // host unbracketed (parseDSN strips the brackets).
    for ([_][]const u8{ "::1", "[::1]" }) |host| {
        var client = try verifyingClient(host, server.port(), &pki);
        defer client.deinit();
        try roundTrip(&client);
    }
}

test "SONNY-6494: a DSN with an IPv6 host reaches the server" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var pki = try makePki();
    defer pki.deinit();
    var server: EchoServer = undefined;
    try startServer(&server, "[::1]:0", &pki);
    defer server.stop();

    const dsn = try std.fmt.allocPrint(std.testing.allocator, "quic://[::1]:{d}/g?ca={s}", .{ server.port(), pki.ca_path });
    defer std.testing.allocator.free(dsn);
    var cfg = try geode_client.config.parseDSNStrict(std.testing.allocator, dsn);
    defer cfg.deinit(std.testing.allocator);
    var client = try GeodeClient.initFromConfig(std.testing.allocator, cfg);
    defer client.deinit();
    try roundTrip(&client);
}

test "SONNY-6494: an IPv4 destination still works (127.0.0.1)" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    var pki = try makePki();
    defer pki.deinit();
    var server: EchoServer = undefined;
    try startServer(&server, "127.0.0.1:0", &pki);
    defer server.stop();
    var client = try verifyingClient("127.0.0.1", server.port(), &pki);
    defer client.deinit();
    try roundTrip(&client);
}

test "SONNY-6494: a host name with only an IPv6 address falls back to IPv6" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;
    // Debian/Ubuntu /etc/hosts maps ip6-localhost to ::1 only.
    const name = "ip6-localhost";
    const fam = try lookupFamilies(name);
    if (!fam.ip6 or fam.ip4) {
        std.debug.print("SKIP: '{s}' does not resolve to IPv6 only here (ip4={}, ip6={})\n", .{ name, fam.ip4, fam.ip6 });
        return error.SkipZigTest;
    }
    var pki = try makePki();
    defer pki.deinit();
    var server: EchoServer = undefined;
    try startServer(&server, "[::1]:0", &pki);
    defer server.stop();

    var client = try verifyingClient(name, server.port(), &pki);
    defer client.deinit();
    // An endpoint made before the destination is known (the IPv4 guess for
    // a name) is rebuilt for the family the name resolves to.
    try client.ensureEndpoint();
    try roundTrip(&client);
}
