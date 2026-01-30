// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Type system for the Geode Zig client library.
// Provides a Value type supporting all GQL types with JSON serialization.

const std = @import("std");
const GeodeError = @import("error").GeodeError;

/// GQL Value type that can represent any value in the type system.
/// Supports all ISO GQL types including nodes, relationships, paths, and temporal types.
pub const Value = union(enum) {
    /// Null value
    null,
    /// Boolean value
    boolean: bool,
    /// 64-bit signed integer
    integer: i64,
    /// 64-bit floating point
    float: f64,
    /// UTF-8 string (not owned by Value)
    string: []const u8,
    /// Binary data (bytes)
    bytes: []const u8,
    /// Array of values
    array: []const Value,
    /// Object/Map with string keys
    object: std.StringHashMapUnmanaged(Value),
    /// Date (year, month, day)
    date: Date,
    /// Time with optional timezone offset
    time: Time,
    /// Timestamp (datetime) with optional timezone
    timestamp: Timestamp,
    /// Duration (ISO 8601 duration)
    duration: Duration,
    /// Graph node
    node: Node,
    /// Graph relationship/edge
    relationship: Relationship,
    /// Graph path
    path: Path,

    /// Date type (year, month, day)
    /// SECURITY: Use initChecked() for user-provided values to validate bounds (CWE-20).
    pub const Date = struct {
        year: i32,
        month: u8,
        day: u8,

        /// Create a date without validation. Use initChecked() for user input.
        pub fn init(year: i32, month: u8, day: u8) Date {
            return .{ .year = year, .month = month, .day = day };
        }

        /// Create a date with bounds validation.
        /// SECURITY: Validates month (1-12) and day (1-31) to prevent invalid temporal data (CWE-20).
        /// Returns error.InvalidMonth if month is not in range 1-12.
        /// Returns error.InvalidDay if day is not in range 1-31.
        /// Note: Does not validate day-of-month for specific months (e.g., Feb 30).
        pub fn initChecked(year: i32, month: u8, day: u8) !Date {
            if (month < 1 or month > 12) return error.InvalidMonth;
            if (day < 1 or day > 31) return error.InvalidDay;
            return .{ .year = year, .month = month, .day = day };
        }

        pub fn format(self: Date, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
            _ = fmt;
            _ = options;
            // Format year as unsigned to avoid + sign for positive years
            if (self.year >= 0) {
                try writer.print("{d:0>4}-{d:0>2}-{d:0>2}", .{
                    @as(u32, @intCast(self.year)), self.month, self.day,
                });
            } else {
                try writer.print("-{d:0>4}-{d:0>2}-{d:0>2}", .{
                    @as(u32, @intCast(-self.year)), self.month, self.day,
                });
            }
        }
    };

    /// Time type with optional timezone offset
    /// SECURITY: Use initChecked() for user-provided values to validate bounds (CWE-20).
    pub const Time = struct {
        hour: u8,
        minute: u8,
        second: u8,
        nanosecond: u32 = 0,
        tz_offset_minutes: ?i16 = null,

        /// Create a time without validation. Use initChecked() for user input.
        pub fn init(hour: u8, minute: u8, second: u8) Time {
            return .{ .hour = hour, .minute = minute, .second = second };
        }

        /// Create a time with bounds validation.
        /// SECURITY: Validates hour (0-23), minute (0-59), second (0-59) to prevent invalid temporal data (CWE-20).
        /// Returns error.InvalidHour if hour is not in range 0-23.
        /// Returns error.InvalidMinute if minute is not in range 0-59.
        /// Returns error.InvalidSecond if second is not in range 0-59.
        pub fn initChecked(hour: u8, minute: u8, second: u8) !Time {
            if (hour > 23) return error.InvalidHour;
            if (minute > 59) return error.InvalidMinute;
            if (second > 59) return error.InvalidSecond;
            return .{ .hour = hour, .minute = minute, .second = second };
        }

        /// Create a time with nanoseconds without validation. Use withNanosChecked() for user input.
        pub fn withNanos(hour: u8, minute: u8, second: u8, nanos: u32) Time {
            return .{ .hour = hour, .minute = minute, .second = second, .nanosecond = nanos };
        }

        /// Create a time with nanoseconds with bounds validation.
        /// SECURITY: Validates all components including nanosecond (0-999999999) (CWE-20).
        pub fn withNanosChecked(hour: u8, minute: u8, second: u8, nanos: u32) !Time {
            if (hour > 23) return error.InvalidHour;
            if (minute > 59) return error.InvalidMinute;
            if (second > 59) return error.InvalidSecond;
            if (nanos > 999_999_999) return error.InvalidNanosecond;
            return .{ .hour = hour, .minute = minute, .second = second, .nanosecond = nanos };
        }

        pub fn format(self: Time, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
            _ = fmt;
            _ = options;
            try writer.print("{d:0>2}:{d:0>2}:{d:0>2}", .{
                self.hour, self.minute, self.second,
            });
            if (self.nanosecond > 0) {
                try writer.print(".{d:0>9}", .{self.nanosecond});
            }
            if (self.tz_offset_minutes) |offset| {
                if (offset == 0) {
                    try writer.writeAll("Z");
                } else {
                    const sign: u8 = if (offset < 0) '-' else '+';
                    const abs_offset: u16 = @intCast(@abs(offset));
                    try writer.print("{c}{d:0>2}:{d:0>2}", .{
                        sign, abs_offset / 60, abs_offset % 60,
                    });
                }
            }
        }
    };

    /// Timestamp type (date + time)
    pub const Timestamp = struct {
        date: Date,
        time: Time,

        pub fn init(date: Date, time: Time) Timestamp {
            return .{ .date = date, .time = time };
        }

        pub fn format(self: Timestamp, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
            _ = fmt;
            _ = options;
            try self.date.format("", .{}, writer);
            try writer.writeAll("T");
            try self.time.format("", .{}, writer);
        }
    };

    /// Duration type (ISO 8601)
    pub const Duration = struct {
        months: i64 = 0,
        days: i64 = 0,
        seconds: i64 = 0,
        nanoseconds: i64 = 0,

        pub fn fromDays(days: i64) Duration {
            return .{ .days = days };
        }

        pub fn fromSeconds(seconds: i64) Duration {
            return .{ .seconds = seconds };
        }
    };

    /// Graph node
    pub const Node = struct {
        id: []const u8,
        labels: []const []const u8,
        properties: std.StringHashMapUnmanaged(Value),
    };

    /// Graph relationship/edge
    pub const Relationship = struct {
        id: []const u8,
        type_name: []const u8,
        start_node_id: []const u8,
        end_node_id: []const u8,
        properties: std.StringHashMapUnmanaged(Value),
    };

    /// Graph path
    pub const Path = struct {
        nodes: []const Node,
        relationships: []const Relationship,
    };

    // =========================================================================
    // Constructors
    // =========================================================================

    /// Create a null value
    pub fn initNull() Value {
        return .null;
    }

    /// Create a boolean value
    pub fn initBool(b: bool) Value {
        return .{ .boolean = b };
    }

    /// Create an integer value
    pub fn initInt(i: i64) Value {
        return .{ .integer = i };
    }

    /// Create a float value
    pub fn initFloat(f: f64) Value {
        return .{ .float = f };
    }

    /// Create a string value
    pub fn initString(s: []const u8) Value {
        return .{ .string = s };
    }

    /// Create a bytes value
    pub fn initBytes(b: []const u8) Value {
        return .{ .bytes = b };
    }

    /// Create an array value
    pub fn initArray(arr: []const Value) Value {
        return .{ .array = arr };
    }

    /// Create a date value without validation. Use initDateChecked() for user input.
    pub fn initDate(year: i32, month: u8, day: u8) Value {
        return .{ .date = Date.init(year, month, day) };
    }

    /// Create a date value with bounds validation.
    /// SECURITY: Validates month (1-12) and day (1-31) to prevent invalid temporal data (CWE-20).
    pub fn initDateChecked(year: i32, month: u8, day: u8) !Value {
        return .{ .date = try Date.initChecked(year, month, day) };
    }

    /// Create a time value without validation. Use initTimeChecked() for user input.
    pub fn initTime(hour: u8, minute: u8, second: u8) Value {
        return .{ .time = Time.init(hour, minute, second) };
    }

    /// Create a time value with bounds validation.
    /// SECURITY: Validates hour (0-23), minute (0-59), second (0-59) (CWE-20).
    pub fn initTimeChecked(hour: u8, minute: u8, second: u8) !Value {
        return .{ .time = try Time.initChecked(hour, minute, second) };
    }

    /// Create a timestamp value
    pub fn initTimestamp(date: Date, time: Time) Value {
        return .{ .timestamp = Timestamp.init(date, time) };
    }

    // =========================================================================
    // Type checking
    // =========================================================================

    /// Check if value is null
    pub fn isNull(self: Value) bool {
        return self == .null;
    }

    /// Check if value is a boolean
    pub fn isBool(self: Value) bool {
        return self == .boolean;
    }

    /// Check if value is an integer
    pub fn isInt(self: Value) bool {
        return self == .integer;
    }

    /// Check if value is a float
    pub fn isFloat(self: Value) bool {
        return self == .float;
    }

    /// Check if value is a string
    pub fn isString(self: Value) bool {
        return self == .string;
    }

    /// Check if value is bytes
    pub fn isBytes(self: Value) bool {
        return self == .bytes;
    }

    /// Check if value is an array
    pub fn isArray(self: Value) bool {
        return self == .array;
    }

    /// Check if value is an object
    pub fn isObject(self: Value) bool {
        return self == .object;
    }

    /// Check if value is a date
    pub fn isDate(self: Value) bool {
        return self == .date;
    }

    /// Check if value is a time
    pub fn isTime(self: Value) bool {
        return self == .time;
    }

    /// Check if value is a timestamp
    pub fn isTimestamp(self: Value) bool {
        return self == .timestamp;
    }

    /// Check if value is a duration
    pub fn isDuration(self: Value) bool {
        return self == .duration;
    }

    /// Check if value is a node
    pub fn isNode(self: Value) bool {
        return self == .node;
    }

    /// Check if value is a relationship
    pub fn isRelationship(self: Value) bool {
        return self == .relationship;
    }

    /// Check if value is a path
    pub fn isPath(self: Value) bool {
        return self == .path;
    }

    // =========================================================================
    // Type-safe accessors
    // =========================================================================

    /// Get boolean value or return error
    pub fn asBool(self: Value) !bool {
        return switch (self) {
            .boolean => |b| b,
            else => error.TypeMismatch,
        };
    }

    /// Get integer value or return error
    pub fn asInt(self: Value) !i64 {
        return switch (self) {
            .integer => |i| i,
            else => error.TypeMismatch,
        };
    }

    /// Get float value or return error
    pub fn asFloat(self: Value) !f64 {
        return switch (self) {
            .float => |f| f,
            .integer => |i| @floatFromInt(i),
            else => error.TypeMismatch,
        };
    }

    /// Get string value or return error
    pub fn asString(self: Value) ![]const u8 {
        return switch (self) {
            .string => |s| s,
            else => error.TypeMismatch,
        };
    }

    /// Get bytes value or return error
    pub fn asBytes(self: Value) ![]const u8 {
        return switch (self) {
            .bytes => |b| b,
            else => error.TypeMismatch,
        };
    }

    /// Get array value or return error
    pub fn asArray(self: Value) ![]const Value {
        return switch (self) {
            .array => |a| a,
            else => error.TypeMismatch,
        };
    }

    /// Get object value or return error
    pub fn asObject(self: Value) !std.StringHashMapUnmanaged(Value) {
        return switch (self) {
            .object => |o| o,
            else => error.TypeMismatch,
        };
    }

    /// Get date value or return error
    pub fn asDate(self: Value) !Date {
        return switch (self) {
            .date => |d| d,
            else => error.TypeMismatch,
        };
    }

    /// Get time value or return error
    pub fn asTime(self: Value) !Time {
        return switch (self) {
            .time => |t| t,
            else => error.TypeMismatch,
        };
    }

    /// Get timestamp value or return error
    pub fn asTimestamp(self: Value) !Timestamp {
        return switch (self) {
            .timestamp => |ts| ts,
            else => error.TypeMismatch,
        };
    }

    /// Get node value or return error
    pub fn asNode(self: Value) !Node {
        return switch (self) {
            .node => |n| n,
            else => error.TypeMismatch,
        };
    }

    /// Get relationship value or return error
    pub fn asRelationship(self: Value) !Relationship {
        return switch (self) {
            .relationship => |r| r,
            else => error.TypeMismatch,
        };
    }

    // =========================================================================
    // JSON conversion
    // =========================================================================

    /// Convert from std.json.Value
    pub fn fromJson(json: std.json.Value) Value {
        return switch (json) {
            .null => Value.initNull(),
            .bool => |b| Value.initBool(b),
            .integer => |i| Value.initInt(i),
            .float => |f| Value.initFloat(f),
            .string => |s| Value.initString(s),
            .array => |arr| blk: {
                var values: []Value = undefined;
                // Note: In real code, you'd need an allocator here
                // This is a simplified version for the type system
                _ = arr;
                values = &[_]Value{};
                break :blk Value.initArray(values);
            },
            .object => |_| blk: {
                // Simplified - real implementation would iterate over object
                break :blk Value.initNull();
            },
            .number_string => |s| blk: {
                // Try to parse as integer first, then float
                if (std.fmt.parseInt(i64, s, 10)) |i| {
                    break :blk Value.initInt(i);
                } else |_| {
                    if (std.fmt.parseFloat(f64, s)) |f| {
                        break :blk Value.initFloat(f);
                    } else |_| {
                        break :blk Value.initString(s);
                    }
                }
            },
        };
    }

    /// Convert to JSON value (requires allocator for arrays/objects)
    pub fn toJson(self: Value, allocator: std.mem.Allocator) !std.json.Value {
        return switch (self) {
            .null => std.json.Value.null,
            .boolean => |b| std.json.Value{ .bool = b },
            .integer => |i| std.json.Value{ .integer = i },
            .float => |f| std.json.Value{ .float = f },
            .string => |s| std.json.Value{ .string = s },
            .bytes => |b| blk: {
                // Encode bytes as base64 string
                const encoded = std.base64.standard.Encoder.calcSize(b.len);
                const buf = try allocator.alloc(u8, encoded);
                _ = std.base64.standard.Encoder.encode(buf, b);
                break :blk std.json.Value{ .string = buf };
            },
            .array => |arr| blk: {
                var json_arr = std.json.Array.init(allocator);
                for (arr) |item| {
                    try json_arr.append(try item.toJson(allocator));
                }
                break :blk std.json.Value{ .array = json_arr };
            },
            .object => |obj| blk: {
                var json_obj = std.json.ObjectMap.init(allocator);
                var iter = obj.iterator();
                while (iter.next()) |entry| {
                    try json_obj.put(entry.key_ptr.*, try entry.value_ptr.toJson(allocator));
                }
                break :blk std.json.Value{ .object = json_obj };
            },
            .date => |d| blk: {
                var buf: [16]u8 = undefined;
                var fbs = std.io.fixedBufferStream(&buf);
                d.format("", .{}, fbs.writer()) catch unreachable;
                const str = try allocator.dupe(u8, fbs.getWritten());
                break :blk std.json.Value{ .string = str };
            },
            .time => |t| blk: {
                var buf: [32]u8 = undefined;
                var fbs = std.io.fixedBufferStream(&buf);
                t.format("", .{}, fbs.writer()) catch unreachable;
                const str = try allocator.dupe(u8, fbs.getWritten());
                break :blk std.json.Value{ .string = str };
            },
            .timestamp => |ts| blk: {
                var buf: [48]u8 = undefined;
                var fbs = std.io.fixedBufferStream(&buf);
                ts.format("", .{}, fbs.writer()) catch unreachable;
                const str = try allocator.dupe(u8, fbs.getWritten());
                break :blk std.json.Value{ .string = str };
            },
            .duration, .node, .relationship, .path => {
                // Complex types serialize as objects
                return std.json.Value.null; // Simplified
            },
        };
    }

    /// Get the type name as a string
    pub fn typeName(self: Value) []const u8 {
        return switch (self) {
            .null => "null",
            .boolean => "boolean",
            .integer => "integer",
            .float => "float",
            .string => "string",
            .bytes => "bytes",
            .array => "array",
            .object => "object",
            .date => "date",
            .time => "time",
            .timestamp => "timestamp",
            .duration => "duration",
            .node => "node",
            .relationship => "relationship",
            .path => "path",
        };
    }
};

