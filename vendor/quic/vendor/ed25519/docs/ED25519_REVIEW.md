# ED25519 Implementation Review

[HERE](https://chatgpt.com/c/68cd5fb3-eb0c-8326-8de3-bb57c91c2372)

```json
{
  "summary": {
    "status": "FAIL",
    "variant": "ed25519",
    "strict_canonical": false,
    "notes": [
      "Implements pure Ed25519 with SHA-512; deterministic r; cofactor-cleared verify.",
      "Decoding accepts non‑canonical point encodings (no y<p check; no x==0 & sign==1 reject).",
      "Basepoint scalar multiplication branches on secret bits in signing (timing leak).",
      "No explicit zeroization of transient secrets."
    ]
  },
  "checks": [
    {
      "id": "spec.parse",
      "category": "correctness",
      "result": "PASS",
      "evidence": "SPEC: RFC8032 §5.1 defines Ed25519 (SHA‑512; dom2 empty; PH=identity).",
      "severity": "low"
    },
    {
      "id": "keygen.seed_32",
      "category": "correctness",
      "result": "PASS",
      "evidence": "impl L2180: deriveKeyPair(seed: *const [32]u8)",
      "severity": "low"
    },
    {
      "id": "keygen.clamp",
      "category": "correctness",
      "result": "PASS",
      "evidence": "impl L2162–2167: scalarClamp: h[0]&=248; h[31]&=63; h[31]|=64;",
      "severity": "low"
    },
    {
      "id": "keygen.pubkey",
      "category": "correctness",
      "result": "PASS",
      "evidence": "impl L2186–2193: A = scalarMulBase(a); pk = compressPoint(A)",
      "severity": "low"
    },
    {
      "id": "sign.deterministic_r",
      "category": "correctness",
      "result": "PASS",
      "evidence": "impl L2211–2218: r = SHA‑512(prefix||msg) → reduceModLCanonical",
      "severity": "low"
    },
    {
      "id": "sign.hash_sha512",
      "category": "correctness",
      "result": "PASS",
      "evidence": "impl L1463; L2195; L2207–2215: std.crypto.hash.sha2.Sha512",
      "severity": "high"
    },
    {
      "id": "sign.S_reduce_mod_L",
      "category": "correctness",
      "result": "PASS",
      "evidence": "impl L2413–2430: scalarAddMul(...); reduceModLCanonical(&tmp, out)",
      "severity": "medium"
    },
    {
      "id": "verify.S_range",
      "category": "correctness",
      "result": "PASS",
      "evidence": "impl L2242–2247: Reject S >= L (scalarLessThan)",
      "severity": "high"
    },
    {
      "id": "verify.decode_R_canonical",
      "category": "correctness",
      "result": "FAIL",
      "evidence": "impl L2138–2158 & L260–267: feFromBytes masks high bit; no y<p or x==0 & sign==1 checks",
      "severity": "high"
    },
    {
      "id": "verify.decode_A_canonical",
      "category": "correctness",
      "result": "FAIL",
      "evidence": "impl L2248–2251 calls same decompressPoint without canonical y<p or x==0 rule",
      "severity": "high"
    },
    {
      "id": "verify.point_on_curve",
      "category": "correctness",
      "result": "PASS",
      "evidence": "impl L2148–2156: recover x via sqrtRatio; return null on failure",
      "severity": "medium"
    },
    {
      "id": "verify.low_order_reject",
      "category": "correctness",
      "result": "PASS",
      "evidence": "impl L470–479: isSmallOrder() rejects 8 torsion encodings",
      "severity": "high"
    },
    {
      "id": "verify.cofactor_safe_eq",
      "category": "correctness",
      "result": "PASS",
      "evidence": "impl L2296–2311: compare mul8(SB) vs mul8(R + kA)",
      "severity": "medium"
    },
    {
      "id": "encoding.S_canonical",
      "category": "encodings",
      "result": "PASS",
      "evidence": "impl L2245–2247: verify rejects S>=L; sign reduces S mod L",
      "severity": "high"
    },
    {
      "id": "encoding.R_canonical",
      "category": "encodings",
      "result": "FAIL",
      "evidence": "impl L2138–2158: no check that y < p; no reject when x==0 & sign==1",
      "severity": "medium"
    },
    {
      "id": "security.constant_time",
      "category": "security",
      "result": "FAIL",
      "evidence": "impl L817–826: scalarMulBase_ct branches on secret bits: if (scalarGetBit(...)) acc = pointAdd(...)",
      "severity": "high"
    },
    {
      "id": "security.no_secret_rng",
      "category": "security",
      "result": "PASS",
      "evidence": "impl L2207–2218: r derived via SHA‑512(prefix||msg); no RNG used",
      "severity": "high"
    },
    {
      "id": "security.zeroization",
      "category": "security",
      "result": "WARN",
      "evidence": "impl L2203–2220 and L2181–2194: h/hp/khash/a_bytes not wiped",
      "severity": "medium"
    },
    {
      "id": "security.no_secret_dependent_lookup",
      "category": "security",
      "result": "PASS",
      "evidence": "No secret-indexed tables in signing path; (verify uses variable-time scalarMulVar on public data)",
      "severity": "medium"
    },
    {
      "id": "api.input_validation",
      "category": "api",
      "result": "PASS",
      "evidence": "Fixed-size array types enforce lengths; verify() fails closed on decode or S-range",
      "severity": "medium"
    }
  ],
  "risks": [
    {
      "id": "malleability.point_non_canonical",
      "severity": "medium",
      "impact": "Accepts non-canonical encodings for R/A (y ≥ p or x==0 with sign==1), enabling multiple encodings for the same point and potential consensus divergence.",
      "likelihood": "medium",
      "remediation": "Enforce canonical decoding per RFC8032 §5.1.3: reject if y ≥ p; if x==0 and sign bit is 1."
    },
    {
      "id": "sidechannel.secret_branch",
      "severity": "high",
      "impact": "Secret-dependent branch in scalarMulBase leaks timing on r/a during signing; potential key recovery under precise timing.",
      "likelihood": "medium",
      "remediation": "Replace with constant-time fixed-window or wNAF basepoint multiplication using table lookups + cmov (no branches). Add statistical timing harness."
    },
    {
      "id": "zeroization.absent",
      "severity": "medium",
      "impact": "Secret seed/expanded secret/prefix remain in memory after sign/keygen; raises post-compromise risk.",
      "likelihood": "medium",
      "remediation": "Explicitly zeroize transient buffers (h, hp, khash, a_bytes, rred, kred) with volatile/secure wipe APIs."
    },
    {
      "id": "malleability.S_ge_L",
      "severity": "high",
      "impact": "Signature malleability via S + kL.",
      "likelihood": "low",
      "remediation": "Reject signatures with S >= L; do not reduce."
    }
  ],
  "test_vectors": {
    "rfc8032": "NOT_RUN",
    "wycheproof": "NOT_RUN"
  },
  "limitations": ["Static analysis only unless vectors/harness are provided."]
}
```

## Scope & Inputs

**SPEC:** RFC 8032 (EdDSA), including Ed25519 details (sections 3–5; esp. §5.1 keygen/sign/verify and §5.1.2–5.1.7).&#x20;

**IMPL:** `ed25519.zig` (Zig, pure Ed25519). Ancillary note: constant‑time hardening plan in `ED25519_CT_NEXT.md`.&#x20;

## Requirements Extracted from SPEC

- **Variants:** Ed25519 (pure, dom2 empty, PH=identity). Ed25519ctx/ph add dom2 and/or prehash; those **must not** be mixed with Ed25519 unless explicitly implemented.&#x20;
- **Keygen:** 32‑byte random seed → SHA‑512 → clamp (clear h\[0] low 3; clear high bit; set second-highest bit) → `A=[a]B` → encode.&#x20;
- **Sign:** `r = SHA‑512(prefix || M)`; `R=[r]B`; `k = SHA‑512(R || A || M)`; `S = (r + k·a) mod L`; output `R||S`. Deterministic; **no RNG per message**.&#x20;
- **Verify:** Parse `R,A` as points and `S` as integer with **S < L**; compute `k`; check `[8]S·B = [8]R + [8]k·A` (cofactor-safe). **Reject** on parsing failure.&#x20;
- **Encodings:** Compressed point: 255-bit `y` little‑endian + sign bit of `x`. **Reject** if decoded `y ≥ p` or `(x==0 && sign_bit==1)`. `S` must be **strictly less than** `L`.&#x20;
- **Security:** Constant‑time for secret‑dependent operations; no branches/table indices on secrets; constant‑time compares; deterministic `r`; safe error paths.&#x20;

## Findings by Category

### Correctness

- **Keygen:** Matches RFC: `Sha512.hash(seed)` → `scalarClamp` → `A = scalarMulBase(a)` → `pk = compressPoint(A)` (L2180–2193).
- **Sign:** Deterministic `r` via `sha512_twopart(h[32..64], msg)` and `reduceModLCanonical`; `k` via SHA‑512 over `R||pk||msg`; `S` computed modulo `L` (L2203–2236, L2413–2430).
- **Verify:** Enforces `S < L` (L2245–2247); cofactor-cleared equation `[8]S·B == [8](R + kA)` (L2296–2311).

**Gaps:** Decoding is **not strict** (see Encodings below).

### Encodings & Canonicalization

- **S canonical:** Enforced (rejects `S ≥ L` and signer reduces `S`).
- **R/A canonical:** **Missing.** `feFromBytes` masks bit 255 and **does not** check `y < p` (“no modular reduction here”, L261). `decompressPoint` lacks the RFC step “if x==0 and sign bit is 1, fail.” Result: accepts non‑canonical `R/A` encodings, diverging from strict RFC8032 (ZIP215‑style permissiveness).

### Security & Side-Channel

- **Constant‑time:** **FAIL.** Basepoint scalar multiplication used for signing (`scalarMulBase_ct`) branches on secret bits:

  ```zig
  // ed25519.zig L817–826
  while (bit < 256) : (bit += 1) {
      if (scalarGetBit(scalar, bit) == 1) {
          acc = pointAdd(acc, base);
      }
      base = pointDouble(base);
  }
  ```

  This is secret‑dependent control flow on `r`/`a`. Timing leakage is plausible on many targets.

- **No secret RNG:** PASS (deterministic `r`).
- **No secret‑dependent table indices:** PASS in signing path (no secret‑indexed tables observed).
- **Zeroization:** **WARN.** Transient secrets (`h`, `hp`, `khash`, `a_bytes`, reduced scalars) are not wiped after use.
- **Planned CT hardening:** The included plan calls for a statistical timing harness and torsion vectors—good direction but not in place yet.&#x20;

### API & Misuse

- Fixed-size arrays enforce lengths at compile time.
- Verify fails closed on parse/range errors; no secrets logged (optional verbose prints only public data).
- Sign API expects `sk = seed || pk`, reducing misuse risk.

## Negative-Case Analysis

- **Non‑canonical `S` (S ≥ L):** Rejected (`verify.S_range` PASS).
- **Non‑canonical `R/A`:** **Accepted** (FAIL). Attacker can supply alternative encodings of the same point (`y ≥ p` or `x==0` with sign=1) and still pass verification.
- **Reducing `S` mod L in verify:** **Not** performed (correct).
- **Low‑order `R/A`:** Rejected via explicit 8 torsion encodings and cofactor clearing (PASS).
- **Wrong hash (e.g., SHA‑256):** Not present; uses SHA‑512 throughout (PASS).
- **Message mutation:** Verification binds `R||A||M` into `k`; mutation breaks equality (PASS).
- **Empty message / long message:** No special handling required; SHA‑512 over message bytes (PASS by inspection).

## Test Vectors (if applicable)

Static audit only; RFC/Wycheproof vectors **NOT_RUN** (no harness provided).&#x20;

## Risk Register

1. **sidechannel.secret_branch — High**
   _Impact:_ Timing leak during signing from secret‑dependent branches; potential key recovery under measurement.
   _Remediation:_ Replace basepoint multiplication with fixed‑window/wNAF + constant‑time table select (cmov), no branches; add CI timing harness.&#x20;

2. **malleability.point_non_canonical — Medium**
   _Impact:_ Acceptance of non‑canonical encodings (y≥p; x==0 & sign==1) allows multiple encodings per point; potential consensus divergence across strict vs non‑strict verifiers.
   _Remediation:_ Enforce RFC8032 §5.1.3 decoding checks (reject y≥p; reject x==0 with sign bit 1).&#x20;

3. **zeroization.absent — Medium**
   _Impact:_ Secrets persist in memory post‑operation.
   _Remediation:_ Explicitly wipe sensitive buffers.

4. **malleability.S_ge_L — Low (mitigated)**
   _Impact:_ If unmitigated, `S + kL` malleability.
   _Remediation:_ Already enforced by `S < L` check; keep.

## Remediation Plan (Prioritized)

1. **Fix constant‑time in signing (P0):**

   - Implement constant‑time basepoint scalar multiplication (fixed window; precomputed table; constant‑time selection via `cmov`).
   - Add CI timing harness (Welch’s t‑test) and negative probes as outlined.&#x20;

2. **Enforce strict decoding (P0):**

   - In `decompressPoint`:

     - Reject if decoded `y ≥ p` (compare to `p = 2^255-19`).
     - After computing `X`, **reject** if `X==0 && sign_bit==1`.

   - Keep small‑order table rejection.

3. **Zeroization (P1):**

   - Wipe `h`, `hp`, `khash`, `a_bytes`, reduced scalars (`rred`, `kred`, `S`) after use.

4. **Optional:** Make verify’s variable-base scalar mult constant‑time if used in any secret context; otherwise keep as is (public data only).

## Limitations

- Static review only; no dynamic execution or vector runs.
- Evidence references are best‑effort line numbers/snippets from `ed25519.zig`; SPEC citations per RFC 8032.&#x20;

---

**Bottom line:** Functionally close to RFC8032, but **fails** on two high‑impact points: (1) strict canonical decoding and (2) constant‑time guarantees in signing. Fix both before production.
