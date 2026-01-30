// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Authentication support for the Geode Zig client library.
// Provides user management, role management, and Row-Level Security (RLS) policies.
//
// SECURITY: All user-provided strings are JSON-escaped using appendEscapedString()
// to prevent JSON injection attacks. See GAP_ANALYSIS.md Finding 1.

const std = @import("std");
const protocol = @import("protocol");
const validate = @import("validate");

// =============================================================================
// JSON Escaping (Security-Critical)
// =============================================================================

/// Append a JSON-escaped string to a buffer.
/// Properly escapes quotes, backslashes, and control characters to prevent JSON injection.
/// This function is security-critical - it prevents CWE-116 (Improper Encoding/Escaping).
fn appendEscapedString(allocator: std.mem.Allocator, buf: *std.ArrayListUnmanaged(u8), s: []const u8) !void {
    for (s) |c| {
        switch (c) {
            '"' => try buf.appendSlice(allocator, "\\\""),
            '\\' => try buf.appendSlice(allocator, "\\\\"),
            '\n' => try buf.appendSlice(allocator, "\\n"),
            '\r' => try buf.appendSlice(allocator, "\\r"),
            '\t' => try buf.appendSlice(allocator, "\\t"),
            else => {
                if (c < 0x20) {
                    // Control characters as \uXXXX
                    var escape_buf: [6]u8 = undefined;
                    _ = std.fmt.bufPrint(&escape_buf, "\\u{x:0>4}", .{c}) catch unreachable;
                    try buf.appendSlice(allocator, &escape_buf);
                } else {
                    try buf.append(allocator, c);
                }
            },
        }
    }
}

/// Authentication credentials.
pub const Credentials = struct {
    username: []const u8,
    password: []const u8,

    const Self = @This();

    /// Create new credentials.
    pub fn init(username: []const u8, password: []const u8) Self {
        return Self{
            .username = username,
            .password = password,
        };
    }
};

/// User information returned from the server.
pub const UserInfo = struct {
    allocator: std.mem.Allocator,
    /// Username
    username: []const u8,
    /// User's roles
    roles: []const []const u8,
    /// Whether the user is active
    is_active: bool,
    /// When the user was created (ISO 8601)
    created_at: ?[]const u8,
    /// When the user last logged in (ISO 8601)
    last_login: ?[]const u8,

    const Self = @This();

    /// Create user info with minimal fields.
    pub fn init(allocator: std.mem.Allocator, username: []const u8) !Self {
        return Self{
            .allocator = allocator,
            .username = try allocator.dupe(u8, username),
            .roles = &[_][]const u8{},
            .is_active = true,
            .created_at = null,
            .last_login = null,
        };
    }

    /// Free resources.
    pub fn deinit(self: *Self) void {
        self.allocator.free(self.username);
        for (self.roles) |role| {
            self.allocator.free(role);
        }
        if (self.roles.len > 0) {
            self.allocator.free(self.roles);
        }
        if (self.created_at) |ca| {
            self.allocator.free(ca);
        }
        if (self.last_login) |ll| {
            self.allocator.free(ll);
        }
    }
};

/// Role information.
pub const RoleInfo = struct {
    allocator: std.mem.Allocator,
    /// Role name
    name: []const u8,
    /// Role description
    description: ?[]const u8,
    /// Permissions granted to this role
    permissions: []const []const u8,

    const Self = @This();

    /// Create role info.
    pub fn init(allocator: std.mem.Allocator, name: []const u8) !Self {
        return Self{
            .allocator = allocator,
            .name = try allocator.dupe(u8, name),
            .description = null,
            .permissions = &[_][]const u8{},
        };
    }

    /// Free resources.
    pub fn deinit(self: *Self) void {
        self.allocator.free(self.name);
        if (self.description) |desc| {
            self.allocator.free(desc);
        }
        for (self.permissions) |perm| {
            self.allocator.free(perm);
        }
        if (self.permissions.len > 0) {
            self.allocator.free(self.permissions);
        }
    }
};

