<!-- SPDX-License-Identifier: Apache-2.0 -->

# geode-client-zig — FIPS support design (2026-06-23)

**Status:** approved design (brainstorming) → next: implementation plan.
**Worktree:** `.worktrees/fips` on branch `feat/fips` (isolated; other agents are active in the main tree + `.worktrees/driver-parity`).

## Goal

Add a `-Dfips` build mode to `geode-client-zig` that routes all security
crypto through the OpenSSL FIPS-140-3 validated provider (via the `fips`
package seam), while the default (`-Dfips=false`) build keeps the current
`std.crypto` behavior with zero OpenSSL coupling. Both modes stay green.

## Core principle

- **Approved crypto** (SHA-2/3, HMAC, HKDF, AES-GCM, ECDSA/RSA/Ed25519,
  ML-* PQC) → routed through the `crypto_backend` seam.
- **Non-approved mechanisms are removed/fail-closed under `-Dfips=true`** —
  `@compileError` where the algorithm is comptime-known, else
  `error.FipsUnsupported` at runtime. No silent substitution.
- Call sites import `crypto_backend`, **never** `std.crypto` in a security
  path.

Recon note: geode-client-zig's current crypto is **entirely FIPS-approved**
already — `std.crypto.kdf.hkdf.HkdfSha256`, `std.crypto.auth.hmac.sha2.HmacSha256`,
`std.crypto.aead.aes_gcm.Aes256Gcm`, and `std.crypto.secureZero` (in
`src/crypto.zig`, `src/auth.zig`, `src/config.zig`). So there is **no
non-approved algorithm to remove here** — this repo's work is pure routing +
dep bumps. (The `std.crypto.tls.Client` references in `src/grpc.zig` are
TODO comments, not live code.)

## Mechanism — the seam (mirrors the 18 devnw/zig consumers)

1. Vendor three canonical files into `src/`, byte-identical to the `fips`
   repo sources: `crypto_backend.zig` (the comptime backend selector),
   `std_shim.zig` (std.crypto backend), `policy.zig` (approved-algorithm
   allow-list).
2. `build.zig`: add `const fips = b.option(bool, "fips", ...) orelse false;`
   and thread it into the **single** existing `build_options` module
   (`build.zig:53-56` already materializes one — add `addOption(bool, "fips", fips)`),
   preserving the GAP-0020 single-`build_options` rule.
3. Add the lazy dependency (only fetched under `-Dfips=true`):

   ```zig
   .fips = .{ .url = "git+https://gitlab.com/devnw/zig/fips.git#v0.1.0",
              .hash = "fips-0.1.0-1wf3nbxWBgAp6yAk6cPRrF5l_U1tbblcVcN9xcjJDddy",
              .lazy = true },
   ```

   and in `build.zig`, under `-Dfips=true`, `b.lazyDependency("fips", ...)` +
   `link.linkOpenssl` (dynamic, via the fips package's `link.zig` helper or a
   vendored copy) onto the compile units that use crypto.
4. `crypto_backend.zig` selects `@import("fips")` (true) or the local
   `std_shim` (false) at comptime from `build_options.fips`.

## Dependency bumps (FIPS-enabled transport stack)

- `quic` v0.1.32 → **v0.1.33**, `tls` v0.1.15 → **v0.1.16** (the published
  FIPS/PQC stack). Resolve any `detect-diamond-deps` conflicts (bump shared
  transitive consumers to a single version, as done for http3/quic).
- Re-run `zig build --fetch` to confirm clean resolution.

## Routing work (per file)

- `src/crypto.zig` — the central crypto module: replace the `std.crypto`
  HKDF/HMAC/AES-256-GCM/secureZero uses with `crypto_backend.{Kdf,Mac,Aead,secureZero}`.
- `src/auth.zig` — route its 6 crypto sites through `crypto_backend`.
- `src/config.zig` — route its 3 sites through `crypto_backend`.
- `src/grpc.zig` — no live crypto (TODO comments only); add a note that
  future TLS must use the `tls` package (FIPS-routed), not `std.crypto.tls`.

## Testing

- **Dual-mode gate:** `zig build test` green with `-Dfips=false` (shim) AND
  `-Dfips=true -Dopenssl_path=/usr/local/ssl` (OpenSSL FIPS, provider at
  `/usr/local/ssl`). Add a `make test-dual`-style target.
- **KATs/parity:** existing crypto tests must pass under both backends
  (the seam is API-compatible); add a parity test that the same
  HKDF/HMAC/AES-GCM inputs produce identical outputs in both modes.
- No fail-closed tests needed here (no non-approved algos), but assert the
  seam is wired (`crypto_backend` re-exports resolve under both flags).

## Out of scope (tracked follow-ups)

- Implementing the actual `tls.Client` transport (currently a TODO).
- CI `.gitlab-ci.yml` FIPS dual-mode job (mirror the fips repo's pattern) —
  include if low-effort, else note as follow-up.

## Execution

All work in the `feat/fips` worktree; commit on `feat/fips`. Do not touch
the main tree or `.worktrees/driver-parity` (other agents). Push the branch
when green (no merge to main without user direction).
