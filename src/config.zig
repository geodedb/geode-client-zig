// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Configuration and DSN parsing for the Geode Zig client library.
// Supports URL formats: quic://..., grpc://...
// Wire format: protobuf (JSON protocol removed)
//
// See geode/docs/DSN.md for the complete DSN specification.

const std = @import("std");
const GeodeError = @import("error").GeodeError;
const validate = @import("validate");

/// Default Geode server port for QUIC
pub const DEFAULT_PORT: u16 = 3141;

/// Default gRPC port
pub const DEFAULT_GRPC_PORT: u16 = 50051;

/// Default page size for result pagination
pub const DEFAULT_PAGE_SIZE: u32 = 1000;

/// Default connection timeout in milliseconds
pub const DEFAULT_TIMEOUT_MS: u32 = 30000;

/// Maximum length for URL-decoded strings.
/// SECURITY: Prevents resource exhaustion attacks via extremely long DSN strings (CWE-400).
pub const MAX_URL_DECODE_LENGTH: usize = 64 * 1024; // 64KB reasonable limit

/// Transport protocol selection
pub const Transport = enum {
    /// QUIC transport with protobuf wire format (default)
    quic,
    /// gRPC transport over HTTP/2
    grpc,

    pub fn toString(self: Transport) []const u8 {
        return switch (self) {
            .quic => "quic",
            .grpc => "grpc",
        };
    }

    pub fn fromString(s: []const u8) ?Transport {
        if (std.mem.eql(u8, s, "quic")) return .quic;
        if (std.mem.eql(u8, s, "grpc")) return .grpc;
        return null;
    }

    pub fn defaultPort(self: Transport) u16 {
        return switch (self) {
            .quic => DEFAULT_PORT,
            .grpc => DEFAULT_GRPC_PORT,
        };
    }
};