/// Row-Level Security (RLS) policy definition.
pub const RlsPolicy = struct {
    allocator: std.mem.Allocator,
    /// Policy name
    name: []const u8,
    /// Label or type this policy applies to
    target_label: []const u8,
    /// Policy type: "select", "insert", "update", "delete", or "all"
    policy_type: PolicyType,
    /// GQL predicate expression for filtering
    predicate: []const u8,
    /// Roles this policy applies to (empty = all roles)
    roles: []const []const u8,
    /// Whether the policy is enabled
    enabled: bool,

    const Self = @This();

    pub const PolicyType = enum {
        select,
        insert,
        update,
        delete,
        all,

        pub fn toString(self: PolicyType) []const u8 {
            return switch (self) {
                .select => "SELECT",
                .insert => "INSERT",
                .update => "UPDATE",
                .delete => "DELETE",
                .all => "ALL",
            };
        }
    };

    /// Create a new RLS policy.
    pub fn init(
        allocator: std.mem.Allocator,
        name: []const u8,
        target_label: []const u8,
        policy_type: PolicyType,
        predicate: []const u8,
    ) !Self {
        return Self{
            .allocator = allocator,
            .name = try allocator.dupe(u8, name),
            .target_label = try allocator.dupe(u8, target_label),
            .policy_type = policy_type,
            .predicate = try allocator.dupe(u8, predicate),
            .roles = &[_][]const u8{},
            .enabled = true,
        };
    }

    /// Free resources.
    pub fn deinit(self: *Self) void {
        self.allocator.free(self.name);
        self.allocator.free(self.target_label);
        self.allocator.free(self.predicate);
        for (self.roles) |role| {
            self.allocator.free(role);
        }
        if (self.roles.len > 0) {
            self.allocator.free(self.roles);
        }
    }
};

