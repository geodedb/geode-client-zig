# Changelog

## 2025-09-19

### Fixed

- Corrected RFC 8032 test vector #3 seed across all test blocks (previously last 16 bytes mis-copied) ensuring derived clamped scalar and public key now match authoritative spec values.

### Added

- Build flag `-Dtrace-ed25519` to enable verbose internal diagnostics (field limbs, partial scalar/basepoint traces, decompression details). Default off for clean CI logs.

### Changed

- Gated prior always-on debug/tracing `std.debug.print` calls behind `build_options.ed25519_trace` to reduce noise in standard test and bench runs.

### Verification

- `zig build test` passes silently (no trace lines) without the flag.
- `zig build test -Dtrace-ed25519` emits initialization and tracing diagnostics while still passing.
