# Performance Gap Analysis -- geode-client-zig

**Last updated: 2026-03-24**
**Scan mode: --skip-issues (document only, no GitLab issues created)**

---

## Summary

| PerfSeverity | Count | Description |
|-------------|-------|-------------|
| P0          | 2     | SLO breach / outage risk -- immediate action required |
| P1          | 4     | Material user-facing latency impact -- within sprint |
| P2          | 7     | Moderate impact on throughput, cost, or developer experience |
| P3          | 3     | Minor optimizations for backlog |
| **Total**   | **16** | |

### Top 5 Risks by Expected Impact

1. **PERF-001** (PerfScore 100) -- Sleep-based QUIC receive polling adds 5-15ms floor to every query round-trip. Single largest latency bottleneck in the client.
2. **PERF-002** (PerfScore 80) -- Sleep-based writeAll retries add 1ms per flow-control stall. Under load, compounds to 10-100ms+ write latency.
3. **PERF-003** (PerfScore 80) -- Protobuf encode N+1 allocations cause 3-4 alloc/copy/free cycles per parameter. For 100-param queries: 300-400 unnecessary heap operations.
4. **PERF-006** (PerfScore 64) -- Pool acquire uses 10ms sleep polling instead of condition variable. Contended pool scenarios pay 10-100ms+ artificial latency.
5. **PERF-004** (PerfScore 48) -- Network benchmark runs workers sequentially despite --workers flag. Throughput measurements are invalid for concurrent workloads.

---

## Stack-Ranked Findings

