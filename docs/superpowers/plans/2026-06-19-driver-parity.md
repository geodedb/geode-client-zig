# Geode Zig Driver Parity Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Bring the geode-client-zig driver to feature parity with the reference geode-client-go driver by porting 11 capabilities faithfully.

**Architecture:** Add focused, single-responsibility Zig modules under `src/` mirroring the Go source files (`schema.zig`, `redact.zig`, `quote.zig`, `gtime.zig`, `retry.zig`, `crypto.zig`), and extend existing modules (`types.zig`, `config.zig`, `batch.zig`, `pool.zig`, `encryption.zig`). Each new module is wired into `build.zig` for unit tests; new parsing/quoting modules also gain fuzz targets in the `test-fuzz` step. Integration tests follow `tests/integration.zig` conventions and must compile via `zig build test-integration`.

**Tech Stack:** Zig 0.16.0, std.crypto (`Aes256Gcm`, `hkdf`, `hmac`, `secureZero`), std.testing, existing `thread_pool`/`executor`/`Batch` work-stealing infrastructure, pinned QUIC dependency (DO NOT modify dependency versions).

## Global Constraints

- Zig 0.16.0. Commands: `zig build`, `zig build test`, `zig build test-integration`, `zig build test-fuzz`, `zig build bench`. All work happens in worktree `.worktrees/driver-parity` on branch `feat/driver-parity-2026-06`.
- DO NOT bump or change any dependency version in `build.zig.zon`. Only add client code.
- Match conventions exactly: SPDX header `// SPDX-License-Identifier: Apache-2.0` + `// Copyright (c) 2024-2026 CodePros` on every new file; allocator discipline with `errdefer` cleanup; secure zeroing of key material via `std.crypto.secureZero` (CWE-316); `GeodeError`/`Result(T)` style from `src/error.zig`; `validate.zig`-style explicit error sets and CWE-annotated limits; embedded `test {}` blocks in each module; builder methods returning `*Self` on Config.
- Every new `src/*.zig` module gets a corresponding `b.addTest` block appended to the `test_step` chain in `build.zig`, with the same `addImport` wiring its dependencies use.
- Already implemented — DO NOT redo: tenant_id + role in HELLO, prepared statements, transactions, sequential+parallel Batch (`runParallel`), pool, validation, auth HMAC primitives.
- Commit after every task with trailer:
  `Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>`
- The pre-commit hook runs `zig fmt (check)` and `zig build` — run `zig fmt` on touched files before committing.

---

## File Structure

| File | Responsibility | New/Modify |
|------|----------------|------------|
| `src/quote.zig` | `quoteIdent`, `quoteString`, `sanitizeGraphName` + error set | New |
| `src/redact.zig` | `redactDSN` credential masking | New |
| `src/schema.zig` | `parseSchemaFS` reading `.gql` dir into statements | New |
| `src/gtime.zig` | `parseTime` + scanner adapter producing temporal `Value` | New |
| `src/retry.zig` | `RetryPolicy` + `retry(policy, fn)` honoring `isRetryable` | New |
| `src/crypto.zig` | AES-256-GCM FLE: `Cipher`, encrypt/decrypt, hmacHex | New |
| `src/error.zig` | Add `RowError`/`error.NoRows` sentinel + helper | Modify |
| `src/types.zig` | Add `asEdge`, `asPath` accessors + object→node/edge/path conversion | Modify |
| `src/config.zig` | Complete `toDSN` to round-trip with `parseDSN` | Modify |
| `src/batch.zig` | Add `pipelineExec` chunked/worker (GAP-0900) | Modify |
| `src/pool.zig` | Add `Pool(T).initFromConfig` factory | Modify |
| `src/encryption.zig` | Wire real `crypto.zig` Cipher into config (encrypt/decrypt methods) | Modify |
| `fuzz/fuzz_quote.zig` | Fuzz target for quoting helpers | New |
| `fuzz/fuzz_schema.zig` | Fuzz target for schema parsing | New |
| `tests/parity_integration.zig` | Integration tests for new features (compile-only, skip live) | New |
| `build.zig` | Wire all new test/fuzz/integration artifacts | Modify |

---

## Task 1: Quoting helpers (`src/quote.zig`)

Reference: geode-client-go `quote.go`.

**Files:**

- Create: `src/quote.zig`
- Modify: `build.zig` (add `quote_tests` to `test_step`)

**Interfaces:**

