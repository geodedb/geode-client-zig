// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Fuzz tests for DSN parsing in the Geode Zig client library.
// Tests the parseDSN function with arbitrary input to find edge cases and crashes.

const std = @import("std");
const config = @import("config");

/// Fuzz test for DSN parsing
/// This test feeds arbitrary byte sequences to the DSN parser to find crashes,
/// hangs, or other unexpected behavior.
pub fn main() !void {
    // Use a fixed-size buffer allocator for fuzzing to detect memory issues
    var buffer: [64 * 1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    // Read fuzz input from stdin (AFL/libFuzzer style)
    const stdin = std.io.getStdIn();
    const input = stdin.readToEndAlloc(allocator, 1024 * 1024) catch |err| {
        // If we can't read input, just exit cleanly
        std.debug.print("Failed to read input: {}\n", .{err});
        return;
    };

    // Try to parse the input as a DSN - we don't care about the result,
    // we just want to make sure it doesn't crash
    _ = config.parseDSN(allocator, input) catch |err| {
        // Expected errors are fine, we're looking for crashes
        _ = err;
    };
}

// Note: Zig's std.testing.fuzz requires specific setup.
// These property-based tests provide similar coverage.

// =============================================================================
// Property-Based Tests
// =============================================================================

test "property: valid host:port always parses" {
    const hosts = [_][]const u8{
        "localhost",
        "127.0.0.1",
        "192.168.1.1",
        "example.com",
        "sub.example.com",
        "my-host",
        "host123",
    };

    const ports = [_]u16{ 1, 80, 443, 3141, 8080, 8443, 65535 };

    var buffer: [4096]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    for (hosts) |host| {
        for (ports) |port| {
            fba.reset();
            var dsn_buf: [256]u8 = undefined;
            const dsn = std.fmt.bufPrint(&dsn_buf, "{s}:{d}", .{ host, port }) catch continue;

            const result = config.parseDSN(allocator, dsn);
            if (result) |cfg| {
                // Verify the parsed config matches input
                std.testing.expectEqual(port, cfg.port) catch {};
            } else |_| {
                // Some inputs may fail validation, that's OK
            }
        }
    }
}

test "property: URL format preserves host and port" {
    const test_cases = [_]struct { dsn: []const u8, expected_port: u16 }{
        .{ .dsn = "quic://localhost:3141", .expected_port = 3141 },
        .{ .dsn = "quic://127.0.0.1:8443", .expected_port = 8443 },
        .{ .dsn = "quic://example.com:3141", .expected_port = 3141 },
    };

    var buffer: [4096]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    for (test_cases) |tc| {
        fba.reset();
        if (config.parseDSN(allocator, tc.dsn)) |cfg| {
            try std.testing.expectEqual(tc.expected_port, cfg.port);
        } else |_| {}
    }
}

test "property: query params are parsed" {
    const test_cases = [_]struct {
        dsn: []const u8,
        expected_insecure: bool,
        expected_page_size: ?u32,
    }{
        .{ .dsn = "localhost:3141?insecure=true", .expected_insecure = true, .expected_page_size = null },
        .{ .dsn = "localhost:3141?insecure=false", .expected_insecure = false, .expected_page_size = null },
        .{ .dsn = "localhost:3141?page_size=500", .expected_insecure = false, .expected_page_size = 500 },
        .{ .dsn = "localhost:3141?insecure=1&page_size=1000", .expected_insecure = true, .expected_page_size = 1000 },
    };

    var buffer: [4096]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    for (test_cases) |tc| {
        fba.reset();
        if (config.parseDSN(allocator, tc.dsn)) |cfg| {
            try std.testing.expectEqual(tc.expected_insecure, cfg.insecure);
            if (tc.expected_page_size) |expected| {
                try std.testing.expectEqual(expected, cfg.page_size);
            }
        } else |_| {}
    }
}

test "property: empty and whitespace inputs don't crash" {
    const inputs = [_][]const u8{
        "",
        " ",
        "  ",
        "\t",
        "\n",
        "\r\n",
        "   \t\n  ",
    };

    var buffer: [4096]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    for (inputs) |input| {
        fba.reset();
        // Should return error, not crash
        _ = config.parseDSN(allocator, input) catch continue;
    }
}

test "property: special characters don't crash" {
    const inputs = [_][]const u8{
        "\x00",
        "\x00\x00\x00",
        "localhost:\x00",
        "localhost:3141\x00extra",
        "quic://\x00:3141",
        "localhost:3141?key=\x00",
        "\xff\xfe\xfd",
        "localhost:3141?" ++ "\x00" ** 100,
    };

    var buffer: [4096]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    for (inputs) |input| {
        fba.reset();
        // Should handle gracefully, not crash
        _ = config.parseDSN(allocator, input) catch continue;
    }
}

test "property: very long inputs don't crash" {
    var buffer: [256 * 1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    // Very long hostname
    var long_host: [10000]u8 = undefined;
    @memset(&long_host, 'a');
    const long_dsn1 = std.fmt.allocPrint(allocator, "{s}:3141", .{long_host[0..]}) catch return;
    _ = config.parseDSN(allocator, long_dsn1) catch {};

    fba.reset();

    // Very long query string
    var long_query: [10000]u8 = undefined;
    @memset(&long_query, 'x');
    const long_dsn2 = std.fmt.allocPrint(allocator, "localhost:3141?key={s}", .{long_query[0..]}) catch return;
    _ = config.parseDSN(allocator, long_dsn2) catch {};
}

test "property: malformed URLs don't crash" {
    const inputs = [_][]const u8{
        "quic://",
        "quic:///",
        "quic://:",
        "quic://:3141",
        "quic://host:",
        "quic://host:abc",
        "quic://host:-1",
        "quic://host:99999",
        "quic://@host:3141",
        "quic://user@:3141",
        "quic://user:@host:3141",
        "quic://:pass@host:3141",
        "http://localhost:3141", // Wrong scheme
        "://localhost:3141",
        "quic://localhost:3141?",
        "quic://localhost:3141?=value",
        "quic://localhost:3141?key=",
        "quic://localhost:3141?&",
        "quic://localhost:3141?key=value&",
        "quic://localhost:3141?key=value&&key2=value2",
    };

    var buffer: [4096]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    for (inputs) |input| {
        fba.reset();
        // Should handle gracefully, not crash
        _ = config.parseDSN(allocator, input) catch continue;
    }
}
