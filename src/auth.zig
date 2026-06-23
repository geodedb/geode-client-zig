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
// auth_lib is available for future HMAC/TOTP integration
const auth_lib = @import("auth_lib");
const uuid = @import("uuid");
const cb = @import("crypto_backend");

/// Supported authentication methods.
pub const AuthMethod = enum {
    /// Traditional username/password authentication.
    password,
    /// API key authentication (e.g., "ak1.xxx.yyy").
    api_key,
    /// HMAC-based authentication.
    hmac,
};

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
    /// Authentication method in use
    auth_method: AuthMethod,
    /// API key string (e.g., "ak1.xxx.yyy") when using API key auth
    api_key: ?[]const u8,

    const Self = @This();

    /// Create a new auth client.
    pub fn init(allocator: std.mem.Allocator) Self {
        return Self{
            .allocator = allocator,
            .current_user = null,
            .session_token = null,
            .auth_method = .password,
            .api_key = null,
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
            cb.secureZero(@constCast(token));
            self.allocator.free(token);
        }
        if (self.api_key) |key| {
            // SECURITY: Zero API key before freeing (CWE-316, CWE-226)
            cb.secureZero(@constCast(key));
            self.allocator.free(key);
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
        var query: std.ArrayListUnmanaged(u8) = .empty;
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
        var query: std.ArrayListUnmanaged(u8) = .empty;
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
        var query: std.ArrayListUnmanaged(u8) = .empty;
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
        var query: std.ArrayListUnmanaged(u8) = .empty;
        errdefer query.deinit(self.allocator);

        try query.appendSlice(self.allocator, "REVOKE ROLE '");
        try appendEscapedGqlString(self.allocator, &query, role);
        try query.appendSlice(self.allocator, "' FROM USER '");
        try appendEscapedGqlString(self.allocator, &query, username);
        try query.appendSlice(self.allocator, "'");

        return query.toOwnedSlice(self.allocator);
    }

    /// Build a GQL command to create an RLS policy.
    /// SECURITY: Validates the predicate to prevent GQL injection via the USING clause.
    pub fn buildCreateRlsPolicyQuery(
        self: Self,
        policy: RlsPolicy,
    ) (AuthError || std.mem.Allocator.Error)![]u8 {
        // SECURITY: Validate predicate before interpolating into GQL command (#25)
        try validatePredicate(policy.predicate);

        var query: std.ArrayListUnmanaged(u8) = .empty;
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
        var query: std.ArrayListUnmanaged(u8) = .empty;
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
            cb.secureZero(@constCast(old));
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
            cb.secureZero(@constCast(token));
            self.allocator.free(token);
            self.session_token = null;
        }
        if (self.api_key) |key| {
            // SECURITY: Zero API key before freeing (CWE-316, CWE-226)
            cb.secureZero(@constCast(key));
            self.allocator.free(key);
            self.api_key = null;
        }
        self.auth_method = .password;
    }

    /// Set the authentication method to API key and store the key.
    /// Returns self for builder-style chaining.
    /// SECURITY: Zeros any previously stored API key before replacing (CWE-316, CWE-226).
    pub fn withApiKey(self: *Self, api_key: []const u8) !*Self {
        if (self.api_key) |old| {
            // SECURITY: Zero old key before freeing (CWE-316, CWE-226)
            cb.secureZero(@constCast(old));
            self.allocator.free(old);
        }
        self.api_key = try self.allocator.dupe(u8, api_key);
        self.auth_method = .api_key;
        return self;
    }

    /// Build a GQL command to authenticate using an API key.
    /// This is an alternative to username/password login for service accounts
    /// and automated clients that use API keys (e.g., "ak1.xxx.yyy").
    ///
    /// Returns a GQL query string: LOGIN WITH API_KEY '<escaped_key>'
    pub fn buildApiKeyLoginQuery(self: Self, api_key: []const u8) ![]u8 {
        var query: std.ArrayListUnmanaged(u8) = .empty;
        errdefer query.deinit(self.allocator);

        try query.appendSlice(self.allocator, "LOGIN WITH API_KEY '");
        try appendEscapedGqlString(self.allocator, &query, api_key);
        try query.appendSlice(self.allocator, "'");

        return query.toOwnedSlice(self.allocator);
    }

    /// Build a GQL command to create a new API key for a user.
    /// Generates a unique key ID using UUID v4.
    ///
    /// Returns a GQL query string: CREATE API_KEY '<key_id>' FOR USER '<username>'
    pub fn buildCreateApiKeyQuery(self: Self, username: []const u8) ![]u8 {
        var query: std.ArrayListUnmanaged(u8) = .empty;
        errdefer query.deinit(self.allocator);

        const key_id = try uuid.newV4();
        const key_id_str = try key_id.toStringAlloc(self.allocator);
        defer self.allocator.free(key_id_str);

        try query.appendSlice(self.allocator, "CREATE API_KEY '");
        try query.appendSlice(self.allocator, key_id_str);
        try query.appendSlice(self.allocator, "' FOR USER '");
        try appendEscapedGqlString(self.allocator, &query, username);
        try query.appendSlice(self.allocator, "'");

        return query.toOwnedSlice(self.allocator);
    }

    /// Build a GQL command to revoke an API key.
    ///
    /// Returns a GQL query string: REVOKE API_KEY '<key_id>'
    pub fn buildRevokeApiKeyQuery(self: Self, key_id: []const u8) ![]u8 {
        var query: std.ArrayListUnmanaged(u8) = .empty;
        errdefer query.deinit(self.allocator);

        try query.appendSlice(self.allocator, "REVOKE API_KEY '");
        try appendEscapedGqlString(self.allocator, &query, key_id);
        try query.appendSlice(self.allocator, "'");

        return query.toOwnedSlice(self.allocator);
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
    /// Invalid API key format
    InvalidApiKey,
    /// RLS policy predicate contains dangerous characters or is malformed
    InvalidPredicate,
};

