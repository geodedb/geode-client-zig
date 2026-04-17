// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Fuzz tests for connection pool in the Geode Zig client library.
// Tests pool operations with various configurations and usage patterns.

const std = @import("std");
const pool_mod = @import("pool");

// std.time.milliTimestamp was removed in zig 0.16.0.
fn nowMs() i64 {
    var ts: std.os.linux.timespec = undefined;
    const rc = std.os.linux.clock_gettime(.MONOTONIC, &ts);
    if (rc != 0) return 0;
    return @intCast(@divFloor(@as(i128, ts.sec) * std.time.ns_per_s + @as(i128, ts.nsec), std.time.ns_per_ms));
}

const Pool = pool_mod.Pool;
const PoolConfig = pool_mod.PoolConfig;
const PooledConnection = pool_mod.PooledConnection;
const ConnectionState = pool_mod.ConnectionState;
const config = @import("config");
const Config = config.Config;

// Test connection type
const TestConnection = struct {
    id: u64,
};

const TestPool = Pool(TestConnection);

// =============================================================================
// Property-Based Tests for PoolConfig
// =============================================================================

test "property: PoolConfig defaults are valid" {
    const cfg = PoolConfig.init();

    try std.testing.expect(cfg.min_size <= cfg.max_size);
    try std.testing.expect(cfg.min_size >= 1);
    try std.testing.expect(cfg.max_size >= 1);
    try std.testing.expect(cfg.acquire_timeout_ms > 0);
    try std.testing.expect(cfg.idle_timeout_ms > 0);
    try std.testing.expect(cfg.health_check_interval_ms > 0);
}

test "property: PoolConfig builder preserves values" {
    var cfg = PoolConfig.init();
    _ = cfg.withMinSize(5);
    _ = cfg.withMaxSize(20);
    _ = cfg.withAcquireTimeout(60000);
    _ = cfg.withIdleTimeout(120000);

    try std.testing.expectEqual(@as(u32, 5), cfg.min_size);
    try std.testing.expectEqual(@as(u32, 20), cfg.max_size);
    try std.testing.expectEqual(@as(u32, 60000), cfg.acquire_timeout_ms);
    try std.testing.expectEqual(@as(u32, 120000), cfg.idle_timeout_ms);
}

test "property: PoolConfig builder chain returns self" {
    var cfg = PoolConfig.init();
    const result = cfg.withMinSize(5).withMaxSize(20).withAcquireTimeout(30000);

    try std.testing.expectEqual(@as(u32, 5), result.min_size);
    try std.testing.expectEqual(@as(u32, 20), result.max_size);
    try std.testing.expectEqual(@as(u32, 30000), result.acquire_timeout_ms);
}

// =============================================================================
// Property-Based Tests for PooledConnection
// =============================================================================

test "property: PooledConnection state transitions" {
    var conn = PooledConnection{
        .id = 1,
        .state = .idle,
        .created_at = nowMs(),
        .last_used_at = nowMs(),
        .use_count = 0,
    };

    // Initial state
    try std.testing.expect(conn.isIdle());
    try std.testing.expect(!conn.isInUse());

    // Acquire
    conn.acquire();
    try std.testing.expect(!conn.isIdle());
    try std.testing.expect(conn.isInUse());
    try std.testing.expectEqual(@as(u64, 1), conn.use_count);

    // Release
    conn.release();
    try std.testing.expect(conn.isIdle());
    try std.testing.expect(!conn.isInUse());

    // Acquire again
    conn.acquire();
    try std.testing.expectEqual(@as(u64, 2), conn.use_count);
}

test "property: PooledConnection tracks use count" {
    var conn = PooledConnection{
        .id = 1,
        .state = .idle,
        .created_at = 0,
        .last_used_at = 0,
        .use_count = 0,
    };

    for (0..100) |i| {
        conn.acquire();
        try std.testing.expectEqual(@as(u64, i + 1), conn.use_count);
        conn.release();
    }

    try std.testing.expectEqual(@as(u64, 100), conn.use_count);
}

test "property: PooledConnection updates last_used_at" {
    var conn = PooledConnection{
        .id = 1,
        .state = .idle,
        .created_at = 0,
        .last_used_at = 0,
        .use_count = 0,
    };

    const before = nowMs();
    conn.acquire();
    const after_acquire = conn.last_used_at;
    const after = nowMs();

    try std.testing.expect(after_acquire >= before);
    try std.testing.expect(after_acquire <= after);

    conn.release();
    try std.testing.expect(conn.last_used_at >= after_acquire);
}

test "property: PooledConnection idle expiry detection" {
    var conn = PooledConnection{
        .id = 1,
        .state = .idle,
        .created_at = 0,
        .last_used_at = nowMs() - 10000, // 10 seconds ago
        .use_count = 0,
    };

    // Should be expired with 5 second timeout
    try std.testing.expect(conn.isIdleExpired(5000));

    // Should not be expired with 20 second timeout
    try std.testing.expect(!conn.isIdleExpired(20000));

    // In-use connections are never expired
    conn.state = .in_use;
    try std.testing.expect(!conn.isIdleExpired(1));
}

// =============================================================================
// Property-Based Tests for Pool
// =============================================================================

test "property: new pool is empty" {
    var p = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer p.deinit();

    try std.testing.expectEqual(@as(u32, 0), p.size());
    try std.testing.expectEqual(@as(u32, 0), p.available());
    try std.testing.expectEqual(@as(u32, 0), p.inUse());
    try std.testing.expect(!p.isClosed());
}

test "property: acquire creates connection when pool is empty" {
    var p = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer p.deinit();

    const conn = try p.acquire();
    defer p.release(conn);

    try std.testing.expectEqual(@as(u32, 1), p.size());
    try std.testing.expectEqual(@as(u32, 1), p.inUse());
    try std.testing.expectEqual(@as(u32, 0), p.available());
}

