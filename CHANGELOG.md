# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