// =============================================================================
// Unit Tests
// =============================================================================

test "Value.initNull creates null value" {
    const v = Value.initNull();
    try std.testing.expect(v.isNull());
    try std.testing.expectEqualStrings("null", v.typeName());
}

test "Value.initBool creates boolean value" {
    const t = Value.initBool(true);
    const f = Value.initBool(false);

    try std.testing.expect(t.isBool());
    try std.testing.expect(f.isBool());
    try std.testing.expect(try t.asBool());
    try std.testing.expect(!try f.asBool());
    try std.testing.expectEqualStrings("boolean", t.typeName());
}

test "Value.initInt creates integer value" {
    const v = Value.initInt(42);
    try std.testing.expect(v.isInt());
    try std.testing.expectEqual(@as(i64, 42), try v.asInt());
    try std.testing.expectEqualStrings("integer", v.typeName());
}

test "Value.initInt handles negative values" {
    const v = Value.initInt(-100);
    try std.testing.expectEqual(@as(i64, -100), try v.asInt());
}

test "Value.initInt handles large values" {
    const v = Value.initInt(std.math.maxInt(i64));
    try std.testing.expectEqual(std.math.maxInt(i64), try v.asInt());
}

test "Value.initFloat creates float value" {
    const v = Value.initFloat(3.14159);
    try std.testing.expect(v.isFloat());
    try std.testing.expectApproxEqRel(@as(f64, 3.14159), try v.asFloat(), 0.00001);
    try std.testing.expectEqualStrings("float", v.typeName());
}