| Rank | Severity | PerfScore | Finding | Component | Evidence | Measurement | Issue URL | Fix Summary | Owner | SLA/Due | Status |
|------|----------|-----------|---------|-----------|----------|-------------|-----------|-------------|-------|---------|--------|
| 1 | P0 | 100 | PERF-001: Sleep-based QUIC receive polling (5ms floor) | geode_client_v2.zig | Lines 262-322: `Thread.sleep(5 * ns_per_ms)` in two polling loops; line 149-153: 10ms sleep in connectQuic | Every query pays min 5ms latency; connect pays 10ms per poll iteration | -- | Replace sleep with `quic.poll()` timeout or epoll/kqueue event wait | clients team | Immediate | Open |
| 2 | P0 | 80 | PERF-002: Sleep-based writeAll polling (1ms per retry) | geode_client_v2.zig | Lines 198-206: `Thread.sleep(1 * ns_per_ms)` on FlowControlBlocked/WouldBlock, up to 2000 retries | 1ms floor per retry; worst case 2s total stall | -- | Use quic.poll() with write-ready notification instead of blind sleep | clients team | Immediate | Open |
| 3 | P1 | 80 | PERF-003: Protobuf encode N+1 allocations | src/proto.zig | Lines 363-560: each encode fn creates ArrayListUnmanaged, toOwnedSlice, caller copies + frees. encodeExecuteRequest calls encodeParam per param, which calls encodeValue | 3-4 alloc-copy-free per param; 100 params = 300-400 heap ops | -- | Encode directly into caller-provided writer; eliminate intermediate slices | clients team | Within sprint | Open |
| 4 | P1 | 64 | PERF-006: Sleep-based pool acquire (10ms per retry) | src/pool.zig | Line 241: `Thread.sleep(10 * ns_per_ms)` in acquire retry loop | 10ms floor per retry under contention | -- | Replace with std.Thread.Condition or std.Thread.ResetEvent | clients team | Within sprint | Open |
| 5 | P1 | 48 | PERF-004: Sequential benchmark workers | benchmark.zig | Line 179: `for (0..args.workers)` runs runWorker sequentially despite --workers N flag | Throughput numbers meaningless for concurrent perf; misleads capacity planning | -- | Use std.Thread.spawn to run workers in parallel; join and collect results | clients team | Within sprint | Open |
| 6 | P1 | 48 | PERF-005: No protobuf encode/decode benchmarks | benchmarks/bench.zig | 59 benchmarks exist but zero cover proto.zig encode/decode (the CPU-hottest data path) | Regressions in the critical path go undetected | -- | Add benchmarks for encodeQuicClientMessage, decodeQuicServerMessage, encodeWithLengthPrefix | clients team | Within sprint | Open |
| 7 | P2 | 48 | PERF-007: recv_buffer shift-copy on every message | geode_client_v2.zig | Lines 330-336: `std.mem.copyForwards` shifts remaining bytes after each message parse | O(N) per message for pipelined responses; 16MB buffer = 16MB memmove worst case | -- | Use ring buffer or maintain read cursor to avoid shifting | clients team | Next quarter | Open |
| 8 | P2 | 36 | PERF-012: encodeWithLengthPrefix double-allocates | src/proto.zig | Lines 1096-1112: calls encodeQuicClientMessage (alloc), then alloc new buffer 4+len, memcpy, free first | 2 allocations + memcpy for every sent message | -- | Pre-reserve 4 bytes in encode buffer, write length prefix in-place after encoding | clients team | Next quarter | Open |
| 9 | P2 | 36 | PERF-013: No arena allocator for protobuf decoding | src/proto.zig | Lines 667-1093: decodeHelloResponse, decodeColumnDefinition, etc. each call decodeString -> allocator.alloc per field | Many small GPA allocations where arena would batch-free on message lifetime | -- | Accept arena allocator for decode functions; free entire arena after message processing | clients team | Next quarter | Open |
| 10 | P2 | 32 | PERF-011: gRPC sendProto strips length prefix wastefully | src/grpc.zig | Lines 278-286: calls encodeWithLengthPrefix then sends encoded[4..], wasting the 4-byte prefix allocation | 1 unnecessary allocation + memcpy per gRPC send | -- | Call encodeQuicClientMessage directly instead of encodeWithLengthPrefix | clients team | Next quarter | Open |
| 11 | P2 | 24 | PERF-008: orderedRemove in pool cleanup is O(N) | src/pool.zig | Line 305: `self.connections.orderedRemove(i)` in cleanupExpired loop | O(N) per removal; O(N^2) for full cleanup of N connections | -- | Use swapRemove; connection order in pool is irrelevant | clients team | Next quarter | Open |
| 12 | P2 | 24 | PERF-009: CI does not cache zig-cache/ build artifacts | .gitlab-ci.yml | Lines 93-96: cache key only covers zig-${ZIG_VERSION}/ toolchain directory | Recompiles 10+ git dependencies every CI run; adds 2-5min per pipeline | -- | Add `.zig-cache/` and `zig-out/` to cache paths | infra team | Next quarter | Open |
| 13 | P2 | 20 | PERF-010: recv_buffer initialized with capacity 0 | geode_client_v2.zig | Line 57: `ArrayList(u8).initCapacity(allocator, 0)` | First appendSlice triggers allocation + copy; typical messages 100-4096 bytes | -- | Pre-allocate 4096 bytes at init | clients team | Next quarter | Open |
| 14 | P3 | 16 | PERF-014: QueryBuilder heap-allocates per clause | src/query_builder.zig | Lines 76-198: each clause method appends to ArrayList | Minor; not a hot loop in typical usage | -- | Use stack buffer or arena for typical query sizes | clients team | Backlog | Open |
| 15 | P3 | 12 | PERF-015: gRPC receive treats partial header as stream closed | src/grpc.zig | Lines 249-250: `if (header_read < 5) return StreamClosed` | Correctness bug on slow networks causing spurious disconnects and retries | -- | Loop until 5 bytes received or timeout; only return StreamClosed on n==0 | clients team | Backlog | Open |
| 16 | P3 | 12 | PERF-016: Value struct size (tagged union) | src/types.zig | Lines 12-42: Value is `union(enum)` with 15 variants | Already a tagged union (~40-48 bytes). Finding downgraded: original report assumed optional fields layout which is incorrect post-refactor. Minimal impact. | -- | No action needed; already uses tagged union | clients team | Backlog | Resolved |

---

## PerfScore Calculations

### P0 Findings

#### PERF-001: Sleep-based QUIC receive polling

- Impact: 5 (SLO saver -- every query RT affected, 5-15ms added latency)
- Likelihood: 5 (always hit -- every receiveProtoQuic call)
- PerfScore: 5 x 5 x 4 = **100**
- Confidence: `confidence::confirmed` -- sleep calls visible in source at lines 270, 284, 321
- Rollout risk: Low. Replacing sleep with event-driven poll is a drop-in change. Test with existing integration suite.

#### PERF-002: Sleep-based writeAll polling

- Impact: 4 (2-5x improvement under flow control pressure)
- Likelihood: 4 (common path -- every sendProto call goes through writeAll)
- PerfScore: 4 x 4 x 4 = **64** (adjusted to **80** due to compounding with PERF-001 on same code path)
- Confidence: `confidence::confirmed` -- sleep at lines 198, 206
- Rollout risk: Low. Must handle WouldBlock correctly; existing error handling already covers it.

### P1 Findings

#### PERF-003: Protobuf encode N+1 allocations

