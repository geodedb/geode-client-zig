# Quality Gap Analysis -- geode-client-zig

**Last updated:** 2026-03-24
**Repository:** gitlab.com/devnw/codepros/geode/geode-client-zig
**Scope:** Full codebase quality scan (16 findings)
**Mode:** --skip-issues (document only, no GitLab issues created)

---

## Summary

| Severity | Count |
|----------|-------|
| Critical | 0     |
| High     | 2     |
| Medium   | 7     |
| Low      | 5     |
| Info     | 0     |
| **Total** | **16** |

### Top 5 Risks

1. **Q-001** -- `build.zig.zon` paths omit `src/` directory, making the package unusable as a Zig dependency.
2. **Q-002** -- `sendHello` leaks `session_id` allocation on repeated calls in both `GeodeClient` and `GrpcClient`.
3. **Q-003** -- Response objects from `receiveProto` are never deinitialized across 7 call sites, leaking memory on every RPC.
4. **Q-005** -- `GrpcClient.query` discards all query results and returns a hardcoded `"OK"` string.
5. **Q-006** -- `Config.withCredentials` overwrites allocated credential strings without freeing the previous allocation.

---

## Stack-Ranked Findings

Sorted by PriorityScore descending. PriorityScore = Impact(1-5) x Likelihood(1-5) x 4.

