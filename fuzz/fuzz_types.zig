// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Fuzz tests for Value type system in the Geode Zig client library.
// Tests JSON conversion and type operations with arbitrary input.

const std = @import("std");
const types = @import("types");
const Value = types.Value;

/// Fuzz test for JSON to Value conversion
pub fn main() !void {
    var buffer: [64 * 1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const stdin = std.Io.getStdIn();
    const input = stdin.readToEndAlloc(allocator, 1024 * 1024) catch return;

    // Try to parse as JSON and convert to Value
    const parsed = std.json.parseFromSlice(std.json.Value, allocator, input, .{}) catch return;
    defer parsed.deinit();

    const value = Value.fromJson(parsed.value);

    // Try to convert back to JSON
    _ = value.toJson(allocator) catch {};
}

// Note: Zig's std.testing.fuzz requires specific setup.
// These property-based tests provide similar coverage.

// =============================================================================
// Property-Based Tests
// =============================================================================

test "property: null roundtrip" {
    const v = Value.initNull();
    try std.testing.expect(v.isNull());
    try std.testing.expectEqualStrings("null", v.typeName());

    const json = try v.toJson(std.testing.allocator);
    try std.testing.expect(json == .null);
}

test "property: bool roundtrip" {
    const bools = [_]bool{ true, false };

    for (bools) |b| {
        const v = Value.initBool(b);
        try std.testing.expect(v.isBool());
        try std.testing.expectEqual(b, try v.asBool());

        const json = try v.toJson(std.testing.allocator);
        try std.testing.expectEqual(b, json.bool);
    }
}

test "property: integer roundtrip for various values" {
    const ints = [_]i64{
        0,
        1,
        -1,
        42,
        -42,
        127,
        -128,
        255,
        256,
        -256,
        32767,
        -32768,
        65535,
        2147483647,
        -2147483648,
        std.math.maxInt(i64),
        std.math.minInt(i64),
    };

    for (ints) |i| {
        const v = Value.initInt(i);
        try std.testing.expect(v.isInt());
        try std.testing.expectEqual(i, try v.asInt());

        const json = try v.toJson(std.testing.allocator);
        try std.testing.expectEqual(i, json.integer);
    }
}

test "property: float roundtrip for various values" {
    const floats = [_]f64{
        0.0,
        1.0,
        -1.0,
        0.5,
        -0.5,
        3.14159265359,
        -3.14159265359,
        1.0e10,
        1.0e-10,
        std.math.floatMax(f64),
        std.math.floatMin(f64),
    };

    for (floats) |f| {
        const v = Value.initFloat(f);
        try std.testing.expect(v.isFloat());
        try std.testing.expectApproxEqRel(f, try v.asFloat(), 0.0001);
    }
}

test "property: string roundtrip for various values" {
    const strings = [_][]const u8{
        "",
        "a",
        "hello",
        "Hello, World!",
        "unicode: \u{00E9}\u{00F1}\u{00FC}",
        "emoji: \u{1F600}",
        "newlines\nand\ttabs",
        "quotes: \"double\" and 'single'",
        "backslash: \\",
        "null char: \x00",
    };

    for (strings) |s| {
        const v = Value.initString(s);
        try std.testing.expect(v.isString());
        try std.testing.expectEqualStrings(s, try v.asString());
    }
}

test "property: date formatting is consistent" {
    const dates = [_]struct { year: i32, month: u8, day: u8, expected: []const u8 }{
        .{ .year = 2025, .month = 1, .day = 24, .expected = "2025-01-24" },
        .{ .year = 2000, .month = 12, .day = 31, .expected = "2000-12-31" },
        .{ .year = 1999, .month = 1, .day = 1, .expected = "1999-01-01" },
        .{ .year = 0, .month = 1, .day = 1, .expected = "0000-01-01" },
    };

    for (dates) |d| {
        const date = Value.Date.init(d.year, d.month, d.day);
        var buf: [16]u8 = undefined;
        var fbs = std.Io.fixedBufferStream(&buf);
        date.format("", .{}, fbs.writer()) catch unreachable;
        try std.testing.expectEqualStrings(d.expected, fbs.getWritten());
    }
}

test "property: time formatting is consistent" {
    const times = [_]struct { hour: u8, minute: u8, second: u8, expected: []const u8 }{
        .{ .hour = 0, .minute = 0, .second = 0, .expected = "00:00:00" },
        .{ .hour = 12, .minute = 30, .second = 45, .expected = "12:30:45" },
        .{ .hour = 23, .minute = 59, .second = 59, .expected = "23:59:59" },
    };

    for (times) |t| {
        const time = Value.Time.init(t.hour, t.minute, t.second);
        var buf: [32]u8 = undefined;
        var fbs = std.Io.fixedBufferStream(&buf);
        time.format("", .{}, fbs.writer()) catch unreachable;
        try std.testing.expectEqualStrings(t.expected, fbs.getWritten());
    }
}

test "property: type accessors return correct errors" {
    const v = Value.initInt(42);

    // Correct accessor works
    try std.testing.expectEqual(@as(i64, 42), try v.asInt());

    // Wrong accessors return TypeMismatch
    try std.testing.expectError(error.TypeMismatch, v.asBool());
    try std.testing.expectError(error.TypeMismatch, v.asString());
    try std.testing.expectError(error.TypeMismatch, v.asBytes());
    try std.testing.expectError(error.TypeMismatch, v.asArray());
    try std.testing.expectError(error.TypeMismatch, v.asObject());
    try std.testing.expectError(error.TypeMismatch, v.asDate());
    try std.testing.expectError(error.TypeMismatch, v.asTime());
    try std.testing.expectError(error.TypeMismatch, v.asTimestamp());
    try std.testing.expectError(error.TypeMismatch, v.asNode());
    try std.testing.expectError(error.TypeMismatch, v.asRelationship());
}

test "property: type checking is exclusive" {
    const values = [_]Value{
        Value.initNull(),
        Value.initBool(true),
        Value.initInt(42),
        Value.initFloat(3.14),
        Value.initString("test"),
    };

    for (values) |v| {
        var true_count: u32 = 0;
        if (v.isNull()) true_count += 1;
        if (v.isBool()) true_count += 1;
        if (v.isInt()) true_count += 1;
        if (v.isFloat()) true_count += 1;
        if (v.isString()) true_count += 1;
        if (v.isBytes()) true_count += 1;
        if (v.isArray()) true_count += 1;
        if (v.isObject()) true_count += 1;
        if (v.isDate()) true_count += 1;
        if (v.isTime()) true_count += 1;
        if (v.isTimestamp()) true_count += 1;
        if (v.isDuration()) true_count += 1;
        if (v.isNode()) true_count += 1;
        if (v.isRelationship()) true_count += 1;
        if (v.isPath()) true_count += 1;

        // Exactly one type check should return true
        try std.testing.expectEqual(@as(u32, 1), true_count);
    }
}

test "property: asFloat accepts integers" {
    const ints = [_]i64{ 0, 1, -1, 100, -100, 1000000 };

    for (ints) |i| {
        const v = Value.initInt(i);
        const f = try v.asFloat();
        try std.testing.expectApproxEqRel(@as(f64, @floatFromInt(i)), f, 0.0001);
    }
}

test "property: array values maintain order" {
    const items = [_]Value{
        Value.initInt(1),
        Value.initInt(2),
        Value.initInt(3),
        Value.initString("test"),
        Value.initBool(true),
    };

    const v = Value.initArray(&items);
    try std.testing.expect(v.isArray());

    const arr = try v.asArray();
    try std.testing.expectEqual(items.len, arr.len);

    for (arr, 0..) |item, i| {
        try std.testing.expectEqual(items[i].typeName(), item.typeName());
    }
}

test "property: bytes values are distinct from strings" {
    const data = [_]u8{ 0x00, 0x01, 0x02, 0xff, 0xfe };

    const bytes_val = Value.initBytes(&data);
    const string_val = Value.initString(&data);

    try std.testing.expect(bytes_val.isBytes());
    try std.testing.expect(!bytes_val.isString());

    try std.testing.expect(string_val.isString());
    try std.testing.expect(!string_val.isBytes());

    try std.testing.expectEqualStrings("bytes", bytes_val.typeName());
    try std.testing.expectEqualStrings("string", string_val.typeName());
}

test "property: duration factory methods work" {
    const d1 = Value.Duration.fromDays(30);
    try std.testing.expectEqual(@as(i64, 30), d1.days);
    try std.testing.expectEqual(@as(i64, 0), d1.seconds);

    const d2 = Value.Duration.fromSeconds(3600);
    try std.testing.expectEqual(@as(i64, 0), d2.days);
    try std.testing.expectEqual(@as(i64, 3600), d2.seconds);
}
