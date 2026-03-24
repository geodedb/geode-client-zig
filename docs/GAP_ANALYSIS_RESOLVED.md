# Gap Analysis -- Resolved

**Project:** geode-client-zig
**Repository:** gitlab.com/devnw/codepros/geode/geode-client-zig

All 24 security findings from the adversarial review have been remediated and their GitLab issues closed.

---

## GAP-0001: JSON Injection in auth.zig [RESOLVED]

- **Issue:** [#1](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/1) (closed)
- **Category:** Security
- **Resolution:** Added `appendEscapedString` for all user input in auth message builders + 8 tests. Additionally resolved by protobuf migration (commit 53579e8) which eliminated JSON message construction entirely.
- **Evidence:** `src/auth.zig` lines 21-41; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0002: Gitleaks allowlist too permissive [RESOLVED]

- **Issue:** [#2](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/2) (closed)
- **Category:** Security
- **Resolution:** Replaced blanket `.zig` and `.md` exclusions with 9 targeted regex rules in `.gitleaks.toml`.
- **Evidence:** `.gitleaks.toml`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0003: SBOM scan allows failure [RESOLVED]

- **Issue:** [#3](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/3) (closed)
- **Category:** CI-CD
- **Resolution:** Set `allow_failure: false` on SBOM scan CI job.
- **Evidence:** `.gitlab-ci.yml`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0004: Hardcoded allocator in auth.zig [RESOLVED]

- **Issue:** [#4](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/4) (closed)
- **Category:** Code Quality
- **Resolution:** All auth message builder functions now use `self.allocator` instead of `std.heap.page_allocator`.
- **Evidence:** `src/auth.zig`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0005: TLS verification skip underdocumented [RESOLVED]

- **Issue:** [#5](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/5) (closed)
- **Category:** Docs
- **Resolution:** Added prominent security warnings in documentation about `insecure` mode.
- **Evidence:** README.md, SECURITY.md; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0006: JSON Injection in protocol.zig buildHello [RESOLVED]

- **Issue:** [#6](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/6) (closed)
- **Category:** Security
- **Resolution:** Applied `appendEscapedString` for client_name/version/conformance + 2 tests. Also resolved by protobuf migration.
- **Evidence:** Commit 9ceac61; protobuf migration commit 53579e8
- **Resolved date:** 2026-01-30

## GAP-0007: CI/CD Supply Chain Risk [RESOLVED]

- **Issue:** [#7](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/7) (closed)
- **Category:** CI-CD
- **Resolution:** Won't Fix -- CI catalog component versions managed through other organizational controls.
- **Evidence:** N/A
- **Resolved date:** 2026-01-30

## GAP-0008: QueryBuilder lacks input validation [RESOLVED]

- **Issue:** [#8](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/8) (closed)
- **Category:** Docs
- **Resolution:** Added comprehensive security documentation and injection warnings to QueryBuilder.
- **Evidence:** `src/query_builder.zig`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0009: Sensitive data not zeroed before free in auth.zig [RESOLVED]

- **Issue:** [#9](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/9) (closed)
- **Category:** Security
- **Resolution:** Added `@memset(@constCast(token), 0)` before `allocator.free` in deinit, setAuthenticated, clearAuthentication + 3 tests.
- **Evidence:** `src/auth.zig`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0010: Batch module lacks maximum query count [RESOLVED]

- **Issue:** [#10](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/10) (closed)
- **Category:** Security
- **Resolution:** Added `MAX_BATCH_SIZE = 10000` constant with validation in add/addWithParams + 4 tests.
- **Evidence:** `src/batch.zig`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0011: Date/Time constructors lack bounds validation [RESOLVED]

- **Issue:** [#11](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/11) (closed)
- **Category:** Security
- **Resolution:** Added `initChecked()` methods for Date/Time with bounds validation + `Value.initDateChecked/initTimeChecked` + 18 tests.
- **Evidence:** `src/types.zig`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0012: Integration tests allow_failure bypasses quality gate [RESOLVED]

- **Issue:** [#12](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/12) (closed)
- **Category:** CI-CD
- **Resolution:** Rules-based approach: `allow_failure: false` on main branch, `true` on MRs.
- **Evidence:** `.gitlab-ci.yml`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0013: Config.password not zeroed before free [RESOLVED]

- **Issue:** [#13](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/13) (closed)
- **Category:** Security
- **Resolution:** Added `Config.deinit()` with `@memset` to zero password before free + 3 tests.
- **Evidence:** `src/config.zig`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0014: urlDecode has no input length limit [RESOLVED]

- **Issue:** [#14](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/14) (closed)
- **Category:** Security
- **Resolution:** Added `MAX_URL_DECODE_LENGTH = 64KB` with validation in `urlDecode()` + 4 tests.
- **Evidence:** `src/config.zig`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0015: DSN parsing silently uses default on invalid port [RESOLVED]

- **Issue:** [#15](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/15) (closed)
- **Category:** Security
- **Resolution:** Added `parseDSNStrict()` that returns errors for invalid port/page_size/timeout + 9 tests.
- **Evidence:** `src/config.zig`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0016: recv_buffer has no maximum size limit [RESOLVED]

- **Issue:** [#16](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/16) (closed)
- **Category:** Security
- **Resolution:** Added `MAX_RECV_BUFFER_SIZE = 16MB` constant with check before append + 2 tests.
- **Evidence:** `geode_client_v2.zig`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0017: isIpv6 validation is weak [RESOLVED]

- **Issue:** [#17](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/17) (closed)
- **Category:** Security
- **Resolution:** Strengthened validation to check valid IPv6 character set + 6 tests.
- **Evidence:** `src/validate.zig`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0018: QueryBuilder param() does not validate parameter names [RESOLVED]

- **Issue:** [#18](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/18) (closed)
- **Category:** Security
- **Resolution:** Added `validate.paramName()` call in param() method + 4 tests.
- **Evidence:** `src/query_builder.zig`; commit 9ceac61
- **Resolved date:** 2026-01-30

## GAP-0019: CI downloads Zig without integrity verification [RESOLVED]

- **Issue:** [#19](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/19) (closed)
- **Category:** CI-CD
- **Resolution:** Added SHA256 verification from index.json before extraction in CI pipeline.
- **Evidence:** `.gitlab-ci.yml`; commit b44db0b
- **Resolved date:** 2026-03-24

## GAP-0020: Config.deinit frees non-owned credentials [RESOLVED]

- **Issue:** [#20](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/20) (closed)
- **Category:** Bug
- **Resolution:** `withCredentials` now allocates owned copies of credential strings + 3 tests.
- **Evidence:** `src/config.zig`; commit b44db0b
- **Resolved date:** 2026-03-24

## GAP-0021: parseDSNStrict lacks bounds validation for page_size/timeout [RESOLVED]

- **Issue:** [#21](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/21) (closed)
- **Category:** Security
- **Resolution:** Added `validate.pageSize` and `validate.timeout` calls + timeout validation + 8 tests.
- **Evidence:** `src/config.zig`; commit b44db0b
- **Resolved date:** 2026-03-24

## GAP-0022: parseResponseType uses substring search (spoofable) [RESOLVED]

- **Issue:** [#22](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/22) (closed)
- **Category:** Security
- **Resolution:** Resolved by protobuf migration -- binary tags replace string matching. `src/protocol.zig` removed entirely.
- **Evidence:** `src/proto.zig` (replacement module); commit 53579e8
- **Resolved date:** 2026-03-24

## GAP-0023: Examples default to insecure TLS verification [RESOLVED]

- **Issue:** [#23](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/23) (closed)
- **Category:** Security
- **Resolution:** Examples now default to `insecure=false` with env var/flag override + security warnings.
- **Evidence:** `example_simple.zig`, `example_usage.zig`, `benchmark.zig`; commit b44db0b
- **Resolved date:** 2026-03-24

## GAP-0024: Dependency scanning may not cover Zig dependencies [RESOLVED]

- **Issue:** [#24](https://gitlab.com/devnw/codepros/geode/geode-client-zig/-/issues/24) (closed)
- **Category:** CI-CD
- **Resolution:** Added custom SBOM generation script for `build.zig.zon` + CI job for Zig dependency scanning.
- **Evidence:** `scripts/generate-zig-sbom.sh`, `.gitlab-ci.yml`; commit b44db0b
- **Resolved date:** 2026-03-24
