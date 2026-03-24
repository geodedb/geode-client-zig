# Security Gap Analysis

**Project:** geode-client-zig
**Repository:** gitlab.com/devnw/codepros/geode/geode-client-zig
**Last Updated:** 2026-03-24
**Review Type:** Comprehensive Security Code Review + Adversarial Review + Protobuf Migration Audit
**Reviewed By:** Claude Opus 4.5 / Codex (Adversarial Security Review) / Claude Opus 4.6 (2026-03-24 Audit)

---

## Summary

| Severity | Count | Closed | Open |
|----------|-------|--------|------|
| Critical | 0 | 0 | 0 |
| High     | 5 | 2 | 3 |
| Medium   | 13 | 9 | 4 |
| Low      | 13 | 12 | 1 |
| Info     | 1 | 1 | 0 |
| **Total** | **32** | **24** | **8** |

**Status:** 24 of 32 findings remediated. 8 open items from 2026-03-24 audit remain.

**Top 5 Risks (by score):**

1. #25 GQL Injection via RLS Policy Predicate (Risk: 60, High)
2. #26 gRPC Transport Has No TLS Implementation (Risk: 60, High)
3. #27 Password Not Zeroed in GeodeClient.deinit() (Risk: 48, High)
4. #28 Protobuf String Decoding Has No Per-Field Size Limit (Risk: 30, Medium)
5. #29 Unbounded Row Count in DataPage Decoding (Risk: 30, Medium)

**Note:** Findings #1, #4, #6 (JSON injection) were additionally resolved by the protobuf
wire format migration (commit 53579e8) which eliminated JSON message construction entirely.
Finding #22 (response type spoofing via substring search) was resolved by the same migration
since protobuf uses binary tags, not string matching.

### Findings Overview

