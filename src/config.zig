// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Configuration and DSN parsing for the Geode Zig client library.
// Supports URL format (geode://...) and simple host:port format.

const std = @import("std");
const GeodeError = @import("error").GeodeError;

/// Default Geode server port
pub const DEFAULT_PORT: u16 = 3141;

/// Default page size for result pagination
pub const DEFAULT_PAGE_SIZE: u32 = 1000;

/// Default connection timeout in milliseconds
pub const DEFAULT_TIMEOUT_MS: u32 = 30000;

/// Client configuration parsed from DSN or set programmatically.
pub const Config = struct {
    /// Server hostname or IP address
    host: []const u8,
    /// Server port number
    port: u16,
    /// Username for authentication (optional)
    username: ?[]const u8,
    /// Password for authentication (optional)
    password: ?[]const u8,
    /// Allow insecure (unverified TLS) connections
    insecure: bool,
    /// Default page size for query results
    page_size: u32,
    /// Connection timeout in milliseconds
    timeout_ms: u32,
    /// ALPN protocol string
    alpn: []const u8,

    /// Initialize with default values
    pub fn init() Config {
        return .{
            .host = "127.0.0.1",
            .port = DEFAULT_PORT,
            .username = null,
            .password = null,
            .insecure = false,
            .page_size = DEFAULT_PAGE_SIZE,
            .timeout_ms = DEFAULT_TIMEOUT_MS,
            .alpn = "geode/1",
        };
    }

    /// Initialize with host and port
    pub fn initWithHost(host: []const u8, port: u16) Config {
        var cfg = Config.init();
        cfg.host = host;
        cfg.port = port;
        return cfg;
    }

    /// Set credentials
    pub fn withCredentials(self: *Config, username: []const u8, password: []const u8) *Config {
        self.username = username;
        self.password = password;
        return self;
    }

    /// Set insecure mode
    pub fn withInsecure(self: *Config, insecure: bool) *Config {
        self.insecure = insecure;
        return self;
    }

    /// Set page size
    pub fn withPageSize(self: *Config, page_size: u32) *Config {
        self.page_size = page_size;
        return self;
    }

    /// Set timeout
    pub fn withTimeout(self: *Config, timeout_ms: u32) *Config {
        self.timeout_ms = timeout_ms;
        return self;
    }

    /// Check if authentication is configured
    pub fn hasAuth(self: Config) bool {
        return self.username != null and self.password != null;
    }

    /// Format as connection string (without credentials)
    pub fn toConnectionString(self: Config, allocator: std.mem.Allocator) ![]const u8 {
        return std.fmt.allocPrint(allocator, "{s}:{d}", .{ self.host, self.port });
    }
};

/// Parse a DSN (Data Source Name) string into a Config.
/// Supports formats:
/// - URL format: geode://[user:pass@]host[:port][?params]
/// - Simple format: host:port[?params]
/// - Host only: host
pub fn parseDSN(allocator: std.mem.Allocator, dsn: []const u8) !Config {
    var config = Config.init();

    if (dsn.len == 0) {
        return config;
    }

    // Check for URL format (geode://)
    if (std.mem.startsWith(u8, dsn, "geode://")) {
        return parseUrlFormat(allocator, dsn[8..], &config);
    }

    // Simple format: host:port or host:port?params
    return parseSimpleFormat(allocator, dsn, &config);
}

/// Parse URL format: [user:pass@]host[:port][?params]
fn parseUrlFormat(allocator: std.mem.Allocator, url: []const u8, config: *Config) !Config {
    var remaining = url;

    // Check for credentials (user:pass@)
    if (std.mem.indexOf(u8, remaining, "@")) |at_pos| {
        const creds = remaining[0..at_pos];
        remaining = remaining[at_pos + 1 ..];

        // Parse user:pass
        if (std.mem.indexOf(u8, creds, ":")) |colon_pos| {
            const username = creds[0..colon_pos];
            const password = creds[colon_pos + 1 ..];

            // URL decode credentials
            config.username = try urlDecode(allocator, username);
            config.password = try urlDecode(allocator, password);
        } else {
            // Username only
            config.username = try urlDecode(allocator, creds);
        }
    }

    // Parse host[:port][?params]
    return parseHostPortParams(allocator, remaining, config);
}

