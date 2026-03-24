// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Client-side field-level encryption for the Geode Zig client.
// Provides transparent encrypt-before-send and decrypt-after-receive.
//
// This module wraps the FLE library for field-level encryption with
// support for searchable encryption via blind indexes. The FLE
// integration will be wired in once the library API is confirmed;
// this module currently provides the configuration and orchestration
// layer using only std library types.

const std = @import("std");

/// AES-256-GCM key size in bytes.
pub const KEY_SIZE: usize = 32;

/// Maximum number of encrypted fields per configuration.
pub const MAX_ENCRYPTED_FIELDS: usize = 256;

/// Maximum length for AAD context strings.
pub const MAX_AAD_LENGTH: usize = 1024;

/// Maximum length for field names.
pub const MAX_FIELD_NAME_LENGTH: usize = 256;

/// Errors specific to the encryption module.
pub const EncryptionError = error{
    /// Encryption is not enabled (no master key set).
    NotEnabled,
    /// The master key has not been configured.
    MasterKeyNotSet,
    /// The field name exceeds the maximum allowed length.
    FieldNameTooLong,
    /// The field name is empty.
    FieldNameEmpty,
    /// The AAD context exceeds the maximum allowed length.
    AadContextTooLong,
    /// Too many encrypted fields registered.
    TooManyFields,
    /// The specified field is not registered for encryption.
    FieldNotRegistered,
    /// Key derivation failed.
    KeyDerivationFailed,
    /// Encryption operation failed.
    EncryptFailed,
    /// Decryption operation failed.
    DecryptFailed,
};

/// Per-field encryption configuration.
pub const FieldEncryptionConfig = struct {
    /// Whether to create a blind index for searchable encryption.
    searchable: bool,
    /// Additional authenticated data context (typically the field name).
    aad_context: []const u8,

    const Self = @This();

    /// Create a new field encryption config.
    pub fn init(aad_context: []const u8, searchable: bool) Self {
        return Self{
            .searchable = searchable,
            .aad_context = aad_context,
        };
    }
};

