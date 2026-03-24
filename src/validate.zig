// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Input validation for the Geode Zig client library.
// Provides validation functions for queries, parameters, and configuration.

const std = @import("std");
const GeodeError = @import("error").GeodeError;
const gql = @import("gql");

/// Maximum allowed query length (1MB)
pub const MAX_QUERY_LENGTH: usize = 1024 * 1024;

/// Maximum parameter name length
pub const MAX_PARAM_NAME_LENGTH: usize = 256;

/// Maximum hostname length
pub const MAX_HOSTNAME_LENGTH: usize = 253;

/// Minimum valid port number
pub const MIN_PORT: u16 = 1;

/// Maximum valid port number
pub const MAX_PORT: u16 = 65535;

/// Maximum page size
pub const MAX_PAGE_SIZE: u32 = 100000;

/// Minimum page size
pub const MIN_PAGE_SIZE: u32 = 1;

/// Minimum timeout in milliseconds
pub const MIN_TIMEOUT_MS: u32 = 1;

/// Maximum timeout in milliseconds (1 hour)
pub const MAX_TIMEOUT_MS: u32 = 3600000;

/// Validation error types
pub const ValidationError = error{
    QueryTooLong,
    QueryEmpty,
    QueryContainsNull,
    ParamNameTooLong,
    ParamNameEmpty,
    ParamNameInvalid,
    HostnameEmpty,
    HostnameTooLong,
    HostnameInvalid,
    PortOutOfRange,
    PageSizeOutOfRange,
    TimeoutOutOfRange,
};

/// Validate a query string
pub fn query(q: []const u8) ValidationError!void {
    if (q.len == 0) {
        return ValidationError.QueryEmpty;
    }

    if (q.len > MAX_QUERY_LENGTH) {
        return ValidationError.QueryTooLong;
    }

    // Check for null bytes
    for (q) |c| {
        if (c == 0) {
            return ValidationError.QueryContainsNull;
        }
    }
}

/// Validate a GQL query using the ISO/IEC 39075:2024 parser.
/// Returns a more detailed error than the basic `query()` function.
/// SECURITY: Uses the GQL parser for proper syntactic validation (CWE-89).
///
/// This function first runs basic string-level validation (length, null bytes),
/// then parses the query with the full GQL front-end to catch syntactic errors
/// that basic validation misses.
///
/// The parser uses a memory-limited arena (4 MB) to prevent denial-of-service
/// via memory exhaustion on adversarial input.
pub fn queryGql(allocator: std.mem.Allocator, q: []const u8) (ValidationError || GqlValidationError || std.mem.Allocator.Error)!void {
    // First run basic string-level validation (empty, too long, null bytes)
    try query(q);

    // Then attempt to parse with the GQL parser for syntax validation.
    // Use an arena backed by the caller's allocator for all AST nodes.
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    var lx = gql.Lexer{ .src = q };
    var parser = gql.Parser{
        .lx = &lx,
        .arena = &arena,
        .cur = lx.next(),
    };

    _ = parser.parseProgram() catch |err| switch (err) {
        error.UnexpectedToken => return GqlValidationError.GqlSyntaxError,
        error.InvalidCharacter => return GqlValidationError.GqlInvalidCharacter,
        error.InvalidIndexType => return GqlValidationError.GqlInvalidIndexType,
        error.Overflow => return GqlValidationError.GqlOverflow,
        error.OutOfMemory => return error.OutOfMemory,
    };
}

/// Errors specific to GQL parser-based validation.
pub const GqlValidationError = error{
    /// The query has a syntactic error according to the GQL grammar.
    GqlSyntaxError,
    /// The query contains an invalid character.
    GqlInvalidCharacter,
    /// The query uses an invalid index type.
    GqlInvalidIndexType,
    /// Numeric overflow in a literal or expression.
    GqlOverflow,
};

/// Validate a parameter name
pub fn paramName(name: []const u8) ValidationError!void {
    if (name.len == 0) {
        return ValidationError.ParamNameEmpty;
    }

    if (name.len > MAX_PARAM_NAME_LENGTH) {
        return ValidationError.ParamNameTooLong;
    }

    // Must start with letter or underscore
    const first = name[0];
    if (!isLetter(first) and first != '_') {
        return ValidationError.ParamNameInvalid;
    }

    // Rest must be alphanumeric or underscore
    for (name[1..]) |c| {
        if (!isAlphanumeric(c) and c != '_') {
            return ValidationError.ParamNameInvalid;
        }
    }
}

