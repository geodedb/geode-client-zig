# Ed25519 Constant-Time Hardening — Next Steps

This document enumerates planned follow-on work to move from coarse regression guards to a formally defensible constant-time posture for UA-SIG1.

## 1. Statistical Timing Harness

Goal: Detect subtle data-dependent timing differences (<5%) missed by coarse ratio test.

Approach:

- Harness runs scalarMulBase and variable-base scalar multiplication over two scalar classes: random vs. fixed edge (all 0xFF except clamp bits) using identical instruction mix wrappers.
- Collect >= 20k samples per class (batched, pinned CPU via taskset when available) using `std.time.nanoTimestamp()`.
- Apply Welch's t-test; fail if |t| >= 10 and p < 1e-6.
- Environment guard: only active in CI perf lane (UA_PERF_HARNESS_ENABLE=1) to avoid routine developer noise.

## 2. Extended Torsion & Edge Vectors

Add exhaustive rejection tests for all 8 small-order encodings, plus crafted non-canonical encodings (high-bit variants, alternate sqrt roots). Include failing vectors from historical Ed25519 bug writeups (ZIP215 distinctions) to ensure strict RFC8032 semantics.

## 3. Alternate Square Root Handling Tests

Generate points whose decompression triggers the alternate sqrt(-1) branch; assert equivalence after recompression and signature verification paths.

## 4. Micro-Benchmark Baselines

Record cycle/ns median & IQR for:

- Key derivation (hash+clamp+base mult)
- Sign (excluding message hash) for 64B message
- Verify (base & variable mult combined)

Persist JSON baseline (per optimize mode) under `specs/perf/ed25519/*.json`. Gate: future median must be within +15% (debug +50%) to prevent silent perf regressions.

## 5. Negative Side-Channel Probes

Inject artificial data-dependent branch (guarded by build flag) in scalar multiplication; test harness must trip (ensures harness sensitivity before trusting clean runs).

## 6. Deterministic Seed Discipline

Centralize PRNG (xorshift64\*) in `tests/util/prng.zig` to avoid divergence; include reproducible seeds per test logged once with `std.debug.print` under verbose flag.

## 7. CI Integration Plan

- Add `zig build ct-perf` target invoking timing harness with env gating.
- Separate `make ci-perf` lane executing only on nightly schedule + on crypto-affecting diffs (path filter `src/crypto/ed25519.zig`).
- Store last successful perf JSON as artifact; compare on next run.

## 8. Documentation & Audit Trail

Update GAP_ANALYSIS deviation closure when: (a) statistical harness green thrice consecutively, (b) torsion + alt root vectors complete, (c) perf baselines locked. Archive outputs under `docs/audit/ed25519/`.

---

Owner: crypto slice
Status: Planned

## 9. Implemented: Initial ct-perf Harness (Current State)

Implemented a lightweight timing harness (`zig build ct-perf`) producing JSON with structured schema metadata.

Schema Versioning:

- `schema`: current value `1` (increment on structural/semantic change). CI or tooling can gate on this.

Verbose Mode Fields (superset):

`schema,samples,iters_per_sample,mean_a_ns,mean_b_ns,mean_diff_ns,t_stat,effect_size_d,welch_df,abs_t,p_value_approx,threshold,threshold_source,fail,probe_enabled,warmup_discarded,cpu_affinity_allowed?(opt),median_a_ns,median_b_ns,median_diff_ns,mad_a_ns,mad_b_ns,jitter_a,jitter_b,(samples_a,samples_b | raw_samples_omitted)`

- `jitter_a/jitter_b`: MAD/median ratios (robust relative dispersion)
- Raw sample arrays suppressed when `-Dct-no-raw=true` and replaced by `raw_samples_omitted: true`.
- `cpu_affinity_allowed` only present when `-Dct-cpu-affinity-scan=true` and parse succeeds.

Compact Mode:

`-Dct-compact=true` emits a single-line JSON with keys:
`schema,samples,iters,mean_a,mean_b,diff,t,df,d,p,thr,ja,jb,fail,probe,warmup,cpu?(opt)`

Build options (all optional):

- `-Dct-cpu-affinity-scan=true` attempt to parse /proc/self/status (Linux) for Cpus_allowed_list and include affinity hint
- `-Dct-no-raw=true` omit raw sample arrays in verbose output (useful for large SAMPLES in CI artifacts)

Example runs:

```sh
zig build ct-perf
zig build ct-perf -Dct-iters=400 -Dct-samples=12
zig build ct-perf -Dct-iters=800 -Dct-samples=24 -Dct-fail-t=10.0 -Doptimize=ReleaseFast
```

CI Perf Lane:

Dedicated `linux-perf` job (needs build-linux) runs a baseline large-sample ReleaseFast harness with UA_PERF_HARNESS_ENABLE=1 and uploads `ct_perf_baseline.json`. A second run with `-Dct-probe=true` asserts harness sensitivity (expects non-zero exit). Both artifacts are stored for audit.

Remaining Enhancements:

Rationale: Current harness offers quick qualitative assurance that refactors do not introduce gross timing divergence. It trades statistical power for speed; future work (Section 1) will scale sample counts, add distributional checks, and potentially introduce confidence intervals while bumping `schema`.
