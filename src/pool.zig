// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Connection pool for the Geode Zig client library.
// Provides connection pooling with concurrency control.

const std = @import("std");
const Config = @import("config").Config;
const GeodeError = @import("error").GeodeError;

/// Connection pool configuration
pub const PoolConfig = struct {
    /// Minimum number of connections to maintain
    min_size: u32 = 1,
    /// Maximum number of connections allowed
    max_size: u32 = 10,
    /// Maximum time to wait for a connection (milliseconds)
    acquire_timeout_ms: u32 = 30000,
    /// Idle timeout before closing a connection (milliseconds)
    idle_timeout_ms: u32 = 300000,
    /// Health check interval (milliseconds)
    health_check_interval_ms: u32 = 60000,
    /// Validate connections on acquire
    validate_on_acquire: bool = true,

    pub fn init() PoolConfig {
        return .{};
    }

    pub fn withMinSize(self: *PoolConfig, size: u32) *PoolConfig {
        self.min_size = size;
        return self;
    }

    pub fn withMaxSize(self: *PoolConfig, size: u32) *PoolConfig {
        self.max_size = size;
        return self;
    }

    pub fn withAcquireTimeout(self: *PoolConfig, timeout_ms: u32) *PoolConfig {
        self.acquire_timeout_ms = timeout_ms;
        return self;
    }

    pub fn withIdleTimeout(self: *PoolConfig, timeout_ms: u32) *PoolConfig {
        self.idle_timeout_ms = timeout_ms;
        return self;
    }
};

/// Connection state
pub const ConnectionState = enum {
    idle,
    in_use,
    closed,
};

/// Pooled connection wrapper
pub const PooledConnection = struct {
    id: u64,
    state: ConnectionState,
    created_at: i64,
    last_used_at: i64,
    use_count: u64,

    /// Mark connection as in use
    pub fn acquire(self: *PooledConnection) void {
        self.state = .in_use;
        self.last_used_at = std.time.milliTimestamp();
        self.use_count += 1;
    }

    /// Mark connection as idle (returned to pool)
    pub fn release(self: *PooledConnection) void {
        self.state = .idle;
        self.last_used_at = std.time.milliTimestamp();
    }

    /// Check if connection is idle
    pub fn isIdle(self: PooledConnection) bool {
        return self.state == .idle;
    }

    /// Check if connection is in use
    pub fn isInUse(self: PooledConnection) bool {
        return self.state == .in_use;
    }

    /// Check if connection has exceeded idle timeout
    pub fn isIdleExpired(self: PooledConnection, timeout_ms: u32) bool {
        if (self.state != .idle) return false;
        const now = std.time.milliTimestamp();
        const idle_time = now - self.last_used_at;
        return idle_time > timeout_ms;
    }
};

/// Connection pool statistics
pub const PoolStats = struct {
    /// Total connections created
    total_connections: u64,
    /// Currently active connections
    active_connections: u32,
    /// Currently idle connections
    idle_connections: u32,
    /// Number of connection acquires
    acquire_count: u64,
    /// Number of connection releases
    release_count: u64,
    /// Number of timeouts waiting for connection
    timeout_count: u64,
    /// Number of connections closed due to errors
    error_close_count: u64,

    pub fn init() PoolStats {
        return .{
            .total_connections = 0,
            .active_connections = 0,
            .idle_connections = 0,
            .acquire_count = 0,
            .release_count = 0,
            .timeout_count = 0,
            .error_close_count = 0,
        };
    }
};

