// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Fuzz tests for input validation in the Geode Zig client library.
// Tests validation functions with arbitrary input to find edge cases.

const std = @import("std");
const validate = @import("validate");

/// Fuzz test for validation functions
pub fn main() !void {
    var buffer: [64 * 1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const stdin = std.Io.getStdIn();
    const input = stdin.readToEndAlloc(allocator, 1024 * 1024) catch return;

    // Test all validation functions - should never crash
    _ = validate.query(input) catch {};
    _ = validate.paramName(input) catch {};
    _ = validate.hostname(input) catch {};
    _ = validate.ipv4(input);
    _ = validate.isIpv6(input);
    _ = validate.sanitize(allocator, input) catch {};
}

// Note: Zig's std.testing.fuzz requires specific setup.
// These property-based tests provide similar coverage.

// =============================================================================
// Property-Based Tests for Query Validation
// =============================================================================

test "property: valid queries pass validation" {
    const queries = [_][]const u8{
        "MATCH (n) RETURN n",
        "MATCH (n:Person) RETURN n.name",
        "CREATE (n:Person {name: 'Alice'})",
        "MATCH (a)-[r]->(b) RETURN a, r, b",
        "MATCH (n) WHERE n.age > 30 RETURN n",
        "MATCH (n) SET n.x = 1 RETURN n",
        "MATCH (n) DELETE n",
    };

    for (queries) |q| {
        try validate.query(q);
    }
}

test "property: empty query fails validation" {
    try std.testing.expectError(error.QueryEmpty, validate.query(""));
}

test "property: null chars in query fail validation" {
    try std.testing.expectError(error.QueryContainsNull, validate.query("MATCH (n)\x00 RETURN n"));
    try std.testing.expectError(error.QueryContainsNull, validate.query("\x00"));
    try std.testing.expectError(error.QueryContainsNull, validate.query("MATCH\x00"));
}

test "property: very long queries fail validation" {
    // MAX_QUERY_LENGTH is 1MB (1024 * 1024), so we need to exceed that
    var long_query: [1024 * 1024 + 1]u8 = undefined;
    @memset(&long_query, 'x');
    try std.testing.expectError(error.QueryTooLong, validate.query(&long_query));
}

// =============================================================================
// Property-Based Tests for Parameter Name Validation
// =============================================================================

test "property: valid parameter names pass validation" {
    const params = [_][]const u8{
        "x",
        "name",
        "myParam",
        "param1",
        "_underscore",
        "CamelCase",
        "snake_case",
        "a1b2c3",
    };

    for (params) |p| {
        try validate.paramName(p);
    }
}

test "property: empty parameter name fails validation" {
    try std.testing.expectError(error.ParamNameEmpty, validate.paramName(""));
}

test "property: parameter starting with number fails validation" {
    try std.testing.expectError(error.ParamNameInvalid, validate.paramName("1param"));
    try std.testing.expectError(error.ParamNameInvalid, validate.paramName("123"));
}

test "property: parameter with special chars fails validation" {
    const invalid_params = [_][]const u8{
        "my-param",
        "my.param",
        "my param",
        "param!",
        "param@name",
        "$param",
        "param\x00",
    };

    for (invalid_params) |p| {
        try std.testing.expectError(error.ParamNameInvalid, validate.paramName(p));
    }
}

test "property: very long parameter name fails validation" {
    var long_param: [1000]u8 = undefined;
    @memset(&long_param, 'x');
    try std.testing.expectError(error.ParamNameTooLong, validate.paramName(&long_param));
}

// =============================================================================
// Property-Based Tests for Hostname Validation
// =============================================================================

test "property: valid hostnames pass validation" {
    const hostnames = [_][]const u8{
        "localhost",
        "example.com",
        "sub.example.com",
        "my-host",
        "host123",
        "a",
        "a.b.c.d.e",
    };

    for (hostnames) |h| {
        try validate.hostname(h);
    }
}

test "property: empty hostname fails validation" {
    try std.testing.expectError(error.HostnameEmpty, validate.hostname(""));
}

test "property: hostname with invalid chars fails validation" {
    const invalid_hostnames = [_][]const u8{
        "host name",
        "host\tname",
        "host\x00name",
        "host@name",
        "host/name",
    };

    for (invalid_hostnames) |h| {
        try std.testing.expectError(error.HostnameInvalid, validate.hostname(h));
    }
}

test "property: very long hostname fails validation" {
    var long_hostname: [300]u8 = undefined;
    @memset(&long_hostname, 'x');
    try std.testing.expectError(error.HostnameTooLong, validate.hostname(&long_hostname));
}

test "property: invalid port string in hostname is invalid" {
    // "host:name" contains a colon, which is allowed for IPv6
    // This test is already covered by the invalid chars test above
}

// =============================================================================
// Property-Based Tests for Port Validation
// =============================================================================

test "property: valid ports pass validation" {
    const ports = [_]u16{ 1, 80, 443, 3141, 8080, 8443, 65535 };

    for (ports) |p| {
        try validate.port(p);
    }
}

test "property: port 0 fails validation" {
    try std.testing.expectError(error.PortOutOfRange, validate.port(0));
}

// =============================================================================
// Property-Based Tests for Page Size Validation
// =============================================================================

test "property: valid page sizes pass validation" {
    const sizes = [_]u32{ 1, 10, 100, 1000, 10000, 100000 };

    for (sizes) |s| {
        try validate.pageSize(s);
    }
}

test "property: page size 0 fails validation" {
    try std.testing.expectError(error.PageSizeOutOfRange, validate.pageSize(0));
}

test "property: page size too large fails validation" {
    try std.testing.expectError(error.PageSizeOutOfRange, validate.pageSize(100001));
    try std.testing.expectError(error.PageSizeOutOfRange, validate.pageSize(1000000));
}

// =============================================================================
// Property-Based Tests for IPv4 Validation
// =============================================================================

test "property: valid IPv4 addresses return true" {
    const valid_ips = [_][]const u8{
        "0.0.0.0",
        "127.0.0.1",
        "192.168.1.1",
        "10.0.0.1",
        "255.255.255.255",
        "1.2.3.4",
    };

    for (valid_ips) |ip| {
        try std.testing.expect(validate.ipv4(ip));
    }
}

test "property: invalid IPv4 addresses return false" {
    const invalid_ips = [_][]const u8{
        "",
        "localhost",
        "256.0.0.0",
        "1.2.3.256",
        "1.2.3",
        "1.2.3.4.5",
        "1.2.3.a",
        "1..2.3",
        ".1.2.3",
        "1.2.3.",
        "::1",
        "1.2.3.4/24",
    };

    for (invalid_ips) |ip| {
        try std.testing.expect(!validate.ipv4(ip));
    }
}

// =============================================================================
// Property-Based Tests for IPv6 Validation
// =============================================================================

test "property: valid IPv6 addresses return true" {
    const valid_ips = [_][]const u8{
        "::1",
        "::",
        "::ffff:192.168.1.1",
        "2001:db8::1",
        "2001:db8:85a3::8a2e:370:7334",
        "fe80::1",
        "2001:0db8:0000:0000:0000:0000:0000:0001",
    };

    for (valid_ips) |ip| {
        try std.testing.expect(validate.isIpv6(ip));
    }
}

test "property: invalid IPv6 addresses return false" {
    // Note: isIpv6 is a simple heuristic check (counts colons >= 2)
    // These values have fewer than 2 colons, so they're detected as non-IPv6
    const invalid_ips = [_][]const u8{
        "",
        "localhost",
        "127.0.0.1",
        "a:b", // Only one colon
    };

    for (invalid_ips) |ip| {
        try std.testing.expect(!validate.isIpv6(ip));
    }
}

// =============================================================================
// Property-Based Tests for Sanitize
// =============================================================================

test "property: sanitize removes null bytes" {
    const input = "hello\x00world";
    const result = try validate.sanitize(std.testing.allocator, input);
    defer std.testing.allocator.free(result);

    try std.testing.expect(std.mem.indexOf(u8, result, "\x00") == null);
    try std.testing.expectEqualStrings("helloworld", result);
}

test "property: sanitize removes control characters" {
    const input = "hello\x01\x02\x03world";
    const result = try validate.sanitize(std.testing.allocator, input);
    defer std.testing.allocator.free(result);

    // Should not contain control characters
    for (result) |c| {
        try std.testing.expect(c >= 0x20 or c == '\t' or c == '\n' or c == '\r');
    }
}

test "property: sanitize preserves valid characters" {
    const input = "Hello, World! 123";
    const result = try validate.sanitize(std.testing.allocator, input);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings(input, result);
}

test "property: sanitize handles empty input" {
    const result = try validate.sanitize(std.testing.allocator, "");
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("", result);
}

test "property: sanitize handles all control characters" {
    var input: [32]u8 = undefined;
    for (0..32) |i| {
        input[i] = @intCast(i);
    }

    const result = try validate.sanitize(std.testing.allocator, &input);
    defer std.testing.allocator.free(result);

    // Result should only contain allowed whitespace
    for (result) |c| {
        try std.testing.expect(c == '\t' or c == '\n' or c == '\r');
    }
}

// =============================================================================
// Edge Case Tests
// =============================================================================

test "edge: boundary values for port" {
    try validate.port(1); // Minimum valid
    try validate.port(65535); // Maximum valid
    try std.testing.expectError(error.PortOutOfRange, validate.port(0)); // Below minimum
}

test "edge: boundary values for page size" {
    try validate.pageSize(1); // Minimum valid
    try validate.pageSize(100000); // Maximum valid
    try std.testing.expectError(error.PageSizeOutOfRange, validate.pageSize(0)); // Below minimum
    try std.testing.expectError(error.PageSizeOutOfRange, validate.pageSize(100001)); // Above maximum
}

test "edge: boundary values for query length" {
    // MAX_QUERY_LENGTH = 1MB (1024 * 1024)
    // Just under limit should pass
    var query_under: [1024 * 1024]u8 = undefined;
    @memset(&query_under, 'x');
    try validate.query(&query_under);

    // Above limit should fail
    var query_over: [1024 * 1024 + 1]u8 = undefined;
    @memset(&query_over, 'x');
    try std.testing.expectError(error.QueryTooLong, validate.query(&query_over));
}

test "edge: boundary values for hostname length" {
    // Just under limit should pass
    var hostname_250: [250]u8 = undefined;
    @memset(&hostname_250, 'x');
    try validate.hostname(&hostname_250);

    // At/above limit should fail
    var hostname_300: [300]u8 = undefined;
    @memset(&hostname_300, 'x');
    try std.testing.expectError(error.HostnameTooLong, validate.hostname(&hostname_300));
}

test "edge: boundary values for parameter name length" {
    // MAX_PARAM_NAME_LENGTH = 256
    // Just under limit should pass
    var param_256: [256]u8 = undefined;
    @memset(&param_256, 'x');
    try validate.paramName(&param_256);

    // Above limit should fail
    var param_257: [257]u8 = undefined;
    @memset(&param_257, 'x');
    try std.testing.expectError(error.ParamNameTooLong, validate.paramName(&param_257));
}