test "Value.asFloat converts integer to float" {
    const v = Value.initInt(42);
    try std.testing.expectApproxEqRel(@as(f64, 42.0), try v.asFloat(), 0.00001);
}

test "Value.initString creates string value" {
    const v = Value.initString("hello");
    try std.testing.expect(v.isString());
    try std.testing.expectEqualStrings("hello", try v.asString());
    try std.testing.expectEqualStrings("string", v.typeName());
}

test "Value.initString handles empty string" {
    const v = Value.initString("");
    try std.testing.expectEqualStrings("", try v.asString());
}

test "Value.initString handles unicode" {
    const v = Value.initString("日本語");
    try std.testing.expectEqualStrings("日本語", try v.asString());
}

test "Value.initBytes creates bytes value" {
    const data = [_]u8{ 0x00, 0x01, 0x02, 0xff };
    const v = Value.initBytes(&data);
    try std.testing.expect(v.isBytes());
    try std.testing.expectEqualSlices(u8, &data, try v.asBytes());
    try std.testing.expectEqualStrings("bytes", v.typeName());
}

test "Value.initArray creates array value" {
    const items = [_]Value{
        Value.initInt(1),
        Value.initInt(2),
        Value.initInt(3),
    };
    const v = Value.initArray(&items);
    try std.testing.expect(v.isArray());
    const arr = try v.asArray();
    try std.testing.expectEqual(@as(usize, 3), arr.len);
    try std.testing.expectEqual(@as(i64, 1), try arr[0].asInt());
    try std.testing.expectEqualStrings("array", v.typeName());
}

