# Copilot Instructions — ed25519.zig (Security-Critical)

**Audience:** GitHub Copilot & Copilot Chat for this repository.  
**Goal:** Generate **minimal, safe, spec-correct** patches to our Ed25519 (Zig) library.
**Variant:** Pure Ed25519 (RFC 8032): dom2 empty, PH=identity. Keep **cofactor‑cleared verify** `[8]S·B == [8](R + k·A)`.

---

## Repository Facts (source of truth)

- **Language/Tooling:** Zig ≥ 0.15.x; use `zig fmt` style and `std` APIs.
- **Build targets (must remain working):**
  - `zig build test` — unit tests (RFC 8032 vectors; canonical decoding; torsion rejection).
  - `zig build bench` — micro‑bench (prints median ns for keygen/sign/verify).
  - `zig build fuzz` — deterministic sign→verify fuzz (no RNG for secrets).
  - `UA_PERF_HARNESS_ENABLE=1 zig build ct-perf` — statistical timing harness (Welch’s t‑test).
- **Public API (do not break):**
  - `deriveKeyPair(seed: *const [32]u8) -> struct { sk: [64]u8, pk: [32]u8 }`
  - `sign(out_sig: *[64]u8, msg: []const u8, sk: *const [64]u8) void`
  - `verify(sig: *const [64]u8, msg: []const u8, pk: *const [32]u8) bool`

If a suggested change risks any of the above, propose an **alternative** that preserves them.

---

## Non‑Negotiable Rules (apply to all completions)

1. **Strict decoding for R and A (compressed points):**
   - Reject if decoded `y ≥ p` (non‑canonical).
   - After recovering `x`, **reject** if `x == 0` **and** the sign bit is `1`.
   - Always reject known small‑order encodings (torsion).
2. **Signing must be constant‑time:**
   - Basepoint scalar multiplication uses a **fixed‑window, branchless** method (table + `cmov`).
   - No secret‑dependent branches **or** secret‑indexed tables anywhere in signing.
3. **Deterministic Ed25519 only:**
   - `r = SHA‑512(prefix || M)`; do **not** introduce per‑message RNG.
   - Verify must **reject** `S ≥ L`; never "fix up" by reducing `S` mod `L` in verify.
4. **Zeroization:**
   - Best‑effort wipe of transient secrets (`h`, `hp`, `khash`, `a`, reduced scalars, `S`) using volatile/secure wipe; never log secrets.
5. **Cofactor‑cleared verify remains:**
   - Keep `[8]S·B == [8](R + k·A)` to avoid interop pitfalls while retaining strict parsing.
6. **Tests and harnesses are first‑class:**
   - Any code edit must keep all tests/harnesses green and update/add tests as needed.

> If a user request conflicts with the above, **explain the risk** and propose a spec‑compliant alternative.

---

## How to Propose Changes (Copilot Chat Behavior)

When asked to implement or modify something:

- **Prefer minimal patches**: show only the exact diffs for affected functions, plus any new helpers or tests.
- **Cite file paths** and **line‑anchored** context in explanations (but do not paste entire files).
- **Always add/update tests** next to the change:
  - RFC 8032 vectors (incl. empty and long message).
  - Canonical decoding: `y ≥ p` rejection; `(x==0 && sign=1)` rejection; torsion encodings.
  - Negative tests must fail closed.
- **Demonstrate how to run**: include the exact `zig build …` commands.
- **Never** suggest switching the hash, variant, or relaxing canonical rules.
- **Design rationale**: reply with ≤7 concise bullets; **do not** reveal chain‑of‑thought.

---

## Preferred Implementations & Patterns

- **Decoding helpers**: keep `y` as 255‑bit little‑endian; compare to `p = 2^255 − 19` before field import; constant‑time `feIsZero`; sign‑bit handling matches RFC.
- **Scalar multiply (basepoint)**: reuse the branchless, fixed‑window path; if a single implementation exists for variable‑base that is CT and safe to call with `BASE_POINT`, leverage it; otherwise add a CT basepoint path that uses `cmov` for table selects.
- **Zeroization**: implement a small `secureZero` (volatile stores) and wipe transient buffers on exit paths; avoid optimizer elision.
- **Verify path**: variable‑time operations are acceptable **only** on public inputs (`k`, `A`, `R`); never reuse variable‑time routines with secrets.

