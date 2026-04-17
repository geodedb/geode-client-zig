// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Shared thread-pool runner for the Geode Zig client library.
//
// This module owns the single ThreadPool used by the client. It is configured
// with the `lane_extension` scheduler so blocking network syscalls (QUIC/gRPC
// reads, connect, health checks) run on a dedicated blocking lane without
// starving CPU workers.
//
// Design contract: nothing else in the library constructs a thread_pool.ThreadPool
// directly. Pool.cleanupExpired, Batch.runParallel, and GeodeClient.queryAsync
// all consume an `*Executor` by parameter.

const std = @import("std");
const tp = @import("thread_pool");

pub const Config = struct {
    /// Total worker threads (0 = auto-detect from CPU count).
    max_threads: usize = 0,
    /// Workers carved out of `max_threads` for the blocking lane. Must be
    /// strictly less than `max_threads`. Zero means no blocking lane
    /// (runner falls back to `work_stealing`).
    ///
    /// FOOTGUN: when `> 0`, you must also pass a non-zero `max_threads`
    /// explicitly — relying on CPU auto-detect can produce
    /// `blocking_workers >= max_threads` on small machines (1–2 CPUs)
    /// and will fail `thread_pool.Config.validate()` with
    /// `error.InvalidBlockingWorkers`.
    blocking_workers: u32 = 0,
    /// Default-lane queue capacity (rounded up to power of two by thread_pool).
    queue_capacity: usize = 1024,
    /// Blocking-lane queue capacity. Zero inherits `queue_capacity`.
    blocking_queue_capacity: usize = 0,
};

pub const Executor = struct {
    allocator: std.mem.Allocator,
    pool: tp.ThreadPool,

    pub fn init(allocator: std.mem.Allocator, cfg: Config) !Executor {
        const tp_cfg: tp.Config = if (cfg.blocking_workers > 0) .{
            .max_threads = cfg.max_threads,
            .queue_capacity = cfg.queue_capacity,
            .scheduler_variant = .lane_extension,
            .allow_blocking_lane = true,
            .blocking_workers = cfg.blocking_workers,
            .blocking_queue_capacity = cfg.blocking_queue_capacity,
        } else .{
            .max_threads = cfg.max_threads,
            .queue_capacity = cfg.queue_capacity,
            .scheduler_variant = .work_stealing,
        };
        return .{
            .allocator = allocator,
            .pool = try tp.ThreadPool.init(allocator, tp_cfg),
        };
    }

    pub fn deinit(self: *Executor) void {
        self.pool.deinit();
    }

    pub const Lane = enum { default, blocking };

    /// Submit a task. Returns a handle that can be `wait()`ed on. The
    /// caller owns the context pointer; it must stay alive until the task
    /// completes.
    pub fn submit(
        self: *Executor,
        task_fn: tp.TaskFn,
        ctx: *anyopaque,
        lane: Lane,
    ) !tp.TaskHandle {
        return self.pool.submit(task_fn, ctx, .{
            .waitable = true,
            .lane = switch (lane) {
                .default => .default,
                .blocking => .blocking,
            },
            .backpressure = .return_error,
        });
    }

    /// Blocking submit — waits until queue has space or the timeout expires.
    pub fn submitBlocking(
        self: *Executor,
        task_fn: tp.TaskFn,
        ctx: *anyopaque,
        lane: Lane,
        timeout_ns: ?u64,
    ) !tp.TaskHandle {
        return self.pool.submit(task_fn, ctx, .{
            .waitable = true,
            .lane = switch (lane) {
                .default => .default,
                .blocking => .blocking,
            },
            .backpressure = if (timeout_ns != null) .block_with_timeout else .block,
            .timeout_ns = timeout_ns,
        });
    }

    /// Wait for a specific task to complete.
    pub fn wait(self: *Executor, handle: tp.TaskHandle) !void {
        return self.pool.wait(handle);
    }
};

test "Executor.init with no blocking lane uses work_stealing" {
    var runner = try Executor.init(std.testing.allocator, .{ .max_threads = 2 });
    defer runner.deinit();
    const stats = runner.pool.statsSnapshot();
    // Fresh pool: nothing submitted yet.
    try std.testing.expectEqual(@as(u64, 0), stats.submitted);
}

test "Executor.init with blocking lane uses lane_extension" {
    var runner = try Executor.init(std.testing.allocator, .{
        .max_threads = 4,
        .blocking_workers = 2,
    });
    defer runner.deinit();
    const stats = runner.pool.statsSnapshot();
    // Fresh pool: no tasks active or completed.
    try std.testing.expectEqual(@as(u64, 0), stats.active_tasks);
    try std.testing.expectEqual(@as(u64, 0), stats.completed);
}

test "Executor.init rejects blocking_workers >= max_threads" {
    try std.testing.expectError(
        error.InvalidBlockingWorkers,
        Executor.init(std.testing.allocator, .{
            .max_threads = 2,
            .blocking_workers = 2,
        }),
    );
}

test "Executor.submit runs a default-lane task" {
    var runner = try Executor.init(std.testing.allocator, .{ .max_threads = 2 });
    defer runner.deinit();

    var counter = std.atomic.Value(u32).init(0);
    const Ctx = struct {
        counter: *std.atomic.Value(u32),
        fn run(raw: *anyopaque, _: *tp.TaskContext) void {
            const self: *@This() = @ptrCast(@alignCast(raw));
            _ = self.counter.fetchAdd(1, .release);
        }
    };
    var ctx = Ctx{ .counter = &counter };

    const handle = try runner.submit(Ctx.run, &ctx, .default);
    try runner.wait(handle);

    try std.testing.expectEqual(@as(u32, 1), counter.load(.acquire));
}

test "Executor.submit rejects blocking lane when not configured" {
    var runner = try Executor.init(std.testing.allocator, .{ .max_threads = 2 });
    defer runner.deinit();

    const Ctx = struct {
        fn run(_: *anyopaque, _: *tp.TaskContext) void {}
    };
    var dummy: u8 = 0;
    try std.testing.expectError(
        error.BlockingLaneDisabled,
        runner.submit(Ctx.run, &dummy, .blocking),
    );
}

test "Executor.submit routes to blocking lane when configured" {
    var runner = try Executor.init(std.testing.allocator, .{
        .max_threads = 4,
        .blocking_workers = 2,
    });
    defer runner.deinit();

    var completed = std.atomic.Value(bool).init(false);
    const Ctx = struct {
        completed: *std.atomic.Value(bool),
        fn run(raw: *anyopaque, _: *tp.TaskContext) void {
            const self: *@This() = @ptrCast(@alignCast(raw));
            self.completed.store(true, .release);
        }
    };
    var ctx = Ctx{ .completed = &completed };

    const handle = try runner.submit(Ctx.run, &ctx, .blocking);
    try runner.wait(handle);

    try std.testing.expect(completed.load(.acquire));
}
