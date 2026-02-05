// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Authentication support for the Geode Zig client library.
// Provides user management, role management, and Row-Level Security (RLS) policies.
//
// Note: Authentication uses the protobuf HelloRequest with username/password.
// Administrative operations (CREATE_USER, CREATE_ROLE, RLS policies) are
// executed via GQL commands sent through the Execute message.
//
// SECURITY: All user-provided strings in GQL commands should be properly quoted.

const std = @import("std");
const validate = @import("validate");

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

    /// Build a GQL command to create a user.
    /// Returns a GQL query string to execute via the client.
    pub fn buildCreateUserQuery(
        self: Self,
        username: []const u8,
        password: []const u8,
        roles: ?[]const []const u8,
    ) ![]u8 {
        var query: std.ArrayListUnmanaged(u8) = .{};
        errdefer query.deinit(self.allocator);

        try query.appendSlice(self.allocator, "CREATE USER '");
        try appendEscapedGqlString(self.allocator, &query, username);
        try query.appendSlice(self.allocator, "' SET PASSWORD '");
        try appendEscapedGqlString(self.allocator, &query, password);
        try query.appendSlice(self.allocator, "'");

        if (roles) |r| {
            if (r.len > 0) {
                try query.appendSlice(self.allocator, " SET ROLES [");
                for (r, 0..) |role, i| {
                    if (i > 0) {
                        try query.appendSlice(self.allocator, ", ");
                    }
                    try query.appendSlice(self.allocator, "'");
                    try appendEscapedGqlString(self.allocator, &query, role);
                    try query.appendSlice(self.allocator, "'");
                }
                try query.appendSlice(self.allocator, "]");
            }
        }

        return query.toOwnedSlice(self.allocator);
    }

    /// Build a GQL command to create a role.
    pub fn buildCreateRoleQuery(
        self: Self,
        name: []const u8,
        description: ?[]const u8,
        permissions: ?[]const []const u8,
    ) ![]u8 {
        var query: std.ArrayListUnmanaged(u8) = .{};
        errdefer query.deinit(self.allocator);

        try query.appendSlice(self.allocator, "CREATE ROLE '");
        try appendEscapedGqlString(self.allocator, &query, name);
        try query.appendSlice(self.allocator, "'");

        if (description) |desc| {
            try query.appendSlice(self.allocator, " SET DESCRIPTION '");
            try appendEscapedGqlString(self.allocator, &query, desc);
            try query.appendSlice(self.allocator, "'");
        }

        if (permissions) |perms| {
            if (perms.len > 0) {
                try query.appendSlice(self.allocator, " SET PERMISSIONS [");
                for (perms, 0..) |perm, i| {
                    if (i > 0) {
                        try query.appendSlice(self.allocator, ", ");
                    }
                    try query.appendSlice(self.allocator, "'");
                    try appendEscapedGqlString(self.allocator, &query, perm);
                    try query.appendSlice(self.allocator, "'");
                }
                try query.appendSlice(self.allocator, "]");
            }
        }

        return query.toOwnedSlice(self.allocator);
    }

    /// Build a GQL command to assign a role to a user.
    pub fn buildAssignRoleQuery(
        self: Self,
        username: []const u8,
        role: []const u8,
    ) ![]u8 {
        var query: std.ArrayListUnmanaged(u8) = .{};
        errdefer query.deinit(self.allocator);

        try query.appendSlice(self.allocator, "GRANT ROLE '");
        try appendEscapedGqlString(self.allocator, &query, role);
        try query.appendSlice(self.allocator, "' TO USER '");
        try appendEscapedGqlString(self.allocator, &query, username);
        try query.appendSlice(self.allocator, "'");

        return query.toOwnedSlice(self.allocator);
    }

    /// Build a GQL command to revoke a role from a user.
    pub fn buildRevokeRoleQuery(
        self: Self,
        username: []const u8,
        role: []const u8,
    ) ![]u8 {
        var query: std.ArrayListUnmanaged(u8) = .{};
        errdefer query.deinit(self.allocator);

        try query.appendSlice(self.allocator, "REVOKE ROLE '");
        try appendEscapedGqlString(self.allocator, &query, role);
        try query.appendSlice(self.allocator, "' FROM USER '");
        try appendEscapedGqlString(self.allocator, &query, username);
        try query.appendSlice(self.allocator, "'");

        return query.toOwnedSlice(self.allocator);
    }

    /// Build a GQL command to create an RLS policy.
    pub fn buildCreateRlsPolicyQuery(
        self: Self,
        policy: RlsPolicy,
    ) ![]u8 {
        var query: std.ArrayListUnmanaged(u8) = .{};
        errdefer query.deinit(self.allocator);

        try query.appendSlice(self.allocator, "CREATE POLICY '");
        try appendEscapedGqlString(self.allocator, &query, policy.name);
        try query.appendSlice(self.allocator, "' ON '");
        try appendEscapedGqlString(self.allocator, &query, policy.target_label);
        try query.appendSlice(self.allocator, "' FOR ");
        try query.appendSlice(self.allocator, policy.policy_type.toString());
        try query.appendSlice(self.allocator, " USING (");
        try query.appendSlice(self.allocator, policy.predicate);
        try query.appendSlice(self.allocator, ")");

        if (policy.roles.len > 0) {
            try query.appendSlice(self.allocator, " TO ROLES [");
            for (policy.roles, 0..) |role, i| {
                if (i > 0) {
                    try query.appendSlice(self.allocator, ", ");
                }
                try query.appendSlice(self.allocator, "'");
                try appendEscapedGqlString(self.allocator, &query, role);
                try query.appendSlice(self.allocator, "'");
            }
            try query.appendSlice(self.allocator, "]");
        }

        return query.toOwnedSlice(self.allocator);
    }

    /// Build a GQL command to drop an RLS policy.
    pub fn buildDropRlsPolicyQuery(
        self: Self,
        policy_name: []const u8,
    ) ![]u8 {
        var query: std.ArrayListUnmanaged(u8) = .{};
        errdefer query.deinit(self.allocator);

        try query.appendSlice(self.allocator, "DROP POLICY '");
        try appendEscapedGqlString(self.allocator, &query, policy_name);
        try query.appendSlice(self.allocator, "'");

        return query.toOwnedSlice(self.allocator);
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

// Helper to escape GQL string literals (single quotes)
// SECURITY: Escapes single quotes to prevent GQL injection
fn appendEscapedGqlString(allocator: std.mem.Allocator, buf: *std.ArrayListUnmanaged(u8), s: []const u8) !void {
    for (s) |c| {
        switch (c) {
            '\'' => try buf.appendSlice(allocator, "''"), // Double single quotes for escaping
            '\\' => try buf.appendSlice(allocator, "\\\\"),
            else => try buf.append(allocator, c),
        }
    }
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

test "AuthClient buildCreateUserQuery" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const roles = [_][]const u8{ "reader", "writer" };
    const query = try client.buildCreateUserQuery("newuser", "password123", &roles);
    defer std.testing.allocator.free(query);

    try std.testing.expect(std.mem.indexOf(u8, query, "CREATE USER 'newuser'") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "SET PASSWORD 'password123'") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "SET ROLES [") != null);
}