---

## Test Coverage Expectations (must haves)

- **RFC 8032 §7.1** vectors: tests 1–3 and the 1024‑byte message.
- **Canonical decoding** unit tests:
  - Reject `y = p` (and more generally `y ≥ p`).
  - Reject `(x == 0 && sign == 1)` after recovery.
  - Reject 8 known small‑order encodings.
- **Fuzz**: deterministic sign→verify loop over random seeds and random message lengths (no secret RNG).
- **Perf/CT harness**:
  - Welch’s t‑test comparing two scalar classes for basepoint multiply; gated by `UA_PERF_HARNESS_ENABLE=1`.
  - Include a **negative probe** mode that injects a data‑dependent branch under a build flag and ensures the harness detects it.
- **Micro‑bench**: print median ns for key steps; future medians should not regress beyond agreed thresholds (documented in perf JSON if present).

---

## Commands (include in responses)

```bash
zig build test
zig build bench
zig build fuzz
UA_PERF_HARNESS_ENABLE=1 zig build ct-perf
```

---

## What to Refuse (and what to suggest instead)

- ❌ Changing the variant (e.g., Ed25519ctx/ph) without an explicit, separate feature request.
  ✅ Suggest a separate module/flag and new tests if users insist.
- ❌ Accepting non‑canonical `R/A` encodings or “fixing” `S` by reduction during verify.
  ✅ Enforce strict parsing and `S < L` rejection.
- ❌ Secret‑dependent branches or table indices in signing code.
  ✅ Use fixed‑window with `cmov` and constant‑time compares.
- ❌ Logging secrets or leaving secret buffers live after use.
  ✅ Use best‑effort zeroization via volatile writes.

---

## Style & Documentation

- Follow Zig idioms and `zig fmt`. Keep functions small and single‑purpose.
- Public APIs: add brief doc comments; internal helpers: comment on constant‑time assumptions and inputs/outputs.
- Tests: self‑describing names; include exact expected values for vectors.

---

## Examples (good prompts for Copilot Chat)

- “Patch `decompressPoint` to **reject `y ≥ p`** and **fail if `x==0 && sign=1`**; add unit tests covering both cases and torsion encodings; show diff + `zig build test` output.”
- “Refactor basepoint scalar multiply to **branchless fixed‑window**; ensure no secret‑dependent control flow; add/keep timing harness and demonstrate `ct-perf` run under `UA_PERF_HARNESS_ENABLE=1`.”
- “Zeroize transient buffers (`h`, `hp`, `khash`, `a`, reduced scalars, `S`) at the end of `sign`; include a `secureZero` helper; prove via test that data no longer equals pre‑wipe values.”

---

**Definition of Done (for any change)**

- All four build targets run successfully; performance/timing gates respected.
- Decoding remains strict; signing remains constant‑time; secrets are wiped.
- Public API unchanged; tests updated/added; rationale ≤7 bullets.

```

---

**Sufficiency Status:** **Ready** — This file encodes your review’s failures (strict canonical decoding & constant‑time signing), the surgical remediation plan, and the CT‑NEXT harness expectations. It also pins the commands and API usage that appear in your patch/tests, so Copilot has deterministic rails. **Score:** 9.5/10 (minor repo‑specific Zig version pin could be inlined later). :contentReference[oaicite:12]{index=12} :contentReference[oaicite:13]{index=13} :contentReference[oaicite:14]{index=14}

**Changelog**
- **v1** — Initial `copilot-instructions.md` tailored to your Ed25519 library, embedding strict decoding, constant‑time rules, zeroization, and timing/bench/fuzz guidance with run commands and refusal policy.
```