test "Value.initDate creates date value" {
    const v = Value.initDate(2025, 1, 24);
    try std.testing.expect(v.isDate());
    const d = try v.asDate();
    try std.testing.expectEqual(@as(i32, 2025), d.year);
    try std.testing.expectEqual(@as(u8, 1), d.month);
    try std.testing.expectEqual(@as(u8, 24), d.day);
    try std.testing.expectEqualStrings("date", v.typeName());
}

test "Value.initTime creates time value" {
    const v = Value.initTime(14, 30, 45);
    try std.testing.expect(v.isTime());
    const t = try v.asTime();
    try std.testing.expectEqual(@as(u8, 14), t.hour);
    try std.testing.expectEqual(@as(u8, 30), t.minute);
    try std.testing.expectEqual(@as(u8, 45), t.second);
    try std.testing.expectEqualStrings("time", v.typeName());
}

test "Value.Date.format formats correctly" {
    const d = Value.Date.init(2025, 1, 24);
    var buf: [16]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&buf);
    d.format("", .{}, fbs.writer()) catch unreachable;
    try std.testing.expectEqualStrings("2025-01-24", fbs.getWritten());
}

test "Value.Time.format formats correctly" {
    const t = Value.Time.init(14, 30, 45);
    var buf: [32]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&buf);
    t.format("", .{}, fbs.writer()) catch unreachable;
    try std.testing.expectEqualStrings("14:30:45", fbs.getWritten());
}

