// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Benchmarks for the Geode Zig client library.
// Measures performance of type system, query builders, and other components.

const std = @import("std");

// Import modules to benchmark
const Value = @import("types").Value;
const QueryBuilder = @import("query_builder").QueryBuilder;
const PatternBuilder = @import("query_builder").PatternBuilder;
const PredicateBuilder = @import("query_builder").PredicateBuilder;
const Config = @import("config").Config;
const parseDSN = @import("config").parseDSN;
const Pool = @import("pool").Pool;
const PoolConfig = @import("pool").PoolConfig;
const validate = @import("validate");

// =============================================================================
// Benchmark Framework
// =============================================================================

/// Result of a benchmark run
const BenchmarkResult = struct {
    name: []const u8,
    iterations: u64,
    total_ns: u64,
    min_ns: u64,
    max_ns: u64,
    avg_ns: u64,
    ops_per_sec: f64,

    pub fn print(self: BenchmarkResult) void {
        const avg_us = @as(f64, @floatFromInt(self.avg_ns)) / 1000.0;
        const min_us = @as(f64, @floatFromInt(self.min_ns)) / 1000.0;
        const max_us = @as(f64, @floatFromInt(self.max_ns)) / 1000.0;

        std.debug.print("{s:<45} {d:>10} iterations  {d:>10.2} us/op  {d:>12.0} ops/sec  (min: {d:.2} us, max: {d:.2} us)\n", .{
            self.name,
            self.iterations,
            avg_us,
            self.ops_per_sec,
            min_us,
            max_us,
        });
    }
};

/// Run a benchmark function multiple times and collect statistics
fn benchmark(name: []const u8, comptime func: fn (std.mem.Allocator) void, allocator: std.mem.Allocator) BenchmarkResult {
    const warmup_iterations: u64 = 100;
    const min_iterations: u64 = 1000;
    const target_time_ns: u64 = 100_000_000; // 100ms target

    // Warmup
    var i: u64 = 0;
    while (i < warmup_iterations) : (i += 1) {
        func(allocator);
    }

    // Estimate iterations needed
    var timer = std.time.Timer.start() catch unreachable;
    i = 0;
    while (i < 100) : (i += 1) {
        func(allocator);
    }
    const estimate_ns = timer.read();
    const estimate_per_op = estimate_ns / 100;
    const estimated_iterations = if (estimate_per_op > 0) target_time_ns / estimate_per_op else min_iterations;
    const iterations = @max(min_iterations, estimated_iterations);

    // Run benchmark
    var min_ns: u64 = std.math.maxInt(u64);
    var max_ns: u64 = 0;
    var total_ns: u64 = 0;

    i = 0;
    while (i < iterations) : (i += 1) {
        timer = std.time.Timer.start() catch unreachable;
        func(allocator);
        const elapsed = timer.read();
        total_ns += elapsed;
        min_ns = @min(min_ns, elapsed);
        max_ns = @max(max_ns, elapsed);
    }

    const avg_ns = total_ns / iterations;
    const ops_per_sec = if (avg_ns > 0)
        @as(f64, 1_000_000_000.0) / @as(f64, @floatFromInt(avg_ns))
    else
        0.0;

    return .{
        .name = name,
        .iterations = iterations,
        .total_ns = total_ns,
        .min_ns = min_ns,
        .max_ns = max_ns,
        .avg_ns = avg_ns,
        .ops_per_sec = ops_per_sec,
    };
}