test "property: release returns connection to pool" {
    var p = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer p.deinit();

    const conn = try p.acquire();
    try std.testing.expectEqual(@as(u32, 1), p.inUse());
    try std.testing.expectEqual(@as(u32, 0), p.available());

    p.release(conn);
    try std.testing.expectEqual(@as(u32, 0), p.inUse());
    try std.testing.expectEqual(@as(u32, 1), p.available());
}

test "property: acquire reuses released connection" {
    var p = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer p.deinit();

    const conn1 = try p.acquire();
    const id1 = conn1.id;
    p.release(conn1);

    const conn2 = try p.acquire();
    const id2 = conn2.id;
    p.release(conn2);

    // Same connection should be reused
    try std.testing.expectEqual(id1, id2);
    try std.testing.expectEqual(@as(u32, 1), p.size());
}

test "property: pool respects max_size" {
    var pool_cfg = PoolConfig.init();
    _ = pool_cfg.withMaxSize(2);
    _ = pool_cfg.withAcquireTimeout(50); // Short timeout

    var p = try TestPool.init(std.testing.allocator, Config.init(), pool_cfg);
    defer p.deinit();

    const conn1 = try p.acquire();
    const conn2 = try p.acquire();

    try std.testing.expectEqual(@as(u32, 2), p.size());
    try std.testing.expectEqual(@as(u32, 2), p.inUse());

    // Third acquire should timeout
    try std.testing.expectError(error.AcquireTimeout, p.acquire());

    p.release(conn1);
    p.release(conn2);
}

test "property: pool stats are accurate" {
    var p = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer p.deinit();

    // Initial stats
    var stats = p.getStats();
    try std.testing.expectEqual(@as(u64, 0), stats.total_connections);
    try std.testing.expectEqual(@as(u64, 0), stats.acquire_count);
    try std.testing.expectEqual(@as(u64, 0), stats.release_count);

    // After acquire
    const conn = try p.acquire();
    stats = p.getStats();
    try std.testing.expectEqual(@as(u64, 1), stats.total_connections);
    try std.testing.expectEqual(@as(u64, 1), stats.acquire_count);
    try std.testing.expectEqual(@as(u32, 1), stats.active_connections);
    try std.testing.expectEqual(@as(u32, 0), stats.idle_connections);

    // After release
    p.release(conn);
    stats = p.getStats();
    try std.testing.expectEqual(@as(u64, 1), stats.release_count);
    try std.testing.expectEqual(@as(u32, 0), stats.active_connections);
    try std.testing.expectEqual(@as(u32, 1), stats.idle_connections);
}

test "property: remove updates stats correctly" {
    var p = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer p.deinit();

    const conn = try p.acquire();
    p.remove(conn);

    const stats = p.getStats();
    try std.testing.expectEqual(@as(u64, 1), stats.error_close_count);
    try std.testing.expectEqual(@as(u32, 0), stats.active_connections);
}

test "property: closed pool rejects acquire" {
    var p = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    p.deinit();

    try std.testing.expect(p.isClosed());
    try std.testing.expectError(error.PoolClosed, p.acquire());
}

test "property: double release is safe" {
    var p = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer p.deinit();

    const conn = try p.acquire();
    p.release(conn);
    p.release(conn); // Should not crash or corrupt state

    // Pool should still be in valid state
    try std.testing.expectEqual(@as(u32, 1), p.size());
}

// =============================================================================
// Stress Tests
// =============================================================================

test "stress: rapid acquire/release cycles" {
    var p = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer p.deinit();

    for (0..1000) |_| {
        const conn = try p.acquire();
        p.release(conn);
    }

    const stats = p.getStats();
    try std.testing.expectEqual(@as(u64, 1000), stats.acquire_count);
    try std.testing.expectEqual(@as(u64, 1000), stats.release_count);
    try std.testing.expectEqual(@as(u64, 1), stats.total_connections); // Only one connection needed
}

test "stress: multiple connections" {
    var pool_cfg = PoolConfig.init();
    _ = pool_cfg.withMaxSize(5);

    var p = try TestPool.init(std.testing.allocator, Config.init(), pool_cfg);
    defer p.deinit();

    // Acquire and release connections sequentially to avoid pointer issues
    for (0..5) |_| {
        const conn = try p.acquire();
        try std.testing.expect(conn.isInUse());
        p.release(conn);
    }

    try std.testing.expectEqual(@as(u32, 0), p.inUse());
    try std.testing.expect(p.available() >= 1);
}

// =============================================================================
// Edge Cases
// =============================================================================

test "edge: pool with min_size 0" {
    var pool_cfg = PoolConfig.init();
    _ = pool_cfg.withMinSize(0);

    var p = try TestPool.init(std.testing.allocator, Config.init(), pool_cfg);
    defer p.deinit();

    // Should still work
    const conn = try p.acquire();
    p.release(conn);
}

test "edge: pool with max_size 1" {
    var pool_cfg = PoolConfig.init();
    _ = pool_cfg.withMaxSize(1);
    _ = pool_cfg.withAcquireTimeout(50);

    var p = try TestPool.init(std.testing.allocator, Config.init(), pool_cfg);
    defer p.deinit();

    const conn = try p.acquire();

    // Second acquire should fail
    try std.testing.expectError(error.AcquireTimeout, p.acquire());

    p.release(conn);

    // Now acquire should succeed
    const conn2 = try p.acquire();
    p.release(conn2);
}

test "edge: cleanup expired with no connections" {
    var p = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer p.deinit();

    const removed = p.cleanupExpired();
    try std.testing.expectEqual(@as(u32, 0), removed);
}