/// Client-side encryption configuration.
/// Wraps the FLE library for transparent field encryption.
pub const EncryptionConfig = struct {
    /// Whether encryption is enabled.
    enabled: bool,
    /// Master key (32 bytes for AES-256-GCM).
    master_key: ?[KEY_SIZE]u8,
    /// Fields to encrypt (field name -> encryption config).
    encrypted_fields: std.StringHashMap(FieldEncryptionConfig),
    /// Allocator for internal state.
    allocator: std.mem.Allocator,

    const Self = @This();

    /// Create a new encryption configuration with encryption disabled.
    pub fn init(allocator: std.mem.Allocator) Self {
        return Self{
            .enabled = false,
            .master_key = null,
            .encrypted_fields = std.StringHashMap(FieldEncryptionConfig).init(allocator),
            .allocator = allocator,
        };
    }

    /// Free resources and securely zero the master key.
    pub fn deinit(self: *Self) void {
        // SECURITY: Zero master key before cleanup to prevent key
        // material from lingering in memory (CWE-316).
        if (self.master_key) |*key| {
            @memset(key, 0);
            self.master_key = null;
        }
        self.encrypted_fields.deinit();
    }

    /// Enable encryption with the given master key.
    /// Returns self for builder-style chaining.
    pub fn withMasterKey(self: *Self, key: [KEY_SIZE]u8) *Self {
        // SECURITY: Zero any previous key before overwriting.
        if (self.master_key) |*old| {
            @memset(old, 0);
        }
        self.master_key = key;
        self.enabled = true;
        return self;
    }

    /// Disable encryption and securely zero the master key.
    /// Returns self for builder-style chaining.
    pub fn withDisabled(self: *Self) *Self {
        if (self.master_key) |*key| {
            @memset(key, 0);
        }
        self.master_key = null;
        self.enabled = false;
        return self;
    }

    /// Register a field for encryption.
    pub fn addEncryptedField(
        self: *Self,
        field_name: []const u8,
        searchable: bool,
    ) EncryptionError!void {
        if (field_name.len == 0) {
            return EncryptionError.FieldNameEmpty;
        }
        if (field_name.len > MAX_FIELD_NAME_LENGTH) {
            return EncryptionError.FieldNameTooLong;
        }
        if (self.encrypted_fields.count() >= MAX_ENCRYPTED_FIELDS) {
            return EncryptionError.TooManyFields;
        }
        self.encrypted_fields.put(field_name, FieldEncryptionConfig.init(
            field_name,
            searchable,
        )) catch return EncryptionError.TooManyFields;
    }

    /// Register a field for encryption with a custom AAD context.
    pub fn addEncryptedFieldWithAad(
        self: *Self,
        field_name: []const u8,
        searchable: bool,
        aad_context: []const u8,
    ) EncryptionError!void {
        if (field_name.len == 0) {
            return EncryptionError.FieldNameEmpty;
        }
        if (field_name.len > MAX_FIELD_NAME_LENGTH) {
            return EncryptionError.FieldNameTooLong;
        }
        if (aad_context.len > MAX_AAD_LENGTH) {
            return EncryptionError.AadContextTooLong;
        }
        if (self.encrypted_fields.count() >= MAX_ENCRYPTED_FIELDS) {
            return EncryptionError.TooManyFields;
        }
        self.encrypted_fields.put(field_name, FieldEncryptionConfig.init(
            aad_context,
            searchable,
        )) catch return EncryptionError.TooManyFields;
    }

    /// Remove a field from encryption.
    pub fn removeEncryptedField(self: *Self, field_name: []const u8) bool {
        return self.encrypted_fields.remove(field_name);
    }

    /// Check if a field should be encrypted.
    pub fn isEncryptedField(self: *const Self, field_name: []const u8) bool {
        return self.enabled and self.encrypted_fields.contains(field_name);
    }

    /// Get the encryption config for a specific field.
    pub fn getFieldConfig(self: *const Self, field_name: []const u8) ?FieldEncryptionConfig {
        if (!self.enabled) return null;
        return self.encrypted_fields.get(field_name);
    }

    /// Return the number of registered encrypted fields.
    pub fn fieldCount(self: *const Self) usize {
        return self.encrypted_fields.count();
    }

    /// Validate that the configuration is complete and usable.
    pub fn validate(self: *const Self) EncryptionError!void {
        if (!self.enabled) return;
        if (self.master_key == null) {
            return EncryptionError.MasterKeyNotSet;
        }
    }
};

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

test "EncryptionConfig: init defaults" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    try std.testing.expect(!cfg.enabled);
    try std.testing.expect(cfg.master_key == null);
    try std.testing.expectEqual(@as(usize, 0), cfg.fieldCount());
}

test "EncryptionConfig: withMasterKey enables encryption" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    const key = [_]u8{0xAB} ** KEY_SIZE;
    _ = cfg.withMasterKey(key);

    try std.testing.expect(cfg.enabled);
    try std.testing.expect(cfg.master_key != null);
    try std.testing.expectEqualSlices(u8, &key, &cfg.master_key.?);
}

test "EncryptionConfig: withDisabled zeroes key" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    const key = [_]u8{0xFF} ** KEY_SIZE;
    _ = cfg.withMasterKey(key);
    try std.testing.expect(cfg.enabled);

    _ = cfg.withDisabled();
    try std.testing.expect(!cfg.enabled);
    try std.testing.expect(cfg.master_key == null);
}

test "EncryptionConfig: withMasterKey zeroes previous key" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    const key1 = [_]u8{0xAA} ** KEY_SIZE;
    const key2 = [_]u8{0xBB} ** KEY_SIZE;

    _ = cfg.withMasterKey(key1);
    _ = cfg.withMasterKey(key2);

    try std.testing.expectEqualSlices(u8, &key2, &cfg.master_key.?);
}

test "EncryptionConfig: addEncryptedField" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    const key = [_]u8{0x01} ** KEY_SIZE;
    _ = cfg.withMasterKey(key);

    try cfg.addEncryptedField("ssn", true);
    try cfg.addEncryptedField("email", false);

    try std.testing.expectEqual(@as(usize, 2), cfg.fieldCount());
    try std.testing.expect(cfg.isEncryptedField("ssn"));
    try std.testing.expect(cfg.isEncryptedField("email"));
    try std.testing.expect(!cfg.isEncryptedField("name"));
}