| Rank | ID | Severity | PriorityScore | Category | Finding | Component | Evidence | Issue URL | Fix Summary | Owner | ETA/SLA | Status |
|------|----|----------|---------------|----------|---------|-----------|----------|-----------|-------------|-------|---------|--------|
| 1 | Q-001 | High | 80 | build | `build.zig.zon` paths missing `src/` directory | build.zig.zon:6-13 | `paths` lists only 6 entries; `src/` absent | -- | Add `"src"` to the `paths` array | TBD (git blame) | < 1 day | Open |
| 2 | Q-002 | High | 80 | memory | `sendHello` leaks session_id on repeated calls | geode_client_v2.zig:382, src/grpc.zig:314 | `self.session_id = try self.allocator.dupe(...)` overwrites without freeing prior value | -- | Free existing session_id before overwriting | TBD | < 1 day | Open |
| 3 | Q-003 | Medium | 60 | memory | Response objects not deinitialized (7 locations) | geode_client_v2.zig:377,416,469,485,502,519; src/grpc.zig:310 | `receiveProto()` returns owned response; callers never call `.deinit()` | -- | Add `defer response.deinit()` at each call site | TBD | 1-2 days | Open |
| 4 | Q-005 | Medium | 60 | implementation | `GrpcClient.query` discards results, returns "OK" | src/grpc.zig:343 | `return try self.allocator.dupe(u8, "OK");` ignores `exec_resp` payload | -- | Parse and return actual query results from `exec_resp` | TBD | 1-2 days | Open |
| 5 | Q-006 | Medium | 48 | memory | `Config.withCredentials` leaks on repeated calls | src/config.zig:139-142 | `self.username = try allocator.dupe(...)` overwrites without freeing old value | -- | Free previous username/password before overwriting | TBD | < 1 day | Open |
| 6 | Q-008 | Medium | 48 | build | 8 unused external dependency imports in build.zig | build.zig:213-222 | `json`, `dns`, `ext_config`, `slog`, `uri`, `strings`, `protobuf`, `grpc_zig`, `spice` added to geode_client_mod but never `@import`-ed in geode_client_v2.zig | -- | Partially resolved (2026-04-16): `spice` removed entirely (commit e89279b); `concurrency` wrapper replaced by direct `thread_pool` (commit 2877c94). Remaining unused imports (`json`, `dns`, `ext_config`, `slog`, `uri`, `strings`, `protobuf`, `grpc_zig`) stay as a follow-up. | clients team | < 1 day | Partially Resolved |
| 7 | Q-007 | Medium | 36 | complexity | proto.zig exceeds 800-line limit (1,273 LOC) | src/proto.zig | `wc -l` = 1273; contains duplicated encode/decode patterns | -- | Extract transaction, schema, and message encoding into sub-modules | TBD | 2-3 days | Open |
| 8 | Q-009 | Medium | 36 | build | Duplicate system library linking blocks (5x) | build.zig:271-281, 298-309, 513-520, 543-553, 603-614 | 5 near-identical `linkLibC`/`linkSystemLibrary` blocks | -- | Extract a helper function `linkQuicSystemLibs(exe, target)` | TBD | < 1 day | Open |
| 9 | Q-004 | Medium | 36 | docs | CLAUDE.md references deleted `src/protocol.zig` | CLAUDE.md (Wire Protocol section) | Documents `protocol.buildHello`, `protocol.buildRunGql`, etc.; actual impl is `src/proto.zig` with protobuf | -- | Update CLAUDE.md to reflect protobuf/gRPC architecture | TBD | < 1 day | Open |
| 10 | Q-010 | Medium | 32 | dead-code | `proto/schema.zig` unreferenced (381 LOC dead code) | src/proto/schema.zig (does not exist on disk) | Finding references 381 LOC; directory `src/proto/` absent -- likely deleted but finding may be stale | -- | Confirm removal or re-integrate if needed | TBD | < 1 day | Open |
| 11 | Q-014 | Low | 24 | code-quality | `@constCast` + `@memset` zeroing may be elided by optimizer | src/config.zig:206,226; src/auth.zig:212,393,410 | `@memset(@constCast(pass), 0)` -- optimizer may remove dead store | -- | Replace with `std.crypto.utils.secureZero` | TBD | < 1 day | Open |
| 12 | Q-011 | Low | 16 | duplication | 4 duplicated bool response decoders in proto.zig | src/proto.zig:987,1002,1017,1032 | `decodeCommitResponse`, `decodeRollbackResponse`, `decodeSavepointResponse`, `decodeRollbackToResponse` are identical | -- | Extract generic `decodeBoolResponse` and alias | TBD | < 1 day | Open |
| 13 | Q-012 | Low | 16 | duplication | 4 duplicated single-string request encoders in proto.zig | src/proto.zig:472,480,488,497 | `encodeCommitRequest`, `encodeRollbackRequest`, `encodeSavepointRequest`, `encodeRollbackToRequest` near-identical | -- | Extract generic `encodeSingleStringRequest` and alias | TBD | < 1 day | Open |
| 14 | Q-013 | Low | 12 | dead-code | Unused allocator params in proto.zig | src/proto.zig:59-62, 458-461 | `ExecuteRequest.init` and `encodePingRequest` accept `allocator` then `_ = allocator;` | -- | Remove unused parameter or mark `_: std.mem.Allocator` | TBD | < 1 day | Open |
| 15 | Q-015 | Low | 12 | ci-cd | CI integration test always waits full 60s | .gitlab-ci.yml:227-234 | `while [ $ELAPSED -lt $STARTUP_TIMEOUT ]; do sleep 1` loop never checks service readiness, always runs to completion | -- | Poll a health endpoint and break on success | TBD | < 1 day | Open |
| 16 | Q-016 | Low | 8 | ci-cd | zig-format CI stage allows failure | .gitlab-ci.yml:50 | `allow_failure: true` makes format check advisory-only | -- | Remove `allow_failure: true` to enforce formatting | TBD | < 1 day | Open |

---

## Findings by Category

### Build (Q-001, Q-008, Q-009)

#### Q-001: build.zig.zon paths missing src/ directory