/// Connection pool for managing database connections.
pub fn Pool(comptime ConnectionType: type) type {
    return struct {
        const Self = @This();

        allocator: std.mem.Allocator,
        config: PoolConfig,
        client_config: Config,
        connections: std.ArrayListUnmanaged(PooledConnection),
        stats: PoolStats,
        mutex: std.Thread.Mutex,
        next_id: u64,
        closed: bool,

        // Phantom field to track connection type
        _connection_type: ?ConnectionType = null,

        /// Initialize a new connection pool
        pub fn init(allocator: std.mem.Allocator, client_config: Config, pool_config: PoolConfig) Self {
            return .{
                .allocator = allocator,
                .config = pool_config,
                .client_config = client_config,
                .connections = .{},
                .stats = PoolStats.init(),
                .mutex = .{},
                .next_id = 0,
                .closed = false,
            };
        }

        /// Close the pool and all connections
        pub fn deinit(self: *Self) void {
            self.mutex.lock();
            defer self.mutex.unlock();

            self.closed = true;
            self.connections.deinit(self.allocator);
        }

        /// Get the current pool size
        pub fn size(self: *Self) u32 {
            self.mutex.lock();
            defer self.mutex.unlock();
            return @intCast(self.connections.items.len);
        }

        /// Get the number of available (idle) connections
        pub fn available(self: *Self) u32 {
            self.mutex.lock();
            defer self.mutex.unlock();

            var count: u32 = 0;
            for (self.connections.items) |conn| {
                if (conn.isIdle()) {
                    count += 1;
                }
            }
            return count;
        }

        /// Get the number of in-use connections
        pub fn inUse(self: *Self) u32 {
            self.mutex.lock();
            defer self.mutex.unlock();

            var count: u32 = 0;
            for (self.connections.items) |conn| {
                if (conn.isInUse()) {
                    count += 1;
                }
            }
            return count;
        }

        /// Acquire a connection from the pool
        pub fn acquire(self: *Self) !*PooledConnection {
            const start = std.time.milliTimestamp();
            const deadline = start + self.config.acquire_timeout_ms;

            while (std.time.milliTimestamp() < deadline) {
                self.mutex.lock();

                if (self.closed) {
                    self.mutex.unlock();
                    return error.PoolClosed;
                }

                // Try to find an idle connection
                for (self.connections.items) |*conn| {
                    if (conn.isIdle()) {
                        conn.acquire();
                        self.stats.acquire_count += 1;
                        self.stats.active_connections += 1;
                        self.stats.idle_connections -= 1;
                        self.mutex.unlock();
                        return conn;
                    }
                }

                // Try to create a new connection if under max
                if (self.connections.items.len < self.config.max_size) {
                    const new_conn = try self.createConnection();
                    new_conn.acquire();
                    self.stats.acquire_count += 1;
                    self.stats.active_connections += 1;
                    self.mutex.unlock();
                    return new_conn;
                }

                self.mutex.unlock();

                // Wait and retry
                std.Thread.sleep(10 * std.time.ns_per_ms);
            }

            self.mutex.lock();
            self.stats.timeout_count += 1;
            self.mutex.unlock();

            return error.AcquireTimeout;
        }

        /// Release a connection back to the pool
        pub fn release(self: *Self, conn: *PooledConnection) void {
            self.mutex.lock();
            defer self.mutex.unlock();

            if (!self.closed and conn.state == .in_use) {
                conn.release();
                self.stats.release_count += 1;
                self.stats.active_connections -= 1;
                self.stats.idle_connections += 1;
            }
        }

        /// Remove and close a connection (e.g., on error)
        pub fn remove(self: *Self, conn: *PooledConnection) void {
            self.mutex.lock();
            defer self.mutex.unlock();

            const was_in_use = conn.isInUse();
            const was_idle = conn.isIdle();
            conn.state = .closed;
            self.stats.error_close_count += 1;
            if (was_in_use) {
                self.stats.active_connections -= 1;
            } else if (was_idle and self.stats.idle_connections > 0) {
                self.stats.idle_connections -= 1;
            }
        }

        /// Get pool statistics
        pub fn getStats(self: *Self) PoolStats {
            self.mutex.lock();
            defer self.mutex.unlock();
            return self.stats;
        }

        /// Check if pool is closed
        pub fn isClosed(self: *Self) bool {
            self.mutex.lock();
            defer self.mutex.unlock();
            return self.closed;
        }

        /// Clean up idle expired connections
        pub fn cleanupExpired(self: *Self) u32 {
            self.mutex.lock();
            defer self.mutex.unlock();

            var removed: u32 = 0;
            var i: usize = 0;
            while (i < self.connections.items.len) {
                if (self.connections.items[i].isIdleExpired(self.config.idle_timeout_ms)) {
                    // Keep minimum connections
                    if (self.connections.items.len > self.config.min_size) {
                        _ = self.connections.orderedRemove(i);
                        self.stats.idle_connections -= 1;
                        removed += 1;
                        continue;
                    }
                }
                i += 1;
            }
            return removed;
        }

        // Internal: create a new connection entry
        // Note: stats.idle_connections is NOT incremented here because the caller
        // (acquire) will immediately mark it as in_use. Stats are managed by the caller.
        fn createConnection(self: *Self) !*PooledConnection {
            const now = std.time.milliTimestamp();
            const conn = PooledConnection{
                .id = self.next_id,
                .state = .idle,
                .created_at = now,
                .last_used_at = now,
                .use_count = 0,
            };
            self.next_id += 1;
            self.stats.total_connections += 1;

            try self.connections.append(self.allocator, conn);
            return &self.connections.items[self.connections.items.len - 1];
        }
    };
}

// Dummy connection type for testing
const TestConnection = struct {
    id: u64,
};

// =============================================================================
// Unit Tests
// =============================================================================

test "PoolConfig.init creates default config" {
    const cfg = PoolConfig.init();
    try std.testing.expectEqual(@as(u32, 1), cfg.min_size);
    try std.testing.expectEqual(@as(u32, 10), cfg.max_size);
    try std.testing.expectEqual(@as(u32, 30000), cfg.acquire_timeout_ms);
}