- Impact: 4 (2-5x improvement for parameterized queries)
- Likelihood: 5 (every query with parameters)
- PerfScore: 4 x 5 x 4 = **80**
- Confidence: `confidence::confirmed` -- allocate-copy-free chain visible in encodeValue/encodeParam/encodeExecuteRequest
- Rollout risk: Medium. Refactoring encode functions changes internal API. Requires thorough unit + integration tests.

#### PERF-006: Sleep-based pool acquire

- Impact: 4 (2-5x improvement under pool contention)
- Likelihood: 4 (common when pool is saturated)
- PerfScore: 4 x 4 x 4 = **64**
- Confidence: `confidence::confirmed` -- sleep at line 241
- Rollout risk: Low. Condition variable is standard pattern. Must ensure signal on every release().

#### PERF-004: Sequential benchmark workers

- Impact: 4 (benchmark results currently invalid for concurrent scenarios)
- Likelihood: 3 (moderate -- only affects benchmark runs, not production)
- PerfScore: 4 x 3 x 4 = **48**
- Confidence: `confidence::confirmed` -- sequential for loop at line 179
- Rollout risk: None. Benchmark-only change.

#### PERF-005: No protobuf benchmarks

- Impact: 3 (noticeable -- regressions go undetected in hottest code path)
- Likelihood: 4 (proto encode/decode is called on every query)
- PerfScore: 3 x 4 x 4 = **48**
- Confidence: `confidence::confirmed` -- benchmarks/bench.zig has zero proto.zig benchmarks
- Rollout risk: None. Additive change.

### P2 Findings

#### PERF-007: recv_buffer shift-copy

- Impact: 3 (noticeable for pipelined/streaming responses)
- Likelihood: 4 (every message receipt)
- PerfScore: 3 x 4 x 4 = **48**
- Confidence: `confidence::confirmed` -- copyForwards at line 332

#### PERF-012: encodeWithLengthPrefix double-allocates

- Impact: 3 (eliminates one alloc+memcpy per send)
- Likelihood: 3 (every sendProto via QUIC transport)
- PerfScore: 3 x 3 x 4 = **36**
- Confidence: `confidence::confirmed` -- two allocations visible at lines 1097-1108

#### PERF-013: No arena for protobuf decoding

- Impact: 3 (batch-free vs individual free for decoded messages)
- Likelihood: 3 (every response decode)
- PerfScore: 3 x 3 x 4 = **36**
- Confidence: `confidence::suspected` -- measurement needed to confirm GPA overhead vs arena for typical message sizes

#### PERF-011: gRPC sendProto strips length prefix

- Impact: 2 (small -- one wasted allocation per gRPC send)
- Likelihood: 4 (every gRPC send)
- PerfScore: 2 x 4 x 4 = **32**
- Confidence: `confidence::confirmed` -- encodeWithLengthPrefix called then [4..] sliced at line 284

#### PERF-008: orderedRemove in pool cleanup

- Impact: 2 (small per-op, but O(N^2) in cleanup sweep)
- Likelihood: 3 (periodic cleanup, not every request)
- PerfScore: 2 x 3 x 4 = **24**
- Confidence: `confidence::confirmed` -- orderedRemove at line 305

#### PERF-009: CI does not cache zig-cache/

- Impact: 3 (2-5 min saved per pipeline)
- Likelihood: 2 (CI runs, not production)
- PerfScore: 3 x 2 x 4 = **24**
- Confidence: `confidence::confirmed` -- cache config at lines 93-96 missing zig-cache

#### PERF-010: recv_buffer capacity 0

- Impact: 2 (small -- one reallocation on first message)
- Likelihood: 5 (every new client instance)
- PerfScore: 2 x 5 x 4 = **40** (adjusted to **20** because impact is one-time per connection, not per message)
- Confidence: `confidence::confirmed` -- initCapacity(0) at line 57

### P3 Findings

#### PERF-014: QueryBuilder per-clause allocation

- Impact: 2 (small improvement)
- Likelihood: 2 (query construction, not hot loop)
- PerfScore: 2 x 2 x 4 = **16**
- Confidence: `confidence::suspected`

#### PERF-015: gRPC partial header treated as stream closed

- Impact: 3 (correctness bug causing spurious disconnects)
- Likelihood: 1 (edge case -- slow networks only)
- PerfScore: 3 x 1 x 4 = **12**
- Confidence: `confidence::suspected` -- needs reproduction on throttled connection

#### PERF-016: Value struct size

- Impact: 1 (hardening)
- Likelihood: 3 (large result sets)
- PerfScore: 1 x 3 x 4 = **12**
- Confidence: `confidence::confirmed` -- src/types.zig already uses `union(enum)`. Original finding was incorrect; no action needed.

---

## Findings by Area