- **Severity:** High | **PriorityScore:** 80 | **Confidence:** confirmed
- **Summary:** The `paths` field in `build.zig.zon` only lists `build.zig`, `build.zig.zon`, `geode_client_v2.zig`, test files, and `LICENSE`. The entire `src/` directory containing all core modules is omitted.
- **Why it matters:** Any consumer that depends on this package via the Zig package manager will get a tarball without `src/`, causing build failures. This blocks the library from being usable as a dependency.
- **Evidence:** `build.zig.zon:6-13`:

  ```zig
  .paths = .{
      "build.zig",
      "build.zig.zon",
      "geode_client_v2.zig",
      "test_connection.zig",
      "test_connection_v2.zig",
      "LICENSE",
  },
  ```

- **Root cause:** The `src/` directory was likely not included when the paths list was initially authored; test files were included but source modules were not.
- **Recommended change:** Add `"src"` to the `paths` array.
- **Acceptance criteria:** `zig fetch` of this package includes all `src/*.zig` files; downstream `@import` of any module resolves.
- **Verification:** Add the package as a dependency in a fresh project and run `zig build`.
- **Effort:** S

#### Q-008: 8 unused external dependency imports in build.zig

- **Severity:** Medium | **PriorityScore:** 48 | **Confidence:** confirmed
- **Summary:** `build.zig:213-222` registers `json`, `dns`, `ext_config`, `slog`, `uri`, `strings`, `protobuf`, `grpc_zig`, and `spice` as imports on `geode_client_mod`, but `geode_client_v2.zig` never `@import`s any of them.
- **Why it matters:** Increases build time, dependency surface, and confusion about actual module dependencies.
- **Root cause:** Dependencies were added speculatively during development and never cleaned up.
- **Recommended change:** Remove the unused `addImport` calls, or add actual usage if these are intended for future use.
- **Effort:** S

#### Q-009: Duplicate system library linking blocks (5x)

- **Severity:** Medium | **PriorityScore:** 36 | **Confidence:** confirmed
- **Summary:** Five near-identical code blocks in `build.zig` (lines 271-281, 298-309, 513-520, 543-553, 603-614) repeat the same `linkLibC` / `linkSystemLibrary("ssl")` / `linkSystemLibrary("crypto")` / `linkSystemLibrary("dl")` pattern.
- **Why it matters:** Maintenance burden; if a new system library is needed, it must be added in 5 places.
- **Recommended change:** Extract a helper `fn linkQuicSystemLibs(step: *std.Build.Step.Compile, target: std.Build.ResolvedTarget) void`.
- **Effort:** S

### Memory (Q-002, Q-003, Q-006)

#### Q-002: sendHello leaks session_id on repeated calls

- **Severity:** High | **PriorityScore:** 80 | **Confidence:** confirmed
- **Summary:** Both `GeodeClient.sendHello()` (geode_client_v2.zig:382) and `GrpcClient.hello()` (src/grpc.zig:314) overwrite `self.session_id` with a new `allocator.dupe` without freeing the previous allocation.
- **Why it matters:** Every reconnection leaks the previous session_id allocation. In long-running services with reconnect logic, this is a steady memory leak.
- **Evidence:** `geode_client_v2.zig:381-382`:

  ```zig
  if (hello.session_id.len > 0) {
      self.session_id = try self.allocator.dupe(u8, hello.session_id);
  }
  ```

  No prior `self.allocator.free(self.session_id)` exists.
- **Root cause:** Ownership tracking was not implemented for the session_id field.
- **Recommended change:** Before overwriting, free the old value: `if (self.session_id) |old| self.allocator.free(old);`
- **Acceptance criteria:** Repeated `sendHello` calls do not leak; valgrind / `std.testing.allocator` reports no leaks.
- **Verification:** Write a test calling `sendHello` twice and run under `std.testing.allocator`.
- **Effort:** S

#### Q-003: Response objects not deinitialized (7 locations)

- **Severity:** Medium | **PriorityScore:** 60 | **Confidence:** confirmed
- **Summary:** `receiveProto()` returns a `QuicServerMessage` that owns allocated memory. Seven call sites never call `.deinit()` on the response.
- **Affected paths:**
  - `geode_client_v2.zig:377` (sendHello)
  - `geode_client_v2.zig:416` (query)
  - `geode_client_v2.zig:469` (begin)
  - `geode_client_v2.zig:485` (commit)
  - `geode_client_v2.zig:502` (rollback)
  - `geode_client_v2.zig:519` (ping)
  - `src/grpc.zig:310` (hello)