test "PoolConfig builder methods work" {
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

test "PooledConnection.acquire marks in use" {
    var conn = PooledConnection{
        .id = 1,
        .state = .idle,
        .created_at = 0,
        .last_used_at = 0,
        .use_count = 0,
    };

    conn.acquire();
    try std.testing.expectEqual(ConnectionState.in_use, conn.state);
    try std.testing.expectEqual(@as(u64, 1), conn.use_count);
}

test "PooledConnection.release marks idle" {
    var conn = PooledConnection{
        .id = 1,
        .state = .in_use,
        .created_at = 0,
        .last_used_at = 0,
        .use_count = 1,
    };

    conn.release();
    try std.testing.expectEqual(ConnectionState.idle, conn.state);
}

test "PooledConnection.isIdle and isInUse work correctly" {
    var conn = PooledConnection{
        .id = 1,
        .state = .idle,
        .created_at = 0,
        .last_used_at = 0,
        .use_count = 0,
    };

    try std.testing.expect(conn.isIdle());
    try std.testing.expect(!conn.isInUse());

    conn.state = .in_use;
    try std.testing.expect(!conn.isIdle());
    try std.testing.expect(conn.isInUse());
}

test "PoolStats.init creates zeroed stats" {
    const stats = PoolStats.init();
    try std.testing.expectEqual(@as(u64, 0), stats.total_connections);
    try std.testing.expectEqual(@as(u32, 0), stats.active_connections);
    try std.testing.expectEqual(@as(u32, 0), stats.idle_connections);
}

test "Pool.init creates empty pool" {
    const TestPool = Pool(TestConnection);
    var pool = TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    try std.testing.expectEqual(@as(u32, 0), pool.size());
    try std.testing.expectEqual(@as(u32, 0), pool.available());
    try std.testing.expectEqual(@as(u32, 0), pool.inUse());
}

test "Pool.acquire creates new connection" {
    const TestPool = Pool(TestConnection);
    var pool = TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    const conn = try pool.acquire();
    try std.testing.expectEqual(@as(u32, 1), pool.size());
    try std.testing.expectEqual(@as(u32, 1), pool.inUse());
    try std.testing.expectEqual(@as(u32, 0), pool.available());

    pool.release(conn);
    try std.testing.expectEqual(@as(u32, 0), pool.inUse());
    try std.testing.expectEqual(@as(u32, 1), pool.available());
}

test "Pool.acquire reuses idle connection" {
    const TestPool = Pool(TestConnection);
    var pool = TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    const conn1 = try pool.acquire();
    const id1 = conn1.id;
    pool.release(conn1);

    const conn2 = try pool.acquire();
    try std.testing.expectEqual(id1, conn2.id);
    pool.release(conn2);
}

test "Pool.acquire respects max_size" {
    const TestPool = Pool(TestConnection);
    var pool_cfg = PoolConfig.init();
    _ = pool_cfg.withMaxSize(2);
    _ = pool_cfg.withAcquireTimeout(100); // Short timeout for test

    var pool = TestPool.init(std.testing.allocator, Config.init(), pool_cfg);
    defer pool.deinit();

    const conn1 = try pool.acquire();
    const conn2 = try pool.acquire();
    try std.testing.expectEqual(@as(u32, 2), pool.size());
    try std.testing.expectEqual(@as(u32, 2), pool.inUse());

    // Third acquire should timeout since pool is full
    try std.testing.expectError(error.AcquireTimeout, pool.acquire());

    pool.release(conn1);
    pool.release(conn2);
}

test "Pool.remove closes connection" {
    const TestPool = Pool(TestConnection);
    var pool = TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    const conn = try pool.acquire();
    pool.remove(conn);

    const stats = pool.getStats();
    try std.testing.expectEqual(@as(u64, 1), stats.error_close_count);
}

test "Pool.getStats returns correct stats" {
    const TestPool = Pool(TestConnection);
    var pool = TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    const conn = try pool.acquire();
    var stats = pool.getStats();
    try std.testing.expectEqual(@as(u64, 1), stats.total_connections);
    try std.testing.expectEqual(@as(u64, 1), stats.acquire_count);
    try std.testing.expectEqual(@as(u32, 1), stats.active_connections);

    pool.release(conn);
    stats = pool.getStats();
    try std.testing.expectEqual(@as(u64, 1), stats.release_count);
    try std.testing.expectEqual(@as(u32, 0), stats.active_connections);
    try std.testing.expectEqual(@as(u32, 1), stats.idle_connections);
}

test "Pool.isClosed returns correct state" {
    const TestPool = Pool(TestConnection);
    var pool = TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());

    try std.testing.expect(!pool.isClosed());
    pool.deinit();
    try std.testing.expect(pool.isClosed());
}

test "Pool.acquire after close returns error" {
    const TestPool = Pool(TestConnection);
    var pool = TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    pool.deinit();

    try std.testing.expectError(error.PoolClosed, pool.acquire());
}