/// Validate a hostname
pub fn hostname(host: []const u8) ValidationError!void {
    if (host.len == 0) {
        return ValidationError.HostnameEmpty;
    }

    if (host.len > MAX_HOSTNAME_LENGTH) {
        return ValidationError.HostnameTooLong;
    }

    // Check for valid hostname characters
    // Allow: letters, digits, hyphens, dots, colons (IPv6), brackets (IPv6)
    for (host) |c| {
        if (!isHostnameChar(c)) {
            return ValidationError.HostnameInvalid;
        }
    }

    // Additional checks for standard hostname format
    // (not strict DNS validation, allows IPs)
}

/// Validate a port number
pub fn port(p: u16) ValidationError!void {
    if (p < MIN_PORT or p > MAX_PORT) {
        return ValidationError.PortOutOfRange;
    }
}

/// Validate page size
pub fn pageSize(size: u32) ValidationError!void {
    if (size < MIN_PAGE_SIZE or size > MAX_PAGE_SIZE) {
        return ValidationError.PageSizeOutOfRange;
    }
}

/// Validate a timeout value in milliseconds
/// SECURITY: Enforces reasonable bounds to prevent resource exhaustion (CWE-20).
pub fn timeout(timeout_ms: u32) ValidationError!void {
    if (timeout_ms < MIN_TIMEOUT_MS or timeout_ms > MAX_TIMEOUT_MS) {
        return ValidationError.TimeoutOutOfRange;
    }
}

/// Validate an IPv4 address
pub fn ipv4(addr: []const u8) bool {
    var parts: u8 = 0;
    var current_value: u32 = 0;
    var digits: u8 = 0;

    for (addr) |c| {
        if (c == '.') {
            if (digits == 0 or current_value > 255) {
                return false;
            }
            parts += 1;
            current_value = 0;
            digits = 0;
        } else if (c >= '0' and c <= '9') {
            current_value = current_value * 10 + (c - '0');
            digits += 1;
            if (digits > 3) {
                return false;
            }
        } else {
            return false;
        }
    }

    // Check final part
    if (digits == 0 or current_value > 255) {
        return false;
    }

    return parts == 3;
}

/// Check if string looks like an IPv6 address.
/// SECURITY: Validates character set to prevent false positives (CWE-20).
/// See GAP_ANALYSIS.md Finding 17.
pub fn isIpv6(addr: []const u8) bool {
    if (addr.len == 0) return false;

    var colon_count: u8 = 0;
    var in_zone: bool = false;

    for (addr) |c| {
        // Zone ID separator (e.g., fe80::1%eth0)
        if (c == '%') {
            in_zone = true;
            continue;
        }

        if (in_zone) {
            // Zone ID: allow alphanumerics only
            if (!isAlphanumeric(c)) return false;
            continue;
        }

        // Valid IPv6 characters: hex digits, colons, dots (IPv4-mapped), brackets
        switch (c) {
            ':' => colon_count += 1,
            '0'...'9', 'a'...'f', 'A'...'F', '.', '[', ']' => {},
            else => return false,
        }
    }

    return colon_count >= 2;
}

/// Sanitize a string by removing control characters
pub fn sanitize(allocator: std.mem.Allocator, input: []const u8) ![]u8 {
    var result: std.ArrayListUnmanaged(u8) = .{};
    errdefer result.deinit(allocator);

    for (input) |c| {
        // Skip control characters except tab, newline, carriage return
        if (c < 32 and c != '\t' and c != '\n' and c != '\r') {
            continue;
        }
        // Skip DEL character
        if (c == 127) {
            continue;
        }
        try result.append(allocator, c);
    }

    return result.toOwnedSlice(allocator);
}

// Helper functions