/// Run a benchmark that doesn't need an allocator
fn benchmarkSimple(name: []const u8, comptime func: fn () void) BenchmarkResult {
    const warmup_iterations: u64 = 100;
    const min_iterations: u64 = 1000;
    const target_time_ns: u64 = 100_000_000; // 100ms target

    // Warmup
    var i: u64 = 0;
    while (i < warmup_iterations) : (i += 1) {
        func();
    }

    // Estimate iterations needed
    var timer = std.time.Timer.start() catch unreachable;
    i = 0;
    while (i < 100) : (i += 1) {
        func();
    }
    const estimate_ns = timer.read();
    const estimate_per_op = estimate_ns / 100;
    const estimated_iterations = if (estimate_per_op > 0) target_time_ns / estimate_per_op else min_iterations;
    const iterations = @max(min_iterations, estimated_iterations);

    // Run benchmark
    var min_ns: u64 = std.math.maxInt(u64);
    var max_ns: u64 = 0;
    var total_ns: u64 = 0;

    i = 0;
    while (i < iterations) : (i += 1) {
        timer = std.time.Timer.start() catch unreachable;
        func();
        const elapsed = timer.read();
        total_ns += elapsed;
        min_ns = @min(min_ns, elapsed);
        max_ns = @max(max_ns, elapsed);
    }

    const avg_ns = total_ns / iterations;
    const ops_per_sec = if (avg_ns > 0)
        @as(f64, 1_000_000_000.0) / @as(f64, @floatFromInt(avg_ns))
    else
        0.0;

    return .{
        .name = name,
        .iterations = iterations,
        .total_ns = total_ns,
        .min_ns = min_ns,
        .max_ns = max_ns,
        .avg_ns = avg_ns,
        .ops_per_sec = ops_per_sec,
    };
}

// =============================================================================
// Value Type Benchmarks
// =============================================================================