1. **JSON Injection in auth.zig** - User input not escaped in protocol message builders (High) - **CLOSED** (also resolved by protobuf migration)
2. **Gitleaks allowlist too permissive** - May miss secrets in .zig source files (Medium) - **CLOSED**
3. **SBOM scan allows failure** - Security scan configured as non-blocking (Low) - **CLOSED**
4. **Hardcoded allocator in auth.zig** - Code quality issue affecting memory management (Low) - **CLOSED**
5. **TLS verification skip underdocumented** - Security implications not clearly warned (Info) - **CLOSED**
6. **JSON Injection in protocol.zig buildHello** - Client metadata fields not escaped (Medium) - **CLOSED** (also resolved by protobuf migration)
7. **CI/CD Supply Chain Risk** - Components use unpinned @latest versions (Medium) - **CLOSED (Won't Fix)**
8. **QueryBuilder lacks input validation** - Clause methods directly interpolate user strings (Low) - **CLOSED**
9. **Sensitive data not zeroed before free** - Session tokens not wiped from memory (Medium) - **CLOSED**
10. **No batch size limit** - Batch module lacks maximum query count (Low) - **CLOSED**
11. **Date/Time constructors lack bounds validation** - Invalid dates/times can be created (Low) - **CLOSED**
12. **Integration tests allow_failure bypasses quality gate** - Test failures don't block CI (Low) - **CLOSED**
13. **Config.password not zeroed before free** - Passwords remain in memory (Medium) - **CLOSED**
14. **urlDecode has no input length limit** - Potential memory exhaustion (Low) - **CLOSED**
15. **DSN parsing silently uses default on invalid port** - Unexpected fallback behavior (Low) - **CLOSED**
16. **recv_buffer has no maximum size limit** - Client memory exhaustion risk (Medium) - **CLOSED**
17. **isIpv6 validation is weak** - Accepts invalid strings as IPv6 (Low) - **CLOSED**
18. **QueryBuilder param() does not validate parameter names** - Missing validation (Low) - **CLOSED**
19. **CI downloads Zig without integrity verification** - Supply-chain risk in CI (High) - **CLOSED**
20. **Config.deinit frees non-owned credentials** - Invalid free / memory corruption risk (Medium) - **CLOSED**
21. **parseDSNStrict lacks bounds validation** - page_size/timeout out-of-range accepted (Low) - **CLOSED**
22. **parseResponseType uses substring search** - Response type can be spoofed (Medium) - **CLOSED** (resolved by protobuf migration)
23. **Examples default to insecure TLS** - Encourages disabling verification (Low) - **CLOSED**
24. **Dependency scanning may not cover Zig deps** - CI coverage gap (Medium) - **CLOSED**
25. **GQL Injection via RLS Policy Predicate** - policy.predicate injected raw into GQL without escaping (High) - **OPEN**
26. **gRPC Transport Has No TLS Implementation** - connect() uses plain TCP, credentials sent in cleartext (High) - **OPEN**
27. **Password Not Zeroed in GeodeClient.deinit()** - password/session_id not zeroed before free (High) - **OPEN**
28. **Protobuf String Decoding Has No Per-Field Size Limit** - decodeString allocates based on untrusted varint (Medium) - **OPEN**
29. **Unbounded Row Count in DataPage Decoding** - decodeDataPage appends rows without count limit (Medium) - **OPEN**
30. **SHA256 Verification Fetches Checksum from Same Origin** - archive and checksum both from ziglang.org (Medium) - **OPEN**
31. **Docker Images Use Unpinned :latest Tags** - mutable image tags in CI (Medium) - **OPEN**
32. **@constCast on Potentially Static Strings in proto.zig** - UB risk freeing string literals (Low) - **OPEN**

---

## Stack-Ranked Findings

| Rank | Severity | Risk Score | Finding | Component | CWE/OWASP | Evidence | GitLab Issue | Fix Summary | Owner | SLA | Status |
|------|----------|------------|---------|-----------|-----------|----------|--------------|-------------|-------|-----|--------|
| 1 | High | 60 | JSON Injection - user input not escaped in auth message builders | `src/auth.zig` | CWE-116, CWE-89 | Lines 21-41, 251-484 | [#1](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/1) | Added `appendEscapedString` for all user input | Claude | 7 days | **Closed** |
| 2 | Medium | 30 | CI/CD Supply Chain Risk - 8 components use unpinned @latest versions | `.gitlab-ci.yml` | CWE-1104, OWASP A06 | Lines 45, 53, 57, 61, 65, 68, 71, 76 | [#7](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/7) | Managed through other org controls | - | N/A | **Won't Fix** |
| 3 | Medium | 24 | Gitleaks allowlist excludes all .zig files from secret scanning | `.gitleaks.toml` | CWE-798, CWE-200 | Full file rewrite | [#2](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/2) | Replaced blanket exclusions with targeted regex rules | Claude | 90 days | **Closed** |
| 4 | Medium | 24 | JSON Injection in buildHello - client metadata fields not escaped | `src/protocol.zig` | CWE-116 | Lines 91-101 | [#6](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/6) | Used `appendEscapedString` for client_name/version/conformance + 2 tests | Claude | 30 days | **Closed** |
| 5 | Low | 16 | SBOM scan allows failure in CI/CD | `.gitlab-ci.yml` | CWE-1104 | Lines 70-72 | [#3](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/3) | Set `allow_failure: false` | Claude | 180 days | **Closed** |
| 6 | Low | 12 | QueryBuilder lacks input validation for clause methods | `src/query_builder.zig` | CWE-89 | Lines 1-44, method docs | [#8](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/8) | Added comprehensive security docs + method warnings | Claude | 180 days | **Closed** |
| 7 | Low | 8 | Hardcoded page_allocator instead of struct allocator | `src/auth.zig` | N/A | All message builder functions | [#4](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/4) | All functions now use `self.allocator` | Claude | 180 days | **Closed** |
| 8 | Info | 4 | TLS verification skip option lacks security warnings | `README.md`, `SECURITY.md` | OWASP A02 | Multiple locations | [#5](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/5) | Added prominent security warnings in documentation | Claude | 180 days | **Closed** |
| 9 | Medium | 24 | Sensitive data not zeroed before free - session tokens remain in memory | `src/auth.zig` | CWE-316, CWE-226 | Lines 231-241, 431-441, 449-461 | [#9](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/9) | Added `@memset(@constCast(token), 0)` in deinit, setAuthenticated, clearAuthentication + 3 tests | Claude | 90 days | **Closed** |
| 10 | Low | 12 | Batch module lacks maximum query count limit | `src/batch.zig` | CWE-400 | Lines 17-19, 113-119, 127-133 | [#10](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/10) | Added `MAX_BATCH_SIZE = 10000` constant, validation in add/addWithParams + 4 tests | Claude | 180 days | **Closed** |
| 11 | Low | 12 | Date/Time constructors lack bounds validation | `src/types.zig` | CWE-20 | Lines 50-67, 88-115 | [#11](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/11) | Added `initChecked()` for Date/Time with bounds validation + `Value.initDateChecked/initTimeChecked` + 18 tests | Claude | 180 days | **Closed** |
| 12 | Low | 8 | Integration tests allow_failure bypasses quality gate | `.gitlab-ci.yml` | CWE-1127 | Lines 175-209 | [#12](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/12) | Rules-based approach: `allow_failure: false` on main branch, `true` on MRs | Claude | 90 days | **Closed** |
| 13 | Medium | 24 | Config.password not zeroed before free | `src/config.zig` | CWE-316, CWE-226 | Lines 96-112 | [#13](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/13) | Added `Config.deinit()` with `@memset` to zero password before free + 3 tests | Claude | 90 days | **Closed** |
| 14 | Low | 12 | urlDecode has no input length limit | `src/config.zig` | CWE-400 | Lines 21, 252-259 | [#14](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/14) | Added `MAX_URL_DECODE_LENGTH = 64KB` + validation in `urlDecode()` + 4 tests | Claude | 180 days | **Closed** |
| 15 | Low | 8 | DSN parsing silently uses default on invalid port | `src/config.zig` | CWE-20 | Lines 135-160 | [#15](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/15) | Added `parseDSNStrict()` that returns errors for invalid port/page_size/timeout + 9 tests | Claude | 180 days | **Closed** |
| 16 | Medium | 24 | recv_buffer has no maximum size limit | `geode_client_v2.zig` | CWE-400 | Lines 17, 173 | [#16](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/16) | Added `MAX_RECV_BUFFER_SIZE = 16MB` constant, check before append + 2 tests | Claude | 90 days | **Closed** |
| 17 | Low | 12 | isIpv6 validation is weak | `src/validate.zig` | CWE-20 | Lines 158-167 | [#17](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/17) | Strengthened validation to check valid IPv6 character set + 6 tests | Claude | 180 days | **Closed** |
| 18 | Low | 8 | QueryBuilder param() does not validate parameter names | `src/query_builder.zig` | CWE-20 | Lines 211-214 | [#18](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/18) | Added `validate.paramName()` call in param() method + 4 tests | Claude | 180 days | **Closed** |
| 19 | High | 60 | CI downloads Zig without integrity verification | `.gitlab-ci.yml` | CWE-494 | Lines 99-110 | [#19](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/19) | Added SHA256 verification from index.json before extraction | Claude | 30 days | **Closed** |
| 20 | Medium | 36 | Config.deinit frees non-owned credentials via withCredentials | `src/config.zig` | CWE-590 | Lines 136-140 | [#20](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/20) | withCredentials now allocates owned copies + 3 tests | Claude | 90 days | **Closed** |
| 21 | Low | 16 | parseDSNStrict lacks bounds validation for page_size/timeout | `src/config.zig` | CWE-20, CWE-400 | Lines 407-429 | [#21](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/21) | Added validate.pageSize/timeout calls + timeout validation + 8 tests | Claude | 180 days | **Closed** |
| 22 | Medium | 24 | parseResponseType uses substring search (spoofable) | `src/protocol.zig` | CWE-20 | Removed | [#22](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/22) | Resolved by protobuf migration — binary tags replace string matching | Claude | 90 days | **Closed** |
| 23 | Low | 16 | Examples default to insecure TLS verification | examples, benchmarks | OWASP A02 | `example_simple.zig`, `example_usage.zig`, `benchmark.zig` | [#23](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/23) | Default to insecure=false + env var/flag + warnings | Claude | 180 days | **Closed** |
| 24 | Medium | 48 | Dependency scanning may not cover Zig dependencies | `.gitlab-ci.yml`, `build.zig.zon` | OWASP A06 | CI config | [#24](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/24) | Added custom SBOM script + CI job for build.zig.zon | Claude | 90 days | **Closed** |
| 25 | High | 60 | GQL Injection via RLS Policy Predicate - predicate injected raw without escaping | `src/auth.zig` | CWE-89, CWE-943 / OWASP A03 | `src/auth.zig:351` | --skip-issues | Escape or parameterize predicate in `buildCreateRlsPolicyQuery` | - | 30 days | **Open** |
| 26 | High | 60 | gRPC Transport Has No TLS Implementation - plain TCP, credentials in cleartext | `src/grpc.zig` | CWE-319 / OWASP A02 | `src/grpc.zig:204-217` | --skip-issues | Implement TLS using Config.tls/insecure fields; reject cleartext when insecure=false | - | 30 days | **Open** |
| 27 | High | 48 | Password Not Zeroed in GeodeClient.deinit() - password/session_id left in memory | `geode_client_v2.zig` | CWE-316, CWE-226 / OWASP A02 | `geode_client_v2.zig:75-93` | --skip-issues | Zero password and session_id with `@memset` before free in deinit; consider owning copy of password | - | 30 days | **Open** |
| 28 | Medium | 30 | Protobuf String Decoding Has No Per-Field Size Limit - allocates from untrusted varint | `src/proto.zig` | CWE-400, CWE-770 / OWASP A05 | `src/proto.zig:614-622` | --skip-issues | Add MAX_STRING_FIELD_SIZE (e.g. 1MB) check before allocation | - | 90 days | **Open** |
| 29 | Medium | 30 | Unbounded Row Count in DataPage Decoding - no limit on appended rows | `src/proto.zig` | CWE-400, CWE-770 / OWASP A05 | `src/proto.zig:804-828` | --skip-issues | Add MAX_ROWS_PER_PAGE limit before appending | - | 90 days | **Open** |
| 30 | Medium | 24 | SHA256 Verification Fetches Checksum from Same Origin as archive | `.gitlab-ci.yml` | CWE-494 / OWASP A08 | `.gitlab-ci.yml:112-117` | --skip-issues | Pin expected hash in CI config or fetch checksum from independent mirror | - | 90 days | **Open** |
| 31 | Medium | 24 | Docker Images Use Unpinned :latest Tags - mutable image references | `.gitlab-ci.yml` | CWE-829 / OWASP A08 | `.gitlab-ci.yml:24,265` | --skip-issues | Pin images to digest (sha256) or specific version tags | - | 90 days | **Open** |
| 32 | Low | 8 | @constCast on Potentially Static Strings in proto.zig - UB if freeing string literals | `src/proto.zig` | CWE-758 | `src/proto.zig:41,44` | --skip-issues | Guard free with allocation-source flag or use optional/sentinel values | - | 180 days | **Open** |

---

## Findings by Area

### Application Code (src/)

#### Finding 1: JSON Injection in auth.zig (High) - **CLOSED**

**Description:**
The `src/auth.zig` module was building JSON protocol messages by directly appending user-provided strings without JSON escaping. Special characters like `"`, `\`, and control characters could break out of string context and inject arbitrary JSON content.

**Affected Functions (all fixed):**

- `buildLoginMessage` (via `buildAuthMessage`)
- `buildCreateUserMessage`
- `buildCreateRoleMessage`
- `buildAssignRoleMessage`
- `buildRevokeRoleMessage`
- `buildCreateRlsPolicyMessage`
- `buildDropRlsPolicyMessage`

**Remediation Applied:**

1. Added `appendEscapedString()` function to `src/auth.zig` (lines 21-41)
2. Updated all message builder functions to use `appendEscapedString()` for user input
3. Added security header comment documenting the escaping requirement
4. Added unit tests for JSON injection prevention (8 new tests)

**Secure Implementation:**

```zig
// src/auth.zig - appendEscapedString function
fn appendEscapedString(allocator: std.mem.Allocator, buf: *std.ArrayListUnmanaged(u8), s: []const u8) !void {
    for (s) |c| {
        switch (c) {
            '"' => try buf.appendSlice(allocator, "\\\""),
            '\\' => try buf.appendSlice(allocator, "\\\\"),
            '\n' => try buf.appendSlice(allocator, "\\n"),
            '\r' => try buf.appendSlice(allocator, "\\r"),
            '\t' => try buf.appendSlice(allocator, "\\t"),
            else => {
                if (c < 0x20) {
                    var escape_buf: [6]u8 = undefined;
                    _ = std.fmt.bufPrint(&escape_buf, "\\u{x:0>4}", .{c}) catch unreachable;
                    try buf.appendSlice(allocator, &escape_buf);
                } else {
                    try buf.append(allocator, c);
                }
            },
        }
    }
}
```

**GitLab Issue:** [#1](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/1) (Confidential)

---

#### Finding 4: Hardcoded page_allocator (Low) - **CLOSED**

**Description:**
Auth module functions were using `std.heap.page_allocator` instead of the allocator stored in the `AuthClient` struct, inconsistent with the rest of the codebase.

**Remediation Applied:**
All message builder functions now use `self.allocator` instead of `std.heap.page_allocator`:

- `buildLoginMessage`
- `buildLogoutMessage`
- `buildCreateUserMessage`
- `buildCreateRoleMessage`
- `buildAssignRoleMessage`
- `buildRevokeRoleMessage`
- `buildCreateRlsPolicyMessage`
- `buildDropRlsPolicyMessage`

Updated unit tests to use `std.testing.allocator.free()` for proper memory management.

**GitLab Issue:** [#4](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/4)

---

#### Finding 6: JSON Injection in protocol.zig buildHello (Medium) - **CLOSED**

**Description:**
The `buildHello` function in `src/protocol.zig` directly appends `client_name`, `client_version`, and `conformance` parameters to JSON without escaping. While username and password ARE properly escaped (lines 103, 108), the metadata fields are not.

**Risk Assessment:**

- Severity: Medium
- CWE: CWE-116 (Improper Encoding or Escaping of Output)
- Risk Score: 24
- Exploitability: Low - These parameters are typically library-controlled constants, but could be user-provided in custom implementations.

**Remediation Applied:**

1. Updated `buildHello` in `src/protocol.zig` (lines 91-101) to use `appendEscapedString()` for all three metadata fields
2. Added security comments documenting the CWE-116 mitigation
3. Added 2 new unit tests to verify JSON injection prevention:
   - `test "buildHello escapes metadata fields to prevent JSON injection"` - Tests quote/backslash escaping and injection neutralization
   - `test "buildHello escapes control characters in metadata"` - Tests newline/tab/carriage return escaping

**Secure Implementation:**

```zig
// src/protocol.zig lines 91-101
try msg.appendSlice(allocator, ",\"hello_name\":\"");
// SECURITY: Escape client_name to prevent JSON injection (CWE-116)
try appendEscapedString(allocator, &msg, client_name);
try msg.appendSlice(allocator, "\",\"hello_ver\":\"");
// SECURITY: Escape client_version to prevent JSON injection (CWE-116)
try appendEscapedString(allocator, &msg, client_version);
try msg.appendSlice(allocator, "\",\"conformance\":\"");
// SECURITY: Escape conformance to prevent JSON injection (CWE-116)
try appendEscapedString(allocator, &msg, conformance);
```

**GitLab Issue:** [#6](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/6) (Confidential)

---

#### Finding 8: QueryBuilder Lacks Input Validation (Low) - **CLOSED**

**Description:**
The `QueryBuilder` in `src/query_builder.zig` directly interpolates user-provided strings into GQL clauses without validation or sanitization. While this is somewhat by-design (GQL patterns need flexibility), it creates a misuse risk.

**Risk Assessment:**

- Severity: Low
- CWE: CWE-89 (Injection)
- Risk Score: 12
- Exploitability: Moderate - Requires developer misuse

**Remediation Applied:**

1. Added comprehensive security documentation header to `src/query_builder.zig` (lines 1-44):
   - Module-level GQL injection warning (CWE-89)
   - Safe usage examples with parameterized queries
   - Unsafe usage examples showing injection risks
   - Label validation pattern for user-provided identifiers

2. Added security warnings to all clause methods:
   - `match()`, `optionalMatch()`, `where()` - "Pattern/Condition is interpolated directly. Use param() for user values."
   - `create()`, `merge()` - "Pattern is interpolated directly. Use param() for user values."
   - `delete()`, `detachDelete()` - "Variables are interpolated directly. Use param() for user values."
   - `set()`, `remove()` - "Assignments/Items are interpolated directly. Use param() for user values."
   - `raw()` - "**SECURITY WARNING**: This method provides NO protection against injection."

3. Enhanced `param()` method documentation: "This is the SAFE way to include user-provided values in queries."

**GitLab Issue:** [#8](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/8)

---

#### Finding 9: Sensitive Data Not Zeroed Before Free (Medium) - **CLOSED**

**Description:**
Session tokens and other sensitive authentication data in `src/auth.zig` were freed without being zeroed first. This could leave sensitive tokens in memory that may be accessible through memory dumps, core files, or other memory disclosure vulnerabilities.

**Risk Assessment:**

- Severity: Medium
- CWE: CWE-316 (Cleartext Storage of Sensitive Information in Memory), CWE-226
- Risk Score: 24
- Exploitability: Low - requires additional vulnerabilities or privileged access

**Remediation Applied:**

1. Added `@memset(@constCast(token), 0)` before `allocator.free()` in three locations:
   - `deinit()` (lines 231-241) - zeros session_token before freeing
   - `setAuthenticated()` (lines 431-441) - zeros old token when replacing
   - `clearAuthentication()` (lines 449-461) - zeros token when clearing auth state

2. Added security documentation comments explaining CWE-316/CWE-226 mitigation

3. Added 3 unit tests to verify the security pattern:
   - `test "clearAuthentication zeros and frees session token"`
   - `test "setAuthenticated zeros old token when replacing"`
   - `test "deinit zeros session token"`

**Secure Implementation:**

```zig
// src/auth.zig - clearAuthentication (example)
pub fn clearAuthentication(self: *Self) void {
    if (self.current_user) |user| {
        self.allocator.free(user);
        self.current_user = null;
    }
    if (self.session_token) |token| {
        // SECURITY: Zero sensitive token data before freeing (CWE-316, CWE-226)
        @memset(@constCast(token), 0);
        self.allocator.free(token);
        self.session_token = null;
    }
}
```

**GitLab Issue:** [#9](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/9) (Confidential)

---

#### Finding 10: Batch Module Lacks Maximum Query Count (Low) - **CLOSED**

**Description:**
The `Batch` module in `src/batch.zig` had no maximum limit on the number of queries that could be added to a batch. This could allow resource exhaustion through unbounded batch sizes.

**Risk Assessment:**

- Severity: Low
- CWE: CWE-400 (Uncontrolled Resource Consumption)
- Risk Score: 12
- Exploitability: Low-Moderate - requires intentional abuse

**Remediation Applied:**

1. Added `MAX_BATCH_SIZE = 10000` constant (lines 17-19)
2. Added batch size validation in `add()` method (lines 113-119)
3. Added batch size validation in `addWithParams()` method (lines 127-133)
4. Updated `BatchError` to include `BatchSizeLimitExceeded` error
5. Added security header comment explaining CWE-400 prevention

6. Added 4 unit tests:
   - `test "MAX_BATCH_SIZE constant is defined"`
   - `test "Batch add enforces size limit"`
   - `test "Batch addWithParams enforces size limit"`
   - `test "BatchBuilder query enforces size limit"`

**Secure Implementation:**

```zig
// src/batch.zig

/// Maximum number of queries allowed in a single batch.
/// This limit prevents resource exhaustion attacks (CWE-400).
pub const MAX_BATCH_SIZE: usize = 10000;

/// Add a query to the batch.
/// SECURITY: Enforces MAX_BATCH_SIZE limit to prevent resource exhaustion (CWE-400).
pub fn add(self: *Self, query: []const u8) !*Self {
    // SECURITY: Check batch size limit before adding (CWE-400)
    if (self.queries.items.len >= MAX_BATCH_SIZE) {
        return error.BatchSizeLimitExceeded;
    }
    try validate.query(query);
    try self.queries.append(self.allocator, BatchQuery.init(query));
    return self;
}
```

**GitLab Issue:** [#10](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/10)

---

#### Finding 11: Date/Time Constructors Lack Bounds Validation (Low) - **CLOSED**

**Description:**
The `Date.init()` and `Time.init()` constructors in `src/types.zig` accept any values without validating that they represent valid dates/times. Invalid temporal values (e.g., month=13, hour=25) can be created and may cause unexpected behavior when serialized or sent to the server.

**Risk Assessment:**

- Severity: Low
- CWE: CWE-20 (Improper Input Validation)
- Risk Score: 12
- Exploitability: Low - requires passing invalid values, impact is data corruption

**Remediation Applied:**

1. Added `Date.initChecked()` with bounds validation for month (1-12) and day (1-31)
2. Added `Time.initChecked()` with bounds validation for hour (0-23), minute (0-59), second (0-59)
3. Added `Time.withNanosChecked()` with validation for nanoseconds (0-999999999)
4. Added `Value.initDateChecked()` and `Value.initTimeChecked()` wrappers
5. Added security documentation comments explaining CWE-20 mitigation
6. Original `init()` methods kept for backward compatibility when values are known-valid

**Tests Added (18 tests):**

- `Date.initChecked accepts valid dates`
- `Date.initChecked rejects month=0`
- `Date.initChecked rejects month=13`
- `Date.initChecked rejects day=0`
- `Date.initChecked rejects day=32`
- `Date.initChecked accepts boundary values`
- `Time.initChecked accepts valid times`
- `Time.initChecked rejects hour=24`
- `Time.initChecked rejects minute=60`
- `Time.initChecked rejects second=60`
- `Time.initChecked accepts boundary values`
- `Time.withNanosChecked accepts valid nanoseconds`
- `Time.withNanosChecked rejects invalid nanoseconds`
- `Time.withNanosChecked accepts max valid nanoseconds`
- `Value.initDateChecked accepts valid dates`
- `Value.initDateChecked rejects invalid dates`
- `Value.initTimeChecked accepts valid times`
- `Value.initTimeChecked rejects invalid times`

**Secure Implementation:**

```zig
// src/types.zig - Date.initChecked
pub fn initChecked(year: i32, month: u8, day: u8) !Date {
    if (month < 1 or month > 12) return error.InvalidMonth;
    if (day < 1 or day > 31) return error.InvalidDay;
    return .{ .year = year, .month = month, .day = day };
}

// src/types.zig - Time.initChecked
pub fn initChecked(hour: u8, minute: u8, second: u8) !Time {
    if (hour > 23) return error.InvalidHour;
    if (minute > 59) return error.InvalidMinute;
    if (second > 59) return error.InvalidSecond;
    return .{ .hour = hour, .minute = minute, .second = second };
}
```

**GitLab Issue:** [#11](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/11)

---

#### Finding 13: Config.password Not Zeroed Before Free (Medium) - **CLOSED**

**Description:**
The `Config` struct in `src/config.zig` stores passwords allocated via `urlDecode()` but does not provide a `deinit()` function to zero sensitive data before freeing. This is the same issue as Finding #9 (session tokens) but for the config module.

**Risk Assessment:**

- Severity: Medium
- CWE: CWE-316 (Cleartext Storage of Sensitive Information in Memory), CWE-226
- Risk Score: 24
- Exploitability: Low - requires memory disclosure vulnerability or privileged access

**Remediation Applied:**

1. Added `Config.deinit()` function (lines 96-112) that zeros password before freeing
2. Uses `@memset(@constCast(pass), 0)` to zero sensitive data
3. Also frees username (not sensitive but still allocated)
4. Sets both fields to null after freeing
5. Added security documentation comments explaining CWE-316/CWE-226 mitigation

**Tests Added (3 tests):**

- `Config.deinit zeros password before freeing`
- `Config.deinit handles config without credentials`
- `Config.deinit handles config with username only`

**Secure Implementation:**

```zig
// src/config.zig - Config.deinit
pub fn deinit(self: *Config, allocator: std.mem.Allocator) void {
    // SECURITY: Zero sensitive password data before freeing (CWE-316, CWE-226)
    if (self.password) |pass| {
        @memset(@constCast(pass), 0);
        allocator.free(pass);
        self.password = null;
    }
    // Free username (not sensitive, but still allocated)
    if (self.username) |user| {
        allocator.free(user);
        self.username = null;
    }
}
```

**GitLab Issue:** [#13](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/13) (Confidential)

---

#### Finding 14: urlDecode Has No Input Length Limit (Low) - **CLOSED**

**Description:**
The `urlDecode()` function in `src/config.zig` has no input length validation. A malicious DSN with an extremely long URL-encoded string could cause memory exhaustion.

**Risk Assessment:**

- Severity: Low
- CWE: CWE-400 (Uncontrolled Resource Consumption)
- Risk Score: 12
- Exploitability: Low - requires crafted malicious DSN input

**Remediation Applied:**

1. Added `MAX_URL_DECODE_LENGTH = 64KB` constant (line 21)
2. Added length validation at start of `urlDecode()` (lines 252-259)
3. Returns `error.InputTooLong` if input exceeds limit
4. Added security documentation comments explaining CWE-400 mitigation

**Tests Added (4 tests):**

- `urlDecode accepts input within limit`
- `urlDecode rejects input exceeding MAX_URL_DECODE_LENGTH`
- `urlDecode accepts input at exactly MAX_URL_DECODE_LENGTH`
- `MAX_URL_DECODE_LENGTH constant is reasonable`

**Secure Implementation:**

```zig
// src/config.zig
pub const MAX_URL_DECODE_LENGTH: usize = 64 * 1024; // 64KB reasonable limit

fn urlDecode(allocator: std.mem.Allocator, input: []const u8) ![]const u8 {
    // SECURITY: Check input length to prevent resource exhaustion (CWE-400)
    if (input.len > MAX_URL_DECODE_LENGTH) {
        return error.InputTooLong;
    }
    // ... rest of function
}
```

**GitLab Issue:** [#14](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/14)

---

#### Finding 15: DSN Parsing Silently Uses Default on Invalid Port (Low) - **CLOSED**

**Description:**
The DSN parsing functions in `src/config.zig` silently fall back to default values when encountering invalid numeric input, rather than returning an error. This could lead to unexpected connections to the default port when users misconfigure the DSN.

**Risk Assessment:**

- Severity: Low
- CWE: CWE-20 (Improper Input Validation)
- Risk Score: 8
- Exploitability: Minimal - primarily affects user experience

**Remediation Applied:**

1. Added `parseDSNStrict()` function (lines 135-160) that returns errors for invalid values
2. Original `parseDSN()` preserved for backward compatibility with silent fallback
3. Strict mode validates: port, page_size, timeout
4. Returns specific errors: `error.InvalidPort`, `error.InvalidPageSize`, `error.InvalidTimeout`
5. Updated internal parsing functions to accept `strict: bool` parameter
6. Added documentation recommending `parseDSNStrict()` for production use

**Tests Added (9 tests):**

- `parseDSNStrict accepts valid DSN`
- `parseDSNStrict rejects invalid port`
- `parseDSNStrict rejects invalid port in IPv6`
- `parseDSNStrict rejects invalid page_size`
- `parseDSNStrict rejects invalid timeout`
- `parseDSNStrict accepts valid query parameters`
- `parseDSNStrict accepts valid URL format with credentials`
- `parseDSNStrict handles empty string`
- `parseDSN vs parseDSNStrict behavior comparison`

**Secure Implementation:**

```zig
// src/config.zig - parseDSNStrict
/// Parse a DSN with strict validation.
/// SECURITY: Returns errors for invalid values instead of silently using defaults (CWE-20).
/// This is recommended for production use where misconfigurations should fail explicitly.
pub fn parseDSNStrict(allocator: std.mem.Allocator, dsn: []const u8) !Config {
    // ... delegates to internal functions with strict=true
}

// Internal: strict mode returns error instead of default
if (strict) {
    config.port = std.fmt.parseInt(u16, port_str, 10) catch return error.InvalidPort;
} else {
    config.port = std.fmt.parseInt(u16, port_str, 10) catch DEFAULT_PORT;
}
```

**GitLab Issue:** [#15](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/15)

---

#### Finding 16: recv_buffer Has No Maximum Size Limit (Medium) - **CLOSED**

**Description:**
The `recv_buffer` in `geode_client_v2.zig` is a `std.ArrayList(u8)` that grows without bound when receiving server responses. A malicious server (or network attacker) could exhaust client memory by sending responses without newlines.

**Risk Assessment:**

- Severity: Medium
- CWE: CWE-400 (Uncontrolled Resource Consumption)
- Risk Score: 24
- Exploitability: Moderate - requires malicious server or MitM attack

**Remediation Applied:**

1. Added `MAX_RECV_BUFFER_SIZE = 16MB` constant to `geode_client_v2.zig`
2. Added size check before `appendSlice` in `receiveMessage()` that returns `error.ResponseTooLarge`
3. Added security documentation comments explaining CWE-400 mitigation
4. Added 2 unit tests to verify the constant is defined and has correct value

**Secure Implementation:**

```zig
// geode_client_v2.zig

/// Maximum receive buffer size (16MB).
/// SECURITY: Prevents resource exhaustion from malicious server responses (CWE-400).
pub const MAX_RECV_BUFFER_SIZE: usize = 16 * 1024 * 1024;

// In receiveMessage():
if (n > 0) {
    // SECURITY: Check buffer size limit to prevent resource exhaustion (CWE-400)
    if (self.recv_buffer.items.len + n > MAX_RECV_BUFFER_SIZE) {
        return error.ResponseTooLarge;
    }
    try self.recv_buffer.appendSlice(self.allocator, temp_buf[0..n]);
}
```

**Tests Added:**

- `test "MAX_RECV_BUFFER_SIZE constant is defined"`
- `test "MAX_RECV_BUFFER_SIZE is 16MB"`

**GitLab Issue:** [#16](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/16)

---

#### Finding 17: isIpv6 Validation is Weak (Low) - **CLOSED**

**Description:**
The `isIpv6()` function in `validate.zig` uses an overly permissive check that only counts colons, accepting invalid strings as IPv6 addresses.

**Risk Assessment:**

- Severity: Low
- CWE: CWE-20 (Improper Input Validation)
- Risk Score: 12
- Exploitability: Low - primarily affects logic correctness

**Remediation Applied:**

1. Strengthened `isIpv6()` validation to check for valid IPv6 character set
2. Added support for zone IDs (e.g., `fe80::1%eth0`)
3. Added empty string check
4. Added security documentation comments explaining CWE-20 mitigation
5. Added 6 unit tests for invalid character rejection

**Secure Implementation:**

```zig
// src/validate.zig

/// Check if string looks like an IPv6 address.
/// SECURITY: Validates character set to prevent false positives (CWE-20).
pub fn isIpv6(addr: []const u8) bool {
    if (addr.len == 0) return false;

    var colon_count: u8 = 0;
    var in_zone: bool = false;

    for (addr) |c| {
        // Zone ID separator (e.g., fe80::1%eth0)
        if (c == '%') {
            in_zone = true;
            continue;
        }

        if (in_zone) {
            // Zone ID: allow alphanumerics only
            if (!isAlphanumeric(c)) return false;
            continue;
        }

        // Valid IPv6 characters: hex digits, colons, dots (IPv4-mapped), brackets
        switch (c) {
            ':' => colon_count += 1,
            '0'...'9', 'a'...'f', 'A'...'F', '.', '[', ']' => {},
            else => return false,
        }
    }

    return colon_count >= 2;
}
```

**Tests Added:**

- `test "isIpv6 rejects invalid characters"` - Non-hex letters like 'g', 'x', 'o'
- `test "isIpv6 rejects special characters"` - @, /, space, #
- `test "isIpv6 rejects empty string"`
- `test "isIpv6 accepts valid zone IDs"`
- `test "isIpv6 rejects invalid zone ID characters"`

**GitLab Issue:** [#17](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/17)

---

#### Finding 18: QueryBuilder param() Does Not Validate Parameter Names (Low) - **CLOSED**

**Description:**
The `QueryBuilder.param()` method accepts any string as a parameter name without validation, bypassing the `validate.paramName()` function that exists for this purpose.

**Risk Assessment:**

- Severity: Low
- CWE: CWE-20 (Improper Input Validation)
- Risk Score: 8
- Exploitability: Low - primarily affects error handling

**Remediation Applied:**

1. Added `validate` module import to `src/query_builder.zig`
2. Added `validate.paramName(name)` call before storing parameter
3. Added security documentation comments explaining CWE-20 mitigation
4. Updated `build.zig` to include validate module dependency for query_builder
5. Added 4 unit tests for parameter name validation

**Secure Implementation:**

```zig
// src/query_builder.zig

const validate = @import("validate");

/// Bind a parameter value.
/// This is the SAFE way to include user-provided values in queries.
/// SECURITY: Validates parameter name to prevent invalid identifiers (CWE-20).
pub fn param(self: *QueryBuilder, name: []const u8, value: Value) !*QueryBuilder {
    try validate.paramName(name);
    try self.params.put(self.allocator, name, value);
    return self;
}
```

**Tests Added:**

- `test "QueryBuilder param rejects empty name"`
- `test "QueryBuilder param rejects name starting with digit"`
- `test "QueryBuilder param rejects name with invalid characters"`
- `test "QueryBuilder param accepts valid names"`

**GitLab Issue:** [#18](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/18)

---

#### Finding 25: GQL Injection via RLS Policy Predicate (High) - **OPEN**

**Description:**
In `src/auth.zig:351`, the `buildCreateRlsPolicyQuery` function injects `policy.predicate` raw into the GQL query string without escaping. While `name`, `target_label`, and role fields are properly escaped via `appendEscapedGqlString`, the predicate field is interpolated directly. An attacker who controls the predicate value can inject arbitrary GQL, potentially bypassing row-level security or executing unintended graph mutations.

**Risk Assessment:**

- Severity: High
- CWE: CWE-89 (SQL/GQL Injection), CWE-943 (Improper Neutralization of Special Elements in Data Query Logic)
- OWASP: A03:2021 - Injection
- Risk Score: 60 (Impact: 4 x Likelihood: 3 x 4) -- requires authentication to create RLS policies
- Exploit Surface: Internal (admin-only access typically, but depends on authorization model)
- Confidence: `confidence::confirmed` -- visible in source code

**Evidence:**

- File: `src/auth.zig:351`
- The predicate string is concatenated directly into the query without passing through `appendEscapedGqlString`

**Attack Scenario:**
An authenticated user with RLS policy creation privileges provides a crafted predicate such as `true) RETURN n UNION MATCH (x) DETACH DELETE x //` to escape the predicate context, delete all nodes, and comment out the remainder of the query.

**Fix Guidance:**
Escape the predicate through `appendEscapedGqlString` or, preferably, use a parameterized query with `$predicate` as a bound parameter. If predicates must contain GQL expressions, implement a predicate-specific parser/validator that only allows safe expression syntax.

**Acceptance Criteria:**

- [ ] `policy.predicate` is escaped or parameterized in `buildCreateRlsPolicyQuery`
- [ ] Unit test demonstrates injection payload is neutralized
- [ ] Existing RLS policy tests continue to pass

**How to Verify:** Craft an `RlsPolicy` with predicate `n.x = 1) RETURN n UNION MATCH (m) DELETE m //` and confirm the built query does not break out of the predicate context.

---

#### Finding 26: gRPC Transport Has No TLS Implementation (High) - **OPEN**

**Description:**
In `src/grpc.zig:204-217`, the `connect()` function establishes a plain TCP connection with a comment noting "simplified implementation." The `Config.tls` and `Config.insecure` fields are never consulted. All gRPC connections transmit credentials (username, password, session tokens) in cleartext over the network.

**Risk Assessment:**

- Severity: High
- CWE: CWE-319 (Cleartext Transmission of Sensitive Information)
- OWASP: A02:2021 - Cryptographic Failures
- Risk Score: 60 (Impact: 4 x Likelihood: 3 x 4) -- remote, but requires network position
- Exploit Surface: Internal network (gRPC transport is an alternative to QUIC)
- Confidence: `confidence::confirmed` -- visible in source code

**Evidence:**

- File: `src/grpc.zig:204-217`
- Comment in source: "simplified implementation"
- `Config.tls` and `Config.insecure` are not referenced in the gRPC connect path

**Attack Scenario:**
A network-positioned attacker (same LAN, compromised router, cloud VPC peer) captures gRPC traffic and extracts authentication credentials transmitted in plaintext.

**Fix Guidance:**
Implement TLS negotiation in the gRPC connect path. When `Config.insecure` is false (the default), require TLS. When `Config.tls` configuration is provided, use it. Reject connections that would transmit credentials without encryption unless explicitly opted in via `insecure=true`.

**Acceptance Criteria:**

- [ ] gRPC `connect()` uses TLS by default
- [ ] `Config.insecure` flag is respected
- [ ] `Config.tls` settings (cert paths, etc.) are applied
- [ ] Unit/integration test confirms TLS negotiation occurs

**How to Verify:** Attempt a gRPC connection with `insecure=false` (default) and confirm TLS handshake occurs. Use packet capture to verify no plaintext credentials on wire.

---

#### Finding 27: Password Not Zeroed in GeodeClient.deinit() (High) - **OPEN**

**Description:**
In `geode_client_v2.zig:75-93`, `GeodeClient.deinit()` does not zero the password or session_id fields before the struct is freed/goes out of scope. This contrasts with `AuthClient.deinit()` and `Config.deinit()` which both zero sensitive data. Additionally, the password is stored as a borrowed `[]const u8` (not an owned copy), meaning the client cannot safely zero it.

**Risk Assessment:**

- Severity: High
- CWE: CWE-316 (Cleartext Storage of Sensitive Information in Memory), CWE-226 (Sensitive Information in Resource Not Removed Before Reuse)
- OWASP: A02:2021 - Cryptographic Failures
- Risk Score: 48 (Impact: 4 x Likelihood: 3 x 4) -- requires memory disclosure or privileged access
- Exploit Surface: Requires local access or memory disclosure vulnerability
- Confidence: `confidence::confirmed` -- visible in source code

**Evidence:**

- File: `geode_client_v2.zig:75-93`
- `deinit()` frees connection resources but never zeros `password` or `session_id`
- Password stored as `[]const u8` (borrowed, not owned)

**Attack Scenario:**
After `GeodeClient.deinit()`, the password remains in freed memory. A subsequent memory disclosure vulnerability, core dump, or swap file inspection reveals the plaintext password.

**Fix Guidance:**

1. Store password as an owned copy (allocate and duplicate on init)
2. In `deinit()`, zero the password with `@memset(@constCast(password), 0)` before freeing
3. Also zero `session_id` if present
4. Follow the same pattern already established in `AuthClient.deinit()` and `Config.deinit()`

**Acceptance Criteria:**

- [ ] `GeodeClient` stores an owned copy of password
- [ ] `deinit()` zeros password and session_id before free
- [ ] Unit test confirms zeroing behavior

**How to Verify:** After calling `deinit()`, inspect the memory region (in a test with known allocator) and confirm password bytes are zeroed.

---

#### Finding 28: Protobuf String Decoding Has No Per-Field Size Limit (Medium) - **OPEN**

**Description:**
In `src/proto.zig:614-622`, `decodeString` reads a varint length from the wire and allocates that many bytes without any per-field maximum. While the total receive buffer is capped at `MAX_RECV_BUFFER_SIZE` (16MB), a single string field can claim the full 16MB. A malicious or compromised server could send a small message with a large varint length to force excessive allocation.

**Risk Assessment:**

- Severity: Medium
- CWE: CWE-400 (Uncontrolled Resource Consumption), CWE-770 (Allocation of Resources Without Limits or Throttling)
- OWASP: A05:2021 - Security Misconfiguration
- Risk Score: 30 (Impact: 3 x Likelihood: 2.5 x 4)
- Exploit Surface: Requires malicious server or MitM (network-positioned)
- Confidence: `confidence::confirmed` -- visible in source code

**Evidence:**

- File: `src/proto.zig:614-622`
- `decodeString` allocates based on untrusted varint with no per-field cap

**Fix Guidance:**
Add a `MAX_STRING_FIELD_SIZE` constant (e.g., 1MB or 4MB) and check the decoded length against it before allocating. Return an error such as `error.FieldTooLarge` if exceeded.

**Acceptance Criteria:**

- [ ] `MAX_STRING_FIELD_SIZE` constant defined
- [ ] `decodeString` validates length before allocation
- [ ] Test confirms oversized string field is rejected

**How to Verify:** Craft a protobuf message with a string field length header of 16MB and confirm decoding returns an error.

---

#### Finding 29: Unbounded Row Count in DataPage Decoding (Medium) - **OPEN**

**Description:**
In `src/proto.zig:804-828`, `decodeDataPage` appends rows to an array without any count limit. A malicious server could return a response claiming millions of rows, causing unbounded memory growth on the client.

**Risk Assessment:**

- Severity: Medium
- CWE: CWE-400 (Uncontrolled Resource Consumption), CWE-770 (Allocation of Resources Without Limits or Throttling)
- OWASP: A05:2021 - Security Misconfiguration
- Risk Score: 30 (Impact: 3 x Likelihood: 2.5 x 4)
- Exploit Surface: Requires malicious server or MitM
- Confidence: `confidence::confirmed` -- visible in source code

**Evidence:**

- File: `src/proto.zig:804-828`
- Rows appended in a loop with no maximum count check

**Fix Guidance:**
Add a `MAX_ROWS_PER_PAGE` constant (e.g., 100,000) and check the row count before each append. Return `error.TooManyRows` if exceeded.

**Acceptance Criteria:**

- [ ] `MAX_ROWS_PER_PAGE` constant defined
- [ ] `decodeDataPage` validates row count before appending
- [ ] Test confirms excessive row count is rejected

**How to Verify:** Construct a mock DataPage response with row count exceeding the limit and confirm decoding returns an error.

---

#### Finding 32: @constCast on Potentially Static Strings in proto.zig (Low) - **OPEN**

**Description:**
In `src/proto.zig:41,44`, `HelloResponse.deinit()` uses `@constCast` to free `session_id` and `error_message`. The default values for these fields are `""` (empty string literals). A guard (`len > 0`) prevents freeing the empty default, but if a non-empty string literal were assigned (without allocation), calling `allocator.free` on it would be undefined behavior.

**Risk Assessment:**

- Severity: Low
- CWE: CWE-758 (Reliance on Undefined, Unspecified, or Implementation-Defined Behavior)
- Risk Score: 8 (Impact: 2 x Likelihood: 1 x 4)
- Exploit Surface: Requires specific code path that assigns a non-empty literal
- Confidence: `confidence::suspected` -- would need a code path that assigns a literal to confirm exploitability

**Evidence:**

- File: `src/proto.zig:41,44`
- `@constCast` used on potentially static strings before `allocator.free`

**Fix Guidance:**
Track allocation source with a boolean flag (e.g., `session_id_allocated: bool`) or use an optional type (`?[]u8`) that is only set when the value was heap-allocated. Alternatively, always allocate owned copies so the free is always valid.

**Acceptance Criteria:**

- [ ] `deinit()` never calls `allocator.free` on non-heap memory
- [ ] Test verifies deinit on default-initialized `HelloResponse` does not crash

**How to Verify:** Create a `HelloResponse` with default values, call `deinit()`, and confirm no crash or ASAN violation. Then test with a non-empty literal assignment path.

---

### CI/CD Pipeline

#### Finding 12: Integration Tests allow_failure Bypasses Quality Gate (Low) - **CLOSED**

**Description:**
The integration test job in `.gitlab-ci.yml` is configured with `allow_failure: true`, meaning integration test failures do not block the CI pipeline. This could allow broken functionality to be merged.

**Risk Assessment:**

- Severity: Low
- CWE: CWE-1127 (Compilation with Insufficient Warnings or Errors)
- Risk Score: 8
- Exploitability: Low - requires failing tests to be ignored

**Remediation Applied:**
Implemented Option B (rules-based approach):

1. Removed global `allow_failure: true`
2. Added rules with conditional `allow_failure`:
   - On main branch (`$CI_DEFAULT_BRANCH`): `allow_failure: false` - failures block pipeline
   - On merge requests: `allow_failure: true` - allows MRs where service unavailable
3. Added security comment explaining CWE-1127 mitigation

**Configuration:**

```yaml
# .gitlab-ci.yml - integration-tests job
# SECURITY: Integration tests should block pipeline on main branch (CWE-1127)
# Allow failure on merge requests where service may not be accessible
rules:
  - if: $SKIP_INTEGRATION == "true"
    when: never
  - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
    allow_failure: false
  - if: $CI_PIPELINE_SOURCE == "merge_request_event"
    allow_failure: true
```

**GitLab Issue:** [#12](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/12)

---

#### Finding 3: SBOM Scan Allows Failure (Low) - **CLOSED**

**Description:**
The SBOM scanning component in GitLab CI was configured with `allow_failure: true`, meaning vulnerable dependencies could slip through if the scan encountered errors.

**Remediation Applied:**
Changed `.gitlab-ci.yml` line 72 from `allow_failure: true` to `allow_failure: false`.

```yaml
# .gitlab-ci.yml - FIXED
  # SECURITY: SBOM scan should block pipeline on vulnerable dependencies
  - component: gitlab.com/devnw/ci-catalog/sbom-scan@latest
    inputs:
      allow_failure: false
```

**GitLab Issue:** [#3](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/3)

---

#### Finding 7: CI/CD Supply Chain Risk (Medium) - **CLOSED (Won't Fix)**

**Description:**
The `.gitlab-ci.yml` file includes 8 CI/CD components using `@latest` instead of pinned version tags. This creates a supply chain attack vector where a compromised upstream component could inject malicious code into the build pipeline.

**Affected Configuration:**

```yaml
# .gitlab-ci.yml - All using @latest
- component: gitlab.com/devnw/ci-catalog/zig-format@latest          # line 45
- component: gitlab.com/devnw/ci-catalog/security-sast@latest       # line 53
- component: gitlab.com/devnw/ci-catalog/security-dependency-scanning@latest  # line 57
- component: gitlab.com/devnw/ci-catalog/security-secrets@latest    # line 61
- component: gitlab.com/devnw/ci-catalog/security-gitleaks@latest   # line 65
- component: gitlab.com/devnw/ci-catalog/sbom-generate@latest       # line 68
- component: gitlab.com/devnw/ci-catalog/sbom-scan@latest           # line 71
- component: gitlab.com/devnw/ci-catalog/release-semantic@latest    # line 76
```

**Risk Assessment:**

- Severity: Medium
- CWE: CWE-1104 (Use of Unmaintained Third Party Components)
- OWASP: A06:2021 - Vulnerable and Outdated Components
- Risk Score: 30

**Impact:**

- Pipeline could be compromised if any upstream component is tampered with
- Attackers could inject malicious code during build/test/release stages
- Security scanning components themselves could be bypassed
- Secrets could be exfiltrated via compromised security-secrets component

**Recommended Remediation:**

1. Pin all components to specific version tags
2. Use hash-based pinning if GitLab supports it
3. Set up Dependabot/Renovate for automated version updates
4. Review component changelogs before updating

**Resolution:** Closed as Won't Fix - CI catalog component versions are managed through other organizational controls outside this repository.

**GitLab Issue:** [#7](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/7)

---

#### Finding 30: SHA256 Verification Fetches Checksum from Same Origin (Medium) - **OPEN**

**Description:**
In `.gitlab-ci.yml:112-117`, the CI pipeline downloads both the Zig archive and the `index.json` checksum file from `ziglang.org`. If ziglang.org is compromised, an attacker can tamper with both the archive and the checksum simultaneously, making the SHA256 verification ineffective as a supply chain defense.

**Risk Assessment:**

- Severity: Medium
- CWE: CWE-494 (Download of Code Without Integrity Check) -- partial mitigation
- OWASP: A08:2021 - Software and Data Integrity Failures
- Risk Score: 24 (Impact: 4 x Likelihood: 1.5 x 4) -- requires compromising ziglang.org
- Exploit Surface: CI/CD pipeline (internet-facing download)
- Confidence: `confidence::confirmed` -- visible in CI config

**Evidence:**

- File: `.gitlab-ci.yml:112-117`
- Both archive URL and index.json fetched from `ziglang.org`

**Fix Guidance:**
Pin the expected SHA256 hash directly in the CI configuration file (hardcoded), or fetch the checksum from an independent mirror/source. Update the pinned hash when upgrading Zig versions.

**Acceptance Criteria:**

- [ ] Expected SHA256 hash is pinned in CI config or fetched from independent source
- [ ] CI fails if hash does not match

**How to Verify:** Modify the pinned hash to a wrong value and confirm the CI job fails.

---

#### Finding 31: Docker Images Use Unpinned :latest Tags (Medium) - **OPEN**

**Description:**
In `.gitlab-ci.yml:24,265`, Docker images `geodedb/geode:latest` and `alpine:latest` use the mutable `:latest` tag. These tags can change at any time, potentially introducing unexpected behavior or supply chain attacks.

**Risk Assessment:**

- Severity: Medium
- CWE: CWE-829 (Inclusion of Functionality from Untrusted Control Sphere)
- OWASP: A08:2021 - Software and Data Integrity Failures
- Risk Score: 24 (Impact: 4 x Likelihood: 1.5 x 4) -- requires compromising Docker Hub image
- Exploit Surface: CI/CD pipeline (Docker Hub pull)
- Confidence: `confidence::confirmed` -- visible in CI config

**Evidence:**

- File: `.gitlab-ci.yml:24` -- `geodedb/geode:latest`
- File: `.gitlab-ci.yml:265` -- `alpine:latest`

**Fix Guidance:**
Pin Docker images to specific version tags or, preferably, SHA256 digests. For example:

- `alpine:3.19@sha256:<digest>` instead of `alpine:latest`
- `geodedb/geode:1.2.3@sha256:<digest>` instead of `geodedb/geode:latest`

**Acceptance Criteria:**

- [ ] All Docker images in CI use pinned version tags or sha256 digests
- [ ] A process exists to update pinned versions (e.g., Renovate/Dependabot)

**How to Verify:** Grep `.gitlab-ci.yml` for `:latest` and confirm no mutable tags remain.

---

### Secret Detection Configuration

#### Finding 2: Overly Permissive Gitleaks Allowlist (Medium) - **CLOSED**

**Description:**
The gitleaks configuration excluded all `.zig` and `.md` files from secret scanning, which could allow accidentally committed secrets to go undetected.

**Remediation Applied:**
Replaced blanket file exclusions with targeted regex rules in `.gitleaks.toml`:

1. Removed `'''.*\.zig$'''` and `'''.*\.md$'''` from global path allowlist
2. Added 9 targeted regex rules for known patterns:
   - `test-credentials-zig` - Allow known test credentials in test code
   - `zig-struct-field-password` - Allow password field declarations
   - `zig-struct-field-token` - Allow token field declarations
   - `dsn-example-credentials` - Allow DSN examples with test credentials
   - `test-expect-password` - Allow test assertions
   - `json-field-password` - Allow JSON password field patterns
   - `doc-example-credentials` - Allow example credentials in docs
   - `config-example-credentials` - Allow withCredentials examples
   - `error-messages` - Allow error messages mentioning credentials

**GitLab Issue:** [#2](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/2)

---

### Documentation

#### Finding 5: TLS Verification Skip Underdocumented (Info) - **CLOSED**

**Description:**
The `insecure` option for skipping TLS certificate verification lacked prominent security warnings in user-facing documentation.

**Remediation Applied:**

1. **README.md** - Added prominent security warning after configuration table:
   > **SECURITY WARNING: The `insecure` option disables TLS certificate verification, making connections vulnerable to man-in-the-middle attacks. Only use this option for local development or testing with self-signed certificates. Never use in production environments.**

2. **SECURITY.md** - Added comprehensive "Security Considerations" section covering:
   - TLS Certificate Verification risks
   - When `insecure=true` is acceptable (local dev, testing, CI/CD)
   - When `insecure=true` should never be used (production, untrusted networks)
   - Input validation overview
   - Credential handling

**GitLab Issue:** [#5](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/5)

---

## Positive Security Findings

The following security-positive patterns were observed:

### 1. Protocol Module Uses Proper JSON Escaping

`src/protocol.zig` correctly implements `appendEscapedString()` and uses it for all user-controllable fields in `buildHello` (client_name, client_version, conformance, username, password) and user input in `buildRunGql`, etc.

### 2. Integration Tests Validate Labels Against GQL Injection

`tests/integration.zig` implements `isValidLabel()` (lines 196-210) to prevent GQL injection through label names:

```zig
fn isValidLabel(label: []const u8) bool {
    // Validates that label contains only safe identifier characters
    // Prevents injection like "Person}) DETACH DELETE n"
}
```

### 3. Input Validation Module

`src/validate.zig` provides comprehensive validation including:

- Query length limits (`MAX_QUERY_LENGTH: 1MB`)
- Null byte detection
- Parameter name validation
- Hostname validation
- Page size bounds checking

### 4. Pre-commit Hooks Configured

`.pre-commit-config.yaml` includes:

- `detect-private-key` hook
- `shellcheck` for shell script security
- Commit message validation

### 5. Security Scanning in CI/CD

`.gitlab-ci.yml` includes:

- SAST scanning
- Dependency scanning
- Secret detection
- Gitleaks scanning
- SBOM generation (now blocking on failure)

---

## Quick Wins / Medium-term / Strategic

### Quick Wins (< 1 day)

- [x] Add `appendEscapedString` to auth.zig and fix JSON injection (Issue #1) - **DONE**
- [x] Change SBOM scan `allow_failure` to false (Issue #3) - **DONE**
- [x] Fix JSON escaping in protocol.zig buildHello for metadata fields (Issue #6) - **DONE**
- [x] Zero sensitive data before free in auth.zig (Issue #9) - **DONE**
- [ ] Zero password/session_id in GeodeClient.deinit() (Finding #27)
- [ ] Add per-field size limit to protobuf decodeString (Finding #28)
- [ ] Add row count limit to decodeDataPage (Finding #29)
- [ ] Guard @constCast free with allocation-source check in proto.zig (Finding #32)

### Medium-term (1-5 days)

- [x] Refine gitleaks allowlist with targeted rules (Issue #2) - **DONE**
- [x] Fix hardcoded allocator usage in auth.zig (Issue #4) - **DONE**
- [x] CI/CD component pinning (Issue #7) - **Won't Fix** (managed through other org controls)
- [x] Add batch size limit in batch.zig (Issue #10) - **DONE**
- [x] Zero Config.password before free (Issue #13) - **DONE**
- [x] Set integration tests allow_failure: false (Issue #12) - **DONE**
- [x] Add MAX_RECV_BUFFER_SIZE limit in geode_client_v2.zig (Issue #16) - **DONE**
- [x] Strengthen isIpv6 validation (Issue #17) - **DONE**
- [x] Add validate.paramName() to QueryBuilder.param() (Issue #18) - **DONE**
- [ ] Add fuzz tests for auth message builders
- [ ] Escape or parameterize RLS policy predicate in auth.zig (Finding #25)
- [ ] Pin Docker images to digests in .gitlab-ci.yml (Finding #31)
- [ ] Pin Zig checksum hash in CI config (Finding #30)

### Strategic (> 5 days)

- [x] Add security warning documentation for insecure mode (Issue #5) - **DONE**
- [x] Add QueryBuilder security documentation and warnings (Issue #8) - **DONE**
- [x] Add Date/Time bounds validation (Issue #11) - **DONE**
- [x] Add urlDecode length limit (Issue #14) - **DONE**
- [x] Add strict DSN parsing mode (Issue #15) - **DONE**
- [ ] Consider runtime warnings when `insecure=true`
- [ ] Implement input validation in auth.zig for usernames/roles
- [ ] Implement TLS for gRPC transport (Finding #26)

---

## Blockers and Unknowns

### Unknowns Requiring Investigation

1. **Server-side handling of malformed JSON:** The full impact of JSON injection depends on how the Geode server parses and processes malformed JSON messages. Confirmed exploitation requires server-side testing.

2. **Dependency security:** While SBOM scanning is configured, a full dependency audit was not performed. The `build.zig.zon` dependencies should be reviewed for known vulnerabilities.

3. **gRPC transport usage in production:** Finding #26 (cleartext gRPC) severity depends on whether gRPC transport is actively used or is an experimental/internal-only path. If gRPC is not exposed to users, the effective risk is lower.

4. **RLS policy predicate injection (Finding #25):** Exploitation requires determining whether end users can supply arbitrary predicate strings or if predicates are always admin-controlled. If admin-only, effective risk is reduced but the code defect remains.

5. **@constCast UB in proto.zig (Finding #32):** Confirming exploitability requires identifying any code path that assigns a non-empty string literal to `HelloResponse.session_id` or `error_message` without heap allocation.

### Issue Status

**Security Findings (24/32 remediated, 8 open):**

- Finding #1: JSON Injection in auth.zig - **CLOSED** (`appendEscapedString` + 8 tests)
- Finding #2: Gitleaks allowlist too permissive - **CLOSED** (targeted regex rules)
- Finding #3: SBOM scan allows failure - **CLOSED** (`allow_failure: false`)
- Finding #4: Hardcoded allocator in auth.zig - **CLOSED** (use `self.allocator`)
- Finding #5: TLS verification skip underdocumented - **CLOSED** (security warnings added)
- Finding #6: JSON Injection in protocol.zig buildHello - **CLOSED** (code fix + 2 tests)
- Finding #7: CI/CD Supply Chain Risk - **Won't Fix** (managed through other organizational controls)
- Finding #8: QueryBuilder documentation improvements - **CLOSED** (comprehensive docs)
- Finding #9: Sensitive data not zeroed before free in auth.zig - **CLOSED** (`@memset` before `allocator.free` + 3 tests)
- Finding #10: Batch module lacks maximum query count - **CLOSED** (`MAX_BATCH_SIZE = 10000` + validation + 4 tests)
- Finding #11: Date/Time constructors lack bounds validation - **CLOSED** (`initChecked()` methods + 18 tests)
- Finding #12: Integration tests allow_failure bypasses quality gate - **CLOSED** (rules-based `allow_failure`)
- Finding #13: Config.password not zeroed before free - **CLOSED** (`Config.deinit()` with `@memset` + 3 tests)
- Finding #14: urlDecode has no input length limit - **CLOSED** (`MAX_URL_DECODE_LENGTH = 64KB` + 4 tests)
- Finding #15: DSN parsing silently uses default on invalid port - **CLOSED** (`parseDSNStrict()` + 9 tests)
- Finding #16: recv_buffer has no maximum size limit - **CLOSED** (`MAX_RECV_BUFFER_SIZE = 16MB` + validation + 2 tests)
- Finding #17: isIpv6 validation is weak - **CLOSED** (strengthened character validation + 6 tests)
- Finding #18: QueryBuilder param() does not validate parameter names - **CLOSED** (`validate.paramName()` call + 4 tests)
- Finding #19: CI downloads Zig without integrity verification - **CLOSED** (SHA256 verification from index.json)
- Finding #20: Config.deinit frees non-owned credentials - **CLOSED** (`withCredentials` allocates owned copies + 3 tests)
- Finding #21: parseDSNStrict lacks bounds validation - **CLOSED** (`validate.pageSize/timeout` calls + 8 tests)
- Finding #22: parseResponseType uses substring search - **CLOSED** (resolved by protobuf migration)
- Finding #23: Examples default to insecure TLS - **CLOSED** (default `insecure=false` + env var/flag + warnings)
- Finding #24: Dependency scanning may not cover Zig deps - **CLOSED** (custom SBOM script + CI job)
- Finding #25: GQL Injection via RLS Policy Predicate - **OPEN** (High, SLA: 30 days)
- Finding #26: gRPC Transport Has No TLS Implementation - **OPEN** (High, SLA: 30 days)
- Finding #27: Password Not Zeroed in GeodeClient.deinit() - **OPEN** (High, SLA: 30 days)
- Finding #28: Protobuf String Decoding Has No Per-Field Size Limit - **OPEN** (Medium, SLA: 90 days)
- Finding #29: Unbounded Row Count in DataPage Decoding - **OPEN** (Medium, SLA: 90 days)
- Finding #30: SHA256 Verification Fetches Checksum from Same Origin - **OPEN** (Medium, SLA: 90 days)
- Finding #31: Docker Images Use Unpinned :latest Tags - **OPEN** (Medium, SLA: 90 days)
- Finding #32: @constCast on Potentially Static Strings in proto.zig - **OPEN** (Low, SLA: 180 days)

---

## Methodology

This security review was conducted using:

1. **Static Analysis:** Manual code review of all source files
2. **Pattern Matching:** Grep/ripgrep for security-sensitive patterns
3. **Configuration Review:** Analysis of CI/CD, pre-commit, and gitleaks configs
4. **Threat Modeling:** Assessment of trust boundaries and data flows

### Files Reviewed

- `src/*.zig` - All source modules (including `proto.zig`, `grpc.zig` added in protobuf migration)
- `geode_client_v2.zig` - Main client implementation
- `tests/integration.zig` - Integration test suite
- `.gitlab-ci.yml` - CI/CD pipeline
- `.gitleaks.toml` - Secret scanning config
- `.pre-commit-config.yaml` - Pre-commit hooks
- `build.zig.zon` - Dependencies

### Tools Used

- ripgrep for pattern matching
- GitLab CLI (glab) for issue creation (prior rounds)
- Manual code review
- Adversarial review methodology (2026-03-24 audit)

---

## Change Log

| Date | Change | Author |
|------|--------|--------|
| 2026-01-30 | Initial security review completed | Claude Opus 4.5 |
| 2026-01-30 | Remediated all 5 findings: JSON injection (auth.zig), gitleaks allowlist, SBOM allow_failure, hardcoded allocator, TLS documentation | Claude Opus 4.5 |
| 2026-01-30 | Follow-up adversarial review: identified 3 new findings (#6 buildHello escaping, #7 CI supply chain, #8 QueryBuilder docs) | Claude Opus 4.5 |
| 2026-01-30 | Issue #7 closed as Won't Fix - CI catalog versions managed through other org controls | Claude Opus 4.5 |
| 2026-01-30 | Issue #6 closed: Fixed JSON injection in buildHello (protocol.zig), added 2 unit tests | Claude Opus 4.5 |
| 2026-01-30 | Issue #8 closed: Added comprehensive security documentation to QueryBuilder with injection warnings | Claude Opus 4.5 |
| 2026-01-30 | Adversarial follow-up review: identified 2 new findings (#9 sensitive data zeroing, #10 batch size limit) | Claude Opus 4.5 |
| 2026-01-30 | Issue #9 closed: Added @memset to zero session tokens before free in auth.zig (deinit, setAuthenticated, clearAuthentication) + 3 tests | Claude Opus 4.5 |
| 2026-01-30 | Issue #10 closed: Added MAX_BATCH_SIZE=10000 limit with validation in batch.zig (add, addWithParams) + 4 tests | Claude Opus 4.5 |
| 2026-01-30 | Continued adversarial review: identified 5 additional findings (#11-15) | Claude Opus 4.5 |
| 2026-01-30 | Issue #11 created: Date/Time constructors lack bounds validation (CWE-20) | Claude Opus 4.5 |
| 2026-01-30 | Issue #12 created: Integration tests allow_failure bypasses quality gate (CWE-1127) | Claude Opus 4.5 |
| 2026-01-30 | Issue #13 created: Config.password not zeroed before free (CWE-316) - Confidential | Claude Opus 4.5 |
| 2026-01-30 | Issue #14 created: urlDecode has no input length limit (CWE-400) | Claude Opus 4.5 |
| 2026-01-30 | Issue #15 created: DSN parsing silently uses default on invalid port (CWE-20) | Claude Opus 4.5 |
| 2026-01-30 | Issue #11 closed: Added `Date.initChecked()` and `Time.initChecked()` with bounds validation + 18 tests | Claude Opus 4.5 |
| 2026-01-30 | Issue #12 closed: Changed allow_failure to rules-based approach (strict on main, lenient on MRs) | Claude Opus 4.5 |
| 2026-01-30 | Issue #13 closed: Added `Config.deinit()` with `@memset` to zero password before free + 3 tests | Claude Opus 4.5 |
| 2026-01-30 | Issue #14 closed: Added `MAX_URL_DECODE_LENGTH = 64KB` with validation in `urlDecode()` + 4 tests | Claude Opus 4.5 |
| 2026-01-30 | Issue #15 closed: Added `parseDSNStrict()` that returns errors for invalid port/page_size/timeout + 9 tests | Claude Opus 4.5 |
| 2026-01-30 | All 16 original findings closed - Security gap analysis complete | Claude Opus 4.5 |
| 2026-01-30 | **Adversarial follow-up review Phase 2**: Identified 3 new findings (#16-18) | Claude Opus 4.5 |
| 2026-01-30 | Issue #16 created: recv_buffer has no maximum size limit (CWE-400, Medium) | Claude Opus 4.5 |
| 2026-01-30 | Issue #17 created: isIpv6 validation is weak (CWE-20, Low) | Claude Opus 4.5 |
| 2026-01-30 | Issue #18 created: QueryBuilder param() does not validate parameter names (CWE-20, Low) | Claude Opus 4.5 |
| 2026-01-30 | Updated GAP_ANALYSIS.md with 3 new open findings (19 total, 16 closed) | Claude Opus 4.5 |
| 2026-01-30 | Issue #16 closed: Added `MAX_RECV_BUFFER_SIZE = 16MB` constant with validation in `receiveMessage()` + 2 tests | Claude Opus 4.5 |
| 2026-01-30 | Issue #17 closed: Strengthened `isIpv6()` to validate character set (hex, colons, dots, brackets, zone IDs) + 6 tests | Claude Opus 4.5 |
| 2026-01-30 | Issue #18 closed: Added `validate.paramName()` call in `QueryBuilder.param()` + updated build.zig + 4 tests | Claude Opus 4.5 |
| 2026-01-30 | **All 19 findings remediated - Security gap analysis complete** | Claude Opus 4.5 |
| 2026-03-24 | Adversarial review Phase 3: findings #19-#24 remediated (commits 9ceac61, b44db0b). Closed GitLab issues #1-#5, #9-#24 (21 issues). Updated Issue Status to 24/24. Enhancement issues remain open as future work. | Claude Opus 4.6 |
| 2026-03-24 | **2026-03-24 Audit**: Added 8 new findings (#25-#32) from protobuf migration and expanded code audit. 3 High (GQL injection in RLS predicate, cleartext gRPC, password not zeroed), 4 Medium (protobuf field size, row count, CI checksum origin, Docker :latest), 1 Low (@constCast UB). --skip-issues mode; no GitLab issues created. | Claude Opus 4.6 |
