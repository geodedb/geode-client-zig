// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros

//! Client-side metrics for the Geode Zig client.
//!
//! Wraps the `metrics` library to provide structured observability for
//! connections, queries, transactions, and byte throughput. All metric
//! instances are registered in a single `metrics.Registry` so they can
//! be exported via Prometheus text format or captured as snapshots.
//!
//! ## Quick Start
//!
//! ```zig
//! var m = try ClientMetrics.init(allocator);
//! defer m.deinit();
//!
//! // Record a successful query
//! const sample = m.startQueryTimer();
//! // ... execute query ...
//! m.recordQuerySuccess(sample);
//!
//! // Record bytes transferred
//! m.recordBytesSent(payload.len);
//! m.recordBytesReceived(response.len);
//! ```

const std = @import("std");
const metrics = @import("metrics");

/// Observability metrics for a Geode client instance.
///
/// All fields are pointers into the owned `Registry` and remain valid
/// for the lifetime of this struct. Thread-safe for concurrent use.
pub const ClientMetrics = struct {
    registry: metrics.Registry,

    // -- Counters ----------------------------------------------------------

    /// Total number of queries executed (success + failure).
    queries_total: *metrics.Counter,
    /// Number of queries that failed.
    queries_failed: *metrics.Counter,
    /// Total connection attempts (success + failure).
    connections_total: *metrics.Counter,
    /// Number of connection attempts that failed.
    connections_failed: *metrics.Counter,
    /// Total bytes sent to the server.
    bytes_sent: *metrics.Counter,
    /// Total bytes received from the server.
    bytes_received: *metrics.Counter,
    /// Total number of transactions started.
    transactions_total: *metrics.Counter,
    /// Number of transactions that were committed.
    transactions_committed: *metrics.Counter,
    /// Number of transactions that were rolled back.
    transactions_rolled_back: *metrics.Counter,

    // -- Gauges ------------------------------------------------------------

    /// Number of currently active (open) connections.
    active_connections: *metrics.Gauge,

    // -- Timers ------------------------------------------------------------

    /// Latency distribution for query execution (seconds).
    query_duration: *metrics.Timer,
    /// Latency distribution for connection establishment (seconds).
    connection_duration: *metrics.Timer,

    /// Duration buckets for query latency (in seconds).
    /// Ranges from 1 ms to 30 s, suitable for graph database queries.
    const query_buckets: []const f64 = &.{
        0.001, 0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1.0, 2.5, 5.0, 10.0, 30.0,
    };

    /// Duration buckets for connection establishment (in seconds).
    /// Ranges from 10 ms to 60 s, accounting for TLS/QUIC handshake.
    const connection_buckets: []const f64 = &.{
        0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1.0, 2.5, 5.0, 10.0, 30.0, 60.0,
    };

    /// Initialize a new `ClientMetrics` and register all metrics in a fresh registry.
    pub fn init(allocator: std.mem.Allocator) !ClientMetrics {
        var reg = metrics.Registry.init(allocator);
        errdefer reg.deinit();

        // Counters
        const queries_total = try reg.counter("geode_client_queries_total", "Total queries executed");
        const queries_failed = try reg.counter("geode_client_queries_failed_total", "Total queries that failed");
        const connections_total = try reg.counter("geode_client_connections_total", "Total connection attempts");
        const connections_failed = try reg.counter("geode_client_connections_failed_total", "Total failed connection attempts");
        const bytes_sent = try reg.counter("geode_client_bytes_sent_total", "Total bytes sent to server");
        const bytes_received = try reg.counter("geode_client_bytes_received_total", "Total bytes received from server");
        const transactions_total = try reg.counter("geode_client_transactions_total", "Total transactions started");
        const transactions_committed = try reg.counter("geode_client_transactions_committed_total", "Total transactions committed");
        const transactions_rolled_back = try reg.counter("geode_client_transactions_rolled_back_total", "Total transactions rolled back");

        // Gauges
        const active_connections = try reg.gauge("geode_client_active_connections", "Currently active connections");

        // Timers
        const query_duration = try reg.timer("geode_client_query_duration_seconds", "Query execution duration in seconds", query_buckets);
        const connection_duration = try reg.timer("geode_client_connection_duration_seconds", "Connection establishment duration in seconds", connection_buckets);

        return .{
            .registry = reg,
            .queries_total = queries_total,
            .queries_failed = queries_failed,
            .connections_total = connections_total,
            .connections_failed = connections_failed,
            .bytes_sent = bytes_sent,
            .bytes_received = bytes_received,
            .transactions_total = transactions_total,
            .transactions_committed = transactions_committed,
            .transactions_rolled_back = transactions_rolled_back,
            .active_connections = active_connections,
            .query_duration = query_duration,
            .connection_duration = connection_duration,
        };
    }

    /// Release all resources owned by the registry.
    pub fn deinit(self: *ClientMetrics) void {
        self.registry.deinit();
    }

    // =====================================================================
    // Query helpers
    // =====================================================================

    /// Begin timing a query. Call `recordQuerySuccess` or `recordQueryFailure`
    /// with the returned sample when the query completes.
    pub fn startQueryTimer(self: *ClientMetrics) metrics.Timer.Sample {
        return self.query_duration.start();
    }

    /// Record a successful query completion and stop the timer.
    pub fn recordQuerySuccess(self: *ClientMetrics, sample: metrics.Timer.Sample) void {
        self.queries_total.inc();
        sample.finish();
    }

    /// Record a failed query and stop the timer.
    pub fn recordQueryFailure(self: *ClientMetrics, sample: metrics.Timer.Sample) void {
        self.queries_total.inc();
        self.queries_failed.inc();
        sample.finish();
    }

    // =====================================================================
    // Connection helpers
    // =====================================================================

    /// Begin timing a connection attempt.
    pub fn startConnectionTimer(self: *ClientMetrics) metrics.Timer.Sample {
        return self.connection_duration.start();
    }

    /// Record a successful connection and stop the timer.
    pub fn recordConnectionSuccess(self: *ClientMetrics, sample: metrics.Timer.Sample) void {
        self.connections_total.inc();
        self.active_connections.inc();
        sample.finish();
    }

    /// Record a failed connection attempt and stop the timer.
    pub fn recordConnectionFailure(self: *ClientMetrics, sample: metrics.Timer.Sample) void {
        self.connections_total.inc();
        self.connections_failed.inc();
        sample.finish();
    }

    /// Record that a connection was closed.
    pub fn recordConnectionClosed(self: *ClientMetrics) void {
        self.active_connections.dec();
    }

    // =====================================================================
    // Transaction helpers
    // =====================================================================

    /// Record a transaction begin.
    pub fn recordTransactionBegin(self: *ClientMetrics) void {
        self.transactions_total.inc();
    }

    /// Record a transaction commit.
    pub fn recordTransactionCommit(self: *ClientMetrics) void {
        self.transactions_committed.inc();
    }

    /// Record a transaction rollback.
    pub fn recordTransactionRollback(self: *ClientMetrics) void {
        self.transactions_rolled_back.inc();
    }

    // =====================================================================
    // Byte throughput helpers
    // =====================================================================

    /// Record bytes sent to the server.
    pub fn recordBytesSent(self: *ClientMetrics, n: u64) void {
        self.bytes_sent.add(n);
    }

    /// Record bytes received from the server.
    pub fn recordBytesReceived(self: *ClientMetrics, n: u64) void {
        self.bytes_received.add(n);
    }

    // =====================================================================
    // Snapshot / export
    // =====================================================================

    /// Capture a point-in-time snapshot of all client metrics.
    pub fn snapshot(self: *ClientMetrics) !metrics.Snapshot {
        return try self.registry.snapshot();
    }

    /// Write all metrics in Prometheus text exposition format.
    pub fn writePrometheus(self: *ClientMetrics, writer: anytype) !void {
        var snap = try self.registry.snapshot();
        defer snap.deinit();
        try metrics.writePrometheus(writer, snap);
    }
};