/// Parse simple format: host:port[?params] or host
fn parseSimpleFormat(allocator: std.mem.Allocator, dsn: []const u8, config: *Config) !Config {
    return parseHostPortParams(allocator, dsn, config);
}

/// Parse host[:port][?params]
fn parseHostPortParams(allocator: std.mem.Allocator, input: []const u8, config: *Config) !Config {
    var remaining = input;

    // Check for query parameters
    var params_str: ?[]const u8 = null;
    if (std.mem.indexOf(u8, remaining, "?")) |q_pos| {
        params_str = remaining[q_pos + 1 ..];
        remaining = remaining[0..q_pos];
    }

    // Check for IPv6 address [host]:port
    if (std.mem.startsWith(u8, remaining, "[")) {
        if (std.mem.indexOf(u8, remaining, "]:")) |bracket_colon| {
            // IPv6 with port: [::1]:3141
            config.host = remaining[1..bracket_colon];
            const port_str = remaining[bracket_colon + 2 ..];
            config.port = std.fmt.parseInt(u16, port_str, 10) catch DEFAULT_PORT;
        } else if (std.mem.indexOf(u8, remaining, "]")) |bracket| {
            // IPv6 without port: [::1]
            config.host = remaining[1..bracket];
        } else {
            return error.InvalidDSN;
        }
    } else {
        // Regular host:port or host
        if (std.mem.lastIndexOf(u8, remaining, ":")) |colon_pos| {
            config.host = remaining[0..colon_pos];
            const port_str = remaining[colon_pos + 1 ..];
            config.port = std.fmt.parseInt(u16, port_str, 10) catch DEFAULT_PORT;
        } else {
            config.host = remaining;
        }
    }

    // Parse query parameters
    if (params_str) |params| {
        try parseQueryParams(allocator, params, config);
    }

    return config.*;
}

/// Parse query parameters (key=value&key=value)
fn parseQueryParams(allocator: std.mem.Allocator, params: []const u8, config: *Config) !void {
    var iter = std.mem.splitScalar(u8, params, '&');
    while (iter.next()) |param| {
        if (std.mem.indexOf(u8, param, "=")) |eq_pos| {
            const key = param[0..eq_pos];
            const value = param[eq_pos + 1 ..];

            if (std.mem.eql(u8, key, "insecure") or std.mem.eql(u8, key, "insecure_skip_verify")) {
                config.insecure = std.mem.eql(u8, value, "true") or std.mem.eql(u8, value, "1");
            } else if (std.mem.eql(u8, key, "page_size") or std.mem.eql(u8, key, "pageSize")) {
                config.page_size = std.fmt.parseInt(u32, value, 10) catch DEFAULT_PAGE_SIZE;
            } else if (std.mem.eql(u8, key, "timeout") or std.mem.eql(u8, key, "timeout_ms")) {
                config.timeout_ms = std.fmt.parseInt(u32, value, 10) catch DEFAULT_TIMEOUT_MS;
            } else if (std.mem.eql(u8, key, "username") or std.mem.eql(u8, key, "user")) {
                config.username = try urlDecode(allocator, value);
            } else if (std.mem.eql(u8, key, "password") or std.mem.eql(u8, key, "pass")) {
                config.password = try urlDecode(allocator, value);
            }
        }
    }
}