test "Value.Time.format with nanoseconds" {
    const t = Value.Time.withNanos(14, 30, 45, 123456789);
    var buf: [32]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&buf);
    t.format("", .{}, fbs.writer()) catch unreachable;
    try std.testing.expectEqualStrings("14:30:45.123456789", fbs.getWritten());
}

test "Value.Time.format with timezone offset" {
    var t = Value.Time.init(14, 30, 45);
    t.tz_offset_minutes = 0; // UTC
    var buf: [32]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&buf);
    t.format("", .{}, fbs.writer()) catch unreachable;
    try std.testing.expectEqualStrings("14:30:45Z", fbs.getWritten());

    t.tz_offset_minutes = 330; // +05:30
    fbs = std.io.fixedBufferStream(&buf);
    t.format("", .{}, fbs.writer()) catch unreachable;
    try std.testing.expectEqualStrings("14:30:45+05:30", fbs.getWritten());

    t.tz_offset_minutes = -480; // -08:00
    fbs = std.io.fixedBufferStream(&buf);
    t.format("", .{}, fbs.writer()) catch unreachable;
    try std.testing.expectEqualStrings("14:30:45-08:00", fbs.getWritten());
}

test "Value.Timestamp.format formats correctly" {
    const ts = Value.Timestamp.init(
        Value.Date.init(2025, 1, 24),
        Value.Time.init(14, 30, 45),
    );
    var buf: [48]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&buf);
    ts.format("", .{}, fbs.writer()) catch unreachable;
    try std.testing.expectEqualStrings("2025-01-24T14:30:45", fbs.getWritten());
}