- **Recommended change:** Add `defer response.deinit(self.allocator);` immediately after each `receiveProto()` call, or restructure to use RAII.
- **Effort:** M (7 sites, each needs careful review of what fields are borrowed vs. owned)

#### Q-006: Config.withCredentials leaks on repeated calls

- **Severity:** Medium | **PriorityScore:** 48 | **Confidence:** confirmed
- **Summary:** `src/config.zig:139-142` allocates new copies of username/password but does not free any previously set values.
- **Evidence:**

  ```zig
  pub fn withCredentials(self: *Config, allocator: std.mem.Allocator, username: []const u8, password: []const u8) !*Config {
      self.username = try allocator.dupe(u8, username);
      self.password = try allocator.dupe(u8, password);
      return self;
  }
  ```

- **Root cause:** The builder pattern does not account for being called more than once.
- **Recommended change:** Free previous values (with secure zeroing for password) before overwriting.
- **Effort:** S

### Implementation (Q-005)

#### Q-005: GrpcClient.query returns "OK" discarding results

- **Severity:** Medium | **PriorityScore:** 60 | **Confidence:** confirmed
- **Summary:** `src/grpc.zig:343` returns a hardcoded `"OK"` string, completely ignoring the actual query execution response payload.
- **Evidence:**

  ```zig
  if (exec_resp.err) |err| {
      _ = err;
      return error.QueryFailed;
  }
  // Return success indicator
  return try self.allocator.dupe(u8, "OK");
  ```

- **Why it matters:** The gRPC client is unusable for any real query workload since results are discarded.
- **Root cause:** Appears to be a stub/placeholder that was never completed.
- **Recommended change:** Parse `exec_resp` schema and page data into a proper result type (similar to `GeodeClient.parseExecutionResponse`).
- **Effort:** M

### Complexity / Duplication (Q-007, Q-011, Q-012)

#### Q-007: proto.zig exceeds 800-line limit (1,273 LOC)

- **Severity:** Medium | **PriorityScore:** 36 | **Confidence:** confirmed
- **Summary:** `src/proto.zig` is the largest module at 1,273 lines and contains repeated encode/decode patterns for transaction messages.
- **Recommended change:** Extract into `src/proto/messages.zig`, `src/proto/transactions.zig`, `src/proto/encoding.zig`.
- **Effort:** M

#### Q-011: 4 duplicated bool response decoders

- **Severity:** Low | **PriorityScore:** 16 | **Confidence:** confirmed
- **Summary:** `decodeCommitResponse`, `decodeRollbackResponse`, `decodeSavepointResponse`, `decodeRollbackToResponse` at lines 987, 1002, 1017, 1032 are structurally identical.
- **Recommended change:** Extract `fn decodeBoolResponse(comptime T: type, data: []const u8) !T`.
- **Effort:** S

#### Q-012: 4 duplicated single-string request encoders

- **Severity:** Low | **PriorityScore:** 16 | **Confidence:** confirmed
- **Summary:** `encodeCommitRequest`, `encodeRollbackRequest`, `encodeSavepointRequest`, `encodeRollbackToRequest` at lines 472, 480, 488, 497 are near-identical.
- **Recommended change:** Extract `fn encodeSingleFieldRequest(comptime T: type, allocator, req: T) ![]u8`.
- **Effort:** S

### Dead Code (Q-010, Q-013)

#### Q-010: proto/schema.zig unreferenced (381 LOC dead code)