/// Validate an RLS policy predicate expression.
/// SECURITY: Rejects predicates containing statement terminators (`;`) or unbalanced
/// parentheses, which could allow GQL injection when the predicate is interpolated
/// into a USING(...) clause. Single quotes are also rejected since predicates should
/// use parameterized values ($param), not string literals.
fn validatePredicate(predicate: []const u8) AuthError!void {
    if (predicate.len == 0) return AuthError.InvalidPredicate;

    var paren_depth: i32 = 0;
    for (predicate) |c| {
        switch (c) {
            // Statement terminator enables multi-statement injection
            ';' => return AuthError.InvalidPredicate,
            // Single quotes could break out of the USING context
            '\'' => return AuthError.InvalidPredicate,
            // Null bytes should never appear in predicates
            0 => return AuthError.InvalidPredicate,
            '(' => paren_depth += 1,
            ')' => {
                paren_depth -= 1;
                // Closing paren without matching open could escape the USING clause
                if (paren_depth < 0) return AuthError.InvalidPredicate;
            },
            else => {},
        }
    }
    // Unbalanced open parentheses
    if (paren_depth != 0) return AuthError.InvalidPredicate;
}

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

test "AuthMethod enum values" {
    try std.testing.expectEqual(AuthMethod.password, .password);
    try std.testing.expectEqual(AuthMethod.api_key, .api_key);
    try std.testing.expectEqual(AuthMethod.hmac, .hmac);
}

test "AuthClient default auth method is password" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    try std.testing.expectEqual(AuthMethod.password, client.auth_method);
    try std.testing.expect(client.api_key == null);
}

test "AuthClient withApiKey sets method and stores key" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    _ = try client.withApiKey("ak1.testid.testsecret");
    try std.testing.expectEqual(AuthMethod.api_key, client.auth_method);
    try std.testing.expectEqualStrings("ak1.testid.testsecret", client.api_key.?);
}

test "AuthClient withApiKey replaces previous key" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    _ = try client.withApiKey("ak1.first.key");
    _ = try client.withApiKey("ak1.second.key");
    try std.testing.expectEqualStrings("ak1.second.key", client.api_key.?);
}

