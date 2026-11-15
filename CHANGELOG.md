# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.19] - 2026-11-15

### Fixed

- Every wait of a `GeodeClient` honours `timeout_ms` (SONNY-6617). v0.3.18
  applied it to the QUIC handshake and the HELLO answer only: `query`
  (its first answer), `begin`, `commit`, `rollback` and `ping` waited a
  fixed 30 s, and a write held up by flow control (`writeAll`) a fixed
  30 s. A query's later pages wait at most 5 s each, or `timeout_ms` if
  shorter.
- The gRPC transport honours `timeout_ms` (SONNY-6617).
  `GrpcClient.connect` was a blocking TCP connect (std.Io's connect has no
  timeout yet), so a server that never answered the SYN held it for the
  kernel's SYN retries, about two minutes; it now connects non-blocking
  and gives up after `timeout_ms` (`GeodeClient.connect`:
  `error.ConnectionTimeout`, as for QUIC). Every gRPC read and write waited
  until the server answered or closed; each message now waits at most
  `timeout_ms` (`GrpcClient.receiveTimeout` / `receiveProtoTimeout`;
  `GeodeClient`: `error.ReceiveTimeout`). Windows keeps the blocking path.
- **Behaviour change:** the lenient `parseDSN` falls back to the default
  for an out-of-range timeout (outside 1..3600000 ms) or `page_size`
  (outside 1..100000), as its doc always said (SONNY-6617). It kept the
  number, so `?timeout_ms=0` parsed and `connect` then refused it with
  `error.InvalidTimeout` (v0.3.18). `parseDSNStrict` still refuses them;
  `connect`'s `InvalidTimeout` now comes only from a `Config` or client
  built or changed in code.
- HELLO defaults (SONNY-6617): `Config.init().hello_ver`, the protocol
  default `client_version` (a client built in code) and the gRPC HELLO
  sent `0.1.0`; they send the library version (`config.VERSION`, from
  `src/version.zig`, checked against `build.zig.zon`). The protocol default
  and the gRPC HELLO sent conformance `minimum`; they send `min`, the
  documented value and `Config`'s default.

### Added

- `zig build test-request-timeouts` (also in `zig build test`): every
  request, write and gRPC wait against real sockets (a QUIC server that
  never answers, one that never reads a stream, a TCP listener whose accept
  queue is full, one that never answers), the lenient fallbacks and the
  HELLO defaults. The QUIC test server gains a mode that never reads.
- `zig build test-client-inline` (also in `zig build test`): the inline
  tests of `geode_client_v2.zig`, unwired since 2026-05-01. They run in a
  test module of their own, so the public `geode_client` module is not
  given the test's system libraries.

### Removed

- `proto/schema.zig`, unreferenced (no build step, import or package path
  used it; QUALITY_GAP_ANALYSIS Q-010).

## [0.3.18] - 2026-11-15

### Security

- **BREAKING:** a gRPC client built from a `Config` uses `Config.tls`
  (SONNY-6589). It used `!insecure`, so `grpc://h:50051?insecure=true`
  (skip certificate verification) silently connected in plaintext, and the
  documented `grpc://h:50051?tls=0` could not connect
  (`error.TlsNotImplemented`). Now `?tls=0` connects in plaintext and
  `?insecure=true` keeps TLS on, which the gRPC transport does not
  implement yet, so it is refused (`error.TlsNotImplemented`) instead of
  sent in the clear; write `?tls=0` for a plaintext connection. A client
  built in code (`init` / `initWithTransport`) keeps `!insecure` unless
  its new `tls` field is set.

### Fixed

- `GeodeClient.initFromConfig` applies `timeout_ms`, `page_size`, `tls`,
  `hello_name`, `hello_ver` and `conformance`; it dropped all six
  (SONNY-6589). `connect` waited a fixed 30 s for the QUIC handshake and
  `sendHello` a fixed 30 s for the HELLO answer; both now wait
  `timeout_ms` (DSN `timeout_ms` / `timeout`, or `connect_timeout` in
  seconds). HELLO fields 4-6 (`client_name`, `client_version`,
  `wanted_conformance`, the numbers geode.proto gives them) carry the
  configured strings: a `Config`-built client sends `Config`'s defaults
  (`geode-zig`, `0.1.0`, `min`) unless the DSN sets them; a client built
  in code still sends the protocol defaults (`wanted_conformance` =
  `minimum`). The gRPC transport is also given `timeout_ms`.
- **BREAKING:** `connect` refuses a `timeout_ms` outside 1..3600000 with
  `error.InvalidTimeout` (SONNY-6589). The lenient `parseDSN` keeps
  `?timeout_ms=0`, which would otherwise give up at once.
- `initFromConfig` frees what it had already copied when a later copy
  fails (out of memory); it leaked them.

### Added

- `GeodeClient` fields `timeout_ms`, `page_size`, `tls` (`?bool`),
  `hello_name`, `hello_ver` and `conformance` (owned, freed by `deinit`).
  `page_size` is stored for callers; no client call reads it yet.
- `zig build test-config-timeouts` (also run by `zig build test`): a real
  UDP socket that never answers (connect gives up after about 500 ms with
  `timeout_ms=500`), a QUIC server that never answers the HELLO (sendHello
  gives up after about 500 ms, and the HELLO bytes it read hold the
  configured fields 4-6), gRPC `tls` against a TCP listener, and
  `initFromConfig` under every allocation failure. The QUIC test server in
  `tests/quic_echo_fixture.zig` gains a silent mode and keeps the bytes it
  reads.