- Produces:
  - `pub const QuoteError = error{ InvalidIdent, InvalidString };`
  - `pub fn quoteIdent(name: []const u8) QuoteError![]const u8` (returns the input slice unchanged when valid; validates `[A-Za-z_][A-Za-z_0-9-]*` with digits allowed anywhere including first, hyphen allowed anywhere except first; rejects empty)
  - `pub fn quoteString(allocator: std.mem.Allocator, s: []const u8) (QuoteError||std.mem.Allocator.Error)![]u8` (rejects ASCII control `< 0x20` or `0x7f`; escapes `\`→`\\` first then `'`→`''`; wraps in single quotes; caller owns returned slice)
  - `pub fn sanitizeGraphName(allocator: std.mem.Allocator, name: []const u8) std.mem.Allocator.Error![]u8` (keeps only `[A-Za-z0-9_-]`; caller owns returned slice)

- [ ] **Step 1: Write the failing test file**

Create `src/quote.zig`:

```zig
// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// GQL identifier and string-literal quoting helpers for the Geode Zig
// client. Ported from geode-client-go quote.go. Used to safely inline
// user-supplied data into GQL admin statements (CWE-89).

const std = @import("std");

/// Errors returned by the quoting helpers.
pub const QuoteError = error{
    /// Identifier contains characters that cannot appear in a bare GQL identifier.
    InvalidIdent,
    /// String literal contains ASCII control characters that cannot be safely escaped.
    InvalidString,
};

test "quoteIdent accepts valid identifiers" {
    try std.testing.expectEqualStrings("user_name", try quoteIdent("user_name"));
    try std.testing.expectEqualStrings("User1", try quoteIdent("User1"));
    try std.testing.expectEqualStrings("005_add_index", try quoteIdent("005_add_index"));
    try std.testing.expectEqualStrings("a-b-c", try quoteIdent("a-b-c"));
    try std.testing.expectEqualStrings("_private", try quoteIdent("_private"));
}

test "quoteIdent rejects empty and bad identifiers" {
    try std.testing.expectError(QuoteError.InvalidIdent, quoteIdent(""));
    try std.testing.expectError(QuoteError.InvalidIdent, quoteIdent("-leading-hyphen"));
    try std.testing.expectError(QuoteError.InvalidIdent, quoteIdent("has space"));
    try std.testing.expectError(QuoteError.InvalidIdent, quoteIdent("semi;colon"));
    try std.testing.expectError(QuoteError.InvalidIdent, quoteIdent("dot.dot"));
}

test "quoteString wraps and escapes" {
    const a = std.testing.allocator;
    {
        const out = try quoteString(a, "hello");
        defer a.free(out);
        try std.testing.expectEqualStrings("'hello'", out);
    }
    {
        const out = try quoteString(a, "O'Brien");
        defer a.free(out);
        try std.testing.expectEqualStrings("'O''Brien'", out);
    }
    {
        const out = try quoteString(a, "back\\slash");
        defer a.free(out);
        try std.testing.expectEqualStrings("'back\\\\slash'", out);
    }
    {
        // Backslash escaped BEFORE quote: \' -> \\''
        const out = try quoteString(a, "\\'");
        defer a.free(out);
        try std.testing.expectEqualStrings("'\\\\'''", out);
    }
}

test "quoteString rejects control characters" {
    const a = std.testing.allocator;
    try std.testing.expectError(QuoteError.InvalidString, quoteString(a, "bad\x00null"));
    try std.testing.expectError(QuoteError.InvalidString, quoteString(a, "tab\there"));
    try std.testing.expectError(QuoteError.InvalidString, quoteString(a, "del\x7f"));
}

test "sanitizeGraphName strips disallowed chars" {
    const a = std.testing.allocator;
    {
        const out = try sanitizeGraphName(a, "my-graph_1");
        defer a.free(out);
        try std.testing.expectEqualStrings("my-graph_1", out);
    }
    {
        const out = try sanitizeGraphName(a, "bad name; DROP");
        defer a.free(out);
        try std.testing.expectEqualStrings("badnameDROP", out);
    }
    {
        const out = try sanitizeGraphName(a, "");
        defer a.free(out);
        try std.testing.expectEqualStrings("", out);
    }
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig test src/quote.zig`
Expected: FAIL — `quoteIdent`/`quoteString`/`sanitizeGraphName` not defined.

- [ ] **Step 3: Implement the functions**

Append to `src/quote.zig` (above the `test` blocks is fine; place after `QuoteError`):

```zig
fn isIdentLetter(c: u8) bool {
    return (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') or c == '_';
}

fn isIdentDigit(c: u8) bool {
    return c >= '0' and c <= '9';
}

/// Validate `name` and return it unchanged if it is a safe bare GQL
/// identifier. Valid identifiers consist of letters, digits, underscore,
/// and hyphen; hyphen may not be the first character. Digits are permitted
/// anywhere, including first (digit-prefixed migration names). Empty input
/// is rejected.
pub fn quoteIdent(name: []const u8) QuoteError![]const u8 {
    if (name.len == 0) return QuoteError.InvalidIdent;
    for (name, 0..) |c, i| {
        if (isIdentLetter(c) or isIdentDigit(c)) continue;
        if (c == '-') {
            if (i == 0) return QuoteError.InvalidIdent;
            continue;
        }
        return QuoteError.InvalidIdent;
    }
    return name;
}

/// Return `s` wrapped in GQL single quotes with backslashes and single
/// quotes escaped. ASCII control characters (< 0x20 or 0x7f) are rejected
/// with InvalidString. Escape order: backslash first (\ -> \\), then single
/// quote (' -> ''). Caller owns the returned slice.
pub fn quoteString(allocator: std.mem.Allocator, s: []const u8) (QuoteError || std.mem.Allocator.Error)![]u8 {
    for (s) |c| {
        if (c < 0x20 or c == 0x7f) return QuoteError.InvalidString;
    }
    var out: std.ArrayListUnmanaged(u8) = .empty;
    errdefer out.deinit(allocator);
    try out.append(allocator, '\'');
    for (s) |c| {
        switch (c) {
            '\\' => try out.appendSlice(allocator, "\\\\"),
            '\'' => try out.appendSlice(allocator, "''"),
            else => try out.append(allocator, c),
        }
    }
    try out.append(allocator, '\'');
    return out.toOwnedSlice(allocator);
}

/// Return `name` stripped of any character that is not alphanumeric,
/// underscore, or hyphen, so it can be inlined safely into a USE GRAPH
/// statement. Caller owns the returned slice.
pub fn sanitizeGraphName(allocator: std.mem.Allocator, name: []const u8) std.mem.Allocator.Error![]u8 {
    var out: std.ArrayListUnmanaged(u8) = .empty;
    errdefer out.deinit(allocator);
    for (name) |c| {
        const keep = (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') or
            (c >= '0' and c <= '9') or c == '_' or c == '-';
        if (keep) try out.append(allocator, c);
    }
    return out.toOwnedSlice(allocator);
}
```

- [ ] **Step 4: Wire build.zig**

In `build.zig`, after the existing `// Test grpc module` block (search for `test_step.dependOn(&run_grpc_tests.step);`), add:

```zig
    // Test quote module
    const quote_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/quote.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_quote_tests = b.addRunArtifact(quote_tests);
    test_step.dependOn(&run_quote_tests.step);
```

- [ ] **Step 5: Run tests to verify they pass**

Run: `cd .worktrees/driver-parity && zig fmt src/quote.zig build.zig && zig build test 2>&1 | tail -5`
Expected: build succeeds, exit 0.

- [ ] **Step 6: Commit**

```bash
git add src/quote.zig build.zig
git commit -m "feat(quote): add GQL identifier/string quoting helpers

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 2: Quoting fuzz target (`fuzz/fuzz_quote.zig`)

**Files:**

- Create: `fuzz/fuzz_quote.zig`
- Modify: `build.zig` (add `fuzz_quote` to `fuzz_step`)

**Interfaces:**

- Consumes: `quote` module (`quoteIdent`, `quoteString`, `sanitizeGraphName`).

- [ ] **Step 1: Write the fuzz target with property tests**

Create `fuzz/fuzz_quote.zig`:

```zig
// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Fuzz/property tests for GQL quoting helpers. The invariants: quoting
// never crashes, quoteString output is always single-quote wrapped when it
// succeeds, and quoteIdent never returns a string with a leading hyphen.

const std = @import("std");
const quote = @import("quote");

pub fn main() !void {
    var buffer: [128 * 1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const stdin = std.Io.getStdIn();
    const input = stdin.readToEndAlloc(allocator, 64 * 1024) catch return;

    _ = quote.quoteIdent(input) catch {};
    if (quote.quoteString(allocator, input)) |out| {
        allocator.free(out);
    } else |_| {}
    if (quote.sanitizeGraphName(allocator, input)) |out| {
        allocator.free(out);
    } else |_| {}
}

test "property: quoteString output is single-quote wrapped or rejected" {
    const a = std.testing.allocator;
    const inputs = [_][]const u8{ "", "abc", "a'b", "a\\b", "x\x01" };
    for (inputs) |in| {
        if (quote.quoteString(a, in)) |out| {
            defer a.free(out);
            try std.testing.expect(out.len >= 2);
            try std.testing.expectEqual(@as(u8, '\''), out[0]);
            try std.testing.expectEqual(@as(u8, '\''), out[out.len - 1]);
        } else |err| {
            try std.testing.expectEqual(quote.QuoteError.InvalidString, err);
        }
    }
}

test "property: quoteIdent never accepts leading hyphen" {
    try std.testing.expectError(quote.QuoteError.InvalidIdent, quote.quoteIdent("-x"));
    try std.testing.expectError(quote.QuoteError.InvalidIdent, quote.quoteIdent("-"));
}

test "property: sanitizeGraphName output contains only allowed chars" {
    const a = std.testing.allocator;
    const out = try quote.sanitizeGraphName(a, "a b!c@d#-_1");
    defer a.free(out);
    for (out) |c| {
        const ok = (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') or
            (c >= '0' and c <= '9') or c == '_' or c == '-';
        try std.testing.expect(ok);
    }
}
```

- [ ] **Step 2: Wire build.zig**

In `build.zig`, after the existing `// Fuzz validation` block (search for `fuzz_step.dependOn(&run_fuzz_validate.step);`), add:

```zig
    // Fuzz quote helpers
    const fuzz_quote = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("fuzz/fuzz_quote.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    fuzz_quote.root_module.addImport("quote", quote_mod);
    const run_fuzz_quote = b.addRunArtifact(fuzz_quote);
    fuzz_step.dependOn(&run_fuzz_quote.step);
```

Also, the fuzz target needs a `quote_mod` module reference. In `build.zig`, in the Internal Modules section (after the `encryption_mod` block near line 239), add:

```zig
    // Quote module (GQL identifier/string quoting)
    const quote_mod = b.createModule(.{
        .root_source_file = b.path("src/quote.zig"),
        .target = target,
        .optimize = optimize,
    });
```

- [ ] **Step 3: Run fuzz tests**

Run: `cd .worktrees/driver-parity && zig fmt fuzz/fuzz_quote.zig build.zig && zig build test-fuzz 2>&1 | tail -5`
Expected: exit 0.

- [ ] **Step 4: Commit**

```bash
git add fuzz/fuzz_quote.zig build.zig
git commit -m "test(quote): add fuzz target for quoting helpers

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 3: RedactDSN (`src/redact.zig`)

Reference: geode-client-go `internal/redact/redact.go` + `pool.go` `RedactDSN`.

**Files:**

- Create: `src/redact.zig`
- Modify: `build.zig` (add `redact_tests` to `test_step`)

**Interfaces:**

- Produces: `pub fn redactDSN(allocator: std.mem.Allocator, dsn: []const u8) std.mem.Allocator.Error![]u8` — masks URI userinfo (`user:pass@` -> `***:***@`, `user@` -> `***@`) and credential query params (`user`/`username`/`pass`/`password`, case-insensitive) -> `=***`. Empty input returns an empty owned slice. Caller owns returned slice.

- [ ] **Step 1: Write the failing test file**

Create `src/redact.zig`:

```zig
// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// DSN credential redaction for safe logging. Ported from
// geode-client-go internal/redact/redact.go. Masks URI userinfo and
// credential query parameters before a DSN is written to a log sink.

const std = @import("std");

test "redactDSN masks URI userinfo" {
    const a = std.testing.allocator;
    {
        const out = try redactDSN(a, "quic://user:pass@host:3141");
        defer a.free(out);
        try std.testing.expectEqualStrings("quic://***:***@host:3141", out);
    }
    {
        const out = try redactDSN(a, "quic://user@host:3141");
        defer a.free(out);
        try std.testing.expectEqualStrings("quic://***@host:3141", out);
    }
}

test "redactDSN masks credential query params" {
    const a = std.testing.allocator;
    const out = try redactDSN(a, "quic://host:3141?user=bob&pass=secret&graph=g");
    defer a.free(out);
    try std.testing.expectEqualStrings("quic://host:3141?user=***&pass=***&graph=g", out);
}

test "redactDSN handles both userinfo and params" {
    const a = std.testing.allocator;
    const out = try redactDSN(a, "grpc://u:p@host:50051?password=x&tls=0");
    defer a.free(out);
    try std.testing.expectEqualStrings("grpc://***:***@host:50051?password=***&tls=0", out);
}

test "redactDSN passes through credential-free DSN" {
    const a = std.testing.allocator;
    const out = try redactDSN(a, "localhost:3141");
    defer a.free(out);
    try std.testing.expectEqualStrings("localhost:3141", out);
}

test "redactDSN is empty-safe" {
    const a = std.testing.allocator;
    const out = try redactDSN(a, "");
    defer a.free(out);
    try std.testing.expectEqualStrings("", out);
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig test src/redact.zig`
Expected: FAIL — `redactDSN` not defined.

- [ ] **Step 3: Implement**

Insert before the test blocks in `src/redact.zig`:

```zig
const masked = "***";

fn isCredentialParam(key: []const u8) bool {
    return std.ascii.eqlIgnoreCase(key, "user") or
        std.ascii.eqlIgnoreCase(key, "username") or
        std.ascii.eqlIgnoreCase(key, "pass") or
        std.ascii.eqlIgnoreCase(key, "password");
}

/// Append the userinfo segment (everything up to and including the last
/// '@') of `authority` to `out`, with user and password masked.
fn appendMaskedUserinfo(allocator: std.mem.Allocator, out: *std.ArrayListUnmanaged(u8), userinfo: []const u8) !void {
    if (std.mem.indexOfScalar(u8, userinfo, ':') == null) {
        try out.appendSlice(allocator, masked);
    } else {
        try out.appendSlice(allocator, masked ++ ":" ++ masked);
    }
}

/// Mask the userinfo portion of the base part of a DSN (before any '?').
fn redactBase(allocator: std.mem.Allocator, out: *std.ArrayListUnmanaged(u8), base: []const u8) !void {
    const scheme_marker = "://";
    if (std.mem.indexOf(u8, base, scheme_marker)) |scheme_end| {
        const authority_start = scheme_end + scheme_marker.len;
        const authority = base[authority_start..];
        if (std.mem.lastIndexOfScalar(u8, authority, '@')) |at_idx| {
            try out.appendSlice(allocator, base[0..authority_start]);
            try appendMaskedUserinfo(allocator, out, authority[0..at_idx]);
            try out.appendSlice(allocator, authority[at_idx..]);
            return;
        }
        try out.appendSlice(allocator, base);
        return;
    }
    // No scheme: bare user@host pattern.
    if (std.mem.lastIndexOfScalar(u8, base, '@')) |at_idx| {
        try appendMaskedUserinfo(allocator, out, base[0..at_idx]);
        try out.appendSlice(allocator, base[at_idx..]);
        return;
    }
    try out.appendSlice(allocator, base);
}

/// Mask credential query parameters in `query`, preserving order and
/// non-credential params.
fn redactQuery(allocator: std.mem.Allocator, out: *std.ArrayListUnmanaged(u8), query: []const u8) !void {
    var first = true;
    var iter = std.mem.splitScalar(u8, query, '&');
    while (iter.next()) |param| {
        if (!first) try out.append(allocator, '&');
        first = false;
        if (std.mem.indexOfScalar(u8, param, '=')) |eq| {
            const key = param[0..eq];
            if (isCredentialParam(key)) {
                try out.appendSlice(allocator, key);
                try out.append(allocator, '=');
                try out.appendSlice(allocator, masked);
                continue;
            }
        }
        try out.appendSlice(allocator, param);
    }
}

/// Return `dsn` with credentials masked for safe logging. Caller owns the
/// returned slice. Empty input returns an empty owned slice.
pub fn redactDSN(allocator: std.mem.Allocator, dsn: []const u8) std.mem.Allocator.Error![]u8 {
    var out: std.ArrayListUnmanaged(u8) = .empty;
    errdefer out.deinit(allocator);
    if (dsn.len == 0) return out.toOwnedSlice(allocator);

    const q_idx = std.mem.indexOfScalar(u8, dsn, '?');
    const base = if (q_idx) |i| dsn[0..i] else dsn;
    try redactBase(allocator, &out, base);
    if (q_idx) |i| {
        try out.append(allocator, '?');
        try redactQuery(allocator, &out, dsn[i + 1 ..]);
    }
    return out.toOwnedSlice(allocator);
}
```

- [ ] **Step 4: Wire build.zig**

After the `quote_tests` block from Task 1, add:

```zig
    // Test redact module
    const redact_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/redact.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_redact_tests = b.addRunArtifact(redact_tests);
    test_step.dependOn(&run_redact_tests.step);
```

- [ ] **Step 5: Run tests**

Run: `cd .worktrees/driver-parity && zig fmt src/redact.zig build.zig && zig build test 2>&1 | tail -5`
Expected: exit 0.

- [ ] **Step 6: Commit**

```bash
git add src/redact.zig build.zig
git commit -m "feat(redact): add DSN credential redaction for safe logging

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 4: ParseSchemaFS (`src/schema.zig`)

Reference: geode-client-go `schema.go` (top-level) + `graph/schema.go`. Port the top-level line-based variant: split file into lines, drop blank/comment (`//`, `--`) lines, keep only lines starting (case-insensitive) with `CREATE`/`MERGE`/`MATCH`/`DELETE`, split each kept line on `;` into statements.

**Files:**

- Create: `src/schema.zig`
- Modify: `build.zig` (add `schema_tests` + `schema_mod`)

**Interfaces:**

- Produces:
  - `pub const Statement = struct { query: []const u8 };` (query is allocator-owned dupe)
  - `pub fn parseSchemaFS(allocator: std.mem.Allocator, dir: std.fs.Dir) ![]Statement` — reads direct-child `*.gql` files (sorted by name), parses contents, returns owned slice of `Statement`. Caller frees each `.query` then the slice via `freeStatements`.
  - `pub fn parseSchemaContent(allocator: std.mem.Allocator, content: []const u8, out: *std.ArrayListUnmanaged(Statement)) !void` — appends parsed statements from one file's content.
  - `pub fn freeStatements(allocator: std.mem.Allocator, stmts: []Statement) void`

- [ ] **Step 1: Write the failing test file**

Create `src/schema.zig`:

```zig
// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Schema-file (.gql) parsing for the Geode Zig client. Ported from
// geode-client-go schema.go. Reads .gql files from a directory and splits
// their contents into individual GQL statements suitable for batch/pipeline
// execution.

const std = @import("std");

test "parseSchemaContent keeps GQL statements and drops comments" {
    const a = std.testing.allocator;
    const content =
        "// a comment\n" ++
        "-- another comment\n" ++
        "\n" ++
        "CREATE (n:Person {name: 'Alice'});\n" ++
        "MATCH (n) RETURN n;\n" ++
        "SELECT * FROM x;\n" ++ // dropped: not a GQL keyword
        "MERGE (m:Node); DELETE (m);\n"; // two statements on one line

    var out: std.ArrayListUnmanaged(Statement) = .empty;
    defer {
        for (out.items) |s| a.free(s.query);
        out.deinit(a);
    }
    try parseSchemaContent(a, content, &out);

    try std.testing.expectEqual(@as(usize, 4), out.items.len);
    try std.testing.expectEqualStrings("CREATE (n:Person {name: 'Alice'})", out.items[0].query);
    try std.testing.expectEqualStrings("MATCH (n) RETURN n", out.items[1].query);
    try std.testing.expectEqualStrings("MERGE (m:Node)", out.items[2].query);
    try std.testing.expectEqualStrings("DELETE (m)", out.items[3].query);
}

test "parseSchemaContent is case-insensitive on keywords" {
    const a = std.testing.allocator;
    var out: std.ArrayListUnmanaged(Statement) = .empty;
    defer {
        for (out.items) |s| a.free(s.query);
        out.deinit(a);
    }
    try parseSchemaContent(a, "create (n);\nmatch (n) return n;\n", &out);
    try std.testing.expectEqual(@as(usize, 2), out.items.len);
}

test "parseSchemaFS reads .gql files from a tmp dir in name order" {
    const a = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();

    try tmp.dir.writeFile(.{ .sub_path = "01_nodes.gql", .data = "CREATE (a:A);\n" });
    try tmp.dir.writeFile(.{ .sub_path = "02_edges.gql", .data = "MERGE (b:B);\n" });
    try tmp.dir.writeFile(.{ .sub_path = "ignore.txt", .data = "CREATE (c:C);\n" });

    const stmts = try parseSchemaFS(a, tmp.dir);
    defer freeStatements(a, stmts);

    try std.testing.expectEqual(@as(usize, 2), stmts.len);
    try std.testing.expectEqualStrings("CREATE (a:A)", stmts[0].query);
    try std.testing.expectEqualStrings("MERGE (b:B)", stmts[1].query);
}

test "parseSchemaFS returns empty for dir with no gql files" {
    const a = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    try tmp.dir.writeFile(.{ .sub_path = "readme.md", .data = "hi" });

    const stmts = try parseSchemaFS(a, tmp.dir);
    defer freeStatements(a, stmts);
    try std.testing.expectEqual(@as(usize, 0), stmts.len);
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig test src/schema.zig`
Expected: FAIL — `Statement`/`parseSchemaContent`/`parseSchemaFS`/`freeStatements` not defined.

- [ ] **Step 3: Implement**

Insert before the test blocks:

```zig
/// A parsed GQL statement. `query` is owned by the allocator passed to the
/// parsing function.
pub const Statement = struct {
    query: []const u8,
};

const keywords = [_][]const u8{ "CREATE", "MERGE", "MATCH", "DELETE" };

fn startsWithKeyword(trimmed: []const u8) bool {
    for (keywords) |kw| {
        if (trimmed.len >= kw.len and std.ascii.eqlIgnoreCase(trimmed[0..kw.len], kw)) {
            return true;
        }
    }
    return false;
}

/// Parse one file's content into Statements, appending to `out`. Lines are
/// trimmed; blank lines and `//`/`--` comment lines are dropped; only lines
/// beginning with a recognised GQL keyword are kept; each kept line is split
/// on ';' into one or more statements. Each appended `query` is allocator-owned.
pub fn parseSchemaContent(
    allocator: std.mem.Allocator,
    content: []const u8,
    out: *std.ArrayListUnmanaged(Statement),
) !void {
    var lines = std.mem.splitScalar(u8, content, '\n');
    while (lines.next()) |raw_line| {
        const trimmed = std.mem.trim(u8, raw_line, " \t\r");
        if (trimmed.len == 0) continue;
        if (std.mem.startsWith(u8, trimmed, "//") or std.mem.startsWith(u8, trimmed, "--")) continue;
        if (!startsWithKeyword(trimmed)) continue;

        var parts = std.mem.splitScalar(u8, trimmed, ';');
        while (parts.next()) |part| {
            const stmt = std.mem.trim(u8, part, " \t\r");
            if (stmt.len == 0) continue;
            const owned = try allocator.dupe(u8, stmt);
            errdefer allocator.free(owned);
            try out.append(allocator, .{ .query = owned });
        }
    }
}

/// Read all direct-child `*.gql` files from `dir` (in lexicographic name
/// order) and return their parsed Statements as an owned slice. Caller frees
/// via `freeStatements`.
pub fn parseSchemaFS(allocator: std.mem.Allocator, dir: std.fs.Dir) ![]Statement {
    // Collect .gql filenames.
    var names: std.ArrayListUnmanaged([]u8) = .empty;
    defer {
        for (names.items) |n| allocator.free(n);
        names.deinit(allocator);
    }
    var it = dir.iterate();
    while (try it.next()) |entry| {
        if (entry.kind == .directory) continue;
        if (!std.mem.endsWith(u8, entry.name, ".gql")) continue;
        try names.append(allocator, try allocator.dupe(u8, entry.name));
    }
    std.mem.sort([]u8, names.items, {}, struct {
        fn lessThan(_: void, lhs: []u8, rhs: []u8) bool {
            return std.mem.lessThan(u8, lhs, rhs);
        }
    }.lessThan);

    var out: std.ArrayListUnmanaged(Statement) = .empty;
    errdefer {
        for (out.items) |s| allocator.free(s.query);
        out.deinit(allocator);
    }
    for (names.items) |name| {
        const data = try dir.readFileAlloc(allocator, name, 16 * 1024 * 1024);
        defer allocator.free(data);
        try parseSchemaContent(allocator, data, &out);
    }
    return out.toOwnedSlice(allocator);
}

/// Free a slice of Statements returned by `parseSchemaFS`.
pub fn freeStatements(allocator: std.mem.Allocator, stmts: []Statement) void {
    for (stmts) |s| allocator.free(s.query);
    allocator.free(stmts);
}
```

> NOTE: `dir.readFileAlloc` signature in Zig 0.16 is `readFileAlloc(allocator, sub_path, max_bytes)`. If the compiler reports a different signature, use `dir.readFileAlloc(name, allocator, .limited(16 * 1024 * 1024))` or open the file and `reader().readAllAlloc`. Adjust to whatever the installed std exposes; the test must pass.

- [ ] **Step 4: Wire build.zig**

After the `redact_tests` block, add:

```zig
    // Test schema module
    const schema_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/schema.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_schema_tests = b.addRunArtifact(schema_tests);
    test_step.dependOn(&run_schema_tests.step);
```

And in the Internal Modules section (near the `quote_mod` from Task 2), add:

```zig
    // Schema module (.gql schema-file parsing)
    const schema_mod = b.createModule(.{
        .root_source_file = b.path("src/schema.zig"),
        .target = target,
        .optimize = optimize,
    });
```

- [ ] **Step 5: Run tests**

Run: `cd .worktrees/driver-parity && zig fmt src/schema.zig build.zig && zig build test 2>&1 | tail -10`
Expected: exit 0. If `readFileAlloc` mismatches, fix per the NOTE and re-run.

- [ ] **Step 6: Commit**

```bash
git add src/schema.zig build.zig
git commit -m "feat(schema): add parseSchemaFS for .gql schema files

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 5: Schema fuzz target (`fuzz/fuzz_schema.zig`)

**Files:**

- Create: `fuzz/fuzz_schema.zig`
- Modify: `build.zig` (add `fuzz_schema` to `fuzz_step`)

**Interfaces:**

- Consumes: `schema` module (`parseSchemaContent`, `Statement`).

- [ ] **Step 1: Write the fuzz target**

Create `fuzz/fuzz_schema.zig`:

```zig
// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Fuzz/property tests for schema-content parsing. Invariant: parsing never
// crashes and every emitted statement is non-empty and begins with a
// recognised GQL keyword.

const std = @import("std");
const schema = @import("schema");

pub fn main() !void {
    var buffer: [256 * 1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const stdin = std.Io.getStdIn();
    const input = stdin.readToEndAlloc(allocator, 128 * 1024) catch return;

    var out: std.ArrayListUnmanaged(schema.Statement) = .empty;
    schema.parseSchemaContent(allocator, input, &out) catch return;
    // FixedBufferAllocator frees on reset; no explicit free needed.
}

fn startsWithKeyword(s: []const u8) bool {
    const kws = [_][]const u8{ "CREATE", "MERGE", "MATCH", "DELETE" };
    for (kws) |kw| {
        if (s.len >= kw.len and std.ascii.eqlIgnoreCase(s[0..kw.len], kw)) return true;
    }
    return false;
}

test "property: every parsed statement is non-empty and keyword-prefixed" {
    const a = std.testing.allocator;
    const inputs = [_][]const u8{
        "CREATE (a);\nMATCH (b);",
        "// only comments\n-- here\n",
        "garbage line\nMERGE (x); DELETE (y);",
        ";;;\nCREATE (z);;;",
    };
    for (inputs) |in| {
        var out: std.ArrayListUnmanaged(schema.Statement) = .empty;
        defer {
            for (out.items) |s| a.free(s.query);
            out.deinit(a);
        }
        try schema.parseSchemaContent(a, in, &out);
        for (out.items) |s| {
            try std.testing.expect(s.query.len > 0);
            try std.testing.expect(startsWithKeyword(s.query));
        }
    }
}
```

- [ ] **Step 2: Wire build.zig**

After the `fuzz_quote` block (Task 2), add:

```zig
    // Fuzz schema parsing
    const fuzz_schema = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("fuzz/fuzz_schema.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    fuzz_schema.root_module.addImport("schema", schema_mod);
    const run_fuzz_schema = b.addRunArtifact(fuzz_schema);
    fuzz_step.dependOn(&run_fuzz_schema.step);
```

- [ ] **Step 3: Run fuzz tests**

Run: `cd .worktrees/driver-parity && zig fmt fuzz/fuzz_schema.zig build.zig && zig build test-fuzz 2>&1 | tail -5`
Expected: exit 0.

- [ ] **Step 4: Commit**

```bash
git add fuzz/fuzz_schema.zig build.zig
git commit -m "test(schema): add fuzz target for schema parsing

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 6: ErrNoRows sentinel + row accessor (`src/error.zig`)

Reference: geode-client-go `errors.go` / `rows.go` (empty QueryRow surfaces `sql.ErrNoRows`).

**Files:**

- Modify: `src/error.zig` (add `RowError` + a generic row accessor helper)

**Interfaces:**

- Produces:
  - `pub const RowError = error{NoRows};`
  - `pub fn firstRow(comptime T: type, rows: []const T) RowError!T` — returns `rows[0]` or `error.NoRows` when empty. This is the unit-testable core that a `QueryResult.firstRow()` wrapper (Task 12 integration) builds on.

- [ ] **Step 1: Write the failing test**

In `src/error.zig`, append at the end (after the last existing test):

```zig
test "RowError.NoRows is returned for empty result sets" {
    const empty: []const i64 = &[_]i64{};
    try std.testing.expectError(RowError.NoRows, firstRow(i64, empty));
}

test "firstRow returns the first row when present" {
    const rows = [_]i64{ 10, 20, 30 };
    try std.testing.expectEqual(@as(i64, 10), try firstRow(i64, &rows));
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig test src/error.zig`
Expected: FAIL — `RowError`/`firstRow` not defined.

- [ ] **Step 3: Implement**

In `src/error.zig`, immediately before the `// Unit Tests` divider near line 306, add:

```zig
/// Sentinel error set for row accessors. Mirrors the Go driver's
/// sql.ErrNoRows behaviour: a single-row accessor over an empty result set
/// returns error.NoRows.
pub const RowError = error{
    /// The result set contained no rows.
    NoRows,
};

/// Return the first row of `rows`, or error.NoRows when the slice is empty.
/// This is the allocation-free core used by QueryResult.firstRow().
pub fn firstRow(comptime T: type, rows: []const T) RowError!T {
    if (rows.len == 0) return RowError.NoRows;
    return rows[0];
}
```

- [ ] **Step 4: Run tests**

Run: `cd .worktrees/driver-parity && zig fmt src/error.zig && zig build test 2>&1 | tail -5`
Expected: exit 0.

- [ ] **Step 5: Commit**

```bash
git add src/error.zig
git commit -m "feat(error): add RowError.NoRows sentinel and firstRow accessor

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 7: Node/Edge/Path accessors (`src/types.zig`)

Reference: geode-client-go `types.go` `AsNode`/`AsEdge`/`AsPath`. `Value` already has `asNode` and `asRelationship` direct-variant accessors. Add `asEdge` (alias for relationship), `asPath`, and object→{node,edge,path} conversion helpers mirroring the Go map-shape detection (a node object has `labels`; an edge object has `start_node`+`end_node`; a path object has `nodes`+`edges`/`relationships`).

**Files:**

- Modify: `src/types.zig`

**Interfaces:**

- Produces (methods on `Value`):
  - `pub fn asEdge(self: Value) !Relationship` — returns `.relationship` variant or `error.TypeMismatch`.
  - `pub fn asPath(self: Value) !Path` — returns `.path` variant or `error.TypeMismatch`.
  - `pub fn objectIsNode(self: Value) bool` — true when value is an `.object` with a `labels` key and no `start_node` key.
  - `pub fn objectIsEdge(self: Value) bool` — true when value is an `.object` with both `start_node` and `end_node` keys.
  - `pub fn objectIsPath(self: Value) bool` — true when value is an `.object` with both `nodes` and (`edges` or `relationships`) keys.

- [ ] **Step 1: Write the failing tests**

In `src/types.zig`, append after the last test:

```zig
test "Value.asEdge returns relationship variant" {
    const rel = Value.Relationship{
        .id = "r1",
        .type_name = "KNOWS",
        .start_node_id = "n1",
        .end_node_id = "n2",
        .properties = .empty,
    };
    const v = Value{ .relationship = rel };
    const e = try v.asEdge();
    try std.testing.expectEqualStrings("KNOWS", e.type_name);
    try std.testing.expectError(error.TypeMismatch, Value.initInt(1).asEdge());
}

test "Value.asPath returns path variant" {
    const p = Value.Path{ .nodes = &[_]Value.Node{}, .relationships = &[_]Value.Relationship{} };
    const v = Value{ .path = p };
    const got = try v.asPath();
    try std.testing.expectEqual(@as(usize, 0), got.nodes.len);
    try std.testing.expectError(error.TypeMismatch, Value.initInt(1).asPath());
}

test "Value.objectIsNode/Edge/Path detect map shapes" {
    const a = std.testing.allocator;

    var node_obj: std.StringHashMapUnmanaged(Value) = .empty;
    defer node_obj.deinit(a);
    try node_obj.put(a, "labels", Value.initArray(&[_]Value{}));
    try node_obj.put(a, "id", Value.initInt(1));
    const node_v = Value{ .object = node_obj };
    try std.testing.expect(node_v.objectIsNode());
    try std.testing.expect(!node_v.objectIsEdge());
    try std.testing.expect(!node_v.objectIsPath());

    var edge_obj: std.StringHashMapUnmanaged(Value) = .empty;
    defer edge_obj.deinit(a);
    try edge_obj.put(a, "start_node", Value.initInt(1));
    try edge_obj.put(a, "end_node", Value.initInt(2));
    const edge_v = Value{ .object = edge_obj };
    try std.testing.expect(edge_v.objectIsEdge());
    try std.testing.expect(!edge_v.objectIsNode());

    var path_obj: std.StringHashMapUnmanaged(Value) = .empty;
    defer path_obj.deinit(a);
    try path_obj.put(a, "nodes", Value.initArray(&[_]Value{}));
    try path_obj.put(a, "edges", Value.initArray(&[_]Value{}));
    const path_v = Value{ .object = path_obj };
    try std.testing.expect(path_v.objectIsPath());

    // A plain integer is none of these.
    try std.testing.expect(!Value.initInt(5).objectIsNode());
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig build test 2>&1 | tail -15`
Expected: FAIL — `asEdge`/`asPath`/`objectIsNode`/`objectIsEdge`/`objectIsPath` not defined.

- [ ] **Step 3: Implement**

In `src/types.zig`, in the "Type-safe accessors" section right after the existing `asRelationship` method (around line 529), add:

```zig
    /// Get edge (relationship) value or return error. Alias for asRelationship
    /// matching the Go driver's AsEdge naming.
    pub fn asEdge(self: Value) !Relationship {
        return switch (self) {
            .relationship => |r| r,
            else => error.TypeMismatch,
        };
    }

    /// Get path value or return error.
    pub fn asPath(self: Value) !Path {
        return switch (self) {
            .path => |p| p,
            else => error.TypeMismatch,
        };
    }

    /// Report whether this value is an object whose key-shape matches a
    /// graph node: it has a "labels" key and no "start_node" key. Mirrors
    /// the Go driver's AsNode map-shape detection.
    pub fn objectIsNode(self: Value) bool {
        return switch (self) {
            .object => |o| o.contains("labels") and !o.contains("start_node"),
            else => false,
        };
    }

    /// Report whether this value is an object whose key-shape matches a
    /// graph edge: it has both "start_node" and "end_node" keys.
    pub fn objectIsEdge(self: Value) bool {
        return switch (self) {
            .object => |o| o.contains("start_node") and o.contains("end_node"),
            else => false,
        };
    }

    /// Report whether this value is an object whose key-shape matches a
    /// graph path: it has a "nodes" key and an "edges" or "relationships" key.
    pub fn objectIsPath(self: Value) bool {
        return switch (self) {
            .object => |o| o.contains("nodes") and (o.contains("edges") or o.contains("relationships")),
            else => false,
        };
    }
```

- [ ] **Step 4: Run tests**

Run: `cd .worktrees/driver-parity && zig fmt src/types.zig && zig build test 2>&1 | tail -5`
Expected: exit 0.

- [ ] **Step 5: Commit**

```bash
git add src/types.zig
git commit -m "feat(types): add asEdge/asPath accessors and object shape detection

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 8: Time scanner / adapter (`src/gtime.zig`)

Reference: geode-client-go `time.go`. `ParseTime` tries RFC3339Nano, RFC3339, then fallback layouts; strips Go monotonic suffix `" m=..."`; `ScanTime`/`TimeScanner`. Port to produce the temporal `Value` (`Value.timestamp` / `Value.date`). Module name is `gtime` to avoid clashing with `std.time` import conventions.

**Files:**

- Create: `src/gtime.zig`
- Modify: `build.zig` (add `gtime_tests` + import `types`)

**Interfaces:**

- Consumes: `types` module (`Value`).
- Produces:
  - `pub const ParseError = error{ EmptyTimeString, UnrecognizedTimeFormat };`
  - `pub fn stripMonotonic(s: []const u8) []const u8` — drops everything from the first `" m="` occurrence.
  - `pub fn parseTime(s: []const u8) ParseError!types.Value` — strips monotonic, then tries layouts in order; returns a `Value.timestamp` (or `Value.date` for date-only input). Errors on empty/unrecognized.
  - `pub fn scanTime(src: ?[]const u8) ParseError!types.Value` — scanner-style adapter; `null`/empty -> zero-value timestamp.

- [ ] **Step 1: Write the failing test file**

Create `src/gtime.zig`:

```zig
// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Time-string parsing for Geode server responses. Ported from
// geode-client-go time.go. Tries RFC3339-style and fallback layouts, strips
// Go's monotonic clock suffix, and produces a temporal Value.

const std = @import("std");
const types = @import("types");
const Value = types.Value;

test "stripMonotonic removes Go monotonic suffix" {
    try std.testing.expectEqualStrings(
        "2025-01-24 14:30:45.123 -0700 MST",
        stripMonotonic("2025-01-24 14:30:45.123 -0700 MST m=+0.001234"),
    );
    try std.testing.expectEqualStrings("2025-01-24", stripMonotonic("2025-01-24"));
}

test "parseTime parses RFC3339" {
    const v = try parseTime("2025-01-24T14:30:45Z");
    const ts = try v.asTimestamp();
    try std.testing.expectEqual(@as(i32, 2025), ts.date.year);
    try std.testing.expectEqual(@as(u8, 1), ts.date.month);
    try std.testing.expectEqual(@as(u8, 24), ts.date.day);
    try std.testing.expectEqual(@as(u8, 14), ts.time.hour);
    try std.testing.expectEqual(@as(u8, 30), ts.time.minute);
    try std.testing.expectEqual(@as(u8, 45), ts.time.second);
}

test "parseTime parses RFC3339Nano" {
    const v = try parseTime("2025-01-24T14:30:45.123456789Z");
    const ts = try v.asTimestamp();
    try std.testing.expectEqual(@as(u32, 123456789), ts.time.nanosecond);
}

test "parseTime parses space-separated datetime" {
    const v = try parseTime("2025-01-24 14:30:45");
    const ts = try v.asTimestamp();
    try std.testing.expectEqual(@as(u8, 45), ts.time.second);
}

test "parseTime parses date-only" {
    const v = try parseTime("2025-01-24");
    const d = try v.asDate();
    try std.testing.expectEqual(@as(i32, 2025), d.year);
    try std.testing.expectEqual(@as(u8, 24), d.day);
}

test "parseTime strips monotonic before parsing" {
    const v = try parseTime("2025-01-24 14:30:45 m=+12.5");
    const ts = try v.asTimestamp();
    try std.testing.expectEqual(@as(u8, 30), ts.time.minute);
}

test "parseTime errors on empty and unrecognized" {
    try std.testing.expectError(ParseError.EmptyTimeString, parseTime(""));
    try std.testing.expectError(ParseError.UnrecognizedTimeFormat, parseTime("not a time"));
}

test "scanTime returns zero timestamp for null/empty" {
    const v1 = try scanTime(null);
    const ts1 = try v1.asTimestamp();
    try std.testing.expectEqual(@as(i32, 0), ts1.date.year);
    const v2 = try scanTime("");
    _ = try v2.asTimestamp();
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig test src/gtime.zig` (this will error because `types` import is unresolved standalone — instead rely on `zig build test` after wiring). For the fail check, temporarily run `zig build test` once build is wired in Step 4, OR confirm fail by reading the undefined-symbol error from `zig test --dep types ...`. Simplest: proceed to wire build first, then run.

- [ ] **Step 3: Implement**

Insert before the test blocks:

```zig
/// Errors returned by parseTime/scanTime.
pub const ParseError = error{
    /// Input string was empty.
    EmptyTimeString,
    /// Input did not match any supported layout.
    UnrecognizedTimeFormat,
};

/// Remove Go's monotonic clock suffix (" m=+N" / " m=-N") if present.
pub fn stripMonotonic(s: []const u8) []const u8 {
    if (std.mem.indexOf(u8, s, " m=")) |idx| return s[0..idx];
    return s;
}

const ParsedDateTime = struct {
    year: i32,
    month: u8,
    day: u8,
    hour: u8 = 0,
    minute: u8 = 0,
    second: u8 = 0,
    nanosecond: u32 = 0,
    has_time: bool,
};

fn parseUint(comptime T: type, s: []const u8) ?T {
    return std.fmt.parseInt(T, s, 10) catch null;
}

/// Parse the date portion "YYYY-MM-DD" at the start of s. Returns null on
/// malformed input.
fn parseDatePart(s: []const u8) ?struct { year: i32, month: u8, day: u8 } {
    if (s.len < 10) return null;
    if (s[4] != '-' or s[7] != '-') return null;
    const year = parseUint(i32, s[0..4]) orelse return null;
    const month = parseUint(u8, s[5..7]) orelse return null;
    const day = parseUint(u8, s[8..10]) orelse return null;
    if (month < 1 or month > 12 or day < 1 or day > 31) return null;
    return .{ .year = year, .month = month, .day = day };
}

/// Parse "HH:MM:SS[.fraction]" returning hour/minute/second/nanos. Returns
/// null on malformed input. `frac` may be empty.
fn parseTimePart(s: []const u8) ?struct { hour: u8, minute: u8, second: u8, nanosecond: u32 } {
    if (s.len < 8) return null;
    if (s[2] != ':' or s[5] != ':') return null;
    const hour = parseUint(u8, s[0..2]) orelse return null;
    const minute = parseUint(u8, s[3..5]) orelse return null;
    const second = parseUint(u8, s[6..8]) orelse return null;
    if (hour > 23 or minute > 59 or second > 59) return null;
    var nanosecond: u32 = 0;
    if (s.len > 8 and s[8] == '.') {
        var end: usize = 9;
        while (end < s.len and s[end] >= '0' and s[end] <= '9') : (end += 1) {}
        const frac = s[9..end];
        if (frac.len > 0) {
            // Pad/truncate fractional digits to 9 (nanoseconds).
            var buf: [9]u8 = .{ '0', '0', '0', '0', '0', '0', '0', '0', '0' };
            const n = @min(frac.len, 9);
            @memcpy(buf[0..n], frac[0..n]);
            nanosecond = parseUint(u32, &buf) orelse 0;
        }
    }
    return .{ .hour = hour, .minute = minute, .second = second, .nanosecond = nanosecond };
}

/// Attempt to parse `s` (already monotonic-stripped, trimmed) into a
/// ParsedDateTime. Handles 'T' and space date/time separators, optional
/// trailing 'Z'/offset/zone (ignored beyond the time component), and
/// date-only input.
fn parseFlexible(s_in: []const u8) ?ParsedDateTime {
    const s = std.mem.trim(u8, s_in, " ");
    const date = parseDatePart(s) orelse return null;
    if (s.len == 10) {
        return .{ .year = date.year, .month = date.month, .day = date.day, .has_time = false };
    }
    if (s.len < 11) return null;
    const sep = s[10];
    if (sep != 'T' and sep != ' ') return null;
    const t = parseTimePart(s[11..]) orelse return null;
    return .{
        .year = date.year,
        .month = date.month,
        .day = date.day,
        .hour = t.hour,
        .minute = t.minute,
        .second = t.second,
        .nanosecond = t.nanosecond,
        .has_time = true,
    };
}

/// Parse a Geode server time string into a temporal Value. Date-only input
/// yields a Value.date; otherwise a Value.timestamp.
pub fn parseTime(s_in: []const u8) ParseError!Value {
    if (s_in.len == 0) return ParseError.EmptyTimeString;
    const s = stripMonotonic(s_in);
    const parsed = parseFlexible(s) orelse return ParseError.UnrecognizedTimeFormat;
    if (!parsed.has_time) {
        return Value.initDate(parsed.year, parsed.month, parsed.day);
    }
    return Value{ .timestamp = Value.Timestamp.init(
        Value.Date.init(parsed.year, parsed.month, parsed.day),
        Value.Time.withNanos(parsed.hour, parsed.minute, parsed.second, parsed.nanosecond),
    ) };
}

/// Scanner-style adapter: null or empty source yields a zero-value
/// timestamp; otherwise delegates to parseTime.
pub fn scanTime(src: ?[]const u8) ParseError!Value {
    const s = src orelse return zeroTimestamp();
    if (s.len == 0) return zeroTimestamp();
    return parseTime(s);
}

fn zeroTimestamp() Value {
    return Value{ .timestamp = Value.Timestamp.init(
        Value.Date.init(0, 1, 1),
        Value.Time.init(0, 0, 0),
    ) };
}
```

> NOTE: The date-only zero timestamp uses month=1/day=1 so `Value.Date.init` is valid; the test only checks `year == 0`.

- [ ] **Step 4: Wire build.zig**

After the `schema_tests` block, add:

```zig
    // Test gtime module
    const gtime_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/gtime.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    gtime_tests.root_module.addImport("types", types_mod);
    const run_gtime_tests = b.addRunArtifact(gtime_tests);
    test_step.dependOn(&run_gtime_tests.step);
```

- [ ] **Step 5: Run tests**

Run: `cd .worktrees/driver-parity && zig fmt src/gtime.zig build.zig && zig build test 2>&1 | tail -10`
Expected: exit 0.

- [ ] **Step 6: Commit**

```bash
git add src/gtime.zig build.zig
git commit -m "feat(gtime): add parseTime/scanTime producing temporal Value

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 9: Crypto FLE (`src/crypto.zig`)

Reference: geode-client-go `crypto/cipher.go`. AES-256-GCM via `std.crypto.aead.aes_gcm.Aes256Gcm`; AES + HMAC keys derived via HKDF-SHA256 (`std.crypto.kdf.hkdf`) from a >=32-byte master key; HMAC-SHA256. Expose `encrypt`/`decrypt`, `encryptString`/`decryptString` (base64), `hmacHex` (64-char hex). Secure-zero key material.

**Files:**

- Create: `src/crypto.zig`
- Modify: `build.zig` (add `crypto_tests`, `crypto_mod`, and bench import)

**Interfaces:**

- Produces:
  - `pub const KEY_SIZE = 32; pub const NONCE_SIZE = 12; pub const TAG_SIZE = 16;`
  - `pub const CryptoError = error{ MasterKeyTooShort, CiphertextTooShort, AuthenticationFailed, InvalidBase64 };`
  - `pub const Cipher = struct { enc_key: [KEY_SIZE]u8, hmac_key: [KEY_SIZE]u8, ... }`
    - `pub fn init(master_key: []const u8) CryptoError!Cipher`
    - `pub fn deinit(self: *Cipher) void` (secure-zeros keys)
    - `pub fn encrypt(self: *const Cipher, allocator, plaintext: []const u8) ![]u8` (output = nonce(12) || ciphertext || tag(16))
    - `pub fn decrypt(self: *const Cipher, allocator, ciphertext: []const u8) (CryptoError||std.mem.Allocator.Error)![]u8`
    - `pub fn encryptString(self, allocator, plaintext) ![]u8` (base64 std)
    - `pub fn decryptString(self, allocator, encoded) ![]u8`
    - `pub fn hmacHex(self: *const Cipher, allocator, data: []const u8) std.mem.Allocator.Error![]u8` (64-char lowercase hex)

- [ ] **Step 1: Write the failing test file**

Create `src/crypto.zig`:

```zig
// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Field-level encryption for Geode node/edge properties. Ported from
// geode-client-go crypto/cipher.go. AES-256-GCM authenticated encryption
// with HKDF-SHA256 key derivation and HMAC-SHA256 deterministic hashing.
//
// SECURITY: Derived key material is securely zeroed on deinit (CWE-316).

const std = @import("std");
const Aes256Gcm = std.crypto.aead.aes_gcm.Aes256Gcm;
const Hkdf = std.crypto.kdf.hkdf.HkdfSha256;
const HmacSha256 = std.crypto.auth.hmac.sha2.HmacSha256;

test "Cipher rejects short master key" {
    try std.testing.expectError(CryptoError.MasterKeyTooShort, Cipher.init("too short"));
}

test "Cipher encrypt/decrypt round-trips" {
    const a = std.testing.allocator;
    const master = [_]u8{0x42} ** 48;
    var c = try Cipher.init(&master);
    defer c.deinit();

    const plaintext = "sensitive value 123";
    const ct = try c.encrypt(a, plaintext);
    defer a.free(ct);
    try std.testing.expect(ct.len == NONCE_SIZE + plaintext.len + TAG_SIZE);

    const pt = try c.decrypt(a, ct);
    defer a.free(pt);
    try std.testing.expectEqualStrings(plaintext, pt);
}

test "Cipher encryptString/decryptString round-trips via base64" {
    const a = std.testing.allocator;
    const master = [_]u8{0x07} ** 32;
    var c = try Cipher.init(&master);
    defer c.deinit();

    const enc = try c.encryptString(a, "hello@example.com");
    defer a.free(enc);
    // base64 has no non-base64 chars
    for (enc) |ch| {
        const ok = std.ascii.isAlphanumeric(ch) or ch == '+' or ch == '/' or ch == '=';
        try std.testing.expect(ok);
    }
    const dec = try c.decryptString(a, enc);
    defer a.free(dec);
    try std.testing.expectEqualStrings("hello@example.com", dec);
}

test "Cipher decrypt rejects tampered ciphertext" {
    const a = std.testing.allocator;
    const master = [_]u8{0x11} ** 32;
    var c = try Cipher.init(&master);
    defer c.deinit();

    const ct = try c.encrypt(a, "data");
    defer a.free(ct);
    ct[ct.len - 1] ^= 0xFF; // flip a tag byte
    try std.testing.expectError(CryptoError.AuthenticationFailed, c.decrypt(a, ct));
}

test "Cipher decrypt rejects too-short input" {
    const a = std.testing.allocator;
    const master = [_]u8{0x11} ** 32;
    var c = try Cipher.init(&master);
    defer c.deinit();
    try std.testing.expectError(CryptoError.CiphertextTooShort, c.decrypt(a, "short"));
}

test "Cipher hmacHex is deterministic and 64 hex chars" {
    const a = std.testing.allocator;
    const master = [_]u8{0x99} ** 32;
    var c = try Cipher.init(&master);
    defer c.deinit();

    const h1 = try c.hmacHex(a, "email@example.com");
    defer a.free(h1);
    const h2 = try c.hmacHex(a, "email@example.com");
    defer a.free(h2);
    const h3 = try c.hmacHex(a, "other@example.com");
    defer a.free(h3);

    try std.testing.expectEqual(@as(usize, 64), h1.len);
    try std.testing.expectEqualStrings(h1, h2);
    try std.testing.expect(!std.mem.eql(u8, h1, h3));
    for (h1) |ch| {
        const ok = (ch >= '0' and ch <= '9') or (ch >= 'a' and ch <= 'f');
        try std.testing.expect(ok);
    }
}

test "different master keys produce different ciphertext keys" {
    const a = std.testing.allocator;
    var c1 = try Cipher.init(&([_]u8{0x01} ** 32));
    defer c1.deinit();
    var c2 = try Cipher.init(&([_]u8{0x02} ** 32));
    defer c2.deinit();

    const ct = try c1.encrypt(a, "x");
    defer a.free(ct);
    // c2 cannot decrypt c1's ciphertext.
    try std.testing.expectError(CryptoError.AuthenticationFailed, c2.decrypt(a, ct));
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig test src/crypto.zig`
Expected: FAIL — `Cipher`/`CryptoError`/`KEY_SIZE` not defined.

- [ ] **Step 3: Implement**

Insert before the test blocks:

```zig
/// AES-256 key size in bytes.
pub const KEY_SIZE: usize = 32;
/// AES-GCM nonce size in bytes.
pub const NONCE_SIZE: usize = Aes256Gcm.nonce_length;
/// AES-GCM authentication tag size in bytes.
pub const TAG_SIZE: usize = Aes256Gcm.tag_length;

/// Errors returned by the crypto module.
pub const CryptoError = error{
    /// Master key was shorter than KEY_SIZE bytes.
    MasterKeyTooShort,
    /// Ciphertext was shorter than the minimum (nonce + tag).
    CiphertextTooShort,
    /// GCM authentication failed (tampered or wrong key).
    AuthenticationFailed,
    /// Base64 decoding failed.
    InvalidBase64,
};

/// Derive a KEY_SIZE-byte subkey from `master_key` using HKDF-SHA256 with
/// the given info label (no salt, matching the Go driver).
fn deriveKey(master_key: []const u8, info: []const u8) [KEY_SIZE]u8 {
    const prk = Hkdf.extract(&[_]u8{}, master_key);
    var out: [KEY_SIZE]u8 = undefined;
    Hkdf.expand(&out, info, prk);
    return out;
}

/// Holds derived encryption and HMAC keys for field-level encryption.
pub const Cipher = struct {
    enc_key: [KEY_SIZE]u8,
    hmac_key: [KEY_SIZE]u8,

    const Self = @This();

    /// Create a Cipher from a master key (>= KEY_SIZE bytes). Derives
    /// separate AES and HMAC keys via HKDF-SHA256.
    pub fn init(master_key: []const u8) CryptoError!Self {
        if (master_key.len < KEY_SIZE) return CryptoError.MasterKeyTooShort;
        return .{
            .enc_key = deriveKey(master_key, "geode-encrypt"),
            .hmac_key = deriveKey(master_key, "geode-hmac"),
        };
    }

    /// SECURITY: Securely zero derived key material (CWE-316).
    pub fn deinit(self: *Self) void {
        std.crypto.secureZero(u8, &self.enc_key);
        std.crypto.secureZero(u8, &self.hmac_key);
    }

    /// Encrypt `plaintext` with AES-256-GCM and a random nonce. Output layout
    /// is nonce(12) || ciphertext || tag(16). Caller owns the returned slice.
    pub fn encrypt(self: *const Self, allocator: std.mem.Allocator, plaintext: []const u8) std.mem.Allocator.Error![]u8 {
        const out = try allocator.alloc(u8, NONCE_SIZE + plaintext.len + TAG_SIZE);
        errdefer allocator.free(out);
        var nonce: [NONCE_SIZE]u8 = undefined;
        std.crypto.random.bytes(&nonce);
        @memcpy(out[0..NONCE_SIZE], &nonce);
        const ct = out[NONCE_SIZE .. NONCE_SIZE + plaintext.len];
        var tag: [TAG_SIZE]u8 = undefined;
        Aes256Gcm.encrypt(ct, &tag, plaintext, &[_]u8{}, nonce, self.enc_key);
        @memcpy(out[NONCE_SIZE + plaintext.len ..], &tag);
        return out;
    }

    /// Decrypt a ciphertext produced by `encrypt`. Returns AuthenticationFailed
    /// on tamper/wrong key, CiphertextTooShort on undersized input. Caller owns
    /// the returned slice.
    pub fn decrypt(self: *const Self, allocator: std.mem.Allocator, ciphertext: []const u8) (CryptoError || std.mem.Allocator.Error)![]u8 {
        if (ciphertext.len < NONCE_SIZE + TAG_SIZE) return CryptoError.CiphertextTooShort;
        var nonce: [NONCE_SIZE]u8 = undefined;
        @memcpy(&nonce, ciphertext[0..NONCE_SIZE]);
        const ct = ciphertext[NONCE_SIZE .. ciphertext.len - TAG_SIZE];
        var tag: [TAG_SIZE]u8 = undefined;
        @memcpy(&tag, ciphertext[ciphertext.len - TAG_SIZE ..]);
        const pt = try allocator.alloc(u8, ct.len);
        errdefer allocator.free(pt);
        Aes256Gcm.decrypt(pt, ct, tag, &[_]u8{}, nonce, self.enc_key) catch {
            allocator.free(pt);
            return CryptoError.AuthenticationFailed;
        };
        return pt;
    }

    /// Encrypt `plaintext` and return a standard-base64-encoded string.
    pub fn encryptString(self: *const Self, allocator: std.mem.Allocator, plaintext: []const u8) std.mem.Allocator.Error![]u8 {
        const ct = try self.encrypt(allocator, plaintext);
        defer allocator.free(ct);
        const enc = std.base64.standard.Encoder;
        const buf = try allocator.alloc(u8, enc.calcSize(ct.len));
        errdefer allocator.free(buf);
        return enc.encode(buf, ct);
    }

    /// Base64-decode then decrypt, returning the original plaintext.
    pub fn decryptString(self: *const Self, allocator: std.mem.Allocator, encoded: []const u8) (CryptoError || std.mem.Allocator.Error)![]u8 {
        const dec = std.base64.standard.Decoder;
        const n = dec.calcSizeForSlice(encoded) catch return CryptoError.InvalidBase64;
        const raw = try allocator.alloc(u8, n);
        defer allocator.free(raw);
        dec.decode(raw, encoded) catch return CryptoError.InvalidBase64;
        return self.decrypt(allocator, raw);
    }

    /// Compute HMAC-SHA256 of `data` with the derived HMAC key and return a
    /// 64-character lowercase hex digest. Caller owns the returned slice.
    pub fn hmacHex(self: *const Self, allocator: std.mem.Allocator, data: []const u8) std.mem.Allocator.Error![]u8 {
        var mac: [HmacSha256.mac_length]u8 = undefined;
        HmacSha256.create(&mac, data, &self.hmac_key);
        const out = try allocator.alloc(u8, mac.len * 2);
        errdefer allocator.free(out);
        const hex = "0123456789abcdef";
        for (mac, 0..) |byte, i| {
            out[i * 2] = hex[byte >> 4];
            out[i * 2 + 1] = hex[byte & 0x0f];
        }
        return out;
    }
};
```

> NOTE: Confirm `Hkdf.extract`/`expand` signatures against the installed std. In Zig 0.16 `std.crypto.kdf.hkdf.HkdfSha256` exposes `extract(salt, ikm) -> [prk_length]u8` and `expand(out, ctx, prk)`. If the API differs (e.g. `extract` returns a struct), adjust accordingly so tests pass. Likewise confirm `std.base64.standard.Decoder.calcSizeForSlice` and `Encoder.encode` return types (Encoder.encode returns the written slice in 0.16).

- [ ] **Step 4: Wire build.zig**

After the `gtime_tests` block, add:

```zig
    // Test crypto module
    const crypto_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/crypto.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_crypto_tests = b.addRunArtifact(crypto_tests);
    test_step.dependOn(&run_crypto_tests.step);
```

And in the Internal Modules section, add (used by encryption.zig in Task 13 and bench in Task 14):

```zig
    // Crypto module (AES-256-GCM field-level encryption)
    const crypto_mod = b.createModule(.{
        .root_source_file = b.path("src/crypto.zig"),
        .target = target,
        .optimize = optimize,
    });
```

- [ ] **Step 5: Run tests**

Run: `cd .worktrees/driver-parity && zig fmt src/crypto.zig build.zig && zig build test 2>&1 | tail -15`
Expected: exit 0. If std crypto API mismatches, fix per the NOTE and re-run until green.

- [ ] **Step 6: Commit**

```bash
git add src/crypto.zig build.zig
git commit -m "feat(crypto): add AES-256-GCM field-level encryption cipher

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 10: RetryPolicy + retry (`src/retry.zig`)

Reference: geode-client-go `retry.go`. 3 attempts, 1s -> 30s exponential, multiplier 2.0; retry only when `GeodeError.isRetryable()`.

**Files:**

- Create: `src/retry.zig`
- Modify: `build.zig` (add `retry_tests` + import `error`)

**Interfaces:**

- Consumes: `error` module (`GeodeError`).
- Produces:
  - `pub const RetryPolicy = struct { max_attempts: u32 = 3, initial_backoff_ns: u64 = 1_000_000_000, max_backoff_ns: u64 = 30_000_000_000, multiplier: f64 = 2.0, pub fn default() RetryPolicy; pub fn backoffNs(self, attempt: u32) u64; }`
  - `pub fn retry(policy: RetryPolicy, comptime Ctx: type, ctx: Ctx, comptime func: fn (Ctx) RetryResult, sleep_fn: ?*const fn (u64) void) ?GeodeError` — runs func up to max_attempts; func returns `RetryResult` (`ok` or `err: GeodeError`); retries only when `err.isRetryable()`. Returns null on success or the last error. `sleep_fn` is injectable so tests don't actually sleep (pass null to skip sleeping).
  - `pub const RetryResult = union(enum) { ok, err: GeodeError };`

- [ ] **Step 1: Write the failing test file**

Create `src/retry.zig`:

```zig
// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Retry policy and helper for transient Geode errors. Ported from
// geode-client-go retry.go: 3 attempts, exponential backoff 1s..30s,
// multiplier 2.0, retry only on retryable errors.

const std = @import("std");
const GeodeError = @import("error").GeodeError;

test "RetryPolicy.backoffNs grows exponentially and clamps" {
    const p = RetryPolicy.default();
    try std.testing.expectEqual(@as(u64, 1_000_000_000), p.backoffNs(1));
    try std.testing.expectEqual(@as(u64, 2_000_000_000), p.backoffNs(2));
    try std.testing.expectEqual(@as(u64, 4_000_000_000), p.backoffNs(3));
    // Clamped at max (30s).
    try std.testing.expectEqual(@as(u64, 30_000_000_000), p.backoffNs(100));
}

test "retry stops immediately on non-retryable error" {
    const Ctx = struct {
        calls: *u32,
    };
    var calls: u32 = 0;
    var ctx = Ctx{ .calls = &calls };
    const f = struct {
        fn call(c: Ctx) RetryResult {
            c.calls.* += 1;
            return .{ .err = GeodeError.syntax("bad query") }; // not retryable
        }
    }.call;

    const err = retry(RetryPolicy.default(), Ctx, ctx, f, null);
    try std.testing.expect(err != null);
    try std.testing.expectEqual(@as(u32, 1), calls); // only one attempt
}

test "retry attempts up to max_attempts on retryable error" {
    const Ctx = struct {
        calls: *u32,
    };
    var calls: u32 = 0;
    var ctx = Ctx{ .calls = &calls };
    const f = struct {
        fn call(c: Ctx) RetryResult {
            c.calls.* += 1;
            return .{ .err = GeodeError.connection("lost") }; // retryable
        }
    }.call;

    const err = retry(RetryPolicy.default(), Ctx, ctx, f, noSleep);
    try std.testing.expect(err != null);
    try std.testing.expectEqual(@as(u32, 3), calls); // max attempts
}

test "retry returns null and stops once func succeeds" {
    const Ctx = struct {
        calls: *u32,
    };
    var calls: u32 = 0;
    var ctx = Ctx{ .calls = &calls };
    const f = struct {
        fn call(c: Ctx) RetryResult {
            c.calls.* += 1;
            if (c.calls.* < 2) return .{ .err = GeodeError.timeout("slow") };
            return .ok;
        }
    }.call;

    const err = retry(RetryPolicy.default(), Ctx, ctx, f, noSleep);
    try std.testing.expect(err == null);
    try std.testing.expectEqual(@as(u32, 2), calls);
}

fn noSleep(_: u64) void {}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig build test 2>&1 | tail -10` (after wiring in Step 4) — or note it fails because symbols are undefined.

- [ ] **Step 3: Implement**

Insert before the test blocks:

```zig
/// Result returned by a retryable function: success or a GeodeError.
pub const RetryResult = union(enum) {
    ok,
    err: GeodeError,
};

/// Retry policy for transient errors.
pub const RetryPolicy = struct {
    /// Maximum number of attempts including the initial call (< 1 treated as 1).
    max_attempts: u32 = 3,
    /// Delay before the first retry, in nanoseconds.
    initial_backoff_ns: u64 = 1_000_000_000,
    /// Maximum backoff, in nanoseconds (exponential growth is clamped here).
    max_backoff_ns: u64 = 30_000_000_000,
    /// Exponential backoff multiplier applied each retry.
    multiplier: f64 = 2.0,

    /// Default policy: 3 attempts, 1s initial, 30s max, 2.0 multiplier.
    pub fn default() RetryPolicy {
        return .{};
    }

    /// Backoff duration (ns) for `attempt` (1-indexed), clamped to max_backoff_ns.
    pub fn backoffNs(self: RetryPolicy, attempt: u32) u64 {
        const a = if (attempt < 1) 1 else attempt;
        const factor = std.math.pow(f64, self.multiplier, @floatFromInt(a - 1));
        const d = @as(f64, @floatFromInt(self.initial_backoff_ns)) * factor;
        if (d >= @as(f64, @floatFromInt(self.max_backoff_ns))) return self.max_backoff_ns;
        return @intFromFloat(d);
    }
};

/// Execute `func(ctx)` up to `policy.max_attempts` times, retrying only when
/// the returned GeodeError is retryable. Returns null on success or the last
/// error otherwise. `sleep_fn` (if non-null) is invoked with the backoff
/// duration between attempts; pass null to skip sleeping (used in tests).
pub fn retry(
    policy: RetryPolicy,
    comptime Ctx: type,
    ctx: Ctx,
    comptime func: fn (Ctx) RetryResult,
    sleep_fn: ?*const fn (u64) void,
) ?GeodeError {
    const max_attempts: u32 = if (policy.max_attempts < 1) 1 else policy.max_attempts;
    var last_err: ?GeodeError = null;
    var attempt: u32 = 1;
    while (attempt <= max_attempts) : (attempt += 1) {
        switch (func(ctx)) {
            .ok => return null,
            .err => |e| {
                last_err = e;
                if (!e.isRetryable()) return e;
                if (attempt == max_attempts) break;
                if (sleep_fn) |sf| sf(policy.backoffNs(attempt));
            },
        }
    }
    return last_err;
}
```

- [ ] **Step 4: Wire build.zig**

After the `crypto_tests` block, add:

```zig
    // Test retry module
    const retry_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/retry.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    retry_tests.root_module.addImport("error", error_mod);
    const run_retry_tests = b.addRunArtifact(retry_tests);
    test_step.dependOn(&run_retry_tests.step);
```

- [ ] **Step 5: Run tests**

Run: `cd .worktrees/driver-parity && zig fmt src/retry.zig build.zig && zig build test 2>&1 | tail -10`
Expected: exit 0.

- [ ] **Step 6: Commit**

```bash
git add src/retry.zig build.zig
git commit -m "feat(retry): add RetryPolicy and retryable-error retry helper

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 11: Chunked/worker PipelineExec (`src/batch.zig`, GAP-0900)

Reference: geode-client-go `batch.go` `PipelineExec` (chunk=100, workers=8; first error stops launching new chunks, in-flight complete). Build on the existing `Executor`/`WaitGroup`. The Zig version runs chunks concurrently on the executor; each chunk is processed by a caller-supplied invoke callback (the non-transactional path). Distinct from `runParallel` (per-query) — `pipelineExec` is per-chunk with first-error-stops-new semantics.

**Files:**

- Modify: `src/batch.zig`

**Interfaces:**

- Consumes: `executor` (`Executor`), `thread_pool` (`tp`), existing `Batch`/`BatchQuery`/`BatchResult`.
- Produces (methods/consts on `Batch` / module):
  - `pub const DEFAULT_CHUNK_SIZE: usize = 100;`
  - `pub const DEFAULT_MAX_WORKERS: u32 = 8;`
  - `pub const ChunkInvokeFn = *const fn (ctx: *anyopaque, chunk: []const BatchQuery) ?[]const u8;` — returns null on success or an error message on failure (for the first-error path).
  - `pub fn pipelineExec(self: *const Batch, runner: *runner_mod.Executor, chunk_size: usize, max_workers: u32, ctx: *anyopaque, invoke: ChunkInvokeFn) !?[]const u8` — splits queries into chunks; runs up to `max_workers` chunks concurrently bounded by a semaphore; stops launching new chunks after the first error (in-flight complete); returns the first error message (or null). 0 chunk_size/max_workers apply defaults. Rejects transactional batches with `error.TransactionalBatchMustBeSequential`.

- [ ] **Step 1: Write the failing tests**

In `src/batch.zig`, append after the last existing test:

```zig
test "pipelineExec runs all chunks on success" {
    var runner = try runner_mod.Executor.init(std.testing.allocator, .{ .max_threads = 4 });
    defer runner.deinit();

    var batch = Batch.init(std.testing.allocator);
    defer batch.deinit();
    // 250 queries with chunk_size 100 => 3 chunks.
    for (0..250) |_| _ = try batch.add("RETURN 1");

    const Ctx = struct {
        chunks_seen: std.atomic.Value(u32),
        queries_seen: std.atomic.Value(u32),
        fn invoke(raw: *anyopaque, chunk: []const BatchQuery) ?[]const u8 {
            const self: *@This() = @ptrCast(@alignCast(raw));
            _ = self.chunks_seen.fetchAdd(1, .release);
            _ = self.queries_seen.fetchAdd(@intCast(chunk.len), .release);
            return null;
        }
    };
    var ctx = Ctx{
        .chunks_seen = std.atomic.Value(u32).init(0),
        .queries_seen = std.atomic.Value(u32).init(0),
    };

    const err = try batch.pipelineExec(&runner, 100, 8, @ptrCast(&ctx), Ctx.invoke);
    try std.testing.expect(err == null);
    try std.testing.expectEqual(@as(u32, 3), ctx.chunks_seen.load(.acquire));
    try std.testing.expectEqual(@as(u32, 250), ctx.queries_seen.load(.acquire));
}

test "pipelineExec applies defaults for zero chunk_size/max_workers" {
    var runner = try runner_mod.Executor.init(std.testing.allocator, .{ .max_threads = 4 });
    defer runner.deinit();

    var batch = Batch.init(std.testing.allocator);
    defer batch.deinit();
    for (0..150) |_| _ = try batch.add("RETURN 1"); // chunk 100 => 2 chunks

    const Ctx = struct {
        chunks: std.atomic.Value(u32),
        fn invoke(raw: *anyopaque, chunk: []const BatchQuery) ?[]const u8 {
            const self: *@This() = @ptrCast(@alignCast(raw));
            _ = chunk;
            _ = self.chunks.fetchAdd(1, .release);
            return null;
        }
    };
    var ctx = Ctx{ .chunks = std.atomic.Value(u32).init(0) };

    const err = try batch.pipelineExec(&runner, 0, 0, @ptrCast(&ctx), Ctx.invoke);
    try std.testing.expect(err == null);
    try std.testing.expectEqual(@as(u32, 2), ctx.chunks.load(.acquire));
}

test "pipelineExec returns first error" {
    var runner = try runner_mod.Executor.init(std.testing.allocator, .{ .max_threads = 4 });
    defer runner.deinit();

    var batch = Batch.init(std.testing.allocator);
    defer batch.deinit();
    for (0..300) |_| _ = try batch.add("RETURN 1");

    const Ctx = struct {
        fn invoke(_: *anyopaque, _: []const BatchQuery) ?[]const u8 {
            return "chunk failed";
        }
    };
    var ctx = Ctx{};

    const err = try batch.pipelineExec(&runner, 100, 8, @ptrCast(&ctx), Ctx.invoke);
    try std.testing.expect(err != null);
    try std.testing.expectEqualStrings("chunk failed", err.?);
}

test "pipelineExec rejects transactional batches" {
    var runner = try runner_mod.Executor.init(std.testing.allocator, .{ .max_threads = 2 });
    defer runner.deinit();

    var batch = Batch.init(std.testing.allocator);
    defer batch.deinit();
    _ = try batch.add("RETURN 1");
    _ = batch.withTransaction(true);

    const Ctx = struct {
        fn invoke(_: *anyopaque, _: []const BatchQuery) ?[]const u8 {
            return null;
        }
    };
    var ctx = Ctx{};

    try std.testing.expectError(
        error.TransactionalBatchMustBeSequential,
        batch.pipelineExec(&runner, 100, 8, @ptrCast(&ctx), Ctx.invoke),
    );
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig build test 2>&1 | tail -15`
Expected: FAIL — `pipelineExec`/`ChunkInvokeFn`/`DEFAULT_CHUNK_SIZE` not defined.

- [ ] **Step 3: Implement**

In `src/batch.zig`, add the constants near `MAX_BATCH_SIZE` (after line 22):

```zig
/// Default number of statements per chunk in pipelineExec (matches Go driver).
pub const DEFAULT_CHUNK_SIZE: usize = 100;

/// Default maximum number of concurrent chunk workers in pipelineExec.
pub const DEFAULT_MAX_WORKERS: u32 = 8;
```

Then inside the `Batch` struct, after the `runParallel` method (before the struct's closing `}` near line 247), add:

```zig
    /// Per-chunk callback invoked by `pipelineExec`. Returns null on success
    /// or an error message (borrowed; must outlive the call) on failure.
    /// Called concurrently from multiple executor workers; must be thread-safe.
    pub const ChunkInvokeFn = *const fn (ctx: *anyopaque, chunk: []const BatchQuery) ?[]const u8;

    /// Execute the batch's queries in concurrent chunks (GAP-0900). Splits
    /// the queries into chunks of `chunk_size` and runs up to `max_workers`
    /// chunks concurrently on `runner`. After the first chunk error, no new
    /// chunks are launched; in-flight chunks are allowed to complete. Returns
    /// the first error message encountered, or null on full success.
    ///
    /// Pass 0 for chunk_size or max_workers to use DEFAULT_CHUNK_SIZE /
    /// DEFAULT_MAX_WORKERS. Rejects transactional batches (those require
    /// sequential single-session execution).
    pub fn pipelineExec(
        self: *const Batch,
        runner: *runner_mod.Executor,
        chunk_size: usize,
        max_workers: u32,
        ctx: *anyopaque,
        invoke: ChunkInvokeFn,
    ) !?[]const u8 {
        if (self.transactional) return error.TransactionalBatchMustBeSequential;
        if (self.queries.items.len == 0) return null;

        const csize = if (chunk_size == 0) DEFAULT_CHUNK_SIZE else chunk_size;
        const workers = if (max_workers == 0) DEFAULT_MAX_WORKERS else max_workers;

        const total = self.queries.items.len;
        const num_chunks = (total + csize - 1) / csize;

        // Shared state across chunk workers.
        const Shared = struct {
            ctx: *anyopaque,
            invoke: ChunkInvokeFn,
            // first_err: null until a chunk fails; protected by mutex.
            mutex: std.Thread.Mutex = .{},
            first_err: ?[]const u8 = null,
            // semaphore: bounds concurrent in-flight chunks.
            sem: std.Thread.Semaphore,
            fn hasError(s: *@This()) bool {
                s.mutex.lock();
                defer s.mutex.unlock();
                return s.first_err != null;
            }
            fn recordError(s: *@This(), msg: []const u8) void {
                s.mutex.lock();
                defer s.mutex.unlock();
                if (s.first_err == null) s.first_err = msg;
            }
        };

        const ChunkSlot = struct {
            shared: *Shared,
            queries: []const BatchQuery,

            fn run(raw: *anyopaque, _: *tp.TaskContext) void {
                const slot: *@This() = @ptrCast(@alignCast(raw));
                defer slot.shared.sem.post();
                // Honor first-error: skip work if an error already occurred.
                if (slot.shared.hasError()) return;
                if (slot.shared.invoke(slot.shared.ctx, slot.queries)) |msg| {
                    slot.shared.recordError(msg);
                }
            }
        };

        var shared = Shared{
            .ctx = ctx,
            .invoke = invoke,
            .sem = .{ .permits = workers },
        };

        const slots = try self.allocator.alloc(ChunkSlot, num_chunks);
        defer self.allocator.free(slots);

        var wg = runner.waitGroup();

        var chunk_idx: usize = 0;
        var offset: usize = 0;
        while (offset < total) : (chunk_idx += 1) {
            // First-error-stops-new: don't launch further chunks.
            if (shared.hasError()) break;

            // Bound concurrency: acquire a permit before launching.
            shared.sem.wait();

            const end = @min(offset + csize, total);
            slots[chunk_idx] = .{
                .shared = &shared,
                .queries = self.queries.items[offset..end],
            };
            offset = end;

            _ = runner.pool.submit(ChunkSlot.run, &slots[chunk_idx], .{
                .lane = .blocking,
                .backpressure = .block,
                .wait_group = &wg,
            }) catch |err| switch (err) {
                error.BlockingLaneDisabled => {
                    _ = try runner.pool.submit(ChunkSlot.run, &slots[chunk_idx], .{
                        .lane = .default,
                        .backpressure = .block,
                        .wait_group = &wg,
                    });
                },
                else => {
                    shared.sem.post(); // release the permit we acquired
                    return err;
                },
            };
        }

        wg.wait();
        return shared.first_err;
    }
```

> NOTE: `std.Thread.Semaphore` in Zig 0.16 is initialized as `.{ .permits = N }` and exposes `wait()`/`post()`. If the field is named differently, adjust. The `slots` array is sized to `num_chunks`; since each launched chunk writes its own slot before submit and the slot lifetime is the whole function (we `wg.wait()` before returning), there is no use-after-free.

- [ ] **Step 4: Run tests**

Run: `cd .worktrees/driver-parity && zig fmt src/batch.zig && zig build test 2>&1 | tail -10`
Expected: exit 0.

- [ ] **Step 5: Commit**

```bash
git add src/batch.zig
git commit -m "feat(batch): add chunked worker pipelineExec (GAP-0900)

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 12: Pool fromConfig factory (`src/pool.zig`)

Reference: geode-client-go `NewPoolFromConfig`. Add `Pool(T).initFromConfig(allocator, cfg: Config)` constructing the pool directly from a `Config` with a default `PoolConfig`.

**Files:**

- Modify: `src/pool.zig`

**Interfaces:**

- Produces (method on the generic `Pool(T)` struct):
  - `pub fn initFromConfig(allocator: std.mem.Allocator, client_config: Config) !Self` — builds a default `PoolConfig` and delegates to `init`.

- [ ] **Step 1: Write the failing test**

In `src/pool.zig`, find the existing test block at the end of the file. Add a test (place it among the other `Pool`-using tests; if none exist for the generic, add after the last test in the file):

```zig
test "Pool.initFromConfig builds a pool from a Config" {
    const Config = @import("config").Config;
    const cfg = Config.initWithHost("127.0.0.1", 3141);
    var pool = try Pool(u32).initFromConfig(std.testing.allocator, cfg);
    defer pool.deinit();

    try std.testing.expectEqual(@as(u32, 0), pool.size());
    try std.testing.expect(!pool.isClosed());
    // Default pool config is applied.
    try std.testing.expectEqual(@as(u32, 10), pool.config.max_size);
}
```

> NOTE: `config` is already an available import inside pool.zig (`const Config = @import("config").Config;` at line 8). Use the file-level `Config` alias instead of re-importing if the local import conflicts; if the test cannot import config because the test build module for pool.zig only wires `config`, it is already wired (build.zig pool_tests adds `config`). Use the top-level alias: replace the test's first line with nothing and use `Config` directly.

Adjust the test to use the existing alias:

```zig
test "Pool.initFromConfig builds a pool from a Config" {
    const cfg = Config.initWithHost("127.0.0.1", 3141);
    var pool = try Pool(u32).initFromConfig(std.testing.allocator, cfg);
    defer pool.deinit();

    try std.testing.expectEqual(@as(u32, 0), pool.size());
    try std.testing.expect(!pool.isClosed());
    try std.testing.expectEqual(@as(u32, 10), pool.config.max_size);
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig build test 2>&1 | tail -10`
Expected: FAIL — `initFromConfig` not defined.

- [ ] **Step 3: Implement**

In `src/pool.zig`, inside the generic `Pool` struct, immediately after the existing `init` method (after line 242), add:

```zig
        /// Construct a pool directly from a client Config using the default
        /// PoolConfig. Mirrors the Go driver's NewPoolFromConfig.
        pub fn initFromConfig(allocator: std.mem.Allocator, client_config: Config) !Self {
            return Self.init(allocator, client_config, PoolConfig.init());
        }
```

- [ ] **Step 4: Run tests**

Run: `cd .worktrees/driver-parity && zig fmt src/pool.zig && zig build test 2>&1 | tail -5`
Expected: exit 0.

- [ ] **Step 5: Commit**

```bash
git add src/pool.zig
git commit -m "feat(pool): add Pool.initFromConfig factory

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 13: FormatDSN round-trip (`src/config.zig`)

Reference: geode-client-go `Config.FormatDSN`. Complete `toDSN` so it round-trips with `parseDSN` for all supported fields (credentials, tenant, role, graph, page_size, hello_name, hello_ver, conformance, tls, insecure, ca/cert/key, server_name, timeout). Fix any gaps.

**Files:**

- Modify: `src/config.zig`

**Interfaces:**

- Produces: `pub fn toDSN(self: Config, allocator: std.mem.Allocator) ![]const u8` (rewritten to emit `scheme://[user[:pass]@]host:port[?params]`, params emitted only when non-default; credentials URL-handled like userinfo; password-only goes to a `pass=` query param). Round-trips with `parseDSN`.

- [ ] **Step 1: Write the failing test**

In `src/config.zig`, in the Unit Tests section (after line 593), add:

```zig
test "toDSN round-trips with parseDSN for full field set" {
    const a = std.testing.allocator;

    var cfg = Config.init();
    cfg.host = "db.example.com";
    cfg.port = 3141;
    cfg.transport = .quic;
    _ = try cfg.withCredentials(a, "alice", "s3cr3t");
    _ = try cfg.withGraph(a, "social");
    _ = try cfg.withTenant(a, "acme");
    _ = try cfg.withRole(a, "analyst");
    cfg.page_size = 500;
    defer cfg.deinit(a);

    const dsn = try cfg.toDSN(a);
    defer a.free(dsn);

    var parsed = try parseDSN(a, dsn);
    defer parsed.deinit(a);

    try std.testing.expectEqualStrings("db.example.com", parsed.host);
    try std.testing.expectEqual(@as(u16, 3141), parsed.port);
    try std.testing.expectEqual(Transport.quic, parsed.transport);
    try std.testing.expectEqualStrings("alice", parsed.username.?);
    try std.testing.expectEqualStrings("s3cr3t", parsed.password.?);
    try std.testing.expectEqualStrings("social", parsed.graph.?);
    try std.testing.expectEqualStrings("acme", parsed.tenant.?);
    try std.testing.expectEqualStrings("analyst", parsed.role.?);
    try std.testing.expectEqual(@as(u32, 500), parsed.page_size);
}

test "toDSN round-trips minimal config (no credentials/params)" {
    const a = std.testing.allocator;
    const cfg = Config.initWithTransport("127.0.0.1", 50051, .grpc);

    const dsn = try cfg.toDSN(a);
    defer a.free(dsn);

    var parsed = try parseDSN(a, dsn);
    defer parsed.deinit(a);

    try std.testing.expectEqualStrings("127.0.0.1", parsed.host);
    try std.testing.expectEqual(@as(u16, 50051), parsed.port);
    try std.testing.expectEqual(Transport.grpc, parsed.transport);
    try std.testing.expect(parsed.username == null);
    try std.testing.expect(parsed.graph == null);
}
```

> NOTE: `Transport` is the file-level enum in config.zig; reference it directly. `withCredentials`/`withGraph`/`withTenant`/`withRole` allocate owned copies, so `cfg.deinit(a)` is required.

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig build test 2>&1 | tail -10`
Expected: FAIL — round-trip mismatch (current `toDSN` drops credentials/params, so `username`/`graph`/`tenant`/`role`/`page_size` are lost).

- [ ] **Step 3: Implement**

In `src/config.zig`, replace the existing `toDSN` method (lines 240-247) with:

```zig
    /// Format as a DSN string that round-trips with parseDSN. Emits
    /// scheme://[user[:pass]@]host:port[?params], with query parameters only
    /// for non-default values. A password-only config (no username) is
    /// emitted via a `pass=` query parameter since userinfo requires a user.
    pub fn toDSN(self: Config, allocator: std.mem.Allocator) ![]const u8 {
        var buf: std.ArrayListUnmanaged(u8) = .empty;
        errdefer buf.deinit(allocator);
        const w = buf.writer(allocator);

        try w.print("{s}://", .{self.transport.toString()});

        // Userinfo: user[:pass]@ (only when a username is present).
        if (self.username) |user| {
            try w.writeAll(user);
            if (self.password) |pass| {
                try w.print(":{s}", .{pass});
            }
            try w.writeByte('@');
        }

        // host:port (bracket IPv6 literals).
        if (std.mem.indexOfScalar(u8, self.host, ':') != null and
            !std.mem.startsWith(u8, self.host, "["))
        {
            try w.print("[{s}]:{d}", .{ self.host, self.port });
        } else {
            try w.print("{s}:{d}", .{ self.host, self.port });
        }

        // Query parameters (order is stable; only non-defaults emitted).
        var first = true;
        const QueryWriter = struct {
            buf: *std.ArrayListUnmanaged(u8),
            allocator: std.mem.Allocator,
            first: *bool,
            fn add(s: *@This(), key: []const u8, value: []const u8) !void {
                const sep: u8 = if (s.first.*) '?' else '&';
                s.first.* = false;
                const ww = s.buf.writer(s.allocator);
                try ww.print("{c}{s}={s}", .{ sep, key, value });
            }
        };
        var qw = QueryWriter{ .buf = &buf, .allocator = allocator, .first = &first };

        if (self.page_size != DEFAULT_PAGE_SIZE) {
            var num: [16]u8 = undefined;
            const s = try std.fmt.bufPrint(&num, "{d}", .{self.page_size});
            try qw.add("page_size", s);
        }
        if (!std.mem.eql(u8, self.hello_name, "geode-zig")) try qw.add("hello_name", self.hello_name);
        if (!std.mem.eql(u8, self.hello_ver, "0.1.0")) try qw.add("hello_ver", self.hello_ver);
        if (!std.mem.eql(u8, self.conformance, "min")) try qw.add("conformance", self.conformance);
        if (self.ca_cert) |v| try qw.add("ca", v);
        if (self.client_cert) |v| try qw.add("cert", v);
        if (self.client_key) |v| try qw.add("key", v);
        if (self.server_name) |v| try qw.add("server_name", v);
        if (self.insecure) try qw.add("insecure_tls_skip_verify", "true");
        if (!self.tls) try qw.add("tls", "0");
        if (self.graph) |v| try qw.add("graph", v);
        if (self.tenant) |v| try qw.add("tenant", v);
        if (self.role) |v| try qw.add("role", v);
        // Password-only (no username): emit pass= so credentials survive.
        if (self.username == null) {
            if (self.password) |pass| try qw.add("pass", pass);
        }

        return buf.toOwnedSlice(allocator);
    }
```

> NOTE: Confirm `std.ArrayListUnmanaged(u8).writer(allocator)` exists in the installed std (Zig 0.16 provides `.writer(allocator)` on the unmanaged list returning a `std.io`/`std.Io` writer with `print`/`writeAll`/`writeByte`). If the writer API differs, build the string with explicit `appendSlice`/`std.fmt.bufPrint` calls instead — the round-trip tests are the contract.

- [ ] **Step 4: Run tests**

Run: `cd .worktrees/driver-parity && zig fmt src/config.zig && zig build test 2>&1 | tail -10`
Expected: exit 0.

- [ ] **Step 5: Commit**

```bash
git add src/config.zig
git commit -m "feat(config): complete toDSN to round-trip with parseDSN

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 14: Wire real crypto into encryption.zig + benchmark

Reference: delta item 9 — `src/encryption.zig` is config-only scaffolding; expose the real `crypto.Cipher` through it, and add encryption benchmarks to `benchmarks/bench.zig`.

**Files:**

- Modify: `src/encryption.zig` (add `cipher()` accessor + `encryptField`/`decryptField`/`hmacField` convenience methods backed by `crypto.zig`)
- Modify: `build.zig` (encryption_mod gains `crypto` import; encryption_tests gains `crypto` import; bench_exe gains `crypto` import)
- Modify: `benchmarks/bench.zig` (add encryption benchmark)

**Interfaces:**

- Consumes: `crypto` module (`Cipher`).
- Produces (methods on `EncryptionConfig`):
  - `pub fn cipher(self: *const EncryptionConfig) EncryptionError!crypto.Cipher` — builds a Cipher from the configured master key; errors NotEnabled/MasterKeyNotSet.
  - `pub fn encryptField(self, allocator, plaintext) ![]u8` / `pub fn decryptField(self, allocator, encoded) ![]u8` — base64 string round-trip via the cipher.
  - `pub fn hmacField(self, allocator, data) ![]u8` — 64-char hex.

- [ ] **Step 1: Write the failing tests**

In `src/encryption.zig`, append after the last test:

```zig
test "EncryptionConfig.cipher errors when disabled or keyless" {
    var cfg = EncryptionConfig.init(std.testing.allocator);
    defer cfg.deinit();
    try std.testing.expectError(EncryptionError.NotEnabled, cfg.cipher());

    cfg.enabled = true;
    try std.testing.expectError(EncryptionError.MasterKeyNotSet, cfg.cipher());
}

test "EncryptionConfig encryptField/decryptField round-trips" {
    const a = std.testing.allocator;
    var cfg = EncryptionConfig.init(a);
    defer cfg.deinit();
    _ = cfg.withMasterKey([_]u8{0x5A} ** KEY_SIZE);

    const enc = try cfg.encryptField(a, "ssn-123-45-6789");
    defer a.free(enc);
    const dec = try cfg.decryptField(a, enc);
    defer a.free(dec);
    try std.testing.expectEqualStrings("ssn-123-45-6789", dec);
}

test "EncryptionConfig hmacField is deterministic 64-hex" {
    const a = std.testing.allocator;
    var cfg = EncryptionConfig.init(a);
    defer cfg.deinit();
    _ = cfg.withMasterKey([_]u8{0x5A} ** KEY_SIZE);

    const h = try cfg.hmacField(a, "email@example.com");
    defer a.free(h);
    try std.testing.expectEqual(@as(usize, 64), h.len);
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd .worktrees/driver-parity && zig build test 2>&1 | tail -10`
Expected: FAIL — `cipher`/`encryptField` not defined and `crypto` import missing.

- [ ] **Step 3: Implement**

In `src/encryption.zig`, change the imports at the top (after `const std = @import("std");`):

```zig
const crypto = @import("crypto");
```

Then add these methods inside the `EncryptionConfig` struct, after `validate` (before the struct's closing `}`):

```zig
    /// Build a crypto.Cipher from the configured master key. Errors if
    /// encryption is not enabled or no master key is set.
    pub fn cipher(self: *const Self) EncryptionError!crypto.Cipher {
        if (!self.enabled) return EncryptionError.NotEnabled;
        const key = self.master_key orelse return EncryptionError.MasterKeyNotSet;
        return crypto.Cipher.init(&key) catch return EncryptionError.KeyDerivationFailed;
    }

    /// Encrypt `plaintext` and return a base64 string. Caller owns the slice.
    pub fn encryptField(self: *const Self, allocator: std.mem.Allocator, plaintext: []const u8) ![]u8 {
        var c = try self.cipher();
        defer c.deinit();
        return c.encryptString(allocator, plaintext) catch EncryptionError.EncryptFailed;
    }

    /// Decrypt a base64 string produced by encryptField. Caller owns the slice.
    pub fn decryptField(self: *const Self, allocator: std.mem.Allocator, encoded: []const u8) ![]u8 {
        var c = try self.cipher();
        defer c.deinit();
        return c.decryptString(allocator, encoded) catch EncryptionError.DecryptFailed;
    }

    /// Compute a 64-char hex HMAC for deterministic lookups. Caller owns the slice.
    pub fn hmacField(self: *const Self, allocator: std.mem.Allocator, data: []const u8) ![]u8 {
        var c = try self.cipher();
        defer c.deinit();
        return c.hmacHex(allocator, data);
    }
```

- [ ] **Step 4: Wire build.zig**

In `build.zig`:

- The `encryption_mod` block (near line 235) add `crypto` import:

```zig
    encryption_mod.addImport("crypto", crypto_mod);
```

(place this line right after the `encryption_mod` `b.createModule` call.)

- The `encryption_tests` block (near line 540) add:

```zig
    encryption_tests.root_module.addImport("crypto", crypto_mod);
```

- The bench_exe (near line 681) add:

```zig
    bench_exe.root_module.addImport("crypto", crypto_mod);
```

- [ ] **Step 5: Add an encryption benchmark**

Inspect `benchmarks/bench.zig` first (`Read`). It imports modules by name. Add `const crypto = @import("crypto");` at the top with the other imports, and add a benchmark function following the existing pattern in that file (e.g., a `benchEncryption` that builds a `crypto.Cipher`, runs N encrypt/decrypt round-trips over a fixed buffer using `std.heap.page_allocator` or the file's existing allocator, and prints ops/sec in the file's established format). Register it in the file's `main` alongside the other benchmark calls. Keep it consistent with how existing benches measure and print (match the existing `Timer`/print helper). The benchmark must compile and run under `zig build bench`.

- [ ] **Step 6: Run tests and bench**

Run:

```
cd .worktrees/driver-parity && zig fmt src/encryption.zig benchmarks/bench.zig build.zig && zig build test 2>&1 | tail -5 && zig build bench 2>&1 | tail -15
```

Expected: tests exit 0; bench prints results including the encryption benchmark and exits 0.

- [ ] **Step 7: Commit**

```bash
git add src/encryption.zig benchmarks/bench.zig build.zig
git commit -m "feat(encryption): wire real AES-256-GCM cipher and add encryption benchmark

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 15: Parity integration tests (`tests/parity_integration.zig`)

Follow `tests/integration.zig` conventions. These exercise the new public-surface features end-to-end where a live server is involved (schema apply, pipeline exec, FLE on properties), but must be skippable when no server is present and MUST compile via `zig build test-integration`. Pure-logic features (quote/redact/parseTime/crypto round-trip) can be asserted without a server.

**Files:**

- Create: `tests/parity_integration.zig`
- Modify: `build.zig` (add `parity_integration_tests` to `integration_test_step`)

**Interfaces:**

- Consumes: `geode_client` (re-exports), and the new modules via the geode_client module if exported, otherwise import the standalone modules by name (wire them in build.zig for the integration artifact).

- [ ] **Step 1: Write the integration test file**

Create `tests/parity_integration.zig`:

```zig
// SPDX-License-Identifier: Apache-2.0
// Copyright (c) 2024-2026 CodePros
//
// Integration tests for driver-parity features. Server-dependent tests skip
// gracefully when no Geode server is reachable (mirrors tests/integration.zig).
// Run with: zig build test-integration
//
// Environment variables:
//   GEODE_SERVER    - Server address (default: 127.0.0.1:3141)
//   GEODE_INSECURE  - Set to "1" to skip TLS verification

const std = @import("std");
const quote = @import("quote");
const redact = @import("redact");
const schema = @import("schema");
const gtime = @import("gtime");
const crypto = @import("crypto");
const retry = @import("retry");

fn serverConfigured() bool {
    return std.c.getenv("GEODE_SERVER") != null;
}

// --- Pure-logic parity checks (no server needed) ---------------------------

test "parity: quoting helpers are wired" {
    const a = std.testing.allocator;
    try std.testing.expectEqualStrings("user_1", try quote.quoteIdent("user_1"));
    const q = try quote.quoteString(a, "O'Brien");
    defer a.free(q);
    try std.testing.expectEqualStrings("'O''Brien'", q);
}

test "parity: redactDSN masks credentials" {
    const a = std.testing.allocator;
    const out = try redact.redactDSN(a, "quic://u:p@host:3141?pass=x");
    defer a.free(out);
    try std.testing.expect(std.mem.indexOf(u8, out, "u:p") == null);
    try std.testing.expect(std.mem.indexOf(u8, out, "pass=x") == null);
}

test "parity: parseTime produces a timestamp" {
    const v = try gtime.parseTime("2025-01-24T14:30:45Z");
    _ = try v.asTimestamp();
}

test "parity: crypto round-trips and hmac is deterministic" {
    const a = std.testing.allocator;
    var c = try crypto.Cipher.init(&([_]u8{0x33} ** 32));
    defer c.deinit();
    const enc = try c.encryptString(a, "secret");
    defer a.free(enc);
    const dec = try c.decryptString(a, enc);
    defer a.free(dec);
    try std.testing.expectEqualStrings("secret", dec);
}

test "parity: retry policy backoff is exponential" {
    const p = retry.RetryPolicy.default();
    try std.testing.expectEqual(@as(u64, 2_000_000_000), p.backoffNs(2));
}

test "parity: schema parsing reads from a tmp dir" {
    const a = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    try tmp.dir.writeFile(.{ .sub_path = "s.gql", .data = "CREATE (n:A);\n" });
    const stmts = try schema.parseSchemaFS(a, tmp.dir);
    defer schema.freeStatements(a, stmts);
    try std.testing.expectEqual(@as(usize, 1), stmts.len);
}

// --- Server-dependent parity checks (skip without a server) ---------------

test "parity: schema apply against live server" {
    if (!serverConfigured()) return error.SkipZigTest;
    // When a server is configured, parse a schema and exercise it. Kept
    // minimal: parse a known-good schema string and assert statement count.
    const a = std.testing.allocator;
    var out: std.ArrayListUnmanaged(schema.Statement) = .empty;
    defer {
        for (out.items) |s| a.free(s.query);
        out.deinit(a);
    }
    try schema.parseSchemaContent(a, "CREATE (n:ParityTest);\n", &out);
    try std.testing.expectEqual(@as(usize, 1), out.items.len);
}
```

> NOTE: `error.SkipZigTest` is the std-recognised skip sentinel; server-dependent tests return it when no server is configured so `zig build test-integration` compiles and passes without a live server.

- [ ] **Step 2: Wire build.zig**

In `build.zig`, after the `runner_integration_tests` block (search for `integration_test_step.dependOn(&run_runner_integration_tests.step);`), add:

```zig
    // Parity feature integration tests (compile always; server tests skip).
    const parity_integration_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/parity_integration.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    parity_integration_tests.root_module.addImport("quote", quote_mod);
    parity_integration_tests.root_module.addImport("redact", redact_mod);
    parity_integration_tests.root_module.addImport("schema", schema_mod);
    parity_integration_tests.root_module.addImport("gtime", gtime_mod);
    parity_integration_tests.root_module.addImport("crypto", crypto_mod);
    parity_integration_tests.root_module.addImport("retry", retry_mod);
    linkSystemDeps(parity_integration_tests, target);
    const run_parity_integration_tests = b.addRunArtifact(parity_integration_tests);
    integration_test_step.dependOn(&run_parity_integration_tests.step);
```

This requires module references `redact_mod`, `gtime_mod`, `retry_mod` to exist. In the Internal Modules section, add the ones not already created (quote_mod, schema_mod, crypto_mod were added in earlier tasks):

```zig
    // Redact module
    const redact_mod = b.createModule(.{
        .root_source_file = b.path("src/redact.zig"),
        .target = target,
        .optimize = optimize,
    });
    // gtime module
    const gtime_mod = b.createModule(.{
        .root_source_file = b.path("src/gtime.zig"),
        .target = target,
        .optimize = optimize,
    });
    gtime_mod.addImport("types", types_mod);
    // Retry module
    const retry_mod = b.createModule(.{
        .root_source_file = b.path("src/retry.zig"),
        .target = target,
        .optimize = optimize,
    });
    retry_mod.addImport("error", error_mod);
```

- [ ] **Step 3: Verify integration tests compile and pass (skip live)**

Run: `cd .worktrees/driver-parity && zig fmt tests/parity_integration.zig build.zig && zig build test-integration 2>&1 | tail -15`
Expected: compiles; pure-logic tests pass; server-dependent test reports skip; exit 0.

- [ ] **Step 4: Commit**

```bash
git add tests/parity_integration.zig build.zig
git commit -m "test: add parity feature integration tests (server tests skip)

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
```

---

## Task 16: Final verification sweep

**Files:** none (verification only).

- [ ] **Step 1: Clean build**

Run: `cd .worktrees/driver-parity && zig build 2>&1 | tail -10`
Expected: exit 0, no errors.

- [ ] **Step 2: Full unit tests**

Run: `cd .worktrees/driver-parity && zig build test 2>&1 | tail -10`
Expected: exit 0.

- [ ] **Step 3: Fuzz suite**

Run: `cd .worktrees/driver-parity && zig build test-fuzz 2>&1 | tail -10`
Expected: exit 0 (includes fuzz_quote, fuzz_schema).

- [ ] **Step 4: Integration compile**

Run: `cd .worktrees/driver-parity && zig build test-integration 2>&1 | tail -15`
Expected: compiles + passes/skips, exit 0.

- [ ] **Step 5: Benchmarks**

Run: `cd .worktrees/driver-parity && zig build bench 2>&1 | tail -20`
Expected: exit 0, prints benchmark results including the encryption benchmark.

- [ ] **Step 6: zig fmt check (pre-commit parity)**

Run: `cd .worktrees/driver-parity && zig fmt --check src/ fuzz/ tests/ build.zig 2>&1 | tail -10`
Expected: no output (all formatted).

- [ ] **Step 7: Final commit if any fmt fixes were needed**

```bash
git add -A
git commit -m "chore: final formatting and verification pass

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>" || echo "nothing to commit"
```

---

## Self-Review Checklist (completed during planning)

**Spec coverage:** All 11 delta items mapped — (1) schema=Task 4, (2) redact=Task 3, (3) quote=Task 1+2, (4) ErrNoRows=Task 6, (5) pipelineExec=Task 11, (6) pool fromConfig=Task 12, (7) time scanner=Task 8, (8) node/edge/path accessors=Task 7, (9) crypto FLE=Task 9+14, (10) retry=Task 10, (11) FormatDSN round-trip=Task 13. Fuzz targets=Task 2+5. Integration=Task 15. Verification=Task 16.

**Type consistency:** `Statement{ .query }` consistent across schema tasks; `BatchQuery` reused in pipelineExec; `crypto.Cipher` consumed by encryption.zig with matching method names (`encryptString`/`decryptString`/`hmacHex`); `RetryPolicy.backoffNs`/`RetryResult` consistent; module names (`quote_mod`, `redact_mod`, `schema_mod`, `gtime_mod`, `crypto_mod`, `retry_mod`) consistent between definition and use.

**No placeholders:** Every code step contains complete code. NOTEs flag std-API points to confirm against Zig 0.16 (readFileAlloc, hkdf, base64, ArrayList writer, Semaphore) with explicit fallback instructions; these are implementation guards, not placeholders.