/// URL decode a string (handles %XX encoding)
fn urlDecode(allocator: std.mem.Allocator, input: []const u8) ![]const u8 {
    var result: std.ArrayListUnmanaged(u8) = .{};
    errdefer result.deinit(allocator);

    var i: usize = 0;
    while (i < input.len) {
        if (input[i] == '%' and i + 2 < input.len) {
            const hex = input[i + 1 .. i + 3];
            const byte = std.fmt.parseInt(u8, hex, 16) catch {
                try result.append(allocator, input[i]);
                i += 1;
                continue;
            };
            try result.append(allocator, byte);
            i += 3;
        } else if (input[i] == '+') {
            try result.append(allocator, ' ');
            i += 1;
        } else {
            try result.append(allocator, input[i]);
            i += 1;
        }
    }

    return result.toOwnedSlice(allocator);
}

// =============================================================================
// Unit Tests
// =============================================================================

test "Config.init creates default config" {
    const cfg = Config.init();
    try std.testing.expectEqualStrings("127.0.0.1", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
    try std.testing.expect(cfg.username == null);
    try std.testing.expect(cfg.password == null);
    try std.testing.expect(!cfg.insecure);
    try std.testing.expectEqual(@as(u32, 1000), cfg.page_size);
}

test "Config.initWithHost sets host and port" {
    const cfg = Config.initWithHost("localhost", 8443);
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 8443), cfg.port);
}

test "Config.withCredentials sets auth" {
    var cfg = Config.init();
    _ = cfg.withCredentials("admin", "secret");
    try std.testing.expectEqualStrings("admin", cfg.username.?);
    try std.testing.expectEqualStrings("secret", cfg.password.?);
    try std.testing.expect(cfg.hasAuth());
}

test "Config.withInsecure sets insecure flag" {
    var cfg = Config.init();
    _ = cfg.withInsecure(true);
    try std.testing.expect(cfg.insecure);
}

test "Config.withPageSize sets page size" {
    var cfg = Config.init();
    _ = cfg.withPageSize(500);
    try std.testing.expectEqual(@as(u32, 500), cfg.page_size);
}

test "Config.withTimeout sets timeout" {
    var cfg = Config.init();
    _ = cfg.withTimeout(60000);
    try std.testing.expectEqual(@as(u32, 60000), cfg.timeout_ms);
}

test "Config.hasAuth returns false without credentials" {
    const cfg = Config.init();
    try std.testing.expect(!cfg.hasAuth());
}

test "parseDSN handles empty string" {
    const cfg = try parseDSN(std.testing.allocator, "");
    try std.testing.expectEqualStrings("127.0.0.1", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "parseDSN parses simple host:port" {
    const cfg = try parseDSN(std.testing.allocator, "localhost:8443");
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 8443), cfg.port);
}