// =============================================================================
// Unit Tests
// =============================================================================

test "ClientMetrics: init and deinit" {
    var m = try ClientMetrics.init(std.testing.allocator);
    defer m.deinit();

    // All counters start at zero
    try std.testing.expectEqual(@as(u64, 0), m.queries_total.get());
    try std.testing.expectEqual(@as(u64, 0), m.queries_failed.get());
    try std.testing.expectEqual(@as(u64, 0), m.connections_total.get());
    try std.testing.expectEqual(@as(u64, 0), m.connections_failed.get());
    try std.testing.expectEqual(@as(u64, 0), m.bytes_sent.get());
    try std.testing.expectEqual(@as(u64, 0), m.bytes_received.get());
    try std.testing.expectEqual(@as(u64, 0), m.transactions_total.get());
    try std.testing.expectEqual(@as(u64, 0), m.transactions_committed.get());
    try std.testing.expectEqual(@as(u64, 0), m.transactions_rolled_back.get());

    // Gauge starts at zero
    try std.testing.expectEqual(@as(i64, 0), m.active_connections.get());

    // Timers start empty
    try std.testing.expectEqual(@as(u64, 0), m.query_duration.getCount());
    try std.testing.expectEqual(@as(u64, 0), m.connection_duration.getCount());
}

test "ClientMetrics: registry has correct metric count" {
    var m = try ClientMetrics.init(std.testing.allocator);
    defer m.deinit();

    // 9 counters + 1 gauge + 2 timers = 12
    try std.testing.expectEqual(@as(usize, 12), m.registry.metricCount());
}

