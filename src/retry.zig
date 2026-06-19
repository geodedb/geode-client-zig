// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Retry policy and helper for transient Geode errors. Ported from
// geode-client-go retry.go: 3 attempts, exponential backoff 1s..30s,
// multiplier 2.0, retry only on retryable errors.

const std = @import("std");
const GeodeError = @import("error").GeodeError;

/// Result returned by a retryable function: success or a GeodeError.
pub const RetryResult = union(enum) {
    ok,
    err: GeodeError,
};

/// Retry policy for transient errors.
pub const RetryPolicy = struct {
    /// Maximum number of attempts including the initial call (< 1 treated as 1).
    max_attempts: u32 = 3,
    /// Delay before the first retry, in nanoseconds.
    initial_backoff_ns: u64 = 1_000_000_000,
    /// Maximum backoff, in nanoseconds (exponential growth is clamped here).
    max_backoff_ns: u64 = 30_000_000_000,
    /// Exponential backoff multiplier applied each retry.
    multiplier: f64 = 2.0,

    /// Default policy: 3 attempts, 1s initial, 30s max, 2.0 multiplier.
    pub fn default() RetryPolicy {
        return .{};
    }

    /// Backoff duration (ns) for `attempt` (1-indexed), clamped to max_backoff_ns.
    pub fn backoffNs(self: RetryPolicy, attempt: u32) u64 {
        const a = if (attempt < 1) 1 else attempt;
        const factor = std.math.pow(f64, self.multiplier, @floatFromInt(a - 1));
        const d = @as(f64, @floatFromInt(self.initial_backoff_ns)) * factor;
        if (d >= @as(f64, @floatFromInt(self.max_backoff_ns))) return self.max_backoff_ns;
        return @intFromFloat(d);
    }
};

/// Execute `func(ctx)` up to `policy.max_attempts` times, retrying only when
/// the returned GeodeError is retryable. Returns null on success or the last
/// error otherwise. `sleep_fn` (if non-null) is invoked with the backoff
/// duration between attempts; pass null to skip sleeping (used in tests).
pub fn retry(
    policy: RetryPolicy,
    comptime Ctx: type,
    ctx: Ctx,
    comptime func: fn (Ctx) RetryResult,
    sleep_fn: ?*const fn (u64) void,
) ?GeodeError {
    const max_attempts: u32 = if (policy.max_attempts < 1) 1 else policy.max_attempts;
    var last_err: ?GeodeError = null;
    var attempt: u32 = 1;
    while (attempt <= max_attempts) : (attempt += 1) {
        switch (func(ctx)) {
            .ok => return null,
            .err => |e| {
                last_err = e;
                if (!e.isRetryable()) return e;
                if (attempt == max_attempts) break;
                if (sleep_fn) |sf| sf(policy.backoffNs(attempt));
            },
        }
    }
    return last_err;
}

test "RetryPolicy.backoffNs grows exponentially and clamps" {
    const p = RetryPolicy.default();
    try std.testing.expectEqual(@as(u64, 1_000_000_000), p.backoffNs(1));
    try std.testing.expectEqual(@as(u64, 2_000_000_000), p.backoffNs(2));
    try std.testing.expectEqual(@as(u64, 4_000_000_000), p.backoffNs(3));
    // Clamped at max (30s).
    try std.testing.expectEqual(@as(u64, 30_000_000_000), p.backoffNs(100));
}

test "retry stops immediately on non-retryable error" {
    const Ctx = struct {
        calls: *u32,
    };
    var calls: u32 = 0;
    const ctx = Ctx{ .calls = &calls };
    const f = struct {
        fn call(c: Ctx) RetryResult {
            c.calls.* += 1;
            return .{ .err = GeodeError.syntax("bad query") }; // not retryable
        }
    }.call;

    const err = retry(RetryPolicy.default(), Ctx, ctx, f, null);
    try std.testing.expect(err != null);
    try std.testing.expectEqual(@as(u32, 1), calls); // only one attempt
}

test "retry attempts up to max_attempts on retryable error" {
    const Ctx = struct {
        calls: *u32,
    };
    var calls: u32 = 0;
    const ctx = Ctx{ .calls = &calls };
    const f = struct {
        fn call(c: Ctx) RetryResult {
            c.calls.* += 1;
            return .{ .err = GeodeError.connection("lost") }; // retryable
        }
    }.call;

    const err = retry(RetryPolicy.default(), Ctx, ctx, f, noSleep);
    try std.testing.expect(err != null);
    try std.testing.expectEqual(@as(u32, 3), calls); // max attempts
}

test "retry returns null and stops once func succeeds" {
    const Ctx = struct {
        calls: *u32,
    };
    var calls: u32 = 0;
    const ctx = Ctx{ .calls = &calls };
    const f = struct {
        fn call(c: Ctx) RetryResult {
            c.calls.* += 1;
            if (c.calls.* < 2) return .{ .err = GeodeError.timeout("slow") };
            return .ok;
        }
    }.call;

    const err = retry(RetryPolicy.default(), Ctx, ctx, f, noSleep);
    try std.testing.expect(err == null);
    try std.testing.expectEqual(@as(u32, 2), calls);
}

fn noSleep(_: u64) void {}
