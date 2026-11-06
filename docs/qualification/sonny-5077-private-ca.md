# Private CA delivery to native QUIC

The previous Zig client passed only `QuicConfig.ca_path`. The native QUIC
endpoint creates its TLS context from `inline_ca_chain_der`, so the configured
private CA never reached certificate verification. The pinned Geode v0.8.23
backup client consequently timed out during a verified handshake. Its local
backup fallback could even return exit zero after that failure; that fallback
is not proof of a remote backup.

The client now loads a bounded PEM bundle, owns every DER anchor, supplies the
complete chain to the endpoint, and frees it after endpoint teardown. It
propagates loading and parsing errors and preserves secure verification. The
existing QUIC implementation is reused through published v0.1.48 at
`274109bd5a0a268b7e64cd00a406d00a61bd1de2`, verified by `zig fetch` as
`quic-0.1.48-gBIqUR_-QACpHwpcYcn4npRszy-RS-cTq-y3rH8KkknM`.
No TLS implementation, local replacement or vendored fork is introduced.

Local qualification on 2026-11-06:

- `zig build test-ca-bundle -j2 --summary all`: PASS, including ownership,
  empty/partial material, count and size limits.
- `zig build test -j2 --summary all`: PASS, 480 tests on the final dependency
  graph.
- `zig build -j2 --summary all`: PASS, native executables and benchmark.
- Actual pinned server
  `geodedb/geode@sha256:48a24f3739bda9017536cdd7b9b0c14474d0cc643d0b202560465d3834b9587a`:
  the native `test_connection_v2` binary, SHA-256
  `3121303df81e286d7246bd7822ba0f2e2f5f1f39a578dcaf9d8b2b36f6b65bf7`,
  reports `insecure=false`, connects using the server's own certificate,
  authenticates and returns one row for `RETURN 1 AS x` (exit 0).
- The identical binary against the identical server with a separately generated
  untrusted CA reports `insecure=false` and refuses the connection (exit 1).

The Docker probe uses a unique ownership label, random loopback port and
private ephemeral credentials. Credentials and raw diagnostic logs are not
published. These results qualify the client trust fix; a new published client,
the Geode consumer and actual verified backup, and Lanning's complete integration
suite still require their own delivery checks.
