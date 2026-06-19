// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Time-string parsing for Geode server responses. Ported from
// geode-client-go time.go. Tries RFC3339-style and fallback layouts, strips
// Go's monotonic clock suffix, and produces a temporal Value.

const std = @import("std");
const types = @import("types");
const Value = types.Value;

/// Errors returned by parseTime/scanTime.
pub const ParseError = error{
    /// Input string was empty.
    EmptyTimeString,
    /// Input did not match any supported layout.
    UnrecognizedTimeFormat,
};

/// Remove Go's monotonic clock suffix (" m=+N" / " m=-N") if present.
pub fn stripMonotonic(s: []const u8) []const u8 {
    if (std.mem.indexOf(u8, s, " m=")) |idx| return s[0..idx];
    return s;
}

const ParsedDateTime = struct {
    year: i32,
    month: u8,
    day: u8,
    hour: u8 = 0,
    minute: u8 = 0,
    second: u8 = 0,
    nanosecond: u32 = 0,
    has_time: bool,
};

fn parseUint(comptime T: type, s: []const u8) ?T {
    return std.fmt.parseInt(T, s, 10) catch null;
}

/// Parse the date portion "YYYY-MM-DD" at the start of s. Returns null on
/// malformed input.
fn parseDatePart(s: []const u8) ?struct { year: i32, month: u8, day: u8 } {
    if (s.len < 10) return null;
    if (s[4] != '-' or s[7] != '-') return null;
    const year = parseUint(i32, s[0..4]) orelse return null;
    const month = parseUint(u8, s[5..7]) orelse return null;
    const day = parseUint(u8, s[8..10]) orelse return null;
    if (month < 1 or month > 12 or day < 1 or day > 31) return null;
    return .{ .year = year, .month = month, .day = day };
}

/// Parse "HH:MM:SS[.fraction]" returning hour/minute/second/nanos. Returns
/// null on malformed input. `frac` may be empty.
fn parseTimePart(s: []const u8) ?struct { hour: u8, minute: u8, second: u8, nanosecond: u32 } {
    if (s.len < 8) return null;
    if (s[2] != ':' or s[5] != ':') return null;
    const hour = parseUint(u8, s[0..2]) orelse return null;
    const minute = parseUint(u8, s[3..5]) orelse return null;
    const second = parseUint(u8, s[6..8]) orelse return null;
    if (hour > 23 or minute > 59 or second > 59) return null;
    var nanosecond: u32 = 0;
    if (s.len > 8 and s[8] == '.') {
        var end: usize = 9;
        while (end < s.len and s[end] >= '0' and s[end] <= '9') : (end += 1) {}
        const frac = s[9..end];
        if (frac.len > 0) {
            // Pad/truncate fractional digits to 9 (nanoseconds).
            var buf: [9]u8 = .{ '0', '0', '0', '0', '0', '0', '0', '0', '0' };
            const n = @min(frac.len, 9);
            @memcpy(buf[0..n], frac[0..n]);
            nanosecond = parseUint(u32, &buf) orelse 0;
        }
    }
    return .{ .hour = hour, .minute = minute, .second = second, .nanosecond = nanosecond };
}

/// Attempt to parse `s` (already monotonic-stripped, trimmed) into a
/// ParsedDateTime. Handles 'T' and space date/time separators, optional
/// trailing 'Z'/offset/zone (ignored beyond the time component), and
/// date-only input.
fn parseFlexible(s_in: []const u8) ?ParsedDateTime {
    const s = std.mem.trim(u8, s_in, " ");
    const date = parseDatePart(s) orelse return null;
    if (s.len == 10) {
        return .{ .year = date.year, .month = date.month, .day = date.day, .has_time = false };
    }
    if (s.len < 11) return null;
    const sep = s[10];
    if (sep != 'T' and sep != ' ') return null;
    const t = parseTimePart(s[11..]) orelse return null;
    return .{
        .year = date.year,
        .month = date.month,
        .day = date.day,
        .hour = t.hour,
        .minute = t.minute,
        .second = t.second,
        .nanosecond = t.nanosecond,
        .has_time = true,
    };
}

