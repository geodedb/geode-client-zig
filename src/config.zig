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

/// Maximum length for URL-decoded strings.
/// SECURITY: Prevents resource exhaustion attacks via extremely long DSN strings (CWE-400).
pub const MAX_URL_DECODE_LENGTH: usize = 64 * 1024; // 64KB reasonable limit

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

    /// Free allocated credentials and zero sensitive data before freeing.
    /// SECURITY: Zeros password before freeing to prevent memory disclosure (CWE-316, CWE-226).
    /// Call this when done with a Config that was created via parseDSN.
    pub fn deinit(self: *Config, allocator: std.mem.Allocator) void {
        // SECURITY: Zero sensitive password data before freeing (CWE-316, CWE-226)
        if (self.password) |pass| {
            @memset(@constCast(pass), 0);
            allocator.free(pass);
            self.password = null;
        }
        // Free username (not sensitive, but still allocated)
        if (self.username) |user| {
            allocator.free(user);
            self.username = null;
        }
    }
};

/// Parse a DSN (Data Source Name) string into a Config.
/// Supports formats:
/// - URL format: geode://[user:pass@]host[:port][?params]
/// - Simple format: host:port[?params]
/// - Host only: host
///
/// Note: Invalid numeric values (port, page_size, timeout) silently fall back to defaults.
/// Use parseDSNStrict() for strict validation that returns errors on invalid values.
pub fn parseDSN(allocator: std.mem.Allocator, dsn: []const u8) !Config {
    var config = Config.init();

    if (dsn.len == 0) {
        return config;
    }

    // Check for URL format (geode://)
    if (std.mem.startsWith(u8, dsn, "geode://")) {
        return parseUrlFormat(allocator, dsn[8..], &config, false);
    }

    // Simple format: host:port or host:port?params
    return parseSimpleFormat(allocator, dsn, &config, false);
}

/// Parse a DSN with strict validation.
/// SECURITY: Returns errors for invalid values instead of silently using defaults (CWE-20).
/// This is recommended for production use where misconfigurations should fail explicitly.
pub fn parseDSNStrict(allocator: std.mem.Allocator, dsn: []const u8) !Config {
    var config = Config.init();

    if (dsn.len == 0) {
        return config;
    }

    // Check for URL format (geode://)
    if (std.mem.startsWith(u8, dsn, "geode://")) {
        return parseUrlFormat(allocator, dsn[8..], &config, true);
    }

    // Simple format: host:port or host:port?params
    return parseSimpleFormat(allocator, dsn, &config, true);
}

/// Parse URL format: [user:pass@]host[:port][?params]
fn parseUrlFormat(allocator: std.mem.Allocator, url: []const u8, config: *Config, strict: bool) !Config {
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
    return parseHostPortParams(allocator, remaining, config, strict);
}

/// Parse simple format: host:port[?params] or host
fn parseSimpleFormat(allocator: std.mem.Allocator, dsn: []const u8, config: *Config, strict: bool) !Config {
    return parseHostPortParams(allocator, dsn, config, strict);
}

/// Parse host[:port][?params]
fn parseHostPortParams(allocator: std.mem.Allocator, input: []const u8, config: *Config, strict: bool) !Config {
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
            if (strict) {
                // SECURITY: Strict mode returns error for invalid port (CWE-20)
                config.port = std.fmt.parseInt(u16, port_str, 10) catch return error.InvalidPort;
            } else {
                config.port = std.fmt.parseInt(u16, port_str, 10) catch DEFAULT_PORT;
            }
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
            if (strict) {
                // SECURITY: Strict mode returns error for invalid port (CWE-20)
                config.port = std.fmt.parseInt(u16, port_str, 10) catch return error.InvalidPort;
            } else {
                config.port = std.fmt.parseInt(u16, port_str, 10) catch DEFAULT_PORT;
            }
        } else {
            config.host = remaining;
        }
    }

    // Parse query parameters
    if (params_str) |params| {
        try parseQueryParams(allocator, params, config, strict);
    }

    return config.*;
}