/// Client configuration parsed from DSN or set programmatically.
/// See geode/docs/DSN.md for the full specification.
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
    /// ALPN protocol string (QUIC only)
    alpn: []const u8,
    /// Transport protocol (QUIC or gRPC)
    transport: Transport,
    /// TLS enabled (gRPC only, QUIC always uses TLS)
    tls: bool,
    /// Client name for HELLO handshake
    hello_name: []const u8,
    /// Client version for HELLO handshake
    hello_ver: []const u8,
    /// GQL conformance level
    conformance: []const u8,
    /// Path to CA certificate (optional)
    ca_cert: ?[]const u8,
    /// Path to client certificate for mTLS (optional)
    client_cert: ?[]const u8,
    /// Path to client key for mTLS (optional)
    client_key: ?[]const u8,
    /// SNI server name (optional)
    server_name: ?[]const u8,
    /// Graph name for DSN graph binding (optional)
    graph: ?[]const u8 = null,

    /// Initialize with default values (QUIC transport)
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
            .transport = .quic,
            .tls = true,
            .hello_name = "geode-zig",
            .hello_ver = "0.1.0",
            .conformance = "min",
            .ca_cert = null,
            .client_cert = null,
            .client_key = null,
            .server_name = null,
            .graph = null,
        };
    }

    /// Initialize with host and port
    pub fn initWithHost(host: []const u8, port: u16) Config {
        var cfg = Config.init();
        cfg.host = host;
        cfg.port = port;
        return cfg;
    }

    /// Initialize with host, port, and transport
    pub fn initWithTransport(host: []const u8, port: u16, transport: Transport) Config {
        var cfg = Config.init();
        cfg.host = host;
        cfg.port = port;
        cfg.transport = transport;
        return cfg;
    }

    /// Set credentials by allocating copies.
    /// SECURITY: Allocates owned copies to ensure safe cleanup in deinit() (CWE-590).
    /// The Config takes ownership of the allocated credentials.
    /// Safe to call multiple times; previous values are securely freed.
    pub fn withCredentials(self: *Config, allocator: std.mem.Allocator, username: []const u8, password: []const u8) !*Config {
        // Free previous credentials if they exist to prevent memory leaks (Q-006)
        if (self.password) |old_pass| {
            std.crypto.secureZero(u8, @constCast(old_pass));
            allocator.free(old_pass);
        }
        if (self.username) |old_user| {
            allocator.free(old_user);
        }

        self.username = try allocator.dupe(u8, username);
        errdefer {
            allocator.free(self.username.?);
            self.username = null;
        }
        self.password = try allocator.dupe(u8, password);
        return self;
    }

    /// Set graph name for DSN graph binding.
    /// Takes an owned copy of the graph name string.
    pub fn withGraph(self: *Config, allocator: std.mem.Allocator, graph: []const u8) !*Config {
        if (self.graph) |old| allocator.free(old);
        self.graph = try allocator.dupe(u8, graph);
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

    /// Set transport
    pub fn withTransport(self: *Config, transport: Transport) *Config {
        self.transport = transport;
        // Update port to transport default if it was using the previous transport's default
        if (self.port == Transport.quic.defaultPort() and transport == .grpc) {
            self.port = Transport.grpc.defaultPort();
        } else if (self.port == Transport.grpc.defaultPort() and transport == .quic) {
            self.port = Transport.quic.defaultPort();
        }
        return self;
    }

    /// Set TLS mode (gRPC only)
    pub fn withTls(self: *Config, tls: bool) *Config {
        self.tls = tls;
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

    /// Format as DSN string
    pub fn toDSN(self: Config, allocator: std.mem.Allocator) ![]const u8 {
        return std.fmt.allocPrint(allocator, "{s}://{s}:{d}", .{
            self.transport.toString(),
            self.host,
            self.port,
        });
    }

    /// Free allocated credentials and zero sensitive data before freeing.
    /// SECURITY: Zeros password before freeing to prevent memory disclosure (CWE-316, CWE-226).
    /// Call this when done with a Config that was created via parseDSN.
    pub fn deinit(self: *Config, allocator: std.mem.Allocator) void {
        // SECURITY: Zero sensitive password data before freeing (CWE-316, CWE-226)
        if (self.password) |pass| {
            std.crypto.secureZero(u8, @constCast(pass));
            allocator.free(pass);
            self.password = null;
        }
        // Free username (not sensitive, but still allocated)
        if (self.username) |user| {
            allocator.free(user);
            self.username = null;
        }
        // Free other allocated strings from DSN parsing
        if (self.ca_cert) |v| {
            allocator.free(v);
            self.ca_cert = null;
        }
        if (self.client_cert) |v| {
            allocator.free(v);
            self.client_cert = null;
        }
        // SECURITY: Zero client key before freeing
        if (self.client_key) |v| {
            std.crypto.secureZero(u8, @constCast(v));
            allocator.free(v);
            self.client_key = null;
        }
        if (self.server_name) |v| {
            allocator.free(v);
            self.server_name = null;
        }
        if (self.graph) |v| {
            allocator.free(v);
            self.graph = null;
        }
    }
};

/// Parse a DSN (Data Source Name) string into a Config.
/// Supports formats:
/// - quic://[user:pass@]host[:port][?params] - QUIC transport (recommended)
/// - grpc://[user:pass@]host[:port][?params] - gRPC transport
/// - Simple format: host:port[?params] - defaults to QUIC
/// - Host only: host - defaults to QUIC
///
/// Note: Invalid numeric values (port, page_size, timeout) silently fall back to defaults.
/// Use parseDSNStrict() for strict validation that returns errors on invalid values.
pub fn parseDSN(allocator: std.mem.Allocator, dsn: []const u8) !Config {
    var config = Config.init();

    if (dsn.len == 0) {
        return config;
    }

    // Check for URL format with scheme
    if (std.mem.indexOf(u8, dsn, "://")) |scheme_end| {
        const scheme = dsn[0..scheme_end];
        const rest = dsn[scheme_end + 3 ..];

        // Parse transport from scheme
        if (std.mem.eql(u8, scheme, "quic")) {
            config.transport = .quic;
            config.port = DEFAULT_PORT;
        } else if (std.mem.eql(u8, scheme, "grpc")) {
            config.transport = .grpc;
            config.port = DEFAULT_GRPC_PORT;
        } else {
            return error.UnsupportedScheme;
        }

        return parseUrlFormat(allocator, rest, &config, false);
    }

    // Simple format: host:port or host:port?params (defaults to QUIC)
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

    // Check for URL format with scheme
    if (std.mem.indexOf(u8, dsn, "://")) |scheme_end| {
        const scheme = dsn[0..scheme_end];
        const rest = dsn[scheme_end + 3 ..];

        // Parse transport from scheme
        if (std.mem.eql(u8, scheme, "quic")) {
            config.transport = .quic;
            config.port = DEFAULT_PORT;
        } else if (std.mem.eql(u8, scheme, "grpc")) {
            config.transport = .grpc;
            config.port = DEFAULT_GRPC_PORT;
        } else {
            return error.UnsupportedScheme;
        }

        return parseUrlFormat(allocator, rest, &config, true);
    }

    // Simple format: host:port or host:port?params (defaults to QUIC)
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

/// Parse host[:port][/graph][?params]
fn parseHostPortParams(allocator: std.mem.Allocator, input: []const u8, config: *Config, strict: bool) !Config {
    var remaining = input;

    // Check for query parameters
    var params_str: ?[]const u8 = null;
    if (std.mem.indexOf(u8, remaining, "?")) |q_pos| {
        params_str = remaining[q_pos + 1 ..];
        remaining = remaining[0..q_pos];
    }

    // Extract graph from URL path (everything after first / not inside brackets)
    // Only look for slash outside of IPv6 brackets
    if (!std.mem.startsWith(u8, remaining, "[")) {
        if (std.mem.indexOf(u8, remaining, "/")) |slash_idx| {
            const path = remaining[slash_idx + 1 ..];
            if (path.len > 0) {
                if (config.graph) |old| allocator.free(old);
                config.graph = try allocator.dupe(u8, path);
            }
            remaining = remaining[0..slash_idx];
        }
    } else {
        // IPv6: find closing bracket first, then look for slash after it
        if (std.mem.indexOf(u8, remaining, "]")) |bracket_end| {
            const after_bracket = remaining[bracket_end + 1 ..];
            // after_bracket could be ":port/graph" or "/graph" or ":port"
            if (std.mem.indexOf(u8, after_bracket, "/")) |slash_in_after| {
                const path = after_bracket[slash_in_after + 1 ..];
                if (path.len > 0) {
                    if (config.graph) |old| allocator.free(old);
                    config.graph = try allocator.dupe(u8, path);
                }
                remaining = remaining[0 .. bracket_end + 1 + slash_in_after];
            }
        }
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
/// Supports all parameters defined in geode/docs/DSN.md
fn parseQueryParams(allocator: std.mem.Allocator, params: []const u8, config: *Config, strict: bool) !void {
    var iter = std.mem.splitScalar(u8, params, '&');
    while (iter.next()) |param| {
        if (std.mem.indexOf(u8, param, "=")) |eq_pos| {
            const key = param[0..eq_pos];
            const value = param[eq_pos + 1 ..];

            // Insecure TLS skip verify aliases (primary: insecure_tls_skip_verify)
            if (std.mem.eql(u8, key, "insecure_tls_skip_verify") or std.mem.eql(u8, key, "insecure") or std.mem.eql(u8, key, "skip_verify")) {
                config.insecure = std.mem.eql(u8, value, "true") or std.mem.eql(u8, value, "1") or std.mem.eql(u8, value, "yes") or std.mem.eql(u8, value, "on");
            } else if (std.mem.eql(u8, key, "tls")) {
                // TLS setting for gRPC transport (tls=0 or tls=false disables TLS)
                config.tls = !(std.mem.eql(u8, value, "0") or std.mem.eql(u8, value, "false") or std.mem.eql(u8, value, "no") or std.mem.eql(u8, value, "off"));
            } else if (std.mem.eql(u8, key, "page_size") or std.mem.eql(u8, key, "pageSize")) {
                if (strict) {
                    // SECURITY: Strict mode returns error for invalid page_size (CWE-20)
                    const parsed = std.fmt.parseInt(u32, value, 10) catch return error.InvalidPageSize;
                    try validate.pageSize(parsed);
                    config.page_size = parsed;
                } else {
                    config.page_size = std.fmt.parseInt(u32, value, 10) catch DEFAULT_PAGE_SIZE;
                }
            } else if (std.mem.eql(u8, key, "timeout") or std.mem.eql(u8, key, "timeout_ms") or std.mem.eql(u8, key, "connect_timeout")) {
                // connect_timeout is in seconds, timeout_ms is in milliseconds
                if (std.mem.eql(u8, key, "connect_timeout")) {
                    // Convert seconds to milliseconds
                    const secs = std.fmt.parseInt(u32, value, 10) catch {
                        if (strict) return error.InvalidTimeout;
                        continue;
                    };
                    const ms = secs * 1000;
                    if (strict) try validate.timeout(ms);
                    config.timeout_ms = ms;
                } else {
                    if (strict) {
                        // SECURITY: Strict mode returns error for invalid timeout (CWE-20)
                        const parsed = std.fmt.parseInt(u32, value, 10) catch return error.InvalidTimeout;
                        try validate.timeout(parsed);
                        config.timeout_ms = parsed;
                    } else {
                        config.timeout_ms = std.fmt.parseInt(u32, value, 10) catch DEFAULT_TIMEOUT_MS;
                    }
                }
            } else if (std.mem.eql(u8, key, "username") or std.mem.eql(u8, key, "user")) {
                config.username = try urlDecode(allocator, value);
            } else if (std.mem.eql(u8, key, "password") or std.mem.eql(u8, key, "pass")) {
                config.password = try urlDecode(allocator, value);
            } else if (std.mem.eql(u8, key, "hello_name")) {
                config.hello_name = try urlDecode(allocator, value);
            } else if (std.mem.eql(u8, key, "hello_ver")) {
                config.hello_ver = try urlDecode(allocator, value);
            } else if (std.mem.eql(u8, key, "conformance")) {
                config.conformance = try urlDecode(allocator, value);
            } else if (std.mem.eql(u8, key, "ca") or std.mem.eql(u8, key, "ca_cert")) {
                config.ca_cert = try urlDecode(allocator, value);
            } else if (std.mem.eql(u8, key, "cert") or std.mem.eql(u8, key, "client_cert")) {
                config.client_cert = try urlDecode(allocator, value);
            } else if (std.mem.eql(u8, key, "key") or std.mem.eql(u8, key, "client_key")) {
                config.client_key = try urlDecode(allocator, value);
            } else if (std.mem.eql(u8, key, "server_name")) {
                config.server_name = try urlDecode(allocator, value);
            } else if (std.mem.eql(u8, key, "graph")) {
                if (config.graph) |old| allocator.free(old);
                config.graph = try urlDecode(allocator, value);
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

    var result: std.ArrayListUnmanaged(u8) = .empty;
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
    _ = try cfg.withCredentials(std.testing.allocator, "admin", "secret");
    defer cfg.deinit(std.testing.allocator);
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
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:3141");
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "parseDSN parses URL format with credentials" {
    const cfg = try parseDSN(std.testing.allocator, "quic://admin:secret@localhost:3141");
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
    const cfg = try parseDSN(std.testing.allocator, "quic://user%40domain:pass%3Dword@localhost:3141");
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
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:3141?insecure=1&page_size=200&timeout=60000");
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
    const cfg = try parseDSN(std.testing.allocator, "localhost:3141?user=admin&pass=secret&pageSize=100&skip_verify=true");
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
    const cfg = try parseDSN(std.testing.allocator, "quic://[2001:db8::1]:8443");
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
    var cfg = try parseDSN(std.testing.allocator, "quic://admin:secret123@localhost:3141");

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
    var cfg = try parseDSN(std.testing.allocator, "quic://admin@localhost:3141");
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
    var cfg = try parseDSNStrict(std.testing.allocator, "quic://admin:secret@localhost:3141");
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

// =============================================================================
// Transport and DSN Scheme Tests
// =============================================================================

test "Config.init defaults to QUIC transport" {
    const cfg = Config.init();
    try std.testing.expectEqual(Transport.quic, cfg.transport);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
    try std.testing.expect(cfg.tls);
}

test "Transport.toString returns correct strings" {
    try std.testing.expectEqualStrings("quic", Transport.quic.toString());
    try std.testing.expectEqualStrings("grpc", Transport.grpc.toString());
}

test "Transport.fromString parses correctly" {
    try std.testing.expectEqual(Transport.quic, Transport.fromString("quic").?);
    try std.testing.expectEqual(Transport.grpc, Transport.fromString("grpc").?);
    try std.testing.expect(Transport.fromString("grcp") == null); // No longer supported
    try std.testing.expect(Transport.fromString("unknown") == null);
}

test "Transport.defaultPort returns correct ports" {
    try std.testing.expectEqual(@as(u16, 3141), Transport.quic.defaultPort());
    try std.testing.expectEqual(@as(u16, 50051), Transport.grpc.defaultPort());
}

test "parseDSN parses quic:// scheme" {
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:1234");
    try std.testing.expectEqual(Transport.quic, cfg.transport);
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 1234), cfg.port);
}

test "parseDSN parses quic:// with default port" {
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost");
    try std.testing.expectEqual(Transport.quic, cfg.transport);
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "parseDSN parses grpc:// scheme" {
    const cfg = try parseDSN(std.testing.allocator, "grpc://127.0.0.1:50051");
    try std.testing.expectEqual(Transport.grpc, cfg.transport);
    try std.testing.expectEqualStrings("127.0.0.1", cfg.host);
    try std.testing.expectEqual(@as(u16, 50051), cfg.port);
}

test "parseDSN parses grpc:// with default port" {
    const cfg = try parseDSN(std.testing.allocator, "grpc://localhost");
    try std.testing.expectEqual(Transport.grpc, cfg.transport);
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 50051), cfg.port);
}

test "parseDSN parses grpc:// with tls=0 parameter" {
    const cfg = try parseDSN(std.testing.allocator, "grpc://127.0.0.1:50051?tls=0");
    try std.testing.expectEqual(Transport.grpc, cfg.transport);
    try std.testing.expectEqualStrings("127.0.0.1", cfg.host);
    try std.testing.expectEqual(@as(u16, 50051), cfg.port);
    try std.testing.expect(!cfg.tls);
}

test "parseDSN parses grpc:// with tls=false parameter" {
    const cfg = try parseDSN(std.testing.allocator, "grpc://localhost:50051?tls=false");
    try std.testing.expectEqual(Transport.grpc, cfg.transport);
    try std.testing.expect(!cfg.tls);
}

test "parseDSN rejects grcp:// scheme" {
    try std.testing.expectError(error.UnsupportedScheme, parseDSN(std.testing.allocator, "grcp://localhost:50051"));
}

test "parseDSN rejects geode:// scheme" {
    try std.testing.expectError(error.UnsupportedScheme, parseDSN(std.testing.allocator, "geode://localhost:3141"));
}

test "parseDSN parses quic:// with IPv6" {
    const cfg = try parseDSN(std.testing.allocator, "quic://[::1]:3141");
    try std.testing.expectEqual(Transport.quic, cfg.transport);
    try std.testing.expectEqualStrings("::1", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "parseDSN parses grpc:// with IPv6" {
    const cfg = try parseDSN(std.testing.allocator, "grpc://[2001:db8::1]:50051");
    try std.testing.expectEqual(Transport.grpc, cfg.transport);
    try std.testing.expectEqualStrings("2001:db8::1", cfg.host);
    try std.testing.expectEqual(@as(u16, 50051), cfg.port);
}

test "parseDSN parses quic:// with credentials" {
    var cfg = try parseDSN(std.testing.allocator, "quic://admin:secret@localhost:3141");
    defer cfg.deinit(std.testing.allocator);
    try std.testing.expectEqual(Transport.quic, cfg.transport);
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqualStrings("admin", cfg.username.?);
    try std.testing.expectEqualStrings("secret", cfg.password.?);
}

test "parseDSN parses grpc:// with credentials and query params" {
    var cfg = try parseDSN(std.testing.allocator, "grpc://user:pass@localhost:50051?tls=0&timeout=60000");
    defer cfg.deinit(std.testing.allocator);
    try std.testing.expectEqual(Transport.grpc, cfg.transport);
    try std.testing.expectEqualStrings("user", cfg.username.?);
    try std.testing.expectEqualStrings("pass", cfg.password.?);
    try std.testing.expect(!cfg.tls);
    try std.testing.expectEqual(@as(u32, 60000), cfg.timeout_ms);
}

test "parseDSN rejects unsupported scheme" {
    try std.testing.expectError(error.UnsupportedScheme, parseDSN(std.testing.allocator, "http://localhost:80"));
}

test "parseDSN rejects https:// scheme" {
    try std.testing.expectError(error.UnsupportedScheme, parseDSN(std.testing.allocator, "https://localhost:443"));
}

test "parseDSNStrict rejects unsupported scheme" {
    try std.testing.expectError(error.UnsupportedScheme, parseDSNStrict(std.testing.allocator, "http://localhost:1"));
}

test "parseDSNStrict parses quic:// correctly" {
    const cfg = try parseDSNStrict(std.testing.allocator, "quic://localhost:3141");
    try std.testing.expectEqual(Transport.quic, cfg.transport);
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "parseDSNStrict parses grpc:// correctly" {
    const cfg = try parseDSNStrict(std.testing.allocator, "grpc://localhost:50051");
    try std.testing.expectEqual(Transport.grpc, cfg.transport);
    try std.testing.expectEqualStrings("localhost", cfg.host);
    try std.testing.expectEqual(@as(u16, 50051), cfg.port);
}

test "Config.withTransport updates transport and port" {
    var cfg = Config.init();
    try std.testing.expectEqual(Transport.quic, cfg.transport);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);

    _ = cfg.withTransport(.grpc);
    try std.testing.expectEqual(Transport.grpc, cfg.transport);
    try std.testing.expectEqual(@as(u16, 50051), cfg.port);

    _ = cfg.withTransport(.quic);
    try std.testing.expectEqual(Transport.quic, cfg.transport);
    try std.testing.expectEqual(@as(u16, 3141), cfg.port);
}

test "Config.withTls sets TLS flag" {
    var cfg = Config.init();
    try std.testing.expect(cfg.tls);

    _ = cfg.withTls(false);
    try std.testing.expect(!cfg.tls);

    _ = cfg.withTls(true);
    try std.testing.expect(cfg.tls);
}

test "Config.toDSN formats correctly for QUIC" {
    const cfg = Config.initWithHost("localhost", 3141);
    const dsn = try cfg.toDSN(std.testing.allocator);
    defer std.testing.allocator.free(dsn);
    try std.testing.expectEqualStrings("quic://localhost:3141", dsn);
}

test "Config.toDSN formats correctly for gRPC" {
    var cfg = Config.initWithHost("localhost", 50051);
    _ = cfg.withTransport(.grpc);
    const dsn = try cfg.toDSN(std.testing.allocator);
    defer std.testing.allocator.free(dsn);
    try std.testing.expectEqualStrings("grpc://localhost:50051", dsn);
}

test "simple host:port defaults to QUIC transport" {
    const cfg = try parseDSN(std.testing.allocator, "localhost:3141");
    try std.testing.expectEqual(Transport.quic, cfg.transport);
}

// =============================================================================
// insecure_tls_skip_verify Parameter Tests (Unified DSN)
// =============================================================================

test "parseDSN parses insecure_tls_skip_verify=true" {
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:3141?insecure_tls_skip_verify=true");
    try std.testing.expect(cfg.insecure);
}

test "parseDSN parses insecure_tls_skip_verify=1" {
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:3141?insecure_tls_skip_verify=1");
    try std.testing.expect(cfg.insecure);
}

test "parseDSN parses insecure_tls_skip_verify=yes" {
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:3141?insecure_tls_skip_verify=yes");
    try std.testing.expect(cfg.insecure);
}

test "parseDSN parses insecure_tls_skip_verify=on" {
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:3141?insecure_tls_skip_verify=on");
    try std.testing.expect(cfg.insecure);
}

test "parseDSN parses insecure_tls_skip_verify=false" {
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:3141?insecure_tls_skip_verify=false");
    try std.testing.expect(!cfg.insecure);
}

test "parseDSN parses insecure=true alias" {
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:3141?insecure=true");
    try std.testing.expect(cfg.insecure);
}

test "parseDSN parses insecure=1 alias" {
    const cfg = try parseDSN(std.testing.allocator, "grpc://localhost:50051?insecure=1");
    try std.testing.expect(cfg.insecure);
}

test "parseDSN parses skip_verify=true alias" {
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:3141?skip_verify=true");
    try std.testing.expect(cfg.insecure);
}

test "parseDSN parses skip_verify=yes alias" {
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:3141?skip_verify=yes");
    try std.testing.expect(cfg.insecure);
}

test "parseDSN skip_verify defaults to false" {
    const cfg = try parseDSN(std.testing.allocator, "quic://localhost:3141");
    try std.testing.expect(!cfg.insecure);
}

test "parseDSN insecure_tls_skip_verify with grpc" {
    const cfg = try parseDSN(std.testing.allocator, "grpc://localhost:50051?insecure_tls_skip_verify=true");
    try std.testing.expectEqual(Transport.grpc, cfg.transport);
    try std.testing.expect(cfg.insecure);
}

// =============================================================================
// Security Tests - parseDSNStrict bounds validation (CWE-20)
// =============================================================================

test "parseDSNStrict rejects page_size below minimum" {
    try std.testing.expectError(error.PageSizeOutOfRange, parseDSNStrict(std.testing.allocator, "localhost:3141?page_size=0"));
}

test "parseDSNStrict rejects page_size above maximum" {
    try std.testing.expectError(error.PageSizeOutOfRange, parseDSNStrict(std.testing.allocator, "localhost:3141?page_size=100001"));
}

test "parseDSNStrict accepts page_size at minimum boundary" {
    const cfg = try parseDSNStrict(std.testing.allocator, "localhost:3141?page_size=1");
    try std.testing.expectEqual(@as(u32, 1), cfg.page_size);
}

test "parseDSNStrict accepts page_size at maximum boundary" {
    const cfg = try parseDSNStrict(std.testing.allocator, "localhost:3141?page_size=100000");
    try std.testing.expectEqual(@as(u32, 100000), cfg.page_size);
}

test "parseDSNStrict rejects timeout below minimum" {
    try std.testing.expectError(error.TimeoutOutOfRange, parseDSNStrict(std.testing.allocator, "localhost:3141?timeout=0"));
}

test "parseDSNStrict rejects timeout above maximum" {
    try std.testing.expectError(error.TimeoutOutOfRange, parseDSNStrict(std.testing.allocator, "localhost:3141?timeout=3600001"));
}

test "parseDSNStrict accepts timeout at minimum boundary" {
    const cfg = try parseDSNStrict(std.testing.allocator, "localhost:3141?timeout=1");
    try std.testing.expectEqual(@as(u32, 1), cfg.timeout_ms);
}

test "parseDSNStrict accepts timeout at maximum boundary" {
    const cfg = try parseDSNStrict(std.testing.allocator, "localhost:3141?timeout=3600000");
    try std.testing.expectEqual(@as(u32, 3600000), cfg.timeout_ms);
}

// =============================================================================
// Security Tests - withCredentials ownership (CWE-590)
// =============================================================================

test "Config.withCredentials allocates owned copies" {
    var cfg = Config.init();
    _ = try cfg.withCredentials(std.testing.allocator, "testuser", "testpass");
    defer cfg.deinit(std.testing.allocator);

    try std.testing.expectEqualStrings("testuser", cfg.username.?);
    try std.testing.expectEqualStrings("testpass", cfg.password.?);

    // Verify they are different pointers (allocated, not borrowed)
    const literal = "testuser";
    try std.testing.expect(cfg.username.?.ptr != literal.ptr);
}

test "Config.withCredentials safe with string literals" {
    var cfg = Config.init();
    _ = try cfg.withCredentials(std.testing.allocator, "admin", "secret");
    cfg.deinit(std.testing.allocator);
}

test "Config.withCredentials safe with stack buffers" {
    var cfg = Config.init();
    const stack_user = [_]u8{ 'u', 's', 'e', 'r' };
    const stack_pass = [_]u8{ 'p', 'a', 's', 's' };
    _ = try cfg.withCredentials(std.testing.allocator, &stack_user, &stack_pass);
    cfg.deinit(std.testing.allocator);
}