/// Authentication client for managing users, roles, and RLS policies.
pub const AuthClient = struct {
    allocator: std.mem.Allocator,
    /// Current authenticated user (if any)
    current_user: ?[]const u8,
    /// Session token (if authenticated)
    session_token: ?[]const u8,

    const Self = @This();

    /// Create a new auth client.
    pub fn init(allocator: std.mem.Allocator) Self {
        return Self{
            .allocator = allocator,
            .current_user = null,
            .session_token = null,
        };
    }

    /// Free resources.
    /// SECURITY: Zeros sensitive data before freeing to prevent memory disclosure (CWE-316, CWE-226).
    pub fn deinit(self: *Self) void {
        if (self.current_user) |user| {
            self.allocator.free(user);
        }
        if (self.session_token) |token| {
            // SECURITY: Zero sensitive token data before freeing (CWE-316, CWE-226)
            // This prevents session tokens from remaining in freed memory
            @memset(@constCast(token), 0);
            self.allocator.free(token);
        }
    }

    /// Check if currently authenticated.
    pub fn isAuthenticated(self: Self) bool {
        return self.session_token != null;
    }

    /// Get the current user name.
    pub fn getCurrentUser(self: Self) ?[]const u8 {
        return self.current_user;
    }

    /// Build a login message.
    /// SECURITY: Username and password are JSON-escaped to prevent injection.
    pub fn buildLoginMessage(self: Self, username: []const u8, password: []const u8) ![]u8 {
        return buildAuthMessage(self.allocator, "LOGIN", username, password);
    }

    /// Build a logout message.
    pub fn buildLogoutMessage(self: Self) ![]u8 {
        return buildSimpleAuthMessage(self.allocator, "LOGOUT");
    }

    /// Build a create user message.
    /// SECURITY: All user-provided values are JSON-escaped to prevent injection.
    pub fn buildCreateUserMessage(
        self: Self,
        username: []const u8,
        password: []const u8,
        roles: ?[]const []const u8,
    ) ![]u8 {
        var msg: std.ArrayListUnmanaged(u8) = .{};
        errdefer msg.deinit(self.allocator);

        try msg.appendSlice(self.allocator, "{\"type\":\"CREATE_USER\",\"username\":\"");
        try appendEscapedString(self.allocator, &msg, username);
        try msg.appendSlice(self.allocator, "\",\"password\":\"");
        try appendEscapedString(self.allocator, &msg, password);
        try msg.appendSlice(self.allocator, "\"");

        if (roles) |r| {
            try msg.appendSlice(self.allocator, ",\"roles\":[");
            for (r, 0..) |role, i| {
                if (i > 0) {
                    try msg.appendSlice(self.allocator, ",");
                }
                try msg.appendSlice(self.allocator, "\"");
                try appendEscapedString(self.allocator, &msg, role);
                try msg.appendSlice(self.allocator, "\"");
            }
            try msg.appendSlice(self.allocator, "]");
        }

        try msg.appendSlice(self.allocator, "}\n");
        return msg.toOwnedSlice(self.allocator);
    }

    /// Build a create role message.
    /// SECURITY: All user-provided values are JSON-escaped to prevent injection.
    pub fn buildCreateRoleMessage(
        self: Self,
        name: []const u8,
        description: ?[]const u8,
        permissions: ?[]const []const u8,
    ) ![]u8 {
        var msg: std.ArrayListUnmanaged(u8) = .{};
        errdefer msg.deinit(self.allocator);

        try msg.appendSlice(self.allocator, "{\"type\":\"CREATE_ROLE\",\"name\":\"");
        try appendEscapedString(self.allocator, &msg, name);
        try msg.appendSlice(self.allocator, "\"");

        if (description) |desc| {
            try msg.appendSlice(self.allocator, ",\"description\":\"");
            try appendEscapedString(self.allocator, &msg, desc);
            try msg.appendSlice(self.allocator, "\"");
        }

        if (permissions) |perms| {
            try msg.appendSlice(self.allocator, ",\"permissions\":[");
            for (perms, 0..) |perm, i| {
                if (i > 0) {
                    try msg.appendSlice(self.allocator, ",");
                }
                try msg.appendSlice(self.allocator, "\"");
                try appendEscapedString(self.allocator, &msg, perm);
                try msg.appendSlice(self.allocator, "\"");
            }
            try msg.appendSlice(self.allocator, "]");
        }

        try msg.appendSlice(self.allocator, "}\n");
        return msg.toOwnedSlice(self.allocator);
    }

    /// Build an assign role message.
    /// SECURITY: All user-provided values are JSON-escaped to prevent injection.
    pub fn buildAssignRoleMessage(
        self: Self,
        username: []const u8,
        role: []const u8,
    ) ![]u8 {
        var msg: std.ArrayListUnmanaged(u8) = .{};
        errdefer msg.deinit(self.allocator);

        try msg.appendSlice(self.allocator, "{\"type\":\"ASSIGN_ROLE\",\"username\":\"");
        try appendEscapedString(self.allocator, &msg, username);
        try msg.appendSlice(self.allocator, "\",\"role\":\"");
        try appendEscapedString(self.allocator, &msg, role);
        try msg.appendSlice(self.allocator, "\"}\n");

        return msg.toOwnedSlice(self.allocator);
    }

    /// Build a revoke role message.
    /// SECURITY: All user-provided values are JSON-escaped to prevent injection.
    pub fn buildRevokeRoleMessage(
        self: Self,
        username: []const u8,
        role: []const u8,
    ) ![]u8 {
        var msg: std.ArrayListUnmanaged(u8) = .{};
        errdefer msg.deinit(self.allocator);

        try msg.appendSlice(self.allocator, "{\"type\":\"REVOKE_ROLE\",\"username\":\"");
        try appendEscapedString(self.allocator, &msg, username);
        try msg.appendSlice(self.allocator, "\",\"role\":\"");
        try appendEscapedString(self.allocator, &msg, role);
        try msg.appendSlice(self.allocator, "\"}\n");

        return msg.toOwnedSlice(self.allocator);
    }

    /// Build a create RLS policy message.
    /// SECURITY: All user-provided values are JSON-escaped to prevent injection.
    pub fn buildCreateRlsPolicyMessage(
        self: Self,
        policy: RlsPolicy,
    ) ![]u8 {
        var msg: std.ArrayListUnmanaged(u8) = .{};
        errdefer msg.deinit(self.allocator);

        try msg.appendSlice(self.allocator, "{\"type\":\"CREATE_RLS_POLICY\",\"name\":\"");
        try appendEscapedString(self.allocator, &msg, policy.name);
        try msg.appendSlice(self.allocator, "\",\"target\":\"");
        try appendEscapedString(self.allocator, &msg, policy.target_label);
        try msg.appendSlice(self.allocator, "\",\"policy_type\":\"");
        try msg.appendSlice(self.allocator, policy.policy_type.toString());
        try msg.appendSlice(self.allocator, "\",\"predicate\":\"");
        try appendEscapedString(self.allocator, &msg, policy.predicate);
        try msg.appendSlice(self.allocator, "\"");

        if (policy.roles.len > 0) {
            try msg.appendSlice(self.allocator, ",\"roles\":[");
            for (policy.roles, 0..) |role, i| {
                if (i > 0) {
                    try msg.appendSlice(self.allocator, ",");
                }
                try msg.appendSlice(self.allocator, "\"");
                try appendEscapedString(self.allocator, &msg, role);
                try msg.appendSlice(self.allocator, "\"");
            }
            try msg.appendSlice(self.allocator, "]");
        }

        try msg.appendSlice(self.allocator, ",\"enabled\":");
        try msg.appendSlice(self.allocator, if (policy.enabled) "true" else "false");
        try msg.appendSlice(self.allocator, "}\n");

        return msg.toOwnedSlice(self.allocator);
    }

    /// Build a drop RLS policy message.
    /// SECURITY: Policy name is JSON-escaped to prevent injection.
    pub fn buildDropRlsPolicyMessage(
        self: Self,
        policy_name: []const u8,
    ) ![]u8 {
        var msg: std.ArrayListUnmanaged(u8) = .{};
        errdefer msg.deinit(self.allocator);

        try msg.appendSlice(self.allocator, "{\"type\":\"DROP_RLS_POLICY\",\"name\":\"");
        try appendEscapedString(self.allocator, &msg, policy_name);
        try msg.appendSlice(self.allocator, "\"}\n");

        return msg.toOwnedSlice(self.allocator);
    }

    /// Set authenticated state.
    /// SECURITY: Zeros old session token before freeing to prevent memory disclosure (CWE-316, CWE-226).
    pub fn setAuthenticated(self: *Self, username: []const u8, token: []const u8) !void {
        if (self.current_user) |old| {
            self.allocator.free(old);
        }
        if (self.session_token) |old| {
            // SECURITY: Zero old token before freeing (CWE-316, CWE-226)
            @memset(@constCast(old), 0);
            self.allocator.free(old);
        }
        self.current_user = try self.allocator.dupe(u8, username);
        self.session_token = try self.allocator.dupe(u8, token);
    }

    /// Clear authenticated state.
    /// SECURITY: Zeros sensitive data before freeing to prevent memory disclosure (CWE-316, CWE-226).
    pub fn clearAuthentication(self: *Self) void {
        if (self.current_user) |user| {
            self.allocator.free(user);
            self.current_user = null;
        }
        if (self.session_token) |token| {
            // SECURITY: Zero sensitive token data before freeing (CWE-316, CWE-226)
            // This prevents session tokens from remaining in freed memory
            @memset(@constCast(token), 0);
            self.allocator.free(token);
            self.session_token = null;
        }
    }
};

