// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Authentication support for the Geode Zig client library.
// Provides user management, role management, and Row-Level Security (RLS) policies.

const std = @import("std");
const protocol = @import("protocol");
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
    pub fn deinit(self: *Self) void {
        if (self.current_user) |user| {
            self.allocator.free(user);
        }
        if (self.session_token) |token| {
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
    pub fn buildLoginMessage(self: Self, username: []const u8, password: []const u8) ![]u8 {
        _ = self;
        return buildAuthMessage("LOGIN", username, password);
    }

    /// Build a logout message.
    pub fn buildLogoutMessage(self: Self) ![]u8 {
        return buildSimpleAuthMessage(self.allocator, "LOGOUT");
    }

    /// Build a create user message.
    pub fn buildCreateUserMessage(
        self: Self,
        username: []const u8,
        password: []const u8,
        roles: ?[]const []const u8,
    ) ![]u8 {
        _ = self;
        var msg: std.ArrayListUnmanaged(u8) = .{};
        const allocator = std.heap.page_allocator;
        errdefer msg.deinit(allocator);

        try msg.appendSlice(allocator, "{\"type\":\"CREATE_USER\",\"username\":\"");
        try msg.appendSlice(allocator, username);
        try msg.appendSlice(allocator, "\",\"password\":\"");
        try msg.appendSlice(allocator, password);
        try msg.appendSlice(allocator, "\"");

        if (roles) |r| {
            try msg.appendSlice(allocator, ",\"roles\":[");
            for (r, 0..) |role, i| {
                if (i > 0) {
                    try msg.appendSlice(allocator, ",");
                }
                try msg.appendSlice(allocator, "\"");
                try msg.appendSlice(allocator, role);
                try msg.appendSlice(allocator, "\"");
            }
            try msg.appendSlice(allocator, "]");
        }

        try msg.appendSlice(allocator, "}\n");
        return msg.toOwnedSlice(allocator);
    }

    /// Build a create role message.
    pub fn buildCreateRoleMessage(
        self: Self,
        name: []const u8,
        description: ?[]const u8,
        permissions: ?[]const []const u8,
    ) ![]u8 {
        _ = self;
        var msg: std.ArrayListUnmanaged(u8) = .{};
        const allocator = std.heap.page_allocator;
        errdefer msg.deinit(allocator);

        try msg.appendSlice(allocator, "{\"type\":\"CREATE_ROLE\",\"name\":\"");
        try msg.appendSlice(allocator, name);
        try msg.appendSlice(allocator, "\"");

        if (description) |desc| {
            try msg.appendSlice(allocator, ",\"description\":\"");
            try msg.appendSlice(allocator, desc);
            try msg.appendSlice(allocator, "\"");
        }

        if (permissions) |perms| {
            try msg.appendSlice(allocator, ",\"permissions\":[");
            for (perms, 0..) |perm, i| {
                if (i > 0) {
                    try msg.appendSlice(allocator, ",");
                }
                try msg.appendSlice(allocator, "\"");
                try msg.appendSlice(allocator, perm);
                try msg.appendSlice(allocator, "\"");
            }
            try msg.appendSlice(allocator, "]");
        }

        try msg.appendSlice(allocator, "}\n");
        return msg.toOwnedSlice(allocator);
    }

    /// Build an assign role message.
    pub fn buildAssignRoleMessage(
        self: Self,
        username: []const u8,
        role: []const u8,
    ) ![]u8 {
        _ = self;
        var msg: std.ArrayListUnmanaged(u8) = .{};
        const allocator = std.heap.page_allocator;
        errdefer msg.deinit(allocator);

        try msg.appendSlice(allocator, "{\"type\":\"ASSIGN_ROLE\",\"username\":\"");
        try msg.appendSlice(allocator, username);
        try msg.appendSlice(allocator, "\",\"role\":\"");
        try msg.appendSlice(allocator, role);
        try msg.appendSlice(allocator, "\"}\n");

        return msg.toOwnedSlice(allocator);
    }

    /// Build a revoke role message.
    pub fn buildRevokeRoleMessage(
        self: Self,
        username: []const u8,
        role: []const u8,
    ) ![]u8 {
        _ = self;
        var msg: std.ArrayListUnmanaged(u8) = .{};
        const allocator = std.heap.page_allocator;
        errdefer msg.deinit(allocator);

        try msg.appendSlice(allocator, "{\"type\":\"REVOKE_ROLE\",\"username\":\"");
        try msg.appendSlice(allocator, username);
        try msg.appendSlice(allocator, "\",\"role\":\"");
        try msg.appendSlice(allocator, role);
        try msg.appendSlice(allocator, "\"}\n");

        return msg.toOwnedSlice(allocator);
    }

    /// Build a create RLS policy message.
    pub fn buildCreateRlsPolicyMessage(
        self: Self,
        policy: RlsPolicy,
    ) ![]u8 {
        _ = self;
        var msg: std.ArrayListUnmanaged(u8) = .{};
        const allocator = std.heap.page_allocator;
        errdefer msg.deinit(allocator);

        try msg.appendSlice(allocator, "{\"type\":\"CREATE_RLS_POLICY\",\"name\":\"");
        try msg.appendSlice(allocator, policy.name);
        try msg.appendSlice(allocator, "\",\"target\":\"");
        try msg.appendSlice(allocator, policy.target_label);
        try msg.appendSlice(allocator, "\",\"policy_type\":\"");
        try msg.appendSlice(allocator, policy.policy_type.toString());
        try msg.appendSlice(allocator, "\",\"predicate\":\"");
        try msg.appendSlice(allocator, policy.predicate);
        try msg.appendSlice(allocator, "\"");

        if (policy.roles.len > 0) {
            try msg.appendSlice(allocator, ",\"roles\":[");
            for (policy.roles, 0..) |role, i| {
                if (i > 0) {
                    try msg.appendSlice(allocator, ",");
                }
                try msg.appendSlice(allocator, "\"");
                try msg.appendSlice(allocator, role);
                try msg.appendSlice(allocator, "\"");
            }
            try msg.appendSlice(allocator, "]");
        }

        try msg.appendSlice(allocator, ",\"enabled\":");
        try msg.appendSlice(allocator, if (policy.enabled) "true" else "false");
        try msg.appendSlice(allocator, "}\n");

        return msg.toOwnedSlice(allocator);
    }

    /// Build a drop RLS policy message.
    pub fn buildDropRlsPolicyMessage(
        self: Self,
        policy_name: []const u8,
    ) ![]u8 {
        _ = self;
        var msg: std.ArrayListUnmanaged(u8) = .{};
        const allocator = std.heap.page_allocator;
        errdefer msg.deinit(allocator);

        try msg.appendSlice(allocator, "{\"type\":\"DROP_RLS_POLICY\",\"name\":\"");
        try msg.appendSlice(allocator, policy_name);
        try msg.appendSlice(allocator, "\"}\n");

        return msg.toOwnedSlice(allocator);
    }

    /// Set authenticated state.
    pub fn setAuthenticated(self: *Self, username: []const u8, token: []const u8) !void {
        if (self.current_user) |old| {
            self.allocator.free(old);
        }
        if (self.session_token) |old| {
            self.allocator.free(old);
        }
        self.current_user = try self.allocator.dupe(u8, username);
        self.session_token = try self.allocator.dupe(u8, token);
    }

    /// Clear authenticated state.
    pub fn clearAuthentication(self: *Self) void {
        if (self.current_user) |user| {
            self.allocator.free(user);
            self.current_user = null;
        }
        if (self.session_token) |token| {
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
fn buildAuthMessage(msg_type: []const u8, username: []const u8, password: []const u8) ![]u8 {
    var msg: std.ArrayListUnmanaged(u8) = .{};
    const allocator = std.heap.page_allocator;
    errdefer msg.deinit(allocator);

    try msg.appendSlice(allocator, "{\"type\":\"");
    try msg.appendSlice(allocator, msg_type);
    try msg.appendSlice(allocator, "\",\"username\":\"");
    try msg.appendSlice(allocator, username);
    try msg.appendSlice(allocator, "\",\"password\":\"");
    try msg.appendSlice(allocator, password);
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
    defer std.heap.page_allocator.free(msg);

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
    defer std.heap.page_allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"CREATE_USER\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"username\":\"newuser\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"roles\":[") != null);
}

test "AuthClient buildCreateRoleMessage" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const perms = [_][]const u8{ "read", "write" };
    const msg = try client.buildCreateRoleMessage("editor", "Can edit content", &perms);
    defer std.heap.page_allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"CREATE_ROLE\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"name\":\"editor\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"description\":\"Can edit content\"") != null);
}

test "AuthClient buildAssignRoleMessage" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const msg = try client.buildAssignRoleMessage("alice", "admin");
    defer std.heap.page_allocator.free(msg);

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
    defer std.heap.page_allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"CREATE_RLS_POLICY\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"name\":\"my_policy\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"policy_type\":\"ALL\"") != null);
}

test "AuthClient buildDropRlsPolicyMessage" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const msg = try client.buildDropRlsPolicyMessage("old_policy");
    defer std.heap.page_allocator.free(msg);

    try std.testing.expect(std.mem.indexOf(u8, msg, "\"type\":\"DROP_RLS_POLICY\"") != null);
    try std.testing.expect(std.mem.indexOf(u8, msg, "\"name\":\"old_policy\"") != null);
}
