const std = @import("std");

// Transport deadlines use the target's monotonic clock, as pool deadlines do.
// Raw Linux syscalls are not portable to the macOS client.
pub fn nowNs() i128 {
    return std.Io.Clock.awake.now(std.Io.Threaded.global_single_threaded.io()).toNanoseconds();
}

/// Compute the remaining timeout in milliseconds from a start timestamp and
/// total timeout. Return zero once the deadline has passed.
pub fn remainingMs(start: i128, timeout_ns: u64) u32 {
    const elapsed_ns = nowNs() - start;
    if (elapsed_ns < 0) return 0;
    const elapsed: u64 = @intCast(elapsed_ns);
    if (elapsed >= timeout_ns) return 0;
    const remaining_ns = timeout_ns - elapsed;
    const remaining_ms = remaining_ns / std.time.ns_per_ms;
    // Clamp to u32 and ensure at least 1ms when there is remaining time.
    if (remaining_ms == 0) return 1;
    if (remaining_ms > std.math.maxInt(u32)) return std.math.maxInt(u32);
    return @intCast(remaining_ms);
}

test "client deadlines use the native monotonic clock" {
    const io = std.Io.Threaded.global_single_threaded.io();
    const before = std.Io.Clock.awake.now(io).toNanoseconds();
    const start = nowNs();
    const after = std.Io.Clock.awake.now(io).toNanoseconds();
    try std.testing.expect(start >= before and start <= after);
}

test "client deadlines retain active budgets and expire permanently" {
    const start = nowNs();
    try std.testing.expectEqual(@as(u32, 0), remainingMs(start, 0));
    try std.testing.expectEqual(@as(u32, 0), remainingMs(start - 2 * std.time.ns_per_s, std.time.ns_per_s));
    const remaining = remainingMs(start, 30 * std.time.ns_per_s);
    try std.testing.expect(remaining > 0 and remaining <= 30_000);
    try std.testing.expectEqual(std.math.maxInt(u32), remainingMs(start, std.math.maxInt(u64)));
}