test "AuthClient buildApiKeyLoginQuery" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const query = try client.buildApiKeyLoginQuery("ak1.myid.mysecret");
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("LOGIN WITH API_KEY 'ak1.myid.mysecret'", query);
}

test "AuthClient buildApiKeyLoginQuery escapes injection" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const query = try client.buildApiKeyLoginQuery("ak1.bad'; DROP USER 'root");
    defer std.testing.allocator.free(query);

    // Single quotes should be escaped
    try std.testing.expect(std.mem.indexOf(u8, query, "''") != null);
    // Should NOT contain unescaped DROP command
    try std.testing.expect(std.mem.indexOf(u8, query, "DROP USER 'root'") == null);
}

test "AuthClient buildCreateApiKeyQuery" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const query = try client.buildCreateApiKeyQuery("alice");
    defer std.testing.allocator.free(query);

    try std.testing.expect(std.mem.indexOf(u8, query, "CREATE API_KEY '") != null);
    try std.testing.expect(std.mem.indexOf(u8, query, "' FOR USER 'alice'") != null);
}

test "AuthClient buildRevokeApiKeyQuery" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    const query = try client.buildRevokeApiKeyQuery("key-id-123");
    defer std.testing.allocator.free(query);

    try std.testing.expectEqualStrings("REVOKE API_KEY 'key-id-123'", query);
}

test "AuthClient clearAuthentication resets api_key and auth_method" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    _ = try client.withApiKey("ak1.test.key");
    try client.setAuthenticated("svc-account", "token456");

    client.clearAuthentication();

    try std.testing.expect(!client.isAuthenticated());
    try std.testing.expect(client.api_key == null);
    try std.testing.expectEqual(AuthMethod.password, client.auth_method);
}

// =============================================================================
// Security Tests - GQL Injection Prevention
// =============================================================================

test "appendEscapedGqlString escapes single quotes" {
    var buf: std.ArrayListUnmanaged(u8) = .empty;
    defer buf.deinit(std.testing.allocator);

    try appendEscapedGqlString(std.testing.allocator, &buf, "hello'world");
    try std.testing.expectEqualStrings("hello''world", buf.items);
}

test "appendEscapedGqlString escapes backslashes" {
    var buf: std.ArrayListUnmanaged(u8) = .empty;
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

// =============================================================================
// Security Tests - RLS Predicate Injection Prevention (#25)
// =============================================================================

test "validatePredicate rejects semicolon injection" {
    try std.testing.expectError(AuthError.InvalidPredicate, validatePredicate("true) ; DROP POLICY 'x"));
}

test "validatePredicate rejects single quotes" {
    try std.testing.expectError(AuthError.InvalidPredicate, validatePredicate("n.name = 'alice'"));
}

test "validatePredicate rejects empty predicate" {
    try std.testing.expectError(AuthError.InvalidPredicate, validatePredicate(""));
}

test "validatePredicate rejects unbalanced open parens" {
    try std.testing.expectError(AuthError.InvalidPredicate, validatePredicate("n.age > (10"));
}

test "validatePredicate rejects unbalanced close parens" {
    try std.testing.expectError(AuthError.InvalidPredicate, validatePredicate("n.age > 10)"));
}

test "validatePredicate rejects null bytes" {
    try std.testing.expectError(AuthError.InvalidPredicate, validatePredicate("n.age > 10\x00; DROP"));
}

test "validatePredicate accepts valid predicates" {
    try validatePredicate("n.owner = $current_user");
    try validatePredicate("n.public = true");
    try validatePredicate("n.age > $minAge AND n.active = true");
    try validatePredicate("(n.role = $role) OR (n.public = true)");
}

test "buildCreateRlsPolicyQuery rejects injection in predicate" {
    var client = AuthClient.init(std.testing.allocator);
    defer client.deinit();

    var policy = try RlsPolicy.init(
        std.testing.allocator,
        "evil_policy",
        "Node",
        .select,
        "true) ; DROP POLICY 'x",
    );
    defer policy.deinit();

    try std.testing.expectError(AuthError.InvalidPredicate, client.buildCreateRlsPolicyQuery(policy));
}