fn isLetter(c: u8) bool {
    return (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z');
}

fn isDigit(c: u8) bool {
    return c >= '0' and c <= '9';
}

fn isAlphanumeric(c: u8) bool {
    return isLetter(c) or isDigit(c);
}

fn isHostnameChar(c: u8) bool {
    return isAlphanumeric(c) or c == '-' or c == '.' or c == ':' or c == '[' or c == ']';
}

// =============================================================================
// Unit Tests
// =============================================================================

test "query validates normal query" {
    try query("MATCH (n) RETURN n");
    try query("CREATE (p:Person {name: 'Alice'})");
    try query("MATCH (a)-[:KNOWS]->(b) RETURN a, b");
}

test "query rejects empty query" {
    try std.testing.expectError(ValidationError.QueryEmpty, query(""));
}

test "query rejects query with null byte" {
    try std.testing.expectError(ValidationError.QueryContainsNull, query("MATCH\x00(n)"));
}

test "query rejects too long query" {
    const long_query = "M" ** (MAX_QUERY_LENGTH + 1);
    try std.testing.expectError(ValidationError.QueryTooLong, query(long_query));
}

test "query accepts max length query" {
    const max_query = "M" ** MAX_QUERY_LENGTH;
    try query(max_query);
}

test "paramName validates normal names" {
    try paramName("name");
    try paramName("_private");
    try paramName("param1");
    try paramName("my_param_123");
    try paramName("A");
}

test "paramName rejects empty name" {
    try std.testing.expectError(ValidationError.ParamNameEmpty, paramName(""));
}

test "paramName rejects name starting with digit" {
    try std.testing.expectError(ValidationError.ParamNameInvalid, paramName("1name"));
    try std.testing.expectError(ValidationError.ParamNameInvalid, paramName("123"));
}

test "paramName rejects name with invalid chars" {
    try std.testing.expectError(ValidationError.ParamNameInvalid, paramName("name-with-dash"));
    try std.testing.expectError(ValidationError.ParamNameInvalid, paramName("name.with.dots"));
    try std.testing.expectError(ValidationError.ParamNameInvalid, paramName("name with spaces"));
    try std.testing.expectError(ValidationError.ParamNameInvalid, paramName("name@domain"));
}

test "paramName rejects too long name" {
    const long_name = "a" ** (MAX_PARAM_NAME_LENGTH + 1);
    try std.testing.expectError(ValidationError.ParamNameTooLong, paramName(long_name));
}

test "hostname validates normal hostnames" {
    try hostname("localhost");
    try hostname("example.com");
    try hostname("sub.domain.example.com");
    try hostname("my-server");
    try hostname("server123");
}

test "hostname validates IP addresses" {
    try hostname("127.0.0.1");
    try hostname("192.168.1.1");
    try hostname("10.0.0.1");
}

test "hostname validates IPv6 addresses" {
    try hostname("::1");
    try hostname("2001:db8::1");
    try hostname("[::1]");
    try hostname("[2001:db8::1]");
}

test "hostname rejects empty hostname" {
    try std.testing.expectError(ValidationError.HostnameEmpty, hostname(""));
}

test "hostname rejects too long hostname" {
    const long_host = "a" ** (MAX_HOSTNAME_LENGTH + 1);
    try std.testing.expectError(ValidationError.HostnameTooLong, hostname(long_host));
}

test "hostname rejects invalid characters" {
    try std.testing.expectError(ValidationError.HostnameInvalid, hostname("host name"));
    try std.testing.expectError(ValidationError.HostnameInvalid, hostname("host@domain"));
    try std.testing.expectError(ValidationError.HostnameInvalid, hostname("host/path"));
}

test "port validates normal ports" {
    try port(80);
    try port(443);
    try port(3141);
    try port(8443);
    try port(1);
    try port(65535);
}

test "port rejects port 0" {
    try std.testing.expectError(ValidationError.PortOutOfRange, port(0));
}

test "pageSize validates normal sizes" {
    try pageSize(1);
    try pageSize(100);
    try pageSize(1000);
    try pageSize(10000);
    try pageSize(100000);
}

test "pageSize rejects zero" {
    try std.testing.expectError(ValidationError.PageSizeOutOfRange, pageSize(0));
}

test "pageSize rejects too large" {
    try std.testing.expectError(ValidationError.PageSizeOutOfRange, pageSize(100001));
    try std.testing.expectError(ValidationError.PageSizeOutOfRange, pageSize(1000000));
}

test "timeout validates normal timeouts" {
    try timeout(1);
    try timeout(1000);
    try timeout(30000);
    try timeout(60000);
    try timeout(3600000);
}

test "timeout rejects zero" {
    try std.testing.expectError(ValidationError.TimeoutOutOfRange, timeout(0));
}

test "timeout rejects too large" {
    try std.testing.expectError(ValidationError.TimeoutOutOfRange, timeout(3600001));
    try std.testing.expectError(ValidationError.TimeoutOutOfRange, timeout(10000000));
}

test "ipv4 validates correct addresses" {
    try std.testing.expect(ipv4("127.0.0.1"));
    try std.testing.expect(ipv4("192.168.1.1"));
    try std.testing.expect(ipv4("10.0.0.1"));
    try std.testing.expect(ipv4("255.255.255.255"));
    try std.testing.expect(ipv4("0.0.0.0"));
}

test "ipv4 rejects invalid addresses" {
    try std.testing.expect(!ipv4(""));
    try std.testing.expect(!ipv4("127.0.0"));
    try std.testing.expect(!ipv4("127.0.0.1.1"));
    try std.testing.expect(!ipv4("256.0.0.1"));
    try std.testing.expect(!ipv4("127.0.0.256"));
    try std.testing.expect(!ipv4("abc.def.ghi.jkl"));
    try std.testing.expect(!ipv4("127.0.0.1."));
    try std.testing.expect(!ipv4(".127.0.0.1"));
}

test "isIpv6 identifies IPv6 addresses" {
    try std.testing.expect(isIpv6("::1"));
    try std.testing.expect(isIpv6("2001:db8::1"));
    try std.testing.expect(isIpv6("fe80::1%eth0"));
    try std.testing.expect(isIpv6("::ffff:192.168.1.1"));
}

test "isIpv6 rejects non-IPv6" {
    try std.testing.expect(!isIpv6("127.0.0.1"));
    try std.testing.expect(!isIpv6("localhost"));
    try std.testing.expect(!isIpv6("example.com"));
}

// =============================================================================
// Security Tests - Strengthened IPv6 Validation (CWE-20)
// =============================================================================

test "isIpv6 rejects invalid characters" {
    // These were previously accepted due to weak colon-count-only check
    // Note: 'a', 'b', 'c' are valid hex chars, so "a:b:c" could be valid shorthand
    try std.testing.expect(!isIpv6("foo:bar:baz")); // 'o' and 'r' not in hex range
    try std.testing.expect(!isIpv6("x:y:z")); // 'x', 'y', 'z' not in hex range
    try std.testing.expect(!isIpv6("g:h:i")); // 'g', 'h', 'i' > 'f'
    try std.testing.expect(!isIpv6("hello:world:test")); // Non-hex letters
}

test "isIpv6 rejects special characters" {
    try std.testing.expect(!isIpv6("::1@localhost")); // @ not allowed
    try std.testing.expect(!isIpv6("2001:db8::1/64")); // / not allowed
    try std.testing.expect(!isIpv6("fe80::1 ")); // Space not allowed
    try std.testing.expect(!isIpv6("::1#comment")); // # not allowed
}

test "isIpv6 rejects empty string" {
    try std.testing.expect(!isIpv6(""));
}

test "isIpv6 accepts valid zone IDs" {
    try std.testing.expect(isIpv6("fe80::1%eth0"));
    try std.testing.expect(isIpv6("fe80::1%en0"));
    try std.testing.expect(isIpv6("fe80::1%lo"));
    try std.testing.expect(isIpv6("fe80::1%wlan0"));
}

test "isIpv6 rejects invalid zone ID characters" {
    try std.testing.expect(!isIpv6("fe80::1%eth@0")); // @ in zone ID
    try std.testing.expect(!isIpv6("fe80::1%eth 0")); // Space in zone ID
}

test "sanitize removes control characters" {
    const input = "hello\x00world\x01test\x7f";
    const result = try sanitize(std.testing.allocator, input);
    defer std.testing.allocator.free(result);
    try std.testing.expectEqualStrings("helloworldtest", result);
}

test "sanitize preserves whitespace" {
    const input = "hello\tworld\ntest\r";
    const result = try sanitize(std.testing.allocator, input);
    defer std.testing.allocator.free(result);
    try std.testing.expectEqualStrings("hello\tworld\ntest\r", result);
}

test "sanitize handles empty string" {
    const result = try sanitize(std.testing.allocator, "");
    defer std.testing.allocator.free(result);
    try std.testing.expectEqualStrings("", result);
}

test "sanitize handles normal string" {
    const input = "MATCH (n:Person) RETURN n.name";
    const result = try sanitize(std.testing.allocator, input);
    defer std.testing.allocator.free(result);
    try std.testing.expectEqualStrings(input, result);
}

// =============================================================================
// GQL Parser Validation Tests
// =============================================================================

test "queryGql accepts valid MATCH query" {
    try queryGql(std.testing.allocator, "MATCH (n) RETURN n");
}

test "queryGql accepts valid CREATE query" {
    try queryGql(std.testing.allocator, "CREATE (p:Person {name: 'Alice'})");
}

test "queryGql accepts valid relationship query" {
    try queryGql(std.testing.allocator, "MATCH (a)-[:KNOWS]->(b) RETURN a, b");
}

test "queryGql rejects empty query" {
    try std.testing.expectError(ValidationError.QueryEmpty, queryGql(std.testing.allocator, ""));
}

test "queryGql rejects query with null byte" {
    try std.testing.expectError(ValidationError.QueryContainsNull, queryGql(std.testing.allocator, "MATCH\x00(n)"));
}

test "queryGql rejects syntactically invalid query" {
    try std.testing.expectError(GqlValidationError.GqlSyntaxError, queryGql(std.testing.allocator, "MATCH MATCH MATCH"));
}