### Changed

- dns v0.1.28, thread_pool v0.2.11 (Renovate, since v0.3.17).

## [0.3.17] - 2026-11-14

### Security

- DSN credentials follow RFC 3986 §3.2, the rules geode's CLI uses
  (`src/client/dsn_credentials.zig`, SONNY-6544) (SONNY-6550).
  `parseDSN` / `parseDSNStrict` split the userinfo at the first `@`
  anywhere in the DSN, path and query included. A password holding `@` was
  cut short and its tail became the host: `quic://admin:s3@decoy.invalid@10.0.0.5`
  gave host `decoy.invalid@10.0.0.5` (put in the connect span's
  `server.address` and handed to the resolver, which refused it), and an
  `@` in a query value moved the host into it:
  `quic://db.internal:3141?pass=a@evil.example` dialled `evil.example`
  with user `db.internal` and password `3141?pass=a`. The authority now ends at the first
  `/`, `?` or `#`; the userinfo is everything before its last `@` and splits
  into user name and password at its first `:`. A scheme-less DSN
  (`admin:pw@host:3141`) takes the same rule. It used to keep the userinfo
  in the host (`pw@host`).
- **BREAKING:** an `@` after the authority (a credential holding an
  unencoded `/`, `?` or `#`, or an `@` in the graph path or a query value)
  is `error.UnencodedCredentialDelimiter`; encode it as `%40`. A fragment
  (`#...`) is `error.InvalidDSN`.
- **BREAKING:** the user name, the password, the graph path and every query
  value are strictly percent-decoded: `%` must be followed by two hex digits
  (`%GG`, a trailing `%` and `50%off` used to pass through as typed and are
  now `error.InvalidPercentEncoding`), and `+` is a literal plus (it used to
  become a space, which changed any password holding `+`). The graph in the
  path was not decoded at all (`/my%20graph` gave `my%20graph`; a
  `graph=` value gave `my graph`).
  `InvalidPercentEncoding` and `UnencodedCredentialDelimiter` are the names
  geode's `endpointErrorMessage` already maps.
- **BREAKING:** port 0 (`host:0`) is `error.InvalidPort` in both modes; a
  client cannot dial it. `splitHostPort` still reads it (it is the
  grammar, also used for listeners). `GeodeClient.connect` refuses port 0
  too (`error.InvalidPort`), for a client built in code; it used to fail at
  the first send with `error.Unexpected`.
- `?connect_timeout=` seconds whose milliseconds overflow u32 (e.g.
  `5000000`) panicked `parseDSN` / `parseDSNStrict` in safe builds; strict
  mode now returns `error.TimeoutOutOfRange` and lenient mode keeps the
  default timeout. `zig build test-fuzz` gains "parseDSN never panics or
  leaks on arbitrary bytes" (raw bytes, DSN-alphabet noise, hostile numeric
  query values, `std.testing.allocator`).
- `Config.toDSN` percent-encodes the user name, password and every query
  value, so `parseDSN(toDSN(cfg))` gives back the same bytes for any
  credential (seeded property test in `zig build test-fuzz`); it is
  allocated once at its final size, and a host holding `@`, `/`, `?` or
  `#` is `error.InvalidDSN`.
- New `config.redacted(text)` (`{f}`): an address or DSN without its
  userinfo and with the value of every secret-looking query parameter
  (`pass`, `pwd`, `secret`, `token`, `auth`, `credential`, `key`,
  `session`, `cookie`, `signature`, any case) shown as `***`; a fragment is
  not shown, and a DSN with an `@` after its authority prints as
  `<address redacted>`. `config.redact` exposes `splitAuthority`,
  `decodeUserinfo`, `percentDecode`, `writePercentEncoded`, `schemeEnd` and
  `isSecretKey`, the same rules and names as geode's `dsn_credentials`.
  `Config` formats with `{f}` as `scheme://host:port[/graph]`, without
  credentials or query parameters. `redact.redactDSN` finds the userinfo by
  the same rule (it printed `admin:pa?ss@...` unmasked) and also masks every
  `isSecretKey` parameter.
- Decoded credentials leave no copy in freed memory: the decoder checks
  the text first and allocates the result at its exact size (the old one
  grew a list and freed each partial copy), `Config.deinit` and
  `withCredentials` zero the user name as well as the password, and a
  credential, certificate path, key path, graph, tenant or role given twice
  in the query frees (zeroing the secrets) the first value instead of
  leaking it.

### Fixed

- `hello_name`, `hello_ver` and `conformance` decoded from a DSN were never
  freed: `Config.deinit` could not tell them from the default literals, so
  every DSN that set them leaked (SONNY-6550). `Config` has a new
  `owned_strings` field (all false by default) recording which of the three
  it owns; `deinit` frees those and restores the defaults, and a value
  repeated in the query frees the earlier copy. A value assigned in code is
  not owned and is left alone.

### Changed

- The QUIC echo server and test PKI of `tests/ipv6_dial_test.zig` moved to
  `tests/quic_echo_fixture.zig`, shared with the new
  `zig build test-dsn-userinfo` step (SONNY-6550).

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
