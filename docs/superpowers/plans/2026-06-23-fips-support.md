# geode-client-zig FIPS Support — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax. Work ONLY in this worktree (`.worktrees/fips`, branch `feat/fips`); never touch the main tree or `.worktrees/driver-parity`.

**Goal:** Add a `-Dfips` build mode that routes geode-client-zig's security crypto through the OpenSSL FIPS-validated provider (via the `fips` seam), keeping the default `-Dfips=false` build on `std.crypto` with zero OpenSSL coupling; both modes green.

**Architecture:** Vendor the canonical 3-file seam (`crypto_backend.zig`/`std_shim.zig`/`policy.zig`) + a `link.zig` OpenSSL helper into `src/`; add a `-Dfips` option threaded through the single `build_options` module; add a lazy `fips@v0.1.0` dep; route `src/crypto.zig` + the `secureZero` sites in `src/auth.zig`/`src/config.zig` through `crypto_backend`. Bump the transport stack to the FIPS-enabled `quic@v0.1.33`/`tls@v0.1.16`.

**Tech Stack:** Zig 0.16.0, OpenSSL 3.x FIPS provider (at `/usr/local/ssl`), the published `fips` package.

## Global Constraints

- Approved crypto → `crypto_backend` seam; never `std.crypto` in a security path. (geode-client-zig has NO non-approved algorithms — pure routing.)
- ONE `build_options` module only (GAP-0020); thread `-Dfips` into the existing one at `build.zig:53-56`.
- Published fips dep: `.url = "git+https://gitlab.com/devnw/zig/fips.git#v0.1.0"`, `.hash = "fips-0.1.0-1wf3nbxWBgAp6yAk6cPRrF5l_U1tbblcVcN9xcjJDddy"`, `.lazy = true`.
- Both modes green: `-Dfips=false` (default, std_shim) AND `-Dfips=true -Dopenssl_path=/usr/local/ssl` (OpenSSL FIPS). OpenSSL FIPS provider is installed at `/usr/local/ssl`; set `OPENSSL_CONF=/usr/local/ssl/ssl/openssl.cnf` for fips test runs.
- Seam files (`crypto_backend.zig`, `std_shim.zig`, `policy.zig`, `link.zig`) are copied BYTE-IDENTICAL from the published `fips` repo (fetch from the cache: `~/.cache/zig/p/fips-0.1.0-*/{templates/crypto_backend.zig,src/std_shim.zig,src/policy.zig,src/link.zig}`).
- Commit per task on `feat/fips`. Conventional commits; the repo's pre-commit hooks auto-fix markdown/whitespace (re-stage + re-commit if a commit aborts). End commit bodies with `Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>`. Do NOT push without user direction.

---

### Task 1: Vendor the seam + wire `-Dfips` into the build

**Files:**
- Create: `src/crypto_backend.zig`, `src/std_shim.zig`, `src/policy.zig`, `src/link.zig` (copied from the fips@v0.1.0 cache)
- Modify: `build.zig` (build_options ~:53-56; add the `crypto_backend` module + lazy fips wiring), `build.zig.zon` (add lazy fips dep)
- Test: `src/crypto_backend_smoke_test.zig` (new)

**Interfaces:**
- Produces: a `crypto_backend` module importable by `src/` modules, re-exporting `Aead`/`Hash`/`Mac`/`Kdf`/`Sig`/`Kem`/`Csprng`/`policy`/`secureZero`/`timingSafeEql`/`assertActive`, selecting the OpenSSL `fips` backend under `-Dfips=true` and `std_shim` otherwise.

- [ ] **Step 1 — Vendor the seam files.** Copy the four canonical files from the fips@v0.1.0 package cache (resolve the dir: `FP=$(echo ~/.cache/zig/p/fips-0.1.0-*)`): `cp "$FP/templates/crypto_backend.zig" src/crypto_backend.zig`; `cp "$FP/src/std_shim.zig" src/std_shim.zig`; `cp "$FP/src/policy.zig" src/policy.zig`; `cp "$FP/src/link.zig" src/link.zig`. (If the cache dir is absent, `zig build --fetch` first.) `crypto_backend.zig` imports `build_options`, `std_shim` (sibling), and (under fips) `fips`; `std_shim.zig` imports sibling `policy.zig`.