/// Parse a Geode server time string into a temporal Value. Date-only input
/// yields a Value.date; otherwise a Value.timestamp.
pub fn parseTime(s_in: []const u8) ParseError!Value {
    if (s_in.len == 0) return ParseError.EmptyTimeString;
    const s = stripMonotonic(s_in);
    const parsed = parseFlexible(s) orelse return ParseError.UnrecognizedTimeFormat;
    if (!parsed.has_time) {
        return Value.initDate(parsed.year, parsed.month, parsed.day);
    }
    return Value{ .timestamp = Value.Timestamp.init(
        Value.Date.init(parsed.year, parsed.month, parsed.day),
        Value.Time.withNanos(parsed.hour, parsed.minute, parsed.second, parsed.nanosecond),
    ) };
}

/// Scanner-style adapter: null or empty source yields a zero-value
/// timestamp; otherwise delegates to parseTime.
pub fn scanTime(src: ?[]const u8) ParseError!Value {
    const s = src orelse return zeroTimestamp();
    if (s.len == 0) return zeroTimestamp();
    return parseTime(s);
}

fn zeroTimestamp() Value {
    return Value{ .timestamp = Value.Timestamp.init(
        Value.Date.init(0, 1, 1),
        Value.Time.init(0, 0, 0),
    ) };
}

test "stripMonotonic removes Go monotonic suffix" {
    try std.testing.expectEqualStrings(
        "2025-01-24 14:30:45.123 -0700 MST",
        stripMonotonic("2025-01-24 14:30:45.123 -0700 MST m=+0.001234"),
    );
    try std.testing.expectEqualStrings("2025-01-24", stripMonotonic("2025-01-24"));
}

test "parseTime parses RFC3339" {
    const v = try parseTime("2025-01-24T14:30:45Z");
    const ts = try v.asTimestamp();
    try std.testing.expectEqual(@as(i32, 2025), ts.date.year);
    try std.testing.expectEqual(@as(u8, 1), ts.date.month);
    try std.testing.expectEqual(@as(u8, 24), ts.date.day);
    try std.testing.expectEqual(@as(u8, 14), ts.time.hour);
    try std.testing.expectEqual(@as(u8, 30), ts.time.minute);
    try std.testing.expectEqual(@as(u8, 45), ts.time.second);
}

test "parseTime parses RFC3339Nano" {
    const v = try parseTime("2025-01-24T14:30:45.123456789Z");
    const ts = try v.asTimestamp();
    try std.testing.expectEqual(@as(u32, 123456789), ts.time.nanosecond);
}

test "parseTime parses space-separated datetime" {
    const v = try parseTime("2025-01-24 14:30:45");
    const ts = try v.asTimestamp();
    try std.testing.expectEqual(@as(u8, 45), ts.time.second);
}

test "parseTime parses date-only" {
    const v = try parseTime("2025-01-24");
    const d = try v.asDate();
    try std.testing.expectEqual(@as(i32, 2025), d.year);
    try std.testing.expectEqual(@as(u8, 24), d.day);
}

test "parseTime strips monotonic before parsing" {
    const v = try parseTime("2025-01-24 14:30:45 m=+12.5");
    const ts = try v.asTimestamp();
    try std.testing.expectEqual(@as(u8, 30), ts.time.minute);
}

test "parseTime errors on empty and unrecognized" {
    try std.testing.expectError(ParseError.EmptyTimeString, parseTime(""));
    try std.testing.expectError(ParseError.UnrecognizedTimeFormat, parseTime("not a time"));
}

test "scanTime returns zero timestamp for null/empty" {
    const v1 = try scanTime(null);
    const ts1 = try v1.asTimestamp();
    try std.testing.expectEqual(@as(i32, 0), ts1.date.year);
    const v2 = try scanTime("");
    _ = try v2.asTimestamp();
}
