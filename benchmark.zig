// Native Zig client benchmark for Geode
//
// Usage: zig build benchmark -- --host localhost --port 3142 --workers 10 --queries 1000

const std = @import("std");
const geode = @import("geode_client");

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
        .latencies = .{},
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
        const start = std.time.nanoTimestamp();

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

        const end = std.time.nanoTimestamp();
        const latency_ms = @as(f64, @floatFromInt(end - start)) / 1_000_000.0;

        result.latencies.append(allocator, latency_ms) catch {};
        result.successful += 1;
    }

    return result;
}

fn workerThread(
    result_ptr: *WorkerResult,
    allocator: std.mem.Allocator,
    host: []const u8,
    port: u16,
    queries: usize,
    insecure: bool,
    username: []const u8,
    password: []const u8,
) void {
    result_ptr.* = runWorker(allocator, host, port, queries, insecure, username, password);
}

fn parseArgs(allocator: std.mem.Allocator) !struct {
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

    var args = try std.process.Args.Iterator.init(.{ .vector = @as(std.process.Args.Vector, @ptrCast(std.c.argv)) });
    // skip allocator
    _ = allocator);
    defer args.deinit();

    // Skip program name
    _ = args.skip();

    while (args.next()) |arg| {
        if (std.mem.eql(u8, arg, "--host")) {
            if (args.next()) |val| {
                host = val;
            }
        } else if (std.mem.eql(u8, arg, "--port")) {
            if (args.next()) |val| {
                port = std.fmt.parseInt(u16, val, 10) catch 3142;
            }
        } else if (std.mem.eql(u8, arg, "--workers")) {
            if (args.next()) |val| {
                workers = std.fmt.parseInt(usize, val, 10) catch 10;
            }
        } else if (std.mem.eql(u8, arg, "--queries")) {
            if (args.next()) |val| {
                queries = std.fmt.parseInt(usize, val, 10) catch 1000;
            }
        } else if (std.mem.eql(u8, arg, "--json")) {
            json = true;
        } else if (std.mem.eql(u8, arg, "--insecure")) {
            insecure = true;
        } else if (std.mem.eql(u8, arg, "--username")) {
            if (args.next()) |val| {
                username = val;
            }
        } else if (std.mem.eql(u8, arg, "--password")) {
            if (args.next()) |val| {
                password = val;
            }
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

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try parseArgs(allocator);

    const stdout = std.fs.File.stdout().deprecatedWriter();

    // Collect results from workers in parallel using threads
    var all_latencies: std.ArrayList(f64) = .{};
    defer all_latencies.deinit(allocator);

    var total_successful: i64 = 0;
    var total_failed: i64 = 0;

    // Each worker thread gets its own allocator via ArenaAllocator to avoid contention
    const max_workers = 256;
    if (args.workers > max_workers) {
        return error.TooManyWorkers;
    }

    var results: [max_workers]WorkerResult = undefined;
    var threads: [max_workers]?std.Thread = [_]?std.Thread{null} ** max_workers;

    const start = std.time.nanoTimestamp();

    // Spawn all worker threads
    for (0..args.workers) |i| {
        threads[i] = try std.Thread.spawn(.{}, workerThread, .{ &results[i], allocator, args.host, args.port, args.queries, args.insecure, args.username, args.password });
    }

    // Join all worker threads and collect results
    for (0..args.workers) |i| {
        if (threads[i]) |t| {
            t.join();
        }

        defer results[i].latencies.deinit(allocator);

        for (results[i].latencies.items) |lat| {
            try all_latencies.append(allocator, lat);
        }
        total_successful += results[i].successful;
        total_failed += results[i].failed;
    }

    const end = std.time.nanoTimestamp();
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
    const timestamp = std.fmt.bufPrint(&timestamp_buf, "{d}", .{std.time.timestamp()}) catch "0";

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