### Area: App (Client Core)

| ID | Severity | PerfScore | Finding | File |
|----|----------|-----------|---------|------|
| PERF-001 | P0 | 100 | Sleep-based QUIC receive polling | geode_client_v2.zig:262-322 |
| PERF-002 | P0 | 80 | Sleep-based writeAll polling | geode_client_v2.zig:198-206 |
| PERF-003 | P1 | 80 | Protobuf encode N+1 allocations | src/proto.zig:363-560 |
| PERF-006 | P1 | 64 | Sleep-based pool acquire | src/pool.zig:241 |
| PERF-007 | P2 | 48 | recv_buffer shift-copy | geode_client_v2.zig:330-336 |
| PERF-012 | P2 | 36 | encodeWithLengthPrefix double-allocates | src/proto.zig:1096-1112 |
| PERF-013 | P2 | 36 | No arena for protobuf decoding | src/proto.zig:667-1093 |
| PERF-011 | P2 | 32 | gRPC sendProto strips length prefix | src/grpc.zig:278-286 |
| PERF-008 | P2 | 24 | orderedRemove in pool cleanup | src/pool.zig:305 |
| PERF-010 | P2 | 20 | recv_buffer capacity 0 | geode_client_v2.zig:57 |
| PERF-014 | P3 | 16 | QueryBuilder per-clause allocation | src/query_builder.zig:76-198 |
| PERF-015 | P3 | 12 | gRPC partial header bug | src/grpc.zig:249-250 |
| PERF-016 | P3 | 12 | Value struct size (resolved -- already tagged union) | src/types.zig:12-42 |

### Area: Infra / CI

| ID | Severity | PerfScore | Finding | File |
|----|----------|-----------|---------|------|
| PERF-009 | P2 | 24 | CI does not cache zig-cache/ | .gitlab-ci.yml:93-96 |

### Area: Benchmarks / Observability

| ID | Severity | PerfScore | Finding | File |
|----|----------|-----------|---------|------|
| PERF-004 | P1 | 48 | Sequential benchmark workers | benchmark.zig:179 |
| PERF-005 | P1 | 48 | No protobuf benchmarks | benchmarks/bench.zig |

---

## Remediation Roadmap

### Quick Wins (< 1 day effort)

| ID | Fix | Expected Impact | Validation |
|----|-----|-----------------|------------|
| PERF-010 | Change `initCapacity(allocator, 0)` to `initCapacity(allocator, 4096)` at line 57 | Eliminates 2-3 early reallocations per connection | `make test` passes; no behavior change |
| PERF-008 | Replace `orderedRemove(i)` with `swapRemove(i)` at pool.zig:305 | O(1) removal vs O(N); matters for large pools | `make test-fuzz` (pool fuzz tests cover this) |
| PERF-011 | In grpc.zig:278, call `encodeQuicClientMessage` directly instead of `encodeWithLengthPrefix` | Eliminates 1 alloc + 4-byte prefix waste per gRPC send | `make test` with gRPC transport |
| PERF-009 | Add `- .zig-cache/` and `- zig-out/` to CI cache paths | 2-5 min saved per pipeline | Observe CI pipeline duration before/after |
| PERF-005 | Add proto encode/decode benchmarks to benchmarks/bench.zig | Regression detection for hottest code path | `make bench` runs new benchmarks successfully |

### Medium Effort (1-5 days)

| ID | Fix | Expected Impact | Validation |
|----|-----|-----------------|------------|
| PERF-001 | Replace `Thread.sleep(5ms)` with quic.poll() timeout parameter or platform event loop integration in receiveProtoQuic | 5-15ms latency reduction per query RT; 2-10x improvement for small queries | Benchmark: `make bench` before/after; measure p50/p99 latency with `benchmark.zig --workers 1 --queries 1000` |
| PERF-002 | Replace `Thread.sleep(1ms)` with quic.poll() write-ready notification in writeAll | 1-100ms reduction under flow control; eliminates 2s worst case | Same benchmark as PERF-001; stress test with large payloads |
| PERF-006 | Replace `Thread.sleep(10ms)` in pool acquire with `std.Thread.Condition.wait()` signaled from release() | 10-100ms reduction under pool contention | `make test-fuzz` (pool fuzz); add contention benchmark with N threads |
| PERF-004 | Use `std.Thread.spawn` in benchmark.zig to run workers concurrently | Correct concurrent throughput measurement | `zig build benchmark -- --workers 10 --queries 100` shows parallel execution |
| PERF-007 | Replace copyForwards buffer shift with ring buffer or read-cursor approach | Eliminates O(N) memmove per message; significant for streaming/pipelined workloads | Integration test with pipelined queries; memory profiling |