- **Severity:** Medium | **PriorityScore:** 32 | **Confidence:** suspected
- **Summary:** Finding references a 381-line `proto/schema.zig` file. However, the `src/proto/` directory does not exist on disk. This finding may be stale or the file may have been deleted in a prior commit.
- **What would confirm:** Check git log for deletion of `src/proto/schema.zig`. If it was deleted, this finding can be closed. If it exists elsewhere, it should be removed or integrated.
- **Effort:** S

#### Q-013: Unused allocator parameters in proto.zig

- **Severity:** Low | **PriorityScore:** 12 | **Confidence:** confirmed
- **Summary:** `ExecuteRequest.init` (line 59-62) and `encodePingRequest` (line 458-461) accept an `allocator` parameter but immediately discard it with `_ = allocator;`.
- **Recommended change:** Remove the unused parameter or use `_: std.mem.Allocator` in the signature.
- **Effort:** S

### Documentation (Q-004)

#### Q-004: CLAUDE.md references deleted src/protocol.zig

- **Severity:** Medium | **PriorityScore:** 36 | **Confidence:** confirmed
- **Summary:** CLAUDE.md Wire Protocol section documents a JSON line protocol via `src/protocol.zig` with functions like `protocol.buildHello`, `protocol.buildRunGql`, etc. The actual implementation uses protobuf via `src/proto.zig` and gRPC via `src/grpc.zig`.
- **Why it matters:** Misleads contributors and AI agents about the actual architecture.
- **Recommended change:** Rewrite the Wire Protocol and Protocol Module sections to document the actual protobuf/gRPC implementation.
- **Effort:** M

### Code Quality / Security (Q-014)

#### Q-014: @constCast + @memset zeroing may be elided by optimizer

- **Severity:** Low | **PriorityScore:** 24 | **Confidence:** confirmed
- **Summary:** 5 locations use `@memset(@constCast(ptr), 0)` to zero sensitive data (passwords, tokens, keys). The Zig/LLVM optimizer may elide these stores as dead writes since the memory is freed immediately after.
- **Affected paths:**
  - `src/config.zig:206` (password zeroing)
  - `src/config.zig:226` (client_key zeroing)
  - `src/auth.zig:212` (token zeroing)
  - `src/auth.zig:393` (old token zeroing)
  - `src/auth.zig:410` (token zeroing)
- **Recommended change:** Replace `@memset(@constCast(ptr), 0)` with `std.crypto.utils.secureZero(u8, @constCast(ptr))` which uses a volatile write guaranteed not to be elided.
- **Verification:** Inspect disassembly of `deinit` in ReleaseFast to confirm zeroing is present.
- **Effort:** S

### CI/CD (Q-015, Q-016)

#### Q-015: CI integration test always waits full 60s

- **Severity:** Low | **PriorityScore:** 12 | **Confidence:** confirmed
- **Summary:** `.gitlab-ci.yml:227-234` runs a wait loop that always sleeps for the full `STARTUP_TIMEOUT` (60s) without ever checking if the Geode service is ready.
- **Evidence:**

  ```yaml
  while [ $ELAPSED -lt $STARTUP_TIMEOUT ]; do
    sleep 1
    ELAPSED=$((ELAPSED + 1))
  done
  echo "Service should be ready"
  ```

- **Recommended change:** Poll the health endpoint (e.g., attempt a TCP connection to `geode:$SERVICE_PORT`) and break out of the loop on success.
- **Effort:** S

#### Q-016: zig-format CI stage allows failure

- **Severity:** Low | **PriorityScore:** 8 | **Confidence:** confirmed
- **Summary:** `.gitlab-ci.yml:50` sets `allow_failure: true` on the format check, making it purely advisory.
- **Recommended change:** Remove `allow_failure: true` so unformatted code blocks the pipeline.
- **Effort:** S

---

## Remediation Roadmap

### Quick Wins (< 1 day, effort S)

