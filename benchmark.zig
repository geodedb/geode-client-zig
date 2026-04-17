// Native Zig client benchmark for Geode
//
// Usage: zig build benchmark -- --host localhost --port 3142 --workers 10 --queries 1000

const std = @import("std");
const geode = @import("geode_client");
const tp = @import("thread_pool");
const runner_mod = @import("executor");

// std.time.{nanoTimestamp, timestamp} were removed in zig 0.16.0.
fn nowNs() i128 {
    var ts: std.os.linux.timespec = undefined;
    const rc = std.os.linux.clock_gettime(.MONOTONIC, &ts);
    if (rc != 0) return 0;
    return @as(i128, ts.sec) * std.time.ns_per_s + @as(i128, ts.nsec);
}

fn nowSeconds() i64 {
    var ts: std.os.linux.timespec = undefined;
    const rc = std.os.linux.clock_gettime(.REALTIME, &ts);
    if (rc != 0) return 0;
    return @intCast(ts.sec);
}

const BenchmarkResult = struct {
    timestamp: []const u8,
    duration_seconds: f64,
    total_queries: i64,
    successful_queries: i64,
    failed_queries: i64,
    throughput_qps: f64,
    latency_p50_ms: f64,
    latency_p95_ms: f64,
    latency_p99_ms: f64,
    latency_avg_ms: f64,
    workers: usize,
    queries_per_worker: usize,
    status: []const u8,
};

const WorkerResult = struct {
    latencies: std.ArrayList(f64),
    successful: i64,
    failed: i64,
};

fn runWorker(
    allocator: std.mem.Allocator,
    host: []const u8,
    port: u16,
    queries: usize,
    insecure: bool,
    username: []const u8,
    password: []const u8,
) WorkerResult {
    var result = WorkerResult{
        .latencies = .empty,
        .successful = 0,
        .failed = 0,
    };

    var client = geode.GeodeClient.init(allocator, host, port, insecure, username, password) catch {
        result.failed = @intCast(queries);
        return result;
    };
    defer client.deinit();

    client.connect() catch {
        result.failed = @intCast(queries);
        return result;
    };

    client.openStream() catch {
        result.failed = @intCast(queries);
        return result;
    };

    // Send HELLO (now handles auth internally)
    client.sendHello() catch {
        result.failed = @intCast(queries);
        return result;
    };

    // Run queries
    for (0..queries) |_| {
        const start = nowNs();

        // Execute query using new protobuf-based API
        var query_result = client.query("RETURN 1", null) catch {
            result.failed += 1;
            continue;
        };
        defer query_result.deinit();

        if (query_result.hasError()) {
            result.failed += 1;
            continue;
        }

        const end = nowNs();
        const latency_ms = @as(f64, @floatFromInt(end - start)) / 1_000_000.0;

        result.latencies.append(allocator, latency_ms) catch {};
        result.successful += 1;
    }

    return result;
}

const WorkerCtx = struct {
    result_ptr: *WorkerResult,
    allocator: std.mem.Allocator,
    host: []const u8,
    port: u16,
    queries: usize,
    insecure: bool,
    username: []const u8,
    password: []const u8,

    fn run(raw: *anyopaque, _: *tp.TaskContext) void {
        const self: *WorkerCtx = @ptrCast(@alignCast(raw));
        self.result_ptr.* = runWorker(
            self.allocator,
            self.host,
            self.port,
            self.queries,
            self.insecure,
            self.username,
            self.password,
        );
    }
};

fn parseArgs(argv: []const [:0]const u8) !struct {
    host: []const u8,
    port: u16,
    workers: usize,
    queries: usize,
    json: bool,
    insecure: bool,
    username: []const u8,
    password: []const u8,
} {
    var host: []const u8 = "localhost";
    var port: u16 = 3141;
    var workers: usize = 10;
    var queries: usize = 1000;
    var json: bool = false;
    // SECURITY: Default to secure mode (insecure=false)
    var insecure: bool = false;
    var username: []const u8 = "";
    var password: []const u8 = "";

    // Skip program name (argv[0])
    var i: usize = 1;
    while (i < argv.len) : (i += 1) {
        const arg = argv[i];
        if (std.mem.eql(u8, arg, "--host")) {
            i += 1;
            if (i < argv.len) host = argv[i];
        } else if (std.mem.eql(u8, arg, "--port")) {
            i += 1;
            if (i < argv.len) port = std.fmt.parseInt(u16, argv[i], 10) catch 3142;
        } else if (std.mem.eql(u8, arg, "--workers")) {
            i += 1;
            if (i < argv.len) workers = std.fmt.parseInt(usize, argv[i], 10) catch 10;
        } else if (std.mem.eql(u8, arg, "--queries")) {
            i += 1;
            if (i < argv.len) queries = std.fmt.parseInt(usize, argv[i], 10) catch 1000;
        } else if (std.mem.eql(u8, arg, "--json")) {
            json = true;
        } else if (std.mem.eql(u8, arg, "--insecure")) {
            insecure = true;
        } else if (std.mem.eql(u8, arg, "--username")) {
            i += 1;
            if (i < argv.len) username = argv[i];
        } else if (std.mem.eql(u8, arg, "--password")) {
            i += 1;
            if (i < argv.len) password = argv[i];
        }
    }

    return .{
        .host = host,
        .port = port,
        .workers = workers,
        .queries = queries,
        .json = json,
        .insecure = insecure,
        .username = username,
        .password = password,
    };
}