test "ClientMetrics: recordQuerySuccess increments counter and timer" {
    var m = try ClientMetrics.init(std.testing.allocator);
    defer m.deinit();

    const sample = m.startQueryTimer();
    m.recordQuerySuccess(sample);

    try std.testing.expectEqual(@as(u64, 1), m.queries_total.get());
    try std.testing.expectEqual(@as(u64, 0), m.queries_failed.get());
    try std.testing.expectEqual(@as(u64, 1), m.query_duration.getCount());
}

test "ClientMetrics: recordQueryFailure increments both counters" {
    var m = try ClientMetrics.init(std.testing.allocator);
    defer m.deinit();

    const sample = m.startQueryTimer();
    m.recordQueryFailure(sample);

    try std.testing.expectEqual(@as(u64, 1), m.queries_total.get());
    try std.testing.expectEqual(@as(u64, 1), m.queries_failed.get());
    try std.testing.expectEqual(@as(u64, 1), m.query_duration.getCount());
}

test "ClientMetrics: recordConnectionSuccess increments counter and gauge" {
    var m = try ClientMetrics.init(std.testing.allocator);
    defer m.deinit();

    const sample = m.startConnectionTimer();
    m.recordConnectionSuccess(sample);

    try std.testing.expectEqual(@as(u64, 1), m.connections_total.get());
    try std.testing.expectEqual(@as(u64, 0), m.connections_failed.get());
    try std.testing.expectEqual(@as(i64, 1), m.active_connections.get());
    try std.testing.expectEqual(@as(u64, 1), m.connection_duration.getCount());
}

test "ClientMetrics: recordConnectionFailure does not change gauge" {
    var m = try ClientMetrics.init(std.testing.allocator);
    defer m.deinit();

    const sample = m.startConnectionTimer();
    m.recordConnectionFailure(sample);

    try std.testing.expectEqual(@as(u64, 1), m.connections_total.get());
    try std.testing.expectEqual(@as(u64, 1), m.connections_failed.get());
    try std.testing.expectEqual(@as(i64, 0), m.active_connections.get());
}

test "ClientMetrics: recordConnectionClosed decrements gauge" {
    var m = try ClientMetrics.init(std.testing.allocator);
    defer m.deinit();

    // Simulate open then close
    const sample = m.startConnectionTimer();
    m.recordConnectionSuccess(sample);
    try std.testing.expectEqual(@as(i64, 1), m.active_connections.get());

    m.recordConnectionClosed();
    try std.testing.expectEqual(@as(i64, 0), m.active_connections.get());
}

test "ClientMetrics: transaction lifecycle" {
    var m = try ClientMetrics.init(std.testing.allocator);
    defer m.deinit();

    m.recordTransactionBegin();
    m.recordTransactionBegin();
    m.recordTransactionCommit();
    m.recordTransactionRollback();

    try std.testing.expectEqual(@as(u64, 2), m.transactions_total.get());
    try std.testing.expectEqual(@as(u64, 1), m.transactions_committed.get());
    try std.testing.expectEqual(@as(u64, 1), m.transactions_rolled_back.get());
}

test "ClientMetrics: byte throughput tracking" {
    var m = try ClientMetrics.init(std.testing.allocator);
    defer m.deinit();

    m.recordBytesSent(1024);
    m.recordBytesSent(512);
    m.recordBytesReceived(2048);

    try std.testing.expectEqual(@as(u64, 1536), m.bytes_sent.get());
    try std.testing.expectEqual(@as(u64, 2048), m.bytes_received.get());
}

test "ClientMetrics: snapshot captures all metrics" {
    var m = try ClientMetrics.init(std.testing.allocator);
    defer m.deinit();

    m.queries_total.add(5);
    m.active_connections.set(3);

    var snap = try m.snapshot();
    defer snap.deinit();

    // 12 metrics total
    try std.testing.expectEqual(@as(usize, 12), snap.len());

    const qt = snap.get("geode_client_queries_total") orelse return error.TestUnexpectedResult;
    try std.testing.expectEqual(@as(u64, 5), qt.counter_value);

    const ac = snap.get("geode_client_active_connections") orelse return error.TestUnexpectedResult;
    try std.testing.expectEqual(@as(i64, 3), ac.gauge_value);
}

test "ClientMetrics: multiple query cycles accumulate" {
    var m = try ClientMetrics.init(std.testing.allocator);
    defer m.deinit();

    for (0..10) |_| {
        const sample = m.startQueryTimer();
        m.recordQuerySuccess(sample);
    }
    for (0..3) |_| {
        const sample = m.startQueryTimer();
        m.recordQueryFailure(sample);
    }

    try std.testing.expectEqual(@as(u64, 13), m.queries_total.get());
    try std.testing.expectEqual(@as(u64, 3), m.queries_failed.get());
    try std.testing.expectEqual(@as(u64, 13), m.query_duration.getCount());
}
