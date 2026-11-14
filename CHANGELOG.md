# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.16] - 2026-11-13

### Changed

- quic v0.1.51: finished streams are retired and no longer resent, idle
  connections send nothing, large single-stream transfers no longer crawl,
  a failed connect no longer leaves a freed connection registered, and
  final-size / flow-control violations close the connection (SONNY-6478).

### Fixed

- `parseDSN` / `parseDSNStrict` follow one host grammar, the one geode uses
  (docs/DSN.md, "Host Specification"; SONNY-6494): `host`, `host:port`,
  `[ipv6]`, `[ipv6]:port`, with an optional zone (`[fe80::1%eth0]:3141`).
  An unbracketed IPv6 host (`::1` was read as host `:` port 1), anything but
  `:port` after `]` (`[::1]3141` was read as `::1` on the default port),
  brackets around anything but an IPv6 literal, and an empty host are
  `error.InvalidDSN`. A port that is not 1-5 digits up to 65535 (`http`,
  `+80`, `3_141`, empty, 70000) is `error.InvalidPort` in both modes: the
  lenient `parseDSN` no longer replaces it with the default port. A failed
  parse frees the credentials and graph it had already copied.
  `Config.toConnectionString` brackets an IPv6 host. `splitHostPort`,
  `parsePort`, `isIpv6Literal` and `formatHostPortAlloc` are public.
- A `GeodeClient` reaches a QUIC server on an IPv6 address (SONNY-6494).
  The endpoint was bound to `0.0.0.0:0` whatever the destination and the
  dial address was formatted without brackets (`::1` became the
  unparseable `::1:3141`). The client now resolves the host itself
  (`src/dial_host.zig`, the same rule geode's CLI uses): an address literal
  is dialled as written, bracketed for IPv6, from an endpoint bound to
  `0.0.0.0:0` or `[::]:0`; a host name is looked up in both families (hosts
  file and DNS) and its first IPv4 address wins, otherwise its first IPv6
  address. A name the quic library could not resolve on its own (it read
  only `/etc/hosts`) now resolves through DNS. An IPv6 zone
  (`fe80::1%eth0`) is refused with `error.Ipv6ZoneUnsupported`: the quic
  dialer cannot parse one.
- Client identity loading (`ensureEndpoint` / `connect` with
  `client_cert` / `client_key`) names each bad input and leaves no copy of
  the private key in freed memory (SONNY-6494). A certificate without its
  key is `error.ClientKeyMissing` and a key without its certificate
  `error.ClientCertificateMissing` (both were
  `error.ClientCertificateKeyMismatch`); a damaged key is
  `error.InvalidClientKey` (was `error.UnsupportedKeyType`, and its partial
  decode leaked). Both files are read, and the key decoded, through an
  allocator that zeroes what it frees: the key's PEM text and base64 body
  used to stay in two or three freed buffers in ReleaseFast/ReleaseSmall
  builds, also when the key file was given as the certificate. The key is
  decoded locally instead of by `quic.pem.parsePrivateKey`, with the same
  accepted formats (SEC1 EC, PKCS#1 RSA, PKCS#8).

### Changed

- `Pool` takes its monotonic clock from a `now_ms` field (default: the
  platform's awake clock) and counts completed idle-sweeper passes in
  `sweeps`; `PooledConnection` gains `acquireAt` / `releaseAt` /
  `isIdleExpiredAt`. The idle-sweeper test drives expiry with a test clock
  and waits for sweeps instead of sleeping 80 ms and hoping two sweeps ran;
  it failed on a loaded macOS runner (SONNY-6494). It now also proves that
  an idle connection exactly at the threshold, and one in use, are kept.

## [0.3.15] - 2026-11-13

### Fixed

- Isolate external hook tools from inherited Git repository state while preserving the staged TODO check (SONNY-4778).
- A client certificate (`Config.client_cert` / `client_key`, `?cert=&key=`)
  is presented over QUIC (SONNY-6457). The paths were put in the quic
  config's `cert_path` / `key_path`, which made the endpoint a server, and
  the certificate was never loaded, so a client could not connect to a
  server that requires mutual TLS (the connect timed out). The PEM
  certificate and key (EC, RSA or PKCS#8) are now loaded into
  `inline_client_cert_der` / `inline_client_priv_key`; a certificate
  without its key (or the reverse), or a file that cannot be read or
  parsed, fails `connect` instead of dialling without it.
  `GeodeClient.ensureEndpoint` is public.

### Changed

- Pinned QUIC to `a68d36e`, which defers the first server-side STREAM-only
  standalone ACK under high fan-in request/response traffic and retains a
  delayed ACK fallback for quiet or upload-only peers.

## [0.3.14] - 2026-11-12

### Changed

- Converge quic v0.1.49, which bounds ACK and loss-recovery work per packet
  (SONNY-6434). Geode pins the same quic revision.

## [0.3.8] - 2026-09-12

### Changed

- Converge thread_pool v0.2.7, fips v0.1.1, protobuf v0.1.5, config v0.1.13 (GAP-0838 diamond sync).

## [0.3.7] - 2026-09-12

### Changed

- Converge thread_pool v0.2.7, fips v0.1.1, protobuf v0.1.5 (GAP-0838 diamond sync).