/// Parse query parameters (key=value&key=value)
fn parseQueryParams(allocator: std.mem.Allocator, params: []const u8, config: *Config, strict: bool) !void {
    var iter = std.mem.splitScalar(u8, params, '&');
    while (iter.next()) |param| {
        if (std.mem.indexOf(u8, param, "=")) |eq_pos| {
            const key = param[0..eq_pos];
            const value = param[eq_pos + 1 ..];

            if (std.mem.eql(u8, key, "insecure") or std.mem.eql(u8, key, "insecure_skip_verify")) {
                config.insecure = std.mem.eql(u8, value, "true") or std.mem.eql(u8, value, "1");
            } else if (std.mem.eql(u8, key, "page_size") or std.mem.eql(u8, key, "pageSize")) {
                if (strict) {
                    // SECURITY: Strict mode returns error for invalid page_size (CWE-20)
                    config.page_size = std.fmt.parseInt(u32, value, 10) catch return error.InvalidPageSize;
                } else {
                    config.page_size = std.fmt.parseInt(u32, value, 10) catch DEFAULT_PAGE_SIZE;
                }
            } else if (std.mem.eql(u8, key, "timeout") or std.mem.eql(u8, key, "timeout_ms")) {
                if (strict) {
                    // SECURITY: Strict mode returns error for invalid timeout (CWE-20)
                    config.timeout_ms = std.fmt.parseInt(u32, value, 10) catch return error.InvalidTimeout;
                } else {
                    config.timeout_ms = std.fmt.parseInt(u32, value, 10) catch DEFAULT_TIMEOUT_MS;
                }
            } else if (std.mem.eql(u8, key, "username") or std.mem.eql(u8, key, "user")) {
                config.username = try urlDecode(allocator, value);
            } else if (std.mem.eql(u8, key, "password") or std.mem.eql(u8, key, "pass")) {
                config.password = try urlDecode(allocator, value);
            }
        }
    }
}

/// URL decode a string (handles %XX encoding)
/// SECURITY: Enforces MAX_URL_DECODE_LENGTH to prevent resource exhaustion (CWE-400).
fn urlDecode(allocator: std.mem.Allocator, input: []const u8) ![]const u8 {
    // SECURITY: Check input length to prevent resource exhaustion (CWE-400)
    if (input.len > MAX_URL_DECODE_LENGTH) {
        return error.InputTooLong;
    }

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

// =============================================================================
// Security Tests - Config.deinit Password Zeroing (CWE-316, CWE-226)
// =============================================================================

test "Config.deinit zeros password before freeing" {
    var cfg = try parseDSN(std.testing.allocator, "geode://admin:secret123@localhost:3141");

    // Verify password was set
    try std.testing.expect(cfg.password != null);
    try std.testing.expectEqualStrings("secret123", cfg.password.?);

    // Get pointer to password data before deinit
    const pass_ptr = cfg.password.?.ptr;
    const pass_len = cfg.password.?.len;

    // Call deinit
    cfg.deinit(std.testing.allocator);

    // Verify fields are null
    try std.testing.expect(cfg.password == null);
    try std.testing.expect(cfg.username == null);

    // Note: We can't easily verify the memory is zeroed after free in Zig
    // since the allocator may reuse the memory. The important thing is that
    // deinit() calls @memset before free, which we verify by code inspection.
    _ = pass_ptr;
    _ = pass_len;
}

test "Config.deinit handles config without credentials" {
    var cfg = try parseDSN(std.testing.allocator, "localhost:3141");
    try std.testing.expect(cfg.password == null);
    try std.testing.expect(cfg.username == null);

    // Should not crash
    cfg.deinit(std.testing.allocator);
}

test "Config.deinit handles config with username only" {
    var cfg = try parseDSN(std.testing.allocator, "geode://admin@localhost:3141");
    defer cfg.deinit(std.testing.allocator);

    try std.testing.expect(cfg.username != null);
    try std.testing.expect(cfg.password == null);
}

// =============================================================================
// Security Tests - urlDecode Length Limit (CWE-400)
// =============================================================================

test "urlDecode accepts input within limit" {
    const input = "hello%20world";
    const decoded = try urlDecode(std.testing.allocator, input);
    defer std.testing.allocator.free(decoded);
    try std.testing.expectEqualStrings("hello world", decoded);
}

test "urlDecode rejects input exceeding MAX_URL_DECODE_LENGTH" {
    // Create input that exceeds the limit
    const too_long = try std.testing.allocator.alloc(u8, MAX_URL_DECODE_LENGTH + 1);
    defer std.testing.allocator.free(too_long);
    @memset(too_long, 'a');

    try std.testing.expectError(error.InputTooLong, urlDecode(std.testing.allocator, too_long));
}

test "urlDecode accepts input at exactly MAX_URL_DECODE_LENGTH" {
    // Create input exactly at the limit
    const at_limit = try std.testing.allocator.alloc(u8, MAX_URL_DECODE_LENGTH);
    defer std.testing.allocator.free(at_limit);
    @memset(at_limit, 'a');

    const decoded = try urlDecode(std.testing.allocator, at_limit);
    defer std.testing.allocator.free(decoded);
    try std.testing.expectEqual(MAX_URL_DECODE_LENGTH, decoded.len);
}

test "MAX_URL_DECODE_LENGTH constant is reasonable" {
    // Verify the constant exists and has a reasonable value
    try std.testing.expect(MAX_URL_DECODE_LENGTH > 0);
    try std.testing.expect(MAX_URL_DECODE_LENGTH >= 1024); // At least 1KB
    try std.testing.expect(MAX_URL_DECODE_LENGTH <= 1024 * 1024); // At most 1MB
    try std.testing.expectEqual(@as(usize, 64 * 1024), MAX_URL_DECODE_LENGTH); // Exactly 64KB
}

// =============================================================================
// Security Tests - Strict DSN Parsing (CWE-20)
// =============================================================================

test "parseDSNStrict accepts valid DSN" {
    const cfg = try parseDSNStrict(std.testing.allocator, "localhost:8443");
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 8443), cfg.port);
}

