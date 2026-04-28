// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros

//! observability.zig — single-file otel seam for geode-client-zig.
//!
//! Mirrors the thread-pool / slog / metrics seam pattern. When
//! `build_options.with_otel == false`, every public function in this
//! file collapses to a comptime-known no-op so the optimizer can
//! eliminate the call site. When `true`, calls forward to the
//! `otel.api.trace` helpers via the tracer pointer published at
//! process start by `observability_init.Otel.installGlobals`.
//!
//! INVARIANT: every emit is `catch {}`-discarded. A failing exporter
//! never reaches the caller — telemetry must never break a database
//! call. The seam itself is non-allocating; the real allocations live
//! inside `otel.sdk.trace`.
//!
//! Span shape (db-client semconv 1.40):
//!   - kind: `.client`
//!   - attributes:
//!       * `db.system.name    = "geode"`
//!       * `db.operation.name = "<EXECUTE|BEGIN|COMMIT|ROLLBACK|PING|CONNECT>"`
//!       * `db.query.text     = "<gql statement>"`  (query only)
//!       * `server.address    = "<host>"`            (connect only)
//!       * `server.port       = <port>`              (connect only)
//!       * `network.transport = "<quic|grpc>"`       (connect only)

const std = @import("std");
const build_options = @import("build_options");

pub const enabled: bool = build_options.with_otel;

const otel = if (enabled) @import("otel") else struct {};

/// Opaque span handle. When disabled, this is a zero-sized struct that
/// the optimizer drops entirely. The no-op fallback's `end` signature
/// MUST match `otel.api.trace.Span.end(?u64) void` so callers can write
/// `defer span.end(null)` regardless of `enabled` state.
pub const Span = if (enabled) otel.api.trace.Span else struct {
    pub fn end(self: @This(), _: ?u64) void {
        _ = self;
    }
};

/// Wire transport tag for the `network.transport` connect attribute.
pub const Transport = enum { quic, grpc };

/// Set once at process start by `observability_init.Otel.installGlobals`.
/// Only referenced when `enabled == true`; otherwise the optimizer drops
/// the whole struct.
pub const global = if (enabled) struct {
    pub var tracer: ?*otel.api.trace.Tracer = null;
    pub var meter: ?*otel.api.metrics.Meter = null;
} else struct {};

/// Internal helper — start a client-kind span with the geode db.system
/// attribute already attached. Returns a no-op `Span{}` (disabled or no
/// global tracer installed) so callers don't need to null-check.
fn startClientSpan(name: []const u8, operation: []const u8) Span {
    if (!enabled) return Span{};
    const tracer = global.tracer orelse return Span{};
    const span = tracer.startSpan(.empty(), name, .{ .kind = .client }) catch return Span{};
    span.setStringAttribute("db.system.name", "geode") catch {};
    span.setStringAttribute("db.operation.name", operation) catch {};
    return span;
}

/// Start a span around `GeodeClient.connect`. Wired at the public
/// `connect` entry point so per-transport `connectQuic` / `connectGrpc`
/// failures both surface under one parent span.
pub fn startConnectSpan(host: []const u8, port: u16, transport: Transport) Span {
    const span = startClientSpan("geode.connect", "CONNECT");
    if (!enabled) return span;
    span.setStringAttribute("server.address", host) catch {};
    span.setIntAttribute("server.port", @as(i64, port)) catch {};
    span.setStringAttribute("network.transport", @tagName(transport)) catch {};
    return span;
}

/// Start a span around a single `GeodeClient.query` call.
///
/// `statement` is the raw GQL text. `operation` is a short uppercase tag
/// — typically `"EXECUTE"`, but callers may pass `"EXPLAIN"` /
/// `"PROFILE"` for those entry points.
pub fn startQuerySpan(statement: []const u8, operation: []const u8) Span {
    const span = startClientSpan("geode.query", operation);
    if (!enabled) return span;
    span.setStringAttribute("db.query.text", statement) catch {};
    return span;
}

pub fn startBeginSpan() Span {
    return startClientSpan("geode.tx.begin", "BEGIN");
}

pub fn startCommitSpan() Span {
    return startClientSpan("geode.tx.commit", "COMMIT");
}

pub fn startRollbackSpan() Span {
    return startClientSpan("geode.tx.rollback", "ROLLBACK");
}

pub fn startPingSpan() Span {
    return startClientSpan("geode.ping", "PING");
}

/// Mark a span as failed. Pair with `defer span.end(null)` and
/// `errdefer markSpanError(span, "")` at the call site so the span is
/// always ended exactly once and the error status is recorded only on
/// the failing path. Description is intentionally `[]const u8` (not
/// optional) — callers pass `""` when they have no message; the otel
/// `setStatus` impl tolerates an empty description.
pub fn markSpanError(span: Span, description: []const u8) void {
    if (!enabled) return;
    span.setStatus(.@"error", description);
}

test "seam compiles in disabled build" {
    // When disabled, every helper returns a no-op Span and `end` is a
    // safe call. This test is the cheapest possible smoke for the
    // comptime gate — it does NOT exercise any otel state because the
    // disabled build does not link otel.
    const span = startQuerySpan("MATCH (n) RETURN n", "EXECUTE");
    defer span.end(null);
    markSpanError(span, "");
    try std.testing.expect(true);
}
