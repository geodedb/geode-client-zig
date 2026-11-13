# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Isolate external hook tools from inherited Git repository state while preserving the staged TODO check (SONNY-4778).

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