test "type mismatch errors work correctly" {
    const v = Value.initInt(42);
    try std.testing.expectError(error.TypeMismatch, v.asBool());
    try std.testing.expectError(error.TypeMismatch, v.asString());
    try std.testing.expectError(error.TypeMismatch, v.asArray());
}

test "Value.fromJson converts null" {
    const json = std.json.Value.null;
    const v = Value.fromJson(json);
    try std.testing.expect(v.isNull());
}

test "Value.fromJson converts boolean" {
    const json_true = std.json.Value{ .bool = true };
    const json_false = std.json.Value{ .bool = false };
    try std.testing.expect(try Value.fromJson(json_true).asBool());
    try std.testing.expect(!try Value.fromJson(json_false).asBool());
}

test "Value.fromJson converts integer" {
    const json = std.json.Value{ .integer = 42 };
    const v = Value.fromJson(json);
    try std.testing.expectEqual(@as(i64, 42), try v.asInt());
}

test "Value.fromJson converts float" {
    const json = std.json.Value{ .float = 3.14 };
    const v = Value.fromJson(json);
    try std.testing.expectApproxEqRel(@as(f64, 3.14), try v.asFloat(), 0.01);
}

test "Value.fromJson converts string" {
    const json = std.json.Value{ .string = "hello" };
    const v = Value.fromJson(json);
    try std.testing.expectEqualStrings("hello", try v.asString());
}

test "Value.toJson converts null" {
    const v = Value.initNull();
    const json = try v.toJson(std.testing.allocator);
    try std.testing.expect(json == .null);
}

test "Value.toJson converts boolean" {
    const v = Value.initBool(true);
    const json = try v.toJson(std.testing.allocator);
    try std.testing.expect(json.bool);
}

test "Value.toJson converts integer" {
    const v = Value.initInt(42);
    const json = try v.toJson(std.testing.allocator);
    try std.testing.expectEqual(@as(i64, 42), json.integer);
}

test "Value.toJson converts float" {
    const v = Value.initFloat(3.14);
    const json = try v.toJson(std.testing.allocator);
    try std.testing.expectApproxEqRel(@as(f64, 3.14), json.float, 0.01);
}

test "Value.toJson converts string" {
    const v = Value.initString("hello");
    const json = try v.toJson(std.testing.allocator);
    try std.testing.expectEqualStrings("hello", json.string);
}

test "isNode identifies node values" {
    const v = Value.initNull();
    try std.testing.expect(!v.isNode());
}

test "isRelationship identifies relationship values" {
    const v = Value.initNull();
    try std.testing.expect(!v.isRelationship());
}

test "isPath identifies path values" {
    const v = Value.initNull();
    try std.testing.expect(!v.isPath());
}

test "isDuration identifies duration values" {
    const v = Value.initNull();
    try std.testing.expect(!v.isDuration());
}

test "Duration.fromDays creates duration" {
    const d = Value.Duration.fromDays(30);
    try std.testing.expectEqual(@as(i64, 30), d.days);
}

test "Duration.fromSeconds creates duration" {
    const d = Value.Duration.fromSeconds(3600);
    try std.testing.expectEqual(@as(i64, 3600), d.seconds);
}

// =============================================================================
// Security Tests - Date/Time Bounds Validation (CWE-20)
// =============================================================================