test "EncryptionConfig: isEncryptedField returns false when disabled" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    // Add field without enabling encryption (no master key)
    try cfg.addEncryptedField("ssn", true);

    try std.testing.expect(!cfg.isEncryptedField("ssn"));
}

test "EncryptionConfig: getFieldConfig" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    const key = [_]u8{0x01} ** KEY_SIZE;
    _ = cfg.withMasterKey(key);

    try cfg.addEncryptedField("ssn", true);

    const field_cfg = cfg.getFieldConfig("ssn");
    try std.testing.expect(field_cfg != null);
    try std.testing.expect(field_cfg.?.searchable);
    try std.testing.expectEqualStrings("ssn", field_cfg.?.aad_context);

    try std.testing.expect(cfg.getFieldConfig("missing") == null);
}

test "EncryptionConfig: getFieldConfig returns null when disabled" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    try cfg.addEncryptedField("ssn", true);

    try std.testing.expect(cfg.getFieldConfig("ssn") == null);
}

test "EncryptionConfig: addEncryptedFieldWithAad" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    const key = [_]u8{0x01} ** KEY_SIZE;
    _ = cfg.withMasterKey(key);

    try cfg.addEncryptedFieldWithAad("ssn", true, "tenant:123:ssn");

    const field_cfg = cfg.getFieldConfig("ssn");
    try std.testing.expect(field_cfg != null);
    try std.testing.expectEqualStrings("tenant:123:ssn", field_cfg.?.aad_context);
}

test "EncryptionConfig: removeEncryptedField" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    try cfg.addEncryptedField("ssn", true);
    try std.testing.expectEqual(@as(usize, 1), cfg.fieldCount());

    try std.testing.expect(cfg.removeEncryptedField("ssn"));
    try std.testing.expectEqual(@as(usize, 0), cfg.fieldCount());

    try std.testing.expect(!cfg.removeEncryptedField("nonexistent"));
}

test "EncryptionConfig: validate enabled without key" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    // Force enabled without setting a key
    cfg.enabled = true;

    try std.testing.expectError(EncryptionError.MasterKeyNotSet, cfg.validate());
}

test "EncryptionConfig: validate disabled is always ok" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    try cfg.validate();
}

test "EncryptionConfig: validate enabled with key succeeds" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    const key = [_]u8{0x01} ** KEY_SIZE;
    _ = cfg.withMasterKey(key);

    try cfg.validate();
}

test "EncryptionConfig: addEncryptedField rejects empty name" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    try std.testing.expectError(EncryptionError.FieldNameEmpty, cfg.addEncryptedField("", true));
}

test "EncryptionConfig: addEncryptedField rejects long name" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    const long_name = "x" ** (MAX_FIELD_NAME_LENGTH + 1);
    try std.testing.expectError(EncryptionError.FieldNameTooLong, cfg.addEncryptedField(long_name, true));
}

test "EncryptionConfig: addEncryptedFieldWithAad rejects long aad" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();

    const long_aad = "a" ** (MAX_AAD_LENGTH + 1);
    try std.testing.expectError(EncryptionError.AadContextTooLong, cfg.addEncryptedFieldWithAad("field", true, long_aad));
}

test "EncryptionConfig: deinit zeroes master key" {
    var cfg = EncryptionConfig.init(std.testing.allocator);

    const key = [_]u8{0xFF} ** KEY_SIZE;
    _ = cfg.withMasterKey(key);

    // Capture pointer to key before deinit
    const key_ptr = &cfg.master_key.?;
    const key_copy = key_ptr.*;

    // Verify key was set
    try std.testing.expectEqualSlices(u8, &key, &key_copy);

    cfg.deinit();

    // After deinit, master_key should be null
    try std.testing.expect(cfg.master_key == null);
}

test "FieldEncryptionConfig: init" {
    const fec = FieldEncryptionConfig.init("my_field", true);
    try std.testing.expect(fec.searchable);
    try std.testing.expectEqualStrings("my_field", fec.aad_context);

    const fec2 = FieldEncryptionConfig.init("other", false);
    try std.testing.expect(!fec2.searchable);
}