- [ ] **Step 2 — Add the `-Dfips` option + thread into `build_options`.** In `build.zig`, after the `with_otel` option (~:36) add:
```zig
    const fips = b.option(bool, "fips", "Route security crypto through the OpenSSL FIPS provider (default false = std.crypto shim)") orelse false;
    const openssl_path = b.option([]const u8, "openssl_path", "OpenSSL FIPS install prefix (e.g. /usr/local/ssl)");
```
and in the `build_options` block (~:53-56) add `build_options.addOption(bool, "fips", fips);` BEFORE `createModule()`.

- [ ] **Step 3 — Add the lazy fips dependency.** In `build.zig.zon` `.dependencies`, add:
```zig
        .fips = .{
            .url = "git+https://gitlab.com/devnw/zig/fips.git#v0.1.0",
            .hash = "fips-0.1.0-1wf3nbxWBgAp6yAk6cPRrF5l_U1tbblcVcN9xcjJDddy",
            .lazy = true,
        },
```

- [ ] **Step 4 — Build the `crypto_backend` module + link OpenSSL under fips.** In `build.zig`, after `build_options_mod` is created and after the dep block, add a helper that builds the seam module and is imported by crypto-using internal modules:
```zig
    const std_shim_mod = b.createModule(.{ .root_source_file = b.path("src/std_shim.zig"), .target = target, .optimize = optimize });
    const crypto_backend_mod = b.createModule(.{
        .root_source_file = b.path("src/crypto_backend.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{ .{ .name = "build_options", .module = build_options_mod }, .{ .name = "std_shim", .module = std_shim_mod } },
    });
    const link = @import("src/link.zig");
    if (fips) {
        if (b.lazyDependency("fips", .{ .target = target, .optimize = optimize })) |fips_dep| {
            crypto_backend_mod.addImport("fips", fips_dep.module("fips"));
            link.linkOpenssl(b, crypto_backend_mod, openssl_path);
        }
    }
```
Then add `.addImport("crypto_backend", crypto_backend_mod)` to every internal module that will use crypto (at least the module rooted where `crypto.zig`/`auth.zig`/`config.zig` live — locate their `createModule` calls and add the import; if they're part of a single `client`/root module, add it there). Under `-Dfips=true`, also thread `linkOpenssl` onto the final exe/test artifacts that include crypto (mirror the existing ssl/crypto link helper at `build.zig:5-14`).

- [ ] **Step 5 — Smoke test (both modes).** Create `src/crypto_backend_smoke_test.zig`:
```zig
const std = @import("std");
const cb = @import("crypto_backend");
test "crypto_backend seam wired: hash digest works in both modes" {
    var out: [32]u8 = undefined;
    const n = try cb.Hash.digest(.sha256, "abc", &out);
    try std.testing.expectEqual(@as(usize, 32), n);
}
```
Wire it into the test build importing `crypto_backend`.

- [ ] **Step 6 — Verify both modes compile + smoke test passes.**
  Run: `zig build test -Dfips=false` → PASS.
  Run: `OPENSSL_CONF=/usr/local/ssl/ssl/openssl.cnf zig build test -Dfips=true -Dopenssl_path=/usr/local/ssl` → PASS.

- [ ] **Step 7 — Commit:** `feat(fips): vendor crypto_backend seam + wire -Dfips build option`.

---

### Task 2: Bump the transport stack to the FIPS-enabled quic/tls

**Files:** Modify `build.zig.zon` (quic, tls pins)

- [ ] **Step 1 — Bump pins.** In `build.zig.zon`, set `quic` → `.url = "git+https://gitlab.com/devnw/zig/quic.git#v0.1.33"` with the v0.1.33 hash (compute: `zig fetch 'git+https://gitlab.com/devnw/zig/quic.git#v0.1.33'` from this worktree), and `tls` → `.url = "git+https://gitlab.com/devnw/zig/tls.git#v0.1.16"` with `.hash = "tls-0.1.16-mtEaLPssFgDXM8r7HPoDgZaqNfrAZbAhTQvk7SDmprqu"`.

- [ ] **Step 2 — Resolve + diamond check.** Run `zig build --fetch` (exit 0). Then `uvx --from git+https://gitlab.com/devnw/zig/zig-tool detect-diamond-deps` → must report clean. If a tls/quic/otel diamond appears, bump the conflicting transitive consumer to its v0.1.16-bearing release (same procedure used for http3), or STOP and report if it requires releasing another package.

- [ ] **Step 3 — Build both modes.** `zig build -Dfips=false` and `OPENSSL_CONF=/usr/local/ssl/ssl/openssl.cnf zig build -Dfips=true -Dopenssl_path=/usr/local/ssl` both compile.

- [ ] **Step 4 — Commit:** `build(deps): bump quic v0.1.33 + tls v0.1.16 (FIPS stack)`.

---

### Task 3: Route `src/crypto.zig` through the seam

**Files:** Modify `src/crypto.zig`

**Interfaces:** Consumes `crypto_backend` (`Aead`, `Kdf`, `Mac`, `Csprng`, `secureZero`, `policy`).

- [ ] **Step 1 — Replace the std.crypto imports + ops.** Edit `src/crypto.zig`:
  - Replace the three `const ... = std.crypto...` aliases (lines 11-13) with `const cb = @import("crypto_backend");`. Keep `KEY_SIZE=32`, `NONCE_SIZE=12`, `TAG_SIZE=16` as literals (or from `policy`).
  - `deriveKey`: replace `Hkdf.extract`+`Hkdf.expand` with `try cb.Kdf.hkdf(.sha256, master_key, &[_]u8{}, info, &out);` (extract+expand, empty salt — matches current behavior). Make `deriveKey` return `cb.Kdf.Error![KEY_SIZE]u8` and `init` propagate it.
  - `Cipher.deinit`: `cb.secureZero(&self.enc_key); cb.secureZero(&self.hmac_key);`
  - `encrypt`: fill the nonce with `try cb.Csprng.bytes(&nonce);` and encrypt with `try cb.Aead.seal(.aes_256_gcm, &self.enc_key, &nonce, &[_]u8{}, plaintext, ct, &tag);` — widen the return error set to include `cb.Csprng.Error || cb.Aead.Error`.
  - `decrypt`: `cb.Aead.open(.aes_256_gcm, &self.enc_key, &nonce, &[_]u8{}, ct, &tag, pt) catch { allocator.free(pt); return CryptoError.AuthenticationFailed; };` (maps `error.AuthFailed`/any seam error → `AuthenticationFailed`).
  - `hmacHex`: `var mac: [32]u8 = undefined; _ = try cb.Mac.hmac(.sha256, &self.hmac_key, data, &mac);` (widen error set with `cb.Mac.Error`).
  - Update `encryptString`/`decryptString`/`init` error unions to include the new seam error sets where they propagate.

- [ ] **Step 2 — Update the in-file tests.** The existing tests call `Cipher.init/encrypt/decrypt/...`; add `try` where signatures became fallible. The KAT semantics are unchanged (same algorithms), so assertions stay; the round-trip + tamper + short-input + hmac-determinism tests must still pass.

- [ ] **Step 3 — Verify both modes.**
  `zig build test -Dfips=false` → all crypto.zig tests PASS.
  `OPENSSL_CONF=/usr/local/ssl/ssl/openssl.cnf zig build test -Dfips=true -Dopenssl_path=/usr/local/ssl` → all PASS (now exercising the OpenSSL FIPS backend).

- [ ] **Step 4 — Commit:** `feat(fips): route field-encryption crypto.zig through the seam`.

---

### Task 4: Route `secureZero` in `auth.zig` + `config.zig`

**Files:** Modify `src/auth.zig` (6 sites: lines ~231,236,421,438,444,457), `src/config.zig` (3 sites: ~154,314,334)

- [ ] **Step 1 — Replace.** In both files add `const cb = @import("crypto_backend");` (if not present) and replace every `std.crypto.secureZero(u8, X)` with `cb.secureZero(X)`. (Note: `cb.secureZero` takes a `[]u8`; the existing calls use `@constCast(...)` slices — keep the `@constCast`, drop the `u8` type arg.) Ensure both modules have `crypto_backend` imported in `build.zig` (added in Task 1 Step 4; extend if these modules weren't covered).

- [ ] **Step 2 — Verify both modes.** `zig build test -Dfips=false` and `... -Dfips=true ...` both PASS.

- [ ] **Step 3 — Commit:** `feat(fips): route auth/config secureZero through the seam`.

---

### Task 5: Dual-mode gate + parity test + docs

**Files:** Modify `Makefile` (add dual-mode targets), Create `src/fips_parity_test.zig`, Modify `src/grpc.zig` (TLS note), `README.md`/docs (toggle docs)

- [ ] **Step 1 — Parity test.** Create `src/fips_parity_test.zig` asserting the seam produces correct known answers (a SHA-256 KAT, an AES-256-GCM round-trip+tamper, an HKDF-SHA256 vector, an HMAC-SHA256 vector) via `crypto_backend` — these pass under BOTH backends, proving API+behavior parity. Wire into the test build.

- [ ] **Step 2 — Makefile dual-mode targets.** Add:
```make
test-shim:
	zig build test -Dfips=false --summary all
test-fips:
	OPENSSL_CONF=$(or $(OPENSSL_PREFIX),/usr/local/ssl)/ssl/openssl.cnf zig build test -Dfips=true -Dopenssl_path=$(or $(OPENSSL_PREFIX),/usr/local/ssl) --summary all
test-dual: test-shim test-fips
```

- [ ] **Step 3 — grpc.zig TLS note.** Update the `std.crypto.tls.Client` TODO comments in `src/grpc.zig` to state that the future TLS transport MUST use the `tls` package (FIPS-routed via `-Dfips`), never `std.crypto.tls`, in a security path.

- [ ] **Step 4 — Docs.** Add a short "FIPS mode" section to `README.md` (or docs/) documenting `-Dfips=true -Dopenssl_path=...`, `make test-dual`, and that all field-encryption/auth crypto routes through the validated provider under FIPS.

- [ ] **Step 5 — Final gate.** `make test-dual` green. `grep -rn 'std\.crypto\.' src` shows only non-security or seam-internal uses (the seam files + any `// fips-exempt` annotations); no `std.crypto` in a security path outside the seam.

- [ ] **Step 6 — Commit:** `test(fips): dual-mode gate + parity test + docs`.

---

## Self-Review

- **Spec coverage:** seam vendoring + `-Dfips` (Task 1) ✓; dep bumps (Task 2) ✓; route crypto.zig (Task 3) ✓; route auth/config secureZero (Task 4) ✓; dual-mode/parity/docs + tls.Client note (Task 5) ✓. No non-approved algorithms in this repo (spec confirmed) → no fail-closed tasks needed. ✓
- **Placeholders:** none — concrete code/commands per step.
- **Type consistency:** `cb` = `@import("crypto_backend")` throughout; seam APIs (`Kdf.hkdf(hash,ikm,salt,info,out)`, `Aead.seal/open(alg,key,nonce,ad,...)`, `Mac.hmac(hash,key,msg,out)→usize`, `Csprng.bytes(out)`, `secureZero([]u8)`) match the published fips v0.1.0 surface; `policy.Aead.aes_256_gcm` / `policy.Hash.sha256` are the enum tags used.