/// Errors specific to authentication operations.
pub const AuthError = error{
    /// Invalid credentials provided
    InvalidCredentials,
    /// User not authenticated
    NotAuthenticated,
    /// Insufficient permissions
    InsufficientPermissions,
    /// User already exists
    UserAlreadyExists,
    /// User not found
    UserNotFound,
    /// Role already exists
    RoleAlreadyExists,
    /// Role not found
    RoleNotFound,
    /// Policy already exists
    PolicyAlreadyExists,
    /// Policy not found
    PolicyNotFound,
};

// Helper to build auth message with username/password
// SECURITY: Uses appendEscapedString for user-provided values to prevent JSON injection
fn buildAuthMessage(allocator: std.mem.Allocator, msg_type: []const u8, username: []const u8, password: []const u8) ![]u8 {
    var msg: std.ArrayListUnmanaged(u8) = .{};
    errdefer msg.deinit(allocator);

    try msg.appendSlice(allocator, "{\"type\":\"");
    try msg.appendSlice(allocator, msg_type);
    try msg.appendSlice(allocator, "\",\"username\":\"");
    try appendEscapedString(allocator, &msg, username);
    try msg.appendSlice(allocator, "\",\"password\":\"");
    try appendEscapedString(allocator, &msg, password);
    try msg.appendSlice(allocator, "\"}\n");

    return msg.toOwnedSlice(allocator);
}

