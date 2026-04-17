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
};

test "Executor.init with no blocking lane uses work_stealing" {
    var runner = try Executor.init(std.testing.allocator, .{ .max_threads = 2 });
    defer runner.deinit();
    const stats = runner.pool.statsSnapshot();
    _ = stats;
}

test "Executor.init with blocking lane uses lane_extension" {
    var runner = try Executor.init(std.testing.allocator, .{
        .max_threads = 4,
        .blocking_workers = 2,
    });
    defer runner.deinit();
    _ = runner.pool.statsSnapshot();
}