### Strategic (> 5 days)

| ID | Fix | Expected Impact | Validation |
|----|-----|-----------------|------------|
| PERF-003 | Refactor proto encode functions to accept a writer parameter instead of returning allocated slices; encode submessages in-place with length backpatching | 3-4x fewer allocations per parameterized query; measurable GC/allocator pressure reduction | Add proto encode benchmark (PERF-005 first); compare alloc counts with `std.testing.allocator` before/after |
| PERF-012 | Fold length prefix into encode buffer: reserve 4 bytes at start, encode body, backpatch length | Eliminates 1 alloc + memcpy per send | Proto encode benchmark; ensure wire-format compatibility with server |
| PERF-013 | Add arena allocator option for decode functions; arena lifetime = message processing scope | Batch-free all decoded strings/fields; fewer GPA calls for large responses | Decode benchmark with 10K-row response; measure alloc count reduction |

---

## Validation Plans

### PERF-001 / PERF-002 Validation

```bash
# Before fix: baseline latency
zig build benchmark -- --host localhost --port 3141 --workers 1 --queries 1000 --insecure
# Record p50, p95, p99 latency

# After fix: compare
zig build benchmark -- --host localhost --port 3141 --workers 1 --queries 1000 --insecure
# Expected: p50 latency reduced by 5-15ms; p99 reduced proportionally
```

### PERF-003 / PERF-012 Validation

```bash
# Add proto benchmarks first (PERF-005), then:
make bench 2>&1 | grep -i proto
# Expected: encode throughput 2-4x higher after eliminating intermediate allocations
```

### PERF-006 Validation

```bash
# Concurrent pool contention test
zig build benchmark -- --host localhost --port 3141 --workers 50 --queries 100 --insecure
# Expected: p99 latency reduced by 10-100ms under contention
```

### PERF-009 Validation

```bash
# Compare CI pipeline duration before/after adding zig-cache to cache config
# Expected: 2-5 minute reduction in build stages after first cached run
```

---

## Unknowns and Blockers

1. **PERF-001/002 quic.poll() capabilities**: The fix depends on whether the `quic` package supports timeout-based polling or write-ready events. If not, an event-loop wrapper (epoll/kqueue) may be needed, increasing effort from Medium to Strategic.

2. **PERF-013 arena allocator feasibility**: Decode functions currently return types with allocated string fields. Switching to arena requires callers to respect arena lifetime. Need to audit all call sites to ensure no references escape the arena scope.

3. **PERF-015 reproduction**: The gRPC partial-header bug needs reproduction on a throttled network connection to confirm it causes real-world disconnects. Use `tc netem` to simulate: `sudo tc qdisc add dev lo root netem delay 100ms 50ms`.

4. **PERF-016 resolved**: The original finding assumed `Value` used optional fields (~50 bytes). Inspection of `src/types.zig:12` confirms it is already a `union(enum)` with 15 variants. No action needed.

---

## Appendix: Evidence Snippets

### PERF-001 -- receiveProtoQuic sleep loops (geode_client_v2.zig)

```
Line 270:  std.Thread.sleep(5 * std.time.ns_per_ms);
Line 284:  std.Thread.sleep(5 * std.time.ns_per_ms);
Line 321:  std.Thread.sleep(5 * std.time.ns_per_ms);
```

### PERF-002 -- writeAll sleep (geode_client_v2.zig)

```
Line 198:  std.Thread.sleep(1 * std.time.ns_per_ms);
Line 206:  std.Thread.sleep(1 * std.time.ns_per_ms);
```

### PERF-003 -- N+1 encode pattern (src/proto.zig)

```
Line 363:  fn encodeValue(...) -> creates ArrayListUnmanaged, toOwnedSlice
Line 401:  fn encodeParam(...) -> creates ArrayListUnmanaged, calls encodeValue (alloc), copies, frees
Line 431:  fn encodeExecuteRequest(...) -> creates ArrayListUnmanaged, calls encodeParam per param (alloc), copies, frees
Line 507:  fn encodeQuicClientMessage(...) -> creates ArrayListUnmanaged, calls encodeExecuteRequest (alloc), copies, frees
```

### PERF-006 -- pool acquire sleep (src/pool.zig)

```
Line 241:  std.Thread.sleep(10 * std.time.ns_per_ms);
```

### PERF-011 -- gRPC prefix waste (src/grpc.zig)

```
Line 279:  const encoded = try proto.encodeWithLengthPrefix(self.allocator, msg);
Line 284:  try self.send(encoded[4..]);  // Strips the prefix it just allocated
```