// Helper to build simple auth message
fn buildSimpleAuthMessage(allocator: std.mem.Allocator, msg_type: []const u8) ![]u8 {
    var msg: std.ArrayListUnmanaged(u8) = .{};
    errdefer msg.deinit(allocator);

    try msg.appendSlice(allocator, "{\"type\":\"");
    try msg.appendSlice(allocator, msg_type);
    try msg.appendSlice(allocator, "\"}\n");

    return msg.toOwnedSlice(allocator);
}

// =============================================================================
// Unit Tests
// =============================================================================

test "Credentials init" {
    const creds = Credentials.init("admin", "secret");
    try std.testing.expectEqualStrings("admin", creds.username);
    try std.testing.expectEqualStrings("secret", creds.password);
}

test "UserInfo basic creation" {
    var info = try UserInfo.init(std.testing.allocator, "testuser");
    defer info.deinit();

    try std.testing.expectEqualStrings("testuser", info.username);
    try std.testing.expect(info.is_active);
    try std.testing.expectEqual(@as(usize, 0), info.roles.len);
}

test "RoleInfo basic creation" {
    var role = try RoleInfo.init(std.testing.allocator, "admin");
    defer role.deinit();

    try std.testing.expectEqualStrings("admin", role.name);
    try std.testing.expect(role.description == null);
}

test "RlsPolicy creation" {
    var policy = try RlsPolicy.init(
        std.testing.allocator,
        "user_data_policy",
        "Person",
        .select,
        "n.owner = $current_user",
    );
    defer policy.deinit();

    try std.testing.expectEqualStrings("user_data_policy", policy.name);
    try std.testing.expectEqualStrings("Person", policy.target_label);
    try std.testing.expectEqual(RlsPolicy.PolicyType.select, policy.policy_type);
    try std.testing.expectEqualStrings("n.owner = $current_user", policy.predicate);
    try std.testing.expect(policy.enabled);
}

test "PolicyType toString" {
    try std.testing.expectEqualStrings("SELECT", RlsPolicy.PolicyType.select.toString());
    try std.testing.expectEqualStrings("INSERT", RlsPolicy.PolicyType.insert.toString());
    try std.testing.expectEqualStrings("UPDATE", RlsPolicy.PolicyType.update.toString());
    try std.testing.expectEqualStrings("DELETE", RlsPolicy.PolicyType.delete.toString());
    try std.testing.expectEqualStrings("ALL", RlsPolicy.PolicyType.all.toString());
}

test "AuthClient basic creation" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    try std.testing.expect(!client.isAuthenticated());
    try std.testing.expect(client.getCurrentUser() == null);
}

test "AuthClient authentication state" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    try client.setAuthenticated("admin", "token123");
    try std.testing.expect(client.isAuthenticated());
    try std.testing.expectEqualStrings("admin", client.getCurrentUser().?);

    client.clearAuthentication();
    try std.testing.expect(!client.isAuthenticated());
    try std.testing.expect(client.getCurrentUser() == null);
}

test "AuthClient buildLoginMessage" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const msg = try client.buildLoginMessage("admin", "secret");
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"LOGIN\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"username\":\"admin\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"password\":\"secret\"") != null);
}

test "AuthClient buildLogoutMessage" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const msg = try client.buildLogoutMessage();
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"LOGOUT\"") != null);
}

test "AuthClient buildCreateUserMessage" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const roles = [_][]const u8{ "reader", "writer" };
    const msg = try client.buildCreateUserMessage("newuser", "password123", &roles);
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"CREATE_USER\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"username\":\"newuser\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"roles\":[") != null);
}

test "AuthClient buildCreateRoleMessage" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const perms = [_][]const u8{ "read", "write" };
    const msg = try client.buildCreateRoleMessage("editor", "Can edit content", &perms);
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"CREATE_ROLE\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"name\":\"editor\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"description\":\"Can edit content\"") != null);
}

test "AuthClient buildAssignRoleMessage" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const msg = try client.buildAssignRoleMessage("alice", "admin");
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"ASSIGN_ROLE\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"username\":\"alice\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"role\":\"admin\"") != null);
}

test "AuthClient buildCreateRlsPolicyMessage" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    var policy = try RlsPolicy.init(
        std.testing.allocator,
        "my_policy",
        "Node",
        .all,
        "n.public = true",
    );
    defer policy.deinit();

    const msg = try client.buildCreateRlsPolicyMessage(policy);
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"CREATE_RLS_POLICY\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"name\":\"my_policy\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"policy_type\":\"ALL\"") != null);
}

