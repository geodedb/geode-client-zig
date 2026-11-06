// SPDX-License-Identifier: Apache-2.0
//! Owned, bounded CA material for the native QUIC client. A path string is
//! not consumed by the TLS context; its DER anchors must outlive the endpoint.
const std = @import("std");
const quic = @import("quic");

pub const max_file_bytes = 1024 * 1024;
pub const max_certificates = 32;

pub fn deinit(allocator: std.mem.Allocator, chain: []const []const u8) void {
    for (chain) |certificate| allocator.free(certificate);
    allocator.free(chain);
}

pub fn load(allocator: std.mem.Allocator, path: []const u8) ![]const []const u8 {
    const io = std.Io.Threaded.global_single_threaded.io();
    const data = try std.Io.Dir.cwd().readFileAlloc(io, path, allocator, .limited(max_file_bytes));
    defer allocator.free(data);
    return parse(allocator, data);
}

pub fn parse(allocator: std.mem.Allocator, data: []const u8) ![]const []const u8 {
    if (data.len > max_file_bytes) return error.CaBundleTooLarge;
    var chain = std.ArrayList([]const u8).empty;
    errdefer {
        for (chain.items) |certificate| allocator.free(certificate);
        chain.deinit(allocator);
    }
    const begin = "-----BEGIN CERTIFICATE-----";
    const end = "-----END CERTIFICATE-----";
    var offset: usize = 0;
    while (std.mem.indexOfPos(u8, data, offset, begin)) |start| {
        if (chain.items.len == max_certificates) return error.TooManyCaCertificates;
        const stop = std.mem.indexOfPos(u8, data, start + begin.len, end) orelse return error.InvalidCaBundle;
        const next = stop + end.len;
        const certificate = try quic.pem.parseCertificate(allocator, data[start..next]);
        errdefer allocator.free(certificate);
        if (certificate.len == 0) return error.InvalidCaBundle;
        try chain.append(allocator, certificate);
        offset = next;
    }
    if (chain.items.len == 0) return error.NoCaCertificates;
    return chain.toOwnedSlice(allocator);
}

test "CA bundles own every decoded certificate and reject partial material" {
    const allocator = std.testing.allocator;
    const first = "-----BEGIN CERTIFICATE-----\nAQID\n-----END CERTIFICATE-----\n";
    const second = "-----BEGIN CERTIFICATE-----\nBAUG\n-----END CERTIFICATE-----\n";
    const chain = try parse(allocator, first ++ second);
    defer deinit(allocator, chain);
    try std.testing.expectEqual(@as(usize, 2), chain.len);
    try std.testing.expectEqualSlices(u8, &.{ 1, 2, 3 }, chain[0]);
    try std.testing.expectEqualSlices(u8, &.{ 4, 5, 6 }, chain[1]);
    try std.testing.expectError(error.NoCaCertificates, parse(allocator, ""));
    try std.testing.expectError(error.InvalidCaBundle, parse(allocator, first ++ "-----BEGIN CERTIFICATE-----\nAQID"));
    try std.testing.expectError(error.TooManyCaCertificates, parse(allocator, first ** (max_certificates + 1)));
    try std.testing.expectError(error.CaBundleTooLarge, parse(allocator, "x" ** (max_file_bytes + 1)));
}