fn benchValueInitNull() void {
    const v = Value.initNull();
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueInitBool() void {
    const v = Value.initBool(true);
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueInitInt() void {
    const v = Value.initInt(42);
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueInitFloat() void {
    const v = Value.initFloat(3.14159);
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueInitString() void {
    const v = Value.initString("hello world");
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueInitDate() void {
    const v = Value.initDate(2025, 1, 24);
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueInitTime() void {
    const v = Value.initTime(14, 30, 45);
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueInitTimestamp() void {
    const v = Value.initTimestamp(
        Value.Date.init(2025, 1, 24),
        Value.Time.init(14, 30, 45),
    );
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueInitArray() void {
    const items = [_]Value{
        Value.initInt(1),
        Value.initInt(2),
        Value.initInt(3),
    };
    const v = Value.initArray(&items);
    std.mem.doNotOptimizeAway(&v);
}

// =============================================================================
// Value Accessor Benchmarks
// =============================================================================

fn benchValueIsNull() void {
    const v = Value.initNull();
    const result = v.isNull();
    std.mem.doNotOptimizeAway(&result);
}

fn benchValueIsBool() void {
    const v = Value.initBool(true);
    const result = v.isBool();
    std.mem.doNotOptimizeAway(&result);
}

fn benchValueIsInt() void {
    const v = Value.initInt(42);
    const result = v.isInt();
    std.mem.doNotOptimizeAway(&result);
}

fn benchValueAsInt() void {
    const v = Value.initInt(42);
    const result = v.asInt() catch unreachable;
    std.mem.doNotOptimizeAway(&result);
}

fn benchValueAsFloat() void {
    const v = Value.initFloat(3.14);
    const result = v.asFloat() catch unreachable;
    std.mem.doNotOptimizeAway(&result);
}

fn benchValueAsString() void {
    const v = Value.initString("hello");
    const result = v.asString() catch unreachable;
    std.mem.doNotOptimizeAway(&result);
}

fn benchValueTypeName() void {
    const v = Value.initInt(42);
    const result = v.typeName();
    std.mem.doNotOptimizeAway(&result);
}

// =============================================================================
// JSON Conversion Benchmarks
// =============================================================================

fn benchValueFromJsonNull() void {
    const json = std.json.Value.null;
    const v = Value.fromJson(json);
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueFromJsonBool() void {
    const json = std.json.Value{ .bool = true };
    const v = Value.fromJson(json);
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueFromJsonInt() void {
    const json = std.json.Value{ .integer = 42 };
    const v = Value.fromJson(json);
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueFromJsonFloat() void {
    const json = std.json.Value{ .float = 3.14 };
    const v = Value.fromJson(json);
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueFromJsonString() void {
    const json = std.json.Value{ .string = "hello world" };
    const v = Value.fromJson(json);
    std.mem.doNotOptimizeAway(&v);
}

fn benchValueToJsonNull(allocator: std.mem.Allocator) void {
    const v = Value.initNull();
    const json = v.toJson(allocator) catch unreachable;
    std.mem.doNotOptimizeAway(&json);
}

fn benchValueToJsonBool(allocator: std.mem.Allocator) void {
    const v = Value.initBool(true);
    const json = v.toJson(allocator) catch unreachable;
    std.mem.doNotOptimizeAway(&json);
}

fn benchValueToJsonInt(allocator: std.mem.Allocator) void {
    const v = Value.initInt(42);
    const json = v.toJson(allocator) catch unreachable;
    std.mem.doNotOptimizeAway(&json);
}

fn benchValueToJsonString(allocator: std.mem.Allocator) void {
    const v = Value.initString("hello world");
    const json = v.toJson(allocator) catch unreachable;
    std.mem.doNotOptimizeAway(&json);
}

fn benchValueToJsonDate(allocator: std.mem.Allocator) void {
    const v = Value.initDate(2025, 1, 24);
    const json = v.toJson(allocator) catch unreachable;
    defer allocator.free(json.string);
    std.mem.doNotOptimizeAway(&json);
}

// =============================================================================
// QueryBuilder Benchmarks
// =============================================================================

fn benchQueryBuilderSimple(allocator: std.mem.Allocator) void {
    var qb = QueryBuilder.init(allocator);
    defer qb.deinit();

    _ = qb.match("(n)") catch unreachable;
    _ = qb.ret("n") catch unreachable;

    const query = qb.build() catch unreachable;
    defer allocator.free(query);
    std.mem.doNotOptimizeAway(query);
}

fn benchQueryBuilderWithWhere(allocator: std.mem.Allocator) void {
    var qb = QueryBuilder.init(allocator);
    defer qb.deinit();

    _ = qb.match("(n:Person)") catch unreachable;
    _ = qb.where("n.age > 30") catch unreachable;
    _ = qb.ret("n") catch unreachable;

    const query = qb.build() catch unreachable;
    defer allocator.free(query);
    std.mem.doNotOptimizeAway(query);
}

fn benchQueryBuilderComplex(allocator: std.mem.Allocator) void {
    var qb = QueryBuilder.init(allocator);
    defer qb.deinit();

    _ = qb.match("(p:Person)-[:WORKS_AT]->(c:Company)") catch unreachable;
    _ = qb.where("p.age > 25") catch unreachable;
    _ = qb.with("p, c, count(*) AS cnt") catch unreachable;
    _ = qb.orderByDesc("cnt") catch unreachable;
    _ = qb.limit(10) catch unreachable;
    _ = qb.ret("p.name, c.name, cnt") catch unreachable;

    const query = qb.build() catch unreachable;
    defer allocator.free(query);
    std.mem.doNotOptimizeAway(query);
}

fn benchQueryBuilderWithParams(allocator: std.mem.Allocator) void {
    var qb = QueryBuilder.init(allocator);
    defer qb.deinit();

    _ = qb.match("(n:Person)") catch unreachable;
    _ = qb.where("n.name = $name AND n.age > $minAge") catch unreachable;
    _ = qb.ret("n") catch unreachable;
    _ = qb.param("name", Value.initString("Alice")) catch unreachable;
    _ = qb.param("minAge", Value.initInt(25)) catch unreachable;

    const query = qb.build() catch unreachable;
    defer allocator.free(query);
    std.mem.doNotOptimizeAway(query);
}

fn benchQueryBuilderCreate(allocator: std.mem.Allocator) void {
    var qb = QueryBuilder.init(allocator);
    defer qb.deinit();

    _ = qb.create("(n:Person {name: 'Alice', age: 30})") catch unreachable;
    _ = qb.ret("n") catch unreachable;

    const query = qb.build() catch unreachable;
    defer allocator.free(query);
    std.mem.doNotOptimizeAway(query);
}

fn benchQueryBuilderCRUD(allocator: std.mem.Allocator) void {
    var qb = QueryBuilder.init(allocator);
    defer qb.deinit();

    _ = qb.match("(n:Person)") catch unreachable;
    _ = qb.where("n.id = $id") catch unreachable;
    _ = qb.set("n.updated = true") catch unreachable;
    _ = qb.ret("n") catch unreachable;

    const query = qb.build() catch unreachable;
    defer allocator.free(query);
    std.mem.doNotOptimizeAway(query);
}

// =============================================================================
// PatternBuilder Benchmarks
// =============================================================================

fn benchPatternBuilderSimpleNode(allocator: std.mem.Allocator) void {
    var pb = PatternBuilder.init(allocator);
    defer pb.deinit();

    _ = pb.nodeVar("n") catch unreachable;

    const pattern = pb.build() catch unreachable;
    defer allocator.free(pattern);
    std.mem.doNotOptimizeAway(pattern);
}

fn benchPatternBuilderNodeWithLabel(allocator: std.mem.Allocator) void {
    var pb = PatternBuilder.init(allocator);
    defer pb.deinit();

    _ = pb.nodeLabel("n", "Person") catch unreachable;

    const pattern = pb.build() catch unreachable;
    defer allocator.free(pattern);
    std.mem.doNotOptimizeAway(pattern);
}

fn benchPatternBuilderRelationship(allocator: std.mem.Allocator) void {
    var pb = PatternBuilder.init(allocator);
    defer pb.deinit();

    _ = pb.nodeLabel("a", "Person") catch unreachable;
    _ = pb.edgeRight("KNOWS") catch unreachable;
    _ = pb.nodeLabel("b", "Person") catch unreachable;

    const pattern = pb.build() catch unreachable;
    defer allocator.free(pattern);
    std.mem.doNotOptimizeAway(pattern);
}

fn benchPatternBuilderComplex(allocator: std.mem.Allocator) void {
    var pb = PatternBuilder.init(allocator);
    defer pb.deinit();

    _ = pb.nodeLabel("a", "Person") catch unreachable;
    _ = pb.relRight("r1", "WORKS_AT", null) catch unreachable;
    _ = pb.nodeLabel("c", "Company") catch unreachable;
    _ = pb.relLeft("r2", "MANAGES", null) catch unreachable;
    _ = pb.nodeLabel("m", "Person") catch unreachable;

    const pattern = pb.build() catch unreachable;
    defer allocator.free(pattern);
    std.mem.doNotOptimizeAway(pattern);
}

// =============================================================================
// PredicateBuilder Benchmarks
// =============================================================================

fn benchPredicateBuilderSimple(allocator: std.mem.Allocator) void {
    var pb = PredicateBuilder.init(allocator);
    defer pb.deinit();

    _ = pb.eq("n.name", "name") catch unreachable;

    const pred = pb.build() catch unreachable;
    defer allocator.free(pred);
    std.mem.doNotOptimizeAway(pred);
}

fn benchPredicateBuilderComparison(allocator: std.mem.Allocator) void {
    var pb = PredicateBuilder.init(allocator);
    defer pb.deinit();

    _ = pb.gt("n.age", "minAge") catch unreachable;
    _ = pb.andOp() catch unreachable;
    _ = pb.lt("n.age", "maxAge") catch unreachable;

    const pred = pb.build() catch unreachable;
    defer allocator.free(pred);
    std.mem.doNotOptimizeAway(pred);
}

fn benchPredicateBuilderComplex(allocator: std.mem.Allocator) void {
    var pb = PredicateBuilder.init(allocator);
    defer pb.deinit();

    _ = pb.gt("n.age", "minAge") catch unreachable;
    _ = pb.andOp() catch unreachable;
    _ = pb.isNotNull("n.email") catch unreachable;
    _ = pb.andOp() catch unreachable;
    _ = pb.startsWith("n.name", "prefix") catch unreachable;
    _ = pb.orOp() catch unreachable;
    _ = pb.contains("n.bio", "keyword") catch unreachable;

    const pred = pb.build() catch unreachable;
    defer allocator.free(pred);
    std.mem.doNotOptimizeAway(pred);
}

// =============================================================================
// Config/DSN Parsing Benchmarks
// =============================================================================

fn benchConfigInit() void {
    const cfg = Config.init();
    std.mem.doNotOptimizeAway(&cfg);
}

fn benchConfigBuilder() void {
    var cfg = Config.init();
    _ = cfg.withCredentials("admin", "secret");
    _ = cfg.withInsecure(true);
    _ = cfg.withPageSize(500);
    _ = cfg.withTimeout(30000);
    std.mem.doNotOptimizeAway(&cfg);
}

fn benchParseDSNSimple(allocator: std.mem.Allocator) void {
    const cfg = parseDSN(allocator, "localhost:3141") catch unreachable;
    std.mem.doNotOptimizeAway(&cfg);
}

fn benchParseDSNURL(allocator: std.mem.Allocator) void {
    const cfg = parseDSN(allocator, "geode://localhost:3141") catch unreachable;
    std.mem.doNotOptimizeAway(&cfg);
}

fn benchParseDSNFull(allocator: std.mem.Allocator) void {
    const cfg = parseDSN(allocator, "geode://admin:secret@localhost:3141?insecure=true&page_size=500") catch unreachable;
    std.mem.doNotOptimizeAway(&cfg);
}

// =============================================================================
// Pool Benchmarks
// =============================================================================

const TestConnection = struct {
    id: u64,
};

fn benchPoolCreate(allocator: std.mem.Allocator) void {
    const TestPool = Pool(TestConnection);
    var pool = TestPool.init(allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();
    std.mem.doNotOptimizeAway(&pool);
}

fn benchPoolAcquireRelease(allocator: std.mem.Allocator) void {
    const TestPool = Pool(TestConnection);
    var pool = TestPool.init(allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    const conn = pool.acquire() catch unreachable;
    pool.release(conn);
    std.mem.doNotOptimizeAway(&pool);
}

fn benchPoolReuseConnection(allocator: std.mem.Allocator) void {
    const TestPool = Pool(TestConnection);
    var pool = TestPool.init(allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    // Acquire, release, and reacquire to test connection reuse
    const conn1 = pool.acquire() catch unreachable;
    pool.release(conn1);
    const conn2 = pool.acquire() catch unreachable;
    pool.release(conn2);
    std.mem.doNotOptimizeAway(&pool);
}

fn benchPoolStats(allocator: std.mem.Allocator) void {
    const TestPool = Pool(TestConnection);
    var pool = TestPool.init(allocator, Config.init(), PoolConfig.init());
    defer pool.deinit();

    const conn = pool.acquire() catch unreachable;
    const stats = pool.getStats();
    pool.release(conn);
    std.mem.doNotOptimizeAway(&stats);
}

// =============================================================================
// Validation Benchmarks
// =============================================================================

fn benchValidateQuery() void {
    validate.query("MATCH (n:Person) WHERE n.age > 30 RETURN n") catch unreachable;
}

fn benchValidateParamName() void {
    validate.paramName("myParam") catch unreachable;
}

fn benchValidateHostname() void {
    validate.hostname("localhost") catch unreachable;
}

fn benchValidatePort() void {
    validate.port(3141) catch unreachable;
}

fn benchValidatePageSize() void {
    validate.pageSize(1000) catch unreachable;
}

fn benchValidateIPv4() void {
    const result = validate.ipv4("192.168.1.1");
    std.mem.doNotOptimizeAway(&result);
}

fn benchValidateIPv6() void {
    const result = validate.isIpv6("2001:0db8:85a3:0000:0000:8a2e:0370:7334");
    std.mem.doNotOptimizeAway(&result);
}

fn benchValidateSanitize(allocator: std.mem.Allocator) void {
    const result = validate.sanitize(allocator, "hello\x00world\x01test") catch unreachable;
    defer allocator.free(result);
    std.mem.doNotOptimizeAway(result);
}

// =============================================================================
// Date/Time Formatting Benchmarks
// =============================================================================

fn benchDateFormat() void {
    const d = Value.Date.init(2025, 1, 24);
    var buf: [16]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&buf);
    d.format("", .{}, fbs.writer()) catch unreachable;
    std.mem.doNotOptimizeAway(&buf);
}

fn benchTimeFormat() void {
    const t = Value.Time.withNanos(14, 30, 45, 123456789);
    var buf: [32]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&buf);
    t.format("", .{}, fbs.writer()) catch unreachable;
    std.mem.doNotOptimizeAway(&buf);
}

fn benchTimestampFormat() void {
    const ts = Value.Timestamp.init(
        Value.Date.init(2025, 1, 24),
        Value.Time.withNanos(14, 30, 45, 123456789),
    );
    var buf: [48]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&buf);
    ts.format("", .{}, fbs.writer()) catch unreachable;
    std.mem.doNotOptimizeAway(&buf);
}

// =============================================================================
// Main Entry Point
// =============================================================================

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    std.debug.print("\n", .{});
    std.debug.print("=" ** 100 ++ "\n", .{});
    std.debug.print("Geode Zig Client Benchmarks\n", .{});
    std.debug.print("=" ** 100 ++ "\n", .{});
    std.debug.print("\n", .{});

    // Value Type Creation Benchmarks
    std.debug.print("--- Value Type Creation ---\n", .{});
    benchmarkSimple("Value.initNull", benchValueInitNull).print();
    benchmarkSimple("Value.initBool", benchValueInitBool).print();
    benchmarkSimple("Value.initInt", benchValueInitInt).print();
    benchmarkSimple("Value.initFloat", benchValueInitFloat).print();
    benchmarkSimple("Value.initString", benchValueInitString).print();
    benchmarkSimple("Value.initDate", benchValueInitDate).print();
    benchmarkSimple("Value.initTime", benchValueInitTime).print();
    benchmarkSimple("Value.initTimestamp", benchValueInitTimestamp).print();
    benchmarkSimple("Value.initArray (3 items)", benchValueInitArray).print();
    std.debug.print("\n", .{});

    // Value Accessor Benchmarks
    std.debug.print("--- Value Accessors ---\n", .{});
    benchmarkSimple("Value.isNull", benchValueIsNull).print();
    benchmarkSimple("Value.isBool", benchValueIsBool).print();
    benchmarkSimple("Value.isInt", benchValueIsInt).print();
    benchmarkSimple("Value.asInt", benchValueAsInt).print();
    benchmarkSimple("Value.asFloat", benchValueAsFloat).print();
    benchmarkSimple("Value.asString", benchValueAsString).print();
    benchmarkSimple("Value.typeName", benchValueTypeName).print();
    std.debug.print("\n", .{});

    // JSON Conversion Benchmarks
    std.debug.print("--- JSON Conversion ---\n", .{});
    benchmarkSimple("Value.fromJson (null)", benchValueFromJsonNull).print();
    benchmarkSimple("Value.fromJson (bool)", benchValueFromJsonBool).print();
    benchmarkSimple("Value.fromJson (int)", benchValueFromJsonInt).print();
    benchmarkSimple("Value.fromJson (float)", benchValueFromJsonFloat).print();
    benchmarkSimple("Value.fromJson (string)", benchValueFromJsonString).print();
    benchmark("Value.toJson (null)", benchValueToJsonNull, allocator).print();
    benchmark("Value.toJson (bool)", benchValueToJsonBool, allocator).print();
    benchmark("Value.toJson (int)", benchValueToJsonInt, allocator).print();
    benchmark("Value.toJson (string)", benchValueToJsonString, allocator).print();
    benchmark("Value.toJson (date)", benchValueToJsonDate, allocator).print();
    std.debug.print("\n", .{});

    // Date/Time Formatting Benchmarks
    std.debug.print("--- Date/Time Formatting ---\n", .{});
    benchmarkSimple("Date.format", benchDateFormat).print();
    benchmarkSimple("Time.format (with nanos)", benchTimeFormat).print();
    benchmarkSimple("Timestamp.format", benchTimestampFormat).print();
    std.debug.print("\n", .{});

    // QueryBuilder Benchmarks
    std.debug.print("--- QueryBuilder ---\n", .{});
    benchmark("QueryBuilder (simple)", benchQueryBuilderSimple, allocator).print();
    benchmark("QueryBuilder (with WHERE)", benchQueryBuilderWithWhere, allocator).print();
    benchmark("QueryBuilder (complex)", benchQueryBuilderComplex, allocator).print();
    benchmark("QueryBuilder (with params)", benchQueryBuilderWithParams, allocator).print();
    benchmark("QueryBuilder (CREATE)", benchQueryBuilderCreate, allocator).print();
    benchmark("QueryBuilder (CRUD update)", benchQueryBuilderCRUD, allocator).print();
    std.debug.print("\n", .{});

    // PatternBuilder Benchmarks
    std.debug.print("--- PatternBuilder ---\n", .{});
    benchmark("PatternBuilder (simple node)", benchPatternBuilderSimpleNode, allocator).print();
    benchmark("PatternBuilder (node + label)", benchPatternBuilderNodeWithLabel, allocator).print();
    benchmark("PatternBuilder (relationship)", benchPatternBuilderRelationship, allocator).print();
    benchmark("PatternBuilder (complex)", benchPatternBuilderComplex, allocator).print();
    std.debug.print("\n", .{});

    // PredicateBuilder Benchmarks
    std.debug.print("--- PredicateBuilder ---\n", .{});
    benchmark("PredicateBuilder (simple)", benchPredicateBuilderSimple, allocator).print();
    benchmark("PredicateBuilder (comparison)", benchPredicateBuilderComparison, allocator).print();
    benchmark("PredicateBuilder (complex)", benchPredicateBuilderComplex, allocator).print();
    std.debug.print("\n", .{});

    // Config Benchmarks
    std.debug.print("--- Config/DSN ---\n", .{});
    benchmarkSimple("Config.init", benchConfigInit).print();
    benchmarkSimple("Config builder chain", benchConfigBuilder).print();
    benchmark("parseDSN (simple)", benchParseDSNSimple, allocator).print();
    benchmark("parseDSN (URL)", benchParseDSNURL, allocator).print();
    benchmark("parseDSN (full)", benchParseDSNFull, allocator).print();
    std.debug.print("\n", .{});

    // Pool Benchmarks
    std.debug.print("--- Connection Pool ---\n", .{});
    benchmark("Pool.init", benchPoolCreate, allocator).print();
    benchmark("Pool acquire/release", benchPoolAcquireRelease, allocator).print();
    benchmark("Pool reuse connection", benchPoolReuseConnection, allocator).print();
    benchmark("Pool.getStats", benchPoolStats, allocator).print();
    std.debug.print("\n", .{});

    // Validation Benchmarks
    std.debug.print("--- Validation ---\n", .{});
    benchmarkSimple("validate.query", benchValidateQuery).print();
    benchmarkSimple("validate.paramName", benchValidateParamName).print();
    benchmarkSimple("validate.hostname", benchValidateHostname).print();
    benchmarkSimple("validate.port", benchValidatePort).print();
    benchmarkSimple("validate.pageSize", benchValidatePageSize).print();
    benchmarkSimple("validate.ipv4", benchValidateIPv4).print();
    benchmarkSimple("validate.isIpv6", benchValidateIPv6).print();
    benchmark("validate.sanitize", benchValidateSanitize, allocator).print();
    std.debug.print("\n", .{});

    std.debug.print("=" ** 100 ++ "\n", .{});
    std.debug.print("Benchmarks complete.\n", .{});
    std.debug.print("=" ** 100 ++ "\n", .{});
}