test "AuthClient buildDropRlsPolicyMessage" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const msg = try client.buildDropRlsPolicyMessage("old_policy");
    defer std.testing.allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"DROP_RLS_POLICY\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"name\":\"old_policy\"") != null);
}

// =============================================================================
// Security Tests - JSON Injection Prevention
// =============================================================================

test "appendEscapedString escapes quotes" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedString(std.testing.allocator, &buf, "hello\"world");
    try std.testing.expectEqualStrings("hello\\\"world", buf.items);
}

test "appendEscapedString escapes backslashes" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedString(std.testing.allocator, &buf, "path\\to\\file");
    try std.testing.expectEqualStrings("path\\\\to\\\\file", buf.items);
}

test "appendEscapedString escapes newlines and tabs" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedString(std.testing.allocator, &buf, "line1\nline2\ttab");
    try std.testing.expectEqualStrings("line1\\nline2\\ttab", buf.items);
}

test "appendEscapedString escapes control characters" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedString(std.testing.allocator, &buf, "test\x00null");
    // Control char \x00 should become \u0000
    try std.testing.expect(std.mem.indexOf(u8, buf.items, "\\u0000") != null);
}

test "buildLoginMessage escapes special characters in username" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    // Attempt JSON injection via username
    const msg = try client.buildLoginMessage("admin\",\"injected\":\"true", "secret");
    defer std.testing.allocator.free(msg);

    // The quotes should be escaped, preventing injection
    try std.testing.expect(std.mem.indexOf(u8, msg, "\\\"") != null);
    // Should NOT contain unescaped injected field
    try std.testing.expect(std.mem.indexOf(u8, msg, ",\"injected\":") == null);
}

test "buildLoginMessage escapes special characters in password" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    // Attempt JSON injection via password
    const msg = try client.buildLoginMessage("admin", "pass\",\"admin\":true}");
    defer std.testing.allocator.free(msg);

    // The quotes should be escaped
    try std.testing.expect(std.mem.indexOf(u8, msg, "\\\"") != null);
}

test "buildCreateUserMessage escapes injection attempts" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const roles = [_][]const u8{"admin\",\"superuser\":\"true"};
    const msg = try client.buildCreateUserMessage("user\"}", "pass", &roles);
    defer std.testing.allocator.free(msg);

    // Verify escaping occurred
    try std.testing.expect(std.mem.indexOf(u8, msg, "\\\"") != null);
}

// =============================================================================
// Security Tests - Sensitive Data Zeroing (CWE-316, CWE-226)
// =============================================================================

test "clearAuthentication zeros and frees session token" {
    // This test verifies the sensitive data clearing path is executed correctly.
    // Note: We cannot directly verify memory is zeroed without undefined behavior,
    // but we verify the code path executes without errors and state is cleared.
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    // Set authentication with a sensitive token
    try client.setAuthenticated("admin", "supersecrettoken12345");
    try std.testing.expect(client.isAuthenticated());
    try std.testing.expectEqualStrings("admin", client.getCurrentUser().?);

    // Clear authentication - this should zero the token before freeing
    client.clearAuthentication();

    // Verify state is properly cleared
    try std.testing.expect(!client.isAuthenticated());
    try std.testing.expect(client.getCurrentUser() == null);
    try std.testing.expect(client.session_token == null);
}

test "setAuthenticated zeros old token when replacing" {
    // Verify that when we replace an existing session token, the old one is zeroed
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    // Set initial authentication
    try client.setAuthenticated("user1", "oldtoken123");
    try std.testing.expectEqualStrings("user1", client.getCurrentUser().?);

    // Replace with new authentication - old token should be zeroed before free
    try client.setAuthenticated("user2", "newtoken456");
    try std.testing.expectEqualStrings("user2", client.getCurrentUser().?);

    // Verify no memory leaks (allocator will detect if deinit fails)
}

test "deinit zeros session token" {
    // Verify deinit path zeros the session token
    var client = AuthClient.init(std.testing.allocator);

    // Set authentication
    try client.setAuthenticated("admin", "tokentobezeroed");
    try std.testing.expect(client.isAuthenticated());

    // deinit should zero and free the token
    client.deinit();

    // If we get here without allocator errors, zeroing + free worked correctly
}
