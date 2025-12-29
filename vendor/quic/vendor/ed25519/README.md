# Ed25519 (Zig)

Deterministic, stdlib-only Ed25519 implementation.

## Goals

1. Reusable module without importing the full agent tree.
2. Preserve constant-time properties of secret-dependent operations.
3. Deterministic tests (no RNG) using fixed seeds / RFC8032 vectors (expanded soon).
4. Allow opt-in via build flag: `-Duse_vendor_ed25519=true`.

## Public API

- `deriveKeyPair(seed: []const u8) -> struct{ sk:[64]u8, pk:[32]u8 }`
- `sign(sk, pk, msg) -> [64]u8`
- `verify(pk, msg, sig) -> bool`
- Diagnostics (tests): `test_scalarMulBase`, `decompressPoint`, `compressPoint`.

## Build / Test

Standalone (from repo root so build flag recognized):

```bash
zig build test -Duse_vendor_ed25519=true
```

Verbose internal tracing (diagnostic prints of intermediate field/scalar steps) is disabled by default. To enable:

```bash
zig build test -Dtrace-ed25519
```

Local convenience:

```bash
make -C vendor/ed25519 test
```

## Status

- Functional parity (derive, sign, verify) achieved.
- Constant-time base scalar multiplication (4-bit fixed window) implemented; timing variance guard passes.
- Full RFC8032 vectors (including vector #3) validated; prior mis-copied seed for vector #3 corrected (2025-09-19).
- New `-Dtrace-ed25519` flag gates verbose diagnostic prints to keep default test output clean.
- Pending: drift detection script, variable-base mult perf parity validation.

## Layout

- `src/ed25519.zig` core implementation
- `tests/basic.zig` smoke test
- `Makefile` convenience targets (test/fmt/lint placeholders)

## CI

Workflow `.github/workflows/ed25519-vendor-ci.yml` triggers on changes under `vendor/ed25519/**`.

## Sync Process (Current Manual)

1. Copy updated `src/crypto/ed25519.zig` to `vendor/ed25519/src/ed25519.zig`.
2. Adjust imports if new internal helpers were added.
3. Run `zig build test -Duse_vendor_ed25519=true`.
4. (Planned) Run `tools/sync_ed25519.zig` (to be added) for hash diff & apply.

## License

MIT (inherits root LICENSE).