pub fn main(init: std.process.Init) !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const argv = try init.minimal.args.toSlice(init.arena.allocator());
    const args = try parseArgs(argv);

    var stdout_buffer: [4096]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writer(init.io, &stdout_buffer);
    const stdout = &stdout_writer.interface;
    defer stdout.flush() catch {};

    // Collect results from workers in parallel using threads
    var all_latencies: std.ArrayList(f64) = .empty;
    defer all_latencies.deinit(allocator);

    var total_successful: i64 = 0;
    var total_failed: i64 = 0;

    // Each worker thread gets its own allocator via ArenaAllocator to avoid contention
    const max_workers = 256;
    if (args.workers > max_workers) {
        return error.TooManyWorkers;
    }

    var results: [max_workers]WorkerResult = undefined;
    var contexts: [max_workers]WorkerCtx = undefined;

    // Run each worker on its own blocking-lane thread. Blocking-lane
    // workers are dedicated to network I/O so they don't starve CPU
    // tasks — the client's canonical concurrency story.
    var runner = try runner_mod.Executor.init(allocator, .{
        .max_threads = args.workers + 2,
        .blocking_workers = @intCast(args.workers),
    });
    defer runner.deinit();

    var wg = runner.waitGroup();

    const start = nowNs();

    for (0..args.workers) |i| {
        contexts[i] = .{
            .result_ptr = &results[i],
            .allocator = allocator,
            .host = args.host,
            .port = args.port,
            .queries = args.queries,
            .insecure = args.insecure,
            .username = args.username,
            .password = args.password,
        };
        _ = try runner.pool.submit(WorkerCtx.run, &contexts[i], .{
            .lane = .blocking,
            .backpressure = .block,
            .wait_group = &wg,
        });
    }

    wg.wait();

    for (0..args.workers) |i| {
        defer results[i].latencies.deinit(allocator);
        for (results[i].latencies.items) |lat| {
            try all_latencies.append(allocator, lat);
        }
        total_successful += results[i].successful;
        total_failed += results[i].failed;
    }

    const end = nowNs();
    const duration = @as(f64, @floatFromInt(end - start)) / 1_000_000_000.0;

    // Calculate statistics
    var p50: f64 = 0;
    var p95: f64 = 0;
    var p99: f64 = 0;
    var avg: f64 = 0;

    if (all_latencies.items.len > 0) {
        // Sort latencies
        std.mem.sort(f64, all_latencies.items, {}, std.sort.asc(f64));

        p50 = all_latencies.items[all_latencies.items.len / 2];
        p95 = all_latencies.items[@as(usize, @intFromFloat(@as(f64, @floatFromInt(all_latencies.items.len)) * 0.95))];
        p99 = all_latencies.items[@as(usize, @intFromFloat(@as(f64, @floatFromInt(all_latencies.items.len)) * 0.99))];

        var sum: f64 = 0;
        for (all_latencies.items) |lat| {
            sum += lat;
        }
        avg = sum / @as(f64, @floatFromInt(all_latencies.items.len));
    }

    const throughput = @as(f64, @floatFromInt(total_successful)) / duration;

    const status: []const u8 = if (throughput >= 10000)
        "EXCELLENT"
    else if (throughput >= 1000)
        "GOOD"
    else if (throughput >= 100)
        "ACCEPTABLE"
    else
        "LIMITED";

    // Get timestamp
    var timestamp_buf: [64]u8 = undefined;
    const timestamp = std.fmt.bufPrint(&timestamp_buf, "{d}", .{nowSeconds()}) catch "0";

    if (args.json) {
        try stdout.print(
            \\{{"timestamp":"{s}","duration_seconds":{d:.2},"total_queries":{d},"successful_queries":{d},"failed_queries":{d},"throughput_qps":{d:.0},"latency_p50_ms":{d:.2},"latency_p95_ms":{d:.2},"latency_p99_ms":{d:.2},"latency_avg_ms":{d:.2},"workers":{d},"queries_per_worker":{d},"status":"{s}"}}
            \\
        , .{
            timestamp,
            duration,
            total_successful + total_failed,
            total_successful,
            total_failed,
            throughput,
            p50,
            p95,
            p99,
            avg,
            args.workers,
            args.queries,
            status,
        });
    } else {
        try stdout.print("======================================================================\n", .{});
        try stdout.print("ZIG CLIENT BENCHMARK RESULTS\n", .{});
        try stdout.print("======================================================================\n", .{});
        try stdout.print("Duration: {d:.2}s\n", .{duration});
        try stdout.print("Workers: {d}\n", .{args.workers});
        try stdout.print("Queries/worker: {d}\n", .{args.queries});
        try stdout.print("\n", .{});
        try stdout.print("RESULTS:\n", .{});
        try stdout.print("  Total queries:    {d}\n", .{total_successful + total_failed});
        try stdout.print("  Successful:       {d}\n", .{total_successful});
        try stdout.print("  Failed:           {d}\n", .{total_failed});
        try stdout.print("  Throughput:       {d:.0} qps\n", .{throughput});
        try stdout.print("\n", .{});
        try stdout.print("LATENCY:\n", .{});
        try stdout.print("  p50:  {d:.2}ms\n", .{p50});
        try stdout.print("  p95:  {d:.2}ms\n", .{p95});
        try stdout.print("  p99:  {d:.2}ms\n", .{p99});
        try stdout.print("  avg:  {d:.2}ms\n", .{avg});
        try stdout.print("\n", .{});
        try stdout.print("STATUS: {s}\n", .{status});
        try stdout.print("======================================================================\n", .{});
    }
}