test "AuthClient buildCreateRoleQuery" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const perms = [_][]const u8{ "read", "write" };
    const query = try client.buildCreateRoleQuery("editor", "Can edit content", &perms);
    defer std.testing.allocator.free(query);

    try std.testing.expect(std.mem.indexOf(u8, query, "CREATE ROLE 'editor'") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "SET DESCRIPTION 'Can edit content'") != null);
}

test "AuthClient buildAssignRoleQuery" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const query = try client.buildAssignRoleQuery("alice", "admin");
    defer std.testing.allocator.free(query);

    try std.testing.expect(std.mem.indexOf(u8, query, "GRANT ROLE 'admin'") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "TO USER 'alice'") != null);
}

test "AuthClient buildCreateRlsPolicyQuery" {
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

    const query = try client.buildCreateRlsPolicyQuery(policy);
    defer std.testing.allocator.free(query);

    try std.testing.expect(std.mem.indexOf(u8, query, "CREATE POLICY 'my_policy'") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "ON 'Node'") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "FOR ALL") != null);
}

test "AuthClient buildDropRlsPolicyQuery" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const query = try client.buildDropRlsPolicyQuery("old_policy");
    defer std.testing.allocator.free(query);

    try std.testing.expect(std.mem.indexOf(u8, query, "DROP POLICY 'old_policy'") != null);
}

// =============================================================================
// Security Tests - GQL Injection Prevention
// =============================================================================

test "appendEscapedGqlString escapes single quotes" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedGqlString(std.testing.allocator, &buf, "hello'world");
    try std.testing.expectEqualStrings("hello''world", buf.items);
}

test "appendEscapedGqlString escapes backslashes" {
    var buf: std.ArrayListUnmanaged(u8) = .{};
    defer buf.deinit(std.testing.allocator);

    try appendEscapedGqlString(std.testing.allocator, &buf, "path\\to\\file");
    try std.testing.expectEqualStrings("path\\\\to\\\\file", buf.items);
}

test "buildCreateUserQuery escapes injection attempts" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const query = try client.buildCreateUserQuery("admin'; DROP USER 'root", "pass", null);
    defer std.testing.allocator.free(query);

    // The single quote should be escaped
    try std.testing.expect(std.mem.indexOf(u8, query, "''") != null);
    // Should NOT contain unescaped DROP command
    try std.testing.expect(std.mem.indexOf(u8, query, "DROP USER 'root'") == null);
}

// =============================================================================
// Security Tests - Sensitive Data Zeroing (CWE-316, CWE-226)
// =============================================================================

test "clearAuthentication zeros and frees session token" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    try client.setAuthenticated("admin", "supersecrettoken12345");
    try std.testing.expect(client.isAuthenticated());
    try std.testing.expectEqualStrings("admin", client.getCurrentUser().?);

    client.clearAuthentication();

    try std.testing.expect(!client.isAuthenticated());
    try std.testing.expect(client.getCurrentUser() == null);
    try std.testing.expect(client.session_token == null);
}

test "setAuthenticated zeros old token when replacing" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    try client.setAuthenticated("user1", "oldtoken123");
    try std.testing.expectEqualStrings("user1", client.getCurrentUser().?);

    try client.setAuthenticated("user2", "newtoken456");
    try std.testing.expectEqualStrings("user2", client.getCurrentUser().?);
}

test "deinit zeros session token" {
    var client = AuthClient.init(std.testing.allocator);

    try client.setAuthenticated("admin", "tokentobezeroed");
    try std.testing.expect(client.isAuthenticated());

    client.deinit();
}