test "parseDSN parses host only" {
    const cfg = try parseDSN(std.testing.allocator, "myserver");
    try std.testing.expectEqualStrings("myserver", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "parseDSN parses URL format basic" {
    const cfg = try parseDSN(std.testing.allocator, "geode://localhost:3141");
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "parseDSN parses URL format with credentials" {
    const cfg = try parseDSN(std.testing.allocator, "geode://admin:secret@localhost:3141");
    defer {
        if (cfg.username) |u| std.testing.allocator.free(u);
        if (cfg.password) |p| std.testing.allocator.free(p);
    }
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
    try std.testing.expectEqualStrings("admin", cfg.username.?);
    try std.testing.expectEqualStrings("secret", cfg.password.?);
}

test "parseDSN parses URL with encoded credentials" {
    const cfg = try parseDSN(std.testing.allocator, "geode://user%40domain:pass%3Dword@localhost:3141");
    defer {
        if (cfg.username) |u| std.testing.allocator.free(u);
        if (cfg.password) |p| std.testing.allocator.free(p);
    }
    try std.testing.expectEqualStrings("user@domain", cfg.username.?);
    try std.testing.expectEqualStrings("pass=word", cfg.password.?);
}

test "parseDSN parses query parameters" {
    const cfg = try parseDSN(std.testing.allocator, "localhost:3141?insecure=true&page_size=500");
    try std.testing.expect(cfg.insecure);
    try std.testing.expectEqual(@as(u32, 500), cfg.page_size);
}

test "parseDSN parses all query parameters" {
    const cfg = try parseDSN(std.testing.allocator, "geode://localhost:3141?insecure=1&page_size=200&timeout=60000");
    try std.testing.expect(cfg.insecure);
    try std.testing.expectEqual(@as(u32, 200), cfg.page_size);
    try std.testing.expectEqual(@as(u32, 60000), cfg.timeout_ms);
}

test "parseDSN parses username in query params" {
    const cfg = try parseDSN(std.testing.allocator, "localhost:3141?username=admin&password=secret");
    defer {
        if (cfg.username) |u| std.testing.allocator.free(u);
        if (cfg.password) |p| std.testing.allocator.free(p);
    }
    try std.testing.expectEqualStrings("admin", cfg.username.?);
    try std.testing.expectEqualStrings("secret", cfg.password.?);
}

test "parseDSN parses alternative param names" {
    const cfg = try parseDSN(std.testing.allocator, "localhost:3141?user=admin&pass=secret&pageSize=100&insecure_skip_verify=true");
    defer {
        if (cfg.username) |u| std.testing.allocator.free(u);
        if (cfg.password) |p| std.testing.allocator.free(p);
    }
    try std.testing.expectEqualStrings("admin", cfg.username.?);
    try std.testing.expectEqualStrings("secret", cfg.password.?);
    try std.testing.expectEqual(@as(u32, 100), cfg.page_size);
    try std.testing.expect(cfg.insecure);
}

test "parseDSN handles IPv6 address" {
    const cfg = try parseDSN(std.testing.allocator, "[::1]:3141");
    try std.testing.expectEqualStrings("::1", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "parseDSN handles IPv6 without port" {
    const cfg = try parseDSN(std.testing.allocator, "[::1]");
    try std.testing.expectEqualStrings("::1", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "parseDSN handles IPv6 in URL format" {
    const cfg = try parseDSN(std.testing.allocator, "geode://[2001:db8::1]:8443");
    try std.testing.expectEqualStrings("2001:db8::1", cfg.host);
    try std.testing.expectEqual(@as(u16, 8443), cfg.port);
}

test "parseDSN handles IP address" {
    const cfg = try parseDSN(std.testing.allocator, "192.168.1.100:3141");
    try std.testing.expectEqualStrings("192.168.1.100", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "parseDSN uses default port for invalid port" {
    const cfg = try parseDSN(std.testing.allocator, "localhost:invalid");
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "urlDecode handles plain string" {
    const decoded = try urlDecode(std.testing.allocator, "hello");
    defer std.testing.allocator.free(decoded);
    try std.testing.expectEqualStrings("hello", decoded);
}

test "urlDecode handles percent encoding" {
    const decoded = try urlDecode(std.testing.allocator, "hello%20world");
    defer std.testing.allocator.free(decoded);
    try std.testing.expectEqualStrings("hello world", decoded);
}

test "urlDecode handles plus as space" {
    const decoded = try urlDecode(std.testing.allocator, "hello+world");
    defer std.testing.allocator.free(decoded);
    try std.testing.expectEqualStrings("hello world", decoded);
}

test "urlDecode handles special characters" {
    const decoded = try urlDecode(std.testing.allocator, "user%40domain%3Atest");
    defer std.testing.allocator.free(decoded);
    try std.testing.expectEqualStrings("user@domain:test", decoded);
}

test "urlDecode handles invalid percent encoding" {
    const decoded = try urlDecode(std.testing.allocator, "hello%GGworld");
    defer std.testing.allocator.free(decoded);
    try std.testing.expectEqualStrings("hello%GGworld", decoded);
}

test "Config.toConnectionString formats correctly" {
    var cfg = Config.initWithHost("localhost", 8443);
    const conn_str = try cfg.toConnectionString(std.testing.allocator);
    defer std.testing.allocator.free(conn_str);
    try std.testing.expectEqualStrings("localhost:8443", conn_str);
}