test "Date.initChecked accepts valid dates" {
    const d = try Value.Date.initChecked(2025, 1, 24);
    try std.testing.expectEqual(@as(i32, 2025), d.year);
    try std.testing.expectEqual(@as(u8, 1), d.month);
    try std.testing.expectEqual(@as(u8, 24), d.day);
}

test "Date.initChecked rejects month=0" {
    try std.testing.expectError(error.InvalidMonth, Value.Date.initChecked(2025, 0, 15));
}

test "Date.initChecked rejects month=13" {
    try std.testing.expectError(error.InvalidMonth, Value.Date.initChecked(2025, 13, 15));
}

test "Date.initChecked rejects day=0" {
    try std.testing.expectError(error.InvalidDay, Value.Date.initChecked(2025, 6, 0));
}

test "Date.initChecked rejects day=32" {
    try std.testing.expectError(error.InvalidDay, Value.Date.initChecked(2025, 6, 32));
}

test "Date.initChecked accepts boundary values" {
    // Month boundaries
    _ = try Value.Date.initChecked(2025, 1, 15); // min month
    _ = try Value.Date.initChecked(2025, 12, 15); // max month
    // Day boundaries
    _ = try Value.Date.initChecked(2025, 6, 1); // min day
    _ = try Value.Date.initChecked(2025, 6, 31); // max day
}

test "Time.initChecked accepts valid times" {
    const t = try Value.Time.initChecked(14, 30, 45);
    try std.testing.expectEqual(@as(u8, 14), t.hour);
    try std.testing.expectEqual(@as(u8, 30), t.minute);
    try std.testing.expectEqual(@as(u8, 45), t.second);
}

test "Time.initChecked rejects hour=24" {
    try std.testing.expectError(error.InvalidHour, Value.Time.initChecked(24, 0, 0));
}

test "Time.initChecked rejects minute=60" {
    try std.testing.expectError(error.InvalidMinute, Value.Time.initChecked(12, 60, 0));
}

test "Time.initChecked rejects second=60" {
    try std.testing.expectError(error.InvalidSecond, Value.Time.initChecked(12, 30, 60));
}

test "Time.initChecked accepts boundary values" {
    // Hour boundaries
    _ = try Value.Time.initChecked(0, 30, 30); // min hour
    _ = try Value.Time.initChecked(23, 30, 30); // max hour
    // Minute boundaries
    _ = try Value.Time.initChecked(12, 0, 30); // min minute
    _ = try Value.Time.initChecked(12, 59, 30); // max minute
    // Second boundaries
    _ = try Value.Time.initChecked(12, 30, 0); // min second
    _ = try Value.Time.initChecked(12, 30, 59); // max second
}

test "Time.withNanosChecked accepts valid nanoseconds" {
    const t = try Value.Time.withNanosChecked(14, 30, 45, 123456789);
    try std.testing.expectEqual(@as(u32, 123456789), t.nanosecond);
}

test "Time.withNanosChecked rejects invalid nanoseconds" {
    try std.testing.expectError(error.InvalidNanosecond, Value.Time.withNanosChecked(12, 30, 30, 1_000_000_000));
}

test "Time.withNanosChecked accepts max valid nanoseconds" {
    _ = try Value.Time.withNanosChecked(12, 30, 30, 999_999_999);
}

test "Value.initDateChecked accepts valid dates" {
    const v = try Value.initDateChecked(2025, 6, 15);
    try std.testing.expect(v.isDate());
    const d = try v.asDate();
    try std.testing.expectEqual(@as(u8, 6), d.month);
}

test "Value.initDateChecked rejects invalid dates" {
    try std.testing.expectError(error.InvalidMonth, Value.initDateChecked(2025, 13, 15));
    try std.testing.expectError(error.InvalidDay, Value.initDateChecked(2025, 6, 32));
}

test "Value.initTimeChecked accepts valid times" {
    const v = try Value.initTimeChecked(14, 30, 45);
    try std.testing.expect(v.isTime());
    const t = try v.asTime();
    try std.testing.expectEqual(@as(u8, 14), t.hour);
}

test "Value.initTimeChecked rejects invalid times" {
    try std.testing.expectError(error.InvalidHour, Value.initTimeChecked(24, 0, 0));
    try std.testing.expectError(error.InvalidMinute, Value.initTimeChecked(12, 60, 0));
    try std.testing.expectError(error.InvalidSecond, Value.initTimeChecked(12, 30, 60));
}
