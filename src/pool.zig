// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Connection pool for the Geode Zig client library.
// Provides connection pooling with concurrency control.

const std = @import("std");
const Config = @import("config").Config;
const GeodeError = @import("error").GeodeError;
const tp = @import("thread_pool");

// Pool deadlines and idle expiry use the platform's monotonic clock.
fn nowNs() i128 {
    return std.Io.Clock.awake.now(std.Io.Threaded.global_single_threaded.io()).toNanoseconds();
}

fn nowMs() i64 {
    return @intCast(@divFloor(nowNs(), std.time.ns_per_ms));
}

/// Thread pool executor for async connection pool operations.
/// Wraps `thread_pool.ThreadPool` directly — no intermediate wrapper.
/// Live on construction; teardown via `deinit`.
pub const PoolExecutor = struct {
    pool: tp.ThreadPool,
    allocator: std.mem.Allocator,

    pub const ExecutorConfig = struct {
        /// Number of worker threads (0 = auto-detect CPU count).
        num_threads: usize = 0,
        /// Queue capacity (rounded up to power of two).
        queue_capacity: usize = 1024,
    };

    /// Create and start the executor. Unlike the previous two-stage
    /// init+start, the pool is live immediately.
    pub fn init(allocator: std.mem.Allocator, config: ExecutorConfig) !PoolExecutor {
        return .{
            .pool = try tp.ThreadPool.init(allocator, .{
                .max_threads = config.num_threads,
                .queue_capacity = config.queue_capacity,
            }),
            .allocator = allocator,
        };
    }

    /// Stop the executor and join all workers.
    pub fn deinit(self: *PoolExecutor) void {
        self.pool.deinit();
    }

    /// Submit a task — non-blocking. Returns the handle on success, or
    /// an error if the queue is full or the pool is shutting down.
    pub fn submit(
        self: *PoolExecutor,
        task_fn: tp.TaskFn,
        ctx: *anyopaque,
    ) !tp.TaskHandle {
        return self.pool.submit(task_fn, ctx, .{
            .backpressure = .return_error,
            .waitable = true,
        });
    }

    /// Statistics snapshot.
    pub fn getStats(self: *PoolExecutor) tp.Stats {
        return self.pool.statsSnapshot();
    }
};

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
    /// Optional executor configuration for async pool operations
    executor: ?PoolExecutor.ExecutorConfig = null,

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

    pub fn withExecutor(self: *PoolConfig, config: PoolExecutor.ExecutorConfig) *PoolConfig {
        self.executor = config;
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
        self.acquireAt(nowMs());
    }

    /// Mark connection as in use at `now_ms` (monotonic milliseconds).
    pub fn acquireAt(self: *PooledConnection, now_ms: i64) void {
        self.state = .in_use;
        self.last_used_at = now_ms;
        self.use_count += 1;
    }

    /// Mark connection as idle (returned to pool)
    pub fn release(self: *PooledConnection) void {
        self.releaseAt(nowMs());
    }

    /// Mark connection as idle at `now_ms` (monotonic milliseconds).
    pub fn releaseAt(self: *PooledConnection, now_ms: i64) void {
        self.state = .idle;
        self.last_used_at = now_ms;
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
        return self.isIdleExpiredAt(timeout_ms, nowMs());
    }

    /// Check if connection has been idle for more than `timeout_ms` at
    /// `now_ms` (monotonic milliseconds).
    pub fn isIdleExpiredAt(self: PooledConnection, timeout_ms: u32, now_ms: i64) bool {
        if (self.state != .idle) return false;
        const idle_time = now_ms - self.last_used_at;
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
        mutex: tp.sync.Mutex,
        condition: tp.sync.Condition,
        next_id: u64,
        closed: bool,
        executor: ?PoolExecutor,
        sweeper_running: std.atomic.Value(bool),
        /// Monotonic clock in milliseconds for idle tracking and expiry.
        /// Tests replace it to drive idle expiry without sleeping.
        now_ms: *const fn () i64 = nowMs,
        /// Sweeps the idle sweeper has completed (see `startIdleSweeper`).
        sweeps: std.atomic.Value(u64) = .init(0),

        // Phantom field to track connection type
        _connection_type: ?ConnectionType = null,

        /// Initialize a new connection pool.
        /// If the pool config includes an executor configuration, a
        /// `PoolExecutor` is created and started immediately. Pass `null`
        /// (the default) to skip executor creation.
        pub fn init(allocator: std.mem.Allocator, client_config: Config, pool_config: PoolConfig) !Self {
            const executor: ?PoolExecutor = if (pool_config.executor) |exec_cfg|
                try PoolExecutor.init(allocator, exec_cfg)
            else
                null;

            return .{
                .allocator = allocator,
                .config = pool_config,
                .client_config = client_config,
                .connections = .empty,
                .stats = PoolStats.init(),
                .mutex = .{},
                .condition = .{},
                .next_id = 0,
                .closed = false,
                .executor = executor,
                .sweeper_running = std.atomic.Value(bool).init(false),
            };
        }

        /// Construct a pool directly from a client Config using the default
        /// PoolConfig. Mirrors the Go driver's NewPoolFromConfig.
        pub fn initFromConfig(allocator: std.mem.Allocator, client_config: Config) !Self {
            return Self.init(allocator, client_config, PoolConfig.init());
        }

        /// Get the pool's executor, if configured.
        pub fn getExecutor(self: *Self) ?*PoolExecutor {
            if (self.executor) |*exec| {
                return exec;
            }
            return null;
        }

        /// Close the pool and all connections.
        /// Signals the sweeper loop to stop, then tears down the executor
        /// (which joins the sweeper worker). Safe to call once.
        pub fn deinit(self: *Self) void {
            self.stopIdleSweeper();
            if (self.executor) |*exec| exec.deinit();

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

        /// Acquire a connection from the pool.
        /// Blocks until an idle connection is available, a new connection can
        /// be created, or the acquire timeout expires. Uses a condition
        /// variable instead of sleep-based polling so that a released
        /// connection wakes up a waiting acquirer immediately.
        pub fn acquire(self: *Self) !*PooledConnection {
            const timeout_ns: u64 = @as(u64, self.config.acquire_timeout_ms) * std.time.ns_per_ms;

            self.mutex.lock();
            defer self.mutex.unlock();

            while (true) {
                if (self.closed) {
                    return error.PoolClosed;
                }

                // Try to find an idle connection
                for (self.connections.items) |*conn| {
                    if (conn.isIdle()) {
                        conn.acquireAt(self.now_ms());
                        self.stats.acquire_count += 1;
                        self.stats.active_connections += 1;
                        self.stats.idle_connections -= 1;
                        return conn;
                    }
                }

                // Try to create a new connection if under max
                if (self.connections.items.len < self.config.max_size) {
                    const new_conn = try self.createConnection();
                    new_conn.acquireAt(self.now_ms());
                    self.stats.acquire_count += 1;
                    self.stats.active_connections += 1;
                    return new_conn;
                }

                // Wait for a connection to be released or timeout
                self.condition.timedWait(&self.mutex, timeout_ns) catch {
                    self.stats.timeout_count += 1;
                    return error.AcquireTimeout;
                };
            }
        }

        /// Release a connection back to the pool.
        /// Signals one waiting acquirer so it can immediately reuse the
        /// connection without polling.
        pub fn release(self: *Self, conn: *PooledConnection) void {
            self.mutex.lock();
            defer self.mutex.unlock();

            if (!self.closed and conn.state == .in_use) {
                conn.releaseAt(self.now_ms());
                self.stats.release_count += 1;
                self.stats.active_connections -= 1;
                self.stats.idle_connections += 1;
                self.condition.signal();
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

            const now = self.now_ms();
            var removed: u32 = 0;
            var i: usize = 0;
            while (i < self.connections.items.len) {
                if (self.connections.items[i].isIdleExpiredAt(self.config.idle_timeout_ms, now)) {
                    // Keep minimum connections
                    if (self.connections.items.len > self.config.min_size) {
                        _ = self.connections.swapRemove(i);
                        self.stats.idle_connections -= 1;
                        removed += 1;
                        continue;
                    }
                }
                i += 1;
            }
            return removed;
        }

        /// Submit cleanupExpired to the pool's executor.
        /// Returns the task handle so callers can `exec.pool.wait(h)` or
        /// fire-and-forget. Errors with `NoExecutor` if no executor was
        /// configured.
        pub fn cleanupExpiredAsync(self: *Self) !tp.TaskHandle {
            if (self.executor == null) return error.NoExecutor;
            const sweep = struct {
                fn run(raw: *anyopaque, _: *tp.TaskContext) void {
                    const pool: *Self = @ptrCast(@alignCast(raw));
                    _ = pool.cleanupExpired();
                }
            }.run;
            return self.executor.?.submit(sweep, self);
        }

        /// Start a background loop on the executor that runs
        /// `cleanupExpired` every `health_check_interval_ms`, counting each
        /// completed pass in `sweeps`. Idempotent (a second call is a
        /// no-op). Requires an executor.
        pub fn startIdleSweeper(self: *Self) !void {
            if (self.executor == null) return error.NoExecutor;
            if (self.sweeper_running.swap(true, .acq_rel)) return;

            const loop = struct {
                const tick_ns: u64 = 100 * std.time.ns_per_ms;

                fn run(raw: *anyopaque, _: *tp.TaskContext) void {
                    const pool: *Self = @ptrCast(@alignCast(raw));
                    const interval_ns = @as(u64, pool.config.health_check_interval_ms) *
                        std.time.ns_per_ms;
                    while (pool.sweeper_running.load(.acquire)) {
                        _ = pool.cleanupExpired();
                        _ = pool.sweeps.fetchAdd(1, .acq_rel);
                        // Sleep in ≤100ms chunks so stopIdleSweeper
                        // observes the flag promptly — bounds shutdown
                        // latency to ~100ms regardless of interval.
                        var remaining = interval_ns;
                        while (remaining > 0 and pool.sweeper_running.load(.acquire)) {
                            const step = @min(remaining, tick_ns);
                            tp.clock.sleep(step);
                            remaining -= step;
                        }
                    }
                }
            }.run;

            _ = try self.executor.?.submit(loop, self);
        }

        /// Signal the background sweeper to stop. Returns immediately;
        /// the sweeper exits on its next wake (bounded by
        /// `health_check_interval_ms`). `deinit` calls this before
        /// tearing down the executor.
        pub fn stopIdleSweeper(self: *Self) void {
            self.sweeper_running.store(false, .release);
        }

        // Internal: create a new connection entry
        // Note: stats.idle_connections is NOT incremented here because the caller
        // (acquire) will immediately mark it as in_use. Stats are managed by the caller.
        fn createConnection(self: *Self) !*PooledConnection {
            const now = self.now_ms();
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
    var pool = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    try std.testing.expectEqual(@as(u32, 0), pool.size());
    try std.testing.expectEqual(@as(u32, 0), pool.available());
    try std.testing.expectEqual(@as(u32, 0), pool.inUse());
}

test "Pool.acquire creates new connection" {
    const TestPool = Pool(TestConnection);
    var pool = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
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
    var pool = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
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

    var pool = try TestPool.init(std.testing.allocator, Config.init(), pool_cfg);
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
    var pool = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    const conn = try pool.acquire();
    pool.remove(conn);

    const stats = pool.getStats();
    try std.testing.expectEqual(@as(u64, 1), stats.error_close_count);
}

test "Pool.getStats returns correct stats" {
    const TestPool = Pool(TestConnection);
    var pool = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
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
    var pool = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());

    try std.testing.expect(!pool.isClosed());
    pool.deinit();
    try std.testing.expect(pool.isClosed());
}

test "Pool.acquire after close returns error" {
    const TestPool = Pool(TestConnection);
    var pool = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    pool.deinit();

    try std.testing.expectError(error.PoolClosed, pool.acquire());
}

// =============================================================================
// PoolExecutor Unit Tests
// =============================================================================

test "PoolExecutor.init creates running executor" {
    var exec = try PoolExecutor.init(std.testing.allocator, .{ .num_threads = 1 });
    defer exec.deinit();
    const stats = exec.getStats();
    _ = stats;
}

test "PoolExecutor.submit executes work" {
    var exec = try PoolExecutor.init(std.testing.allocator, .{ .num_threads = 2 });
    defer exec.deinit();

    var counter = std.atomic.Value(u32).init(0);
    const Context = struct {
        counter: *std.atomic.Value(u32),
        fn run(raw: *anyopaque, _: *tp.TaskContext) void {
            const self: *@This() = @ptrCast(@alignCast(raw));
            _ = self.counter.fetchAdd(1, .release);
        }
    };
    var ctx = Context{ .counter = &counter };

    var wg = exec.pool.waitGroup();
    _ = try exec.pool.submit(Context.run, &ctx, .{
        .backpressure = .return_error,
        .wait_group = &wg,
    });
    wg.wait();

    try std.testing.expectEqual(@as(u32, 1), counter.load(.acquire));
}

test "PoolConfig.withExecutor sets executor config" {
    var cfg = PoolConfig.init();
    _ = cfg.withExecutor(.{ .num_threads = 4, .queue_capacity = 256 });

    try std.testing.expect(cfg.executor != null);
    try std.testing.expectEqual(@as(usize, 4), cfg.executor.?.num_threads);
    try std.testing.expectEqual(@as(usize, 256), cfg.executor.?.queue_capacity);
}

test "Pool with executor config creates running executor" {
    const TestPool = Pool(TestConnection);
    var pool_cfg = PoolConfig.init();
    _ = pool_cfg.withExecutor(.{ .num_threads = 2 });

    var pool = try TestPool.init(std.testing.allocator, Config.init(), pool_cfg);
    defer pool.deinit();

    try std.testing.expect(pool.getExecutor() != null);
}

test "Pool without executor config has no executor" {
    const TestPool = Pool(TestConnection);
    var pool = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    try std.testing.expect(pool.getExecutor() == null);
}

// A test clock: idle expiry is driven by advancing it, never by sleeping,
// so the outcome does not depend on how the runner schedules threads.
var test_now_ms = std.atomic.Value(i64).init(1_000_000);

fn testNowMs() i64 {
    return test_now_ms.load(.acquire);
}

fn advanceTestClock(ms: i64) void {
    _ = test_now_ms.fetchAdd(ms, .acq_rel);
}

/// Wait until the sweeper has completed `target` sweeps. The bound only
/// turns a stalled sweeper into a failure instead of a hang.
fn waitForSweeps(pool: anytype, target: u64) !void {
    const deadline = nowNs() + 60 * std.time.ns_per_s;
    while (pool.sweeps.load(.acquire) < target) {
        if (nowNs() > deadline) return error.SweeperStalled;
        tp.clock.sleep(std.time.ns_per_ms);
    }
}

/// Wait for two more completed sweeps: the second one started after this
/// call, so it read the clock and the pool as they are now.
fn waitForFreshSweep(pool: anytype) !void {
    try waitForSweeps(pool, pool.sweeps.load(.acquire) + 2);
}

test "Pool.cleanupExpiredAsync runs on the executor" {
    const TestPool = Pool(TestConnection);
    var cfg = PoolConfig.init();
    _ = cfg.withExecutor(.{ .num_threads = 2 });
    cfg.idle_timeout_ms = 1; // immediate expiry
    cfg.min_size = 0; // allow reaping below 1

    var pool = try TestPool.init(std.testing.allocator, Config.init(), cfg);
    defer pool.deinit();
    pool.now_ms = testNowMs;

    // Seed an idle connection that will expire.
    const c = try pool.acquire();
    pool.release(c);
    advanceTestClock(cfg.idle_timeout_ms + 1);

    const handle = try pool.cleanupExpiredAsync();
    try pool.executor.?.pool.wait(handle);

    // The sweeper should have reaped the expired connection.
    try std.testing.expectEqual(@as(u32, 0), pool.size());
}

test "Pool.cleanupExpiredAsync returns NoExecutor without executor" {
    const TestPool = Pool(TestConnection);
    var pool = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    try std.testing.expectError(error.NoExecutor, pool.cleanupExpiredAsync());
}

test "Pool.startIdleSweeper ticks and reaps idle connections" {
    const TestPool = Pool(TestConnection);
    var cfg = PoolConfig.init();
    _ = cfg.withExecutor(.{ .num_threads = 2 });
    cfg.idle_timeout_ms = 5;
    cfg.health_check_interval_ms = 1;
    cfg.min_size = 0;

    var pool = try TestPool.init(std.testing.allocator, Config.init(), cfg);
    defer pool.deinit();
    pool.now_ms = testNowMs;

    // One idle connection and one in use, both last used now.
    const idle = try pool.acquire();
    const busy = try pool.acquire();
    pool.release(idle);
    try std.testing.expectEqual(@as(u32, 1), pool.available());
    try std.testing.expectEqual(@as(u32, 1), pool.inUse());

    try pool.startIdleSweeper();

    // The sweeper ticks, and keeps an idle connection that is not past the
    // threshold, including exactly at it.
    try waitForFreshSweep(&pool);
    try std.testing.expectEqual(@as(u32, 2), pool.size());
    advanceTestClock(cfg.idle_timeout_ms);
    try waitForFreshSweep(&pool);
    try std.testing.expectEqual(@as(u32, 2), pool.size());

    // Past the threshold the idle connection is reaped; the one in use,
    // last used just as long ago, is not.
    advanceTestClock(1);
    try waitForFreshSweep(&pool);
    try std.testing.expectEqual(@as(u32, 1), pool.size());
    try std.testing.expectEqual(@as(u32, 1), pool.inUse());
    try std.testing.expectEqual(@as(u32, 0), pool.available());

    pool.release(busy);
}

test "Pool.startIdleSweeper is idempotent" {
    const TestPool = Pool(TestConnection);
    var cfg = PoolConfig.init();
    _ = cfg.withExecutor(.{ .num_threads = 2 });

    var pool = try TestPool.init(std.testing.allocator, Config.init(), cfg);
    defer pool.deinit();

    try pool.startIdleSweeper();
    try pool.startIdleSweeper(); // no-op
}

test "Pool.startIdleSweeper without executor errors" {
    const TestPool = Pool(TestConnection);
    var pool = try TestPool.init(std.testing.allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    try std.testing.expectError(error.NoExecutor, pool.startIdleSweeper());
}

test "Pool.initFromConfig builds a pool from a Config" {
    const cfg = Config.initWithHost("127.0.0.1", 3141);
    var pool = try Pool(u32).initFromConfig(std.testing.allocator, cfg);
    defer pool.deinit();

    try std.testing.expectEqual(@as(u32, 0), pool.size());
    try std.testing.expect(!pool.isClosed());
    try std.testing.expectEqual(@as(u32, 10), pool.config.max_size);
}
