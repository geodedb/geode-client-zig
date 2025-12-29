# NEXT Tasks

Status legend: [ ] pending | [x] done.

## Completed

- [x] secureZero helper (volatile wipe + fence) added to `src/ed25519.zig`.
- [x] Zeroization integrated in `deriveKeyPair` and `sign` (h, a_bytes, hp, rred, khash, kred, S).

## Pending

1. Refactor scalarMulBase_ct precompute

   - Introduce static window-4 precomputed table `[64][16]Point` appended after existing point ops.
   - Ensure initialization occurs exactly once inside existing `ensureConstantsInit()` without shadowing it.
   - Remove per-call stack table; keep constant-time selection (`pointCMove`).
   - Add micro test comparing outputs vs current implementation over random scalars.

2. Add tests zeroization + scalar equivalence

   - Unit test: fill buffer with non-zero, call `secureZero`, verify all zeros.
   - Scalar mul equivalence test: sample N (e.g., 64) pseudo-random scalars; compare `scalarMulBase_ct` (new) with reference pre-refactor path (keep helper alias if needed).

3. Run full test + perf harness
   - `zig build test`
   - `zig build fuzz`
   - `zig build bench` (if/when bench target added) / evaluate added perf delta.
   - `UA_PERF_HARNESS_ENABLE=1 zig build ct-perf` (once timing harness exists) to confirm no regressions.

## Notes

- Keep public API stable: `deriveKeyPair`, `sign`, `verify` unchanged.
- Maintain strict canonical decoding: reject y >= p, reject x==0 & sign=1, reject torsion encodings.
- Cofactor-cleared verify retained: `[8]S·B == [8](R + k·A)`.
- Zeroization best-effort only; no guarantee after optimizer, but volatile + fence included.