test "parseDSNStrict rejects invalid port" {
    try std.testing.expectError(error.InvalidPort, parseDSNStrict(std.testing.allocator, "localhost:invalid"));
}

test "parseDSNStrict rejects invalid port in IPv6" {
    try std.testing.expectError(error.InvalidPort, parseDSNStrict(std.testing.allocator, "[::1]:abc"));
}

test "parseDSNStrict rejects invalid page_size" {
    try std.testing.expectError(error.InvalidPageSize, parseDSNStrict(std.testing.allocator, "localhost:3141?page_size=invalid"));
}

test "parseDSNStrict rejects invalid timeout" {
    try std.testing.expectError(error.InvalidTimeout, parseDSNStrict(std.testing.allocator, "localhost:3141?timeout=invalid"));
}

test "parseDSNStrict accepts valid query parameters" {
    const cfg = try parseDSNStrict(std.testing.allocator, "localhost:3141?page_size=500&timeout=60000&insecure=true");
    try std.testing.expectEqual(@as(u32, 500), cfg.page_size);
    try std.testing.expectEqual(@as(u32, 60000), cfg.timeout_ms);
    try std.testing.expect(cfg.insecure);
}

test "parseDSNStrict accepts valid URL format with credentials" {
    var cfg = try parseDSNStrict(std.testing.allocator, "geode://admin:secret@localhost:3141");
    defer cfg.deinit(std.testing.allocator);
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
    try std.testing.expectEqualStrings("admin", cfg.username.?);
}

test "parseDSNStrict handles empty string" {
    const cfg = try parseDSNStrict(std.testing.allocator, "");
    try std.testing.expectEqualStrings("127.0.0.1", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "parseDSN vs parseDSNStrict behavior comparison" {
    // parseDSN silently uses default for invalid port
    const lenient_cfg = try parseDSN(std.testing.allocator, "localhost:invalid");
    try std.testing.expectEqual(@as(u16, 3141), lenient_cfg.port);

    // parseDSNStrict returns error for invalid port
    try std.testing.expectError(error.InvalidPort, parseDSNStrict(std.testing.allocator, "localhost:invalid"));
}
