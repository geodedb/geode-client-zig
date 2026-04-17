const std = @import("std");
const tp = @import("thread_pool");

test "thread_pool module is importable" {
    const cfg: tp.Config = .{ .max_threads = 2 };
    _ = cfg;
    _ = tp.ThreadPool;
    _ = tp.WaitGroup;
    _ = tp.BatchTask;
    _ = tp.sync.Mutex;
    _ = tp.sync.Condition;
}