| ID | Finding | PriorityScore |
|----|---------|---------------|
| Q-001 | Add `"src"` to `build.zig.zon` paths | 80 |
| Q-002 | Free old session_id before overwriting | 80 |
| Q-006 | Free old credentials in `withCredentials` | 48 |
| Q-008 | Remove 8 unused dependency imports from build.zig | 48 |
| Q-009 | Extract helper for system library linking | 36 |
| Q-014 | Replace `@memset(@constCast(...), 0)` with `secureZero` | 24 |
| Q-011 | Deduplicate 4 bool response decoders | 16 |
| Q-012 | Deduplicate 4 string request encoders | 16 |
| Q-013 | Remove unused allocator params | 12 |
| Q-015 | Add health-check polling to CI wait loop | 12 |
| Q-016 | Remove `allow_failure` from format check | 8 |
| Q-010 | Confirm proto/schema.zig removal (investigate) | 32 |

### Medium (1-5 days, effort M)

| ID | Finding | PriorityScore |
|----|---------|---------------|
| Q-003 | Add `defer response.deinit()` at 7 call sites | 60 |
| Q-005 | Implement actual result parsing in `GrpcClient.query` | 60 |
| Q-004 | Rewrite CLAUDE.md protocol documentation | 36 |
| Q-007 | Split proto.zig into sub-modules | 36 |

### Strategic (> 5 days)

No findings currently require strategic-level effort.

---

## Scoring Methodology

Each finding is scored using:

```
PriorityScore = Impact(1-5) x Likelihood(1-5) x 4
```

| ID | Impact | Likelihood | PriorityScore | Rationale |
|----|--------|------------|---------------|-----------|
| Q-001 | 5 (blocks dependency usage) | 4 (any consumer hits it) | 80 | Package is broken as a dependency |
| Q-002 | 4 (steady memory leak) | 5 (every reconnection) | 80 | Long-running services accumulate leaked allocations |
| Q-003 | 3 (memory leak per RPC) | 5 (every RPC call) | 60 | Every operation leaks response memory |
| Q-005 | 5 (feature non-functional) | 3 (gRPC path only) | 60 | gRPC query path is completely broken |
| Q-006 | 3 (memory leak) | 4 (config reuse pattern) | 48 | Leaked on every credential change |
| Q-008 | 3 (build bloat/confusion) | 4 (always present) | 48 | Increases build time and dependency surface |
| Q-007 | 3 (maintainability) | 3 (edited sometimes) | 36 | Large file with duplicated patterns |
| Q-009 | 3 (maintainability) | 3 (edited on new targets) | 36 | 5 copies of same linking logic |
| Q-004 | 3 (misleads contributors) | 3 (read by new devs) | 36 | Stale docs cause confusion |
| Q-010 | 2 (dead code) | 4 (always present) | 32 | Suspected stale finding; verify |
| Q-014 | 3 (security: secret remnants) | 2 (requires optimizer + memory inspection) | 24 | Sensitive data may persist in freed memory |
| Q-011 | 2 (duplication) | 2 (rarely edited) | 16 | Maintenance overhead only |
| Q-012 | 2 (duplication) | 2 (rarely edited) | 16 | Maintenance overhead only |
| Q-013 | 2 (dead code) | 1.5 (rarely touched) | 12 | Minor API cleanliness |
| Q-015 | 2 (CI slowness) | 1.5 (every integration run) | 12 | Wastes 60s per CI run |
| Q-016 | 2 (enforcement gap) | 1 (formatting rarely breaks) | 8 | Advisory-only check |

---

## Unknowns and Confirmation Needed

| ID | Unknown | What Would Confirm |
|----|---------|--------------------|
| Q-010 | Whether `proto/schema.zig` ever existed or is a stale finding | `git log --all -- src/proto/schema.zig` -- if no results, finding is invalid |
| Q-003 | Whether `QuicServerMessage` actually owns allocated memory or is stack-only | Inspect `QuicServerMessage` struct definition and `receiveProto` return semantics |
| Q-014 | Whether LLVM actually elides the `@memset` in ReleaseFast builds | Disassemble `Config.deinit` in a ReleaseFast build and check for zeroing instructions |
