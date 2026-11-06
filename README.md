# Geode Zig Client

A production-ready Zig client library for [Geode](https://gitlab.com/devnw/geode), an enterprise graph database implementing the ISO/IEC 39075:2024 Graph Query Language (GQL) standard.

## Features

- **Dual Transport Support**:
  - **QUIC + TLS 1.3** (default) - secure, high-performance UDP-based connections
  - **gRPC over HTTP/2** - standard gRPC protocol for compatibility
- **Protobuf wire format** for efficient binary serialization
- **Full GQL type system** with 15+ value types including temporal and graph types
- **Fluent query builders** for type-safe query construction
- **Connection pooling** with configurable limits and health checks
- **ISO GQL status codes** for standardized error handling
- **DSN parsing** with transport scheme selection (`quic://`, `grpc://`)
- **Input validation** for robust security

## Requirements

- Zig 0.15.1 or later
- OpenSSL (for TLS support on Linux)

## Installation

Add to your `build.zig.zon`:

```zig
.dependencies = .{
    .geode_client = .{
        .url = "https://gitlab.com/devnw/geode/geode-client-zig/-/archive/main/geode-client-zig-main.tar.gz",
        // Add hash after first build attempt
    },
},
```

Then in `build.zig`:

```zig
const geode_client = b.dependency("geode_client", .{
    .target = target,
    .optimize = optimize,
});
exe.root_module.addImport("geode_client", geode_client.module("geode_client"));
```

## Quick Start

```zig
const std = @import("std");
const geode = @import("geode_client");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Create client
    var client = geode.GeodeClient.init(allocator, "localhost", 3141, true);
    defer client.deinit();

    // Connect
    try client.connect();
    try client.openStream();

    // Send handshake
    try client.sendHello("my-app", "1.0.0");
    const response = try client.receiveMessage(30000);
    defer allocator.free(response);

    // Execute query
    try client.sendQuery("MATCH (n:Person) RETURN n.name, n.age");
    const result = try client.receiveMessage(30000);
    defer allocator.free(result);

    std.debug.print("Result: {s}\n", .{result});
}
```

## API Reference

### Configuration

#### Config

Configuration for client connections:

```zig
const Config = @import("config").Config;

var cfg = Config.init();
_ = cfg.withHost("localhost");
_ = cfg.withPort(3141);
_ = cfg.withCredentials("admin", "secret");
_ = cfg.withInsecure(true);
_ = cfg.withPageSize(500);
_ = cfg.withTimeout(60000);
```

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `host` | `[]const u8` | `"localhost"` | Server hostname |
| `port` | `u16` | `3141` | Server port |
| `transport` | `Transport` | `.quic` | Transport protocol (`.quic` or `.grpc`) |
| `tls` | `bool` | `true` | Enable TLS (gRPC only, QUIC always uses TLS) |
| `username` | `?[]const u8` | `null` | Authentication username |
| `password` | `?[]const u8` | `null` | Authentication password |
| `insecure` | `bool` | `false` | Skip TLS verification |
| `page_size` | `u32` | `1000` | Result pagination size |
| `timeout_ms` | `u32` | `30000` | Connection timeout (ms) |

**SECURITY WARNING: The `insecure` option disables TLS certificate verification, making connections vulnerable to man-in-the-middle attacks. Only use this option for local development or testing with self-signed certificates. Never use in production environments. When `insecure=true`, the connection cannot verify server identity, and all data transmitted (including credentials) could be intercepted or modified by an attacker.**

#### Private QUIC certificate authorities

Set `Config.ca_cert` (or the DSN `ca` parameter) to a PEM certificate bundle
and leave `insecure` false. The client decodes the bundle into owned trust
anchors and retains them until after its QUIC endpoint is destroyed. Missing,
empty, oversized or malformed bundles fail rather than falling back to an
unverified connection. Bundles are limited to 1 MiB and 32 certificates.

The native `test_connection_v2` executable accepts `GEODE_CA_CERT` alongside
`GEODE_SERVER`, `GEODE_USERNAME` and `GEODE_PASSWORD`. With `GEODE_INSECURE`
unset, it must connect, authenticate and execute `RETURN 1 AS x` using the
configured CA. Repeating against the same server with a different CA must fail.
The [qualification record](docs/qualification/sonny-5077-private-ca.md) retains
the actual product pins and outcome; it does not qualify a disabled TLS check.

#### DSN Parsing

> **Note**: See [`geode/docs/DSN.md`](../geode/docs/DSN.md) for the complete DSN specification.

Parse connection strings with transport scheme selection:

```zig
const parseDSN = @import("config").parseDSN;

// QUIC transport (default, high-performance)
const cfg1 = try parseDSN(allocator, "quic://admin:secret@localhost:3141?insecure_tls_skip_verify=true");

// gRPC transport (HTTP/2-based)
const cfg2 = try parseDSN(allocator, "grpc://localhost:50051?tls=false");

// Simple format (defaults to QUIC on port 3141)
const cfg3 = try parseDSN(allocator, "localhost:3141");

// With query parameters
const cfg5 = try parseDSN(allocator, "quic://db.example.com:3141?page_size=500&timeout=60000");
```

**Supported URL Schemes:**

| Scheme | Transport | Default Port | Description |
|--------|-----------|--------------|-------------|
| `quic://` | QUIC + TLS 1.3 | 3141 | High-performance UDP transport (recommended) |
| `grpc://` | gRPC/HTTP/2 | 50051 | Standard gRPC protocol |

**Supported Query Parameters:**

| Parameter | Aliases | Description |
|-----------|---------|-------------|
| `insecure_tls_skip_verify` | - | Skip TLS verification (see security warning above) |
| `tls` | - | Enable/disable TLS (`true`/`false`, gRPC only) |
| `page_size` | `pageSize` | Result page size |
| `timeout` | `timeout_ms` | Connection timeout |
| `username` | `user` | Authentication username |
| `password` | `pass` | Authentication password |

### Value Types

The `Value` type supports all GQL value types:

```zig
const Value = @import("types").Value;

// Primitive types
const null_val = Value.initNull();
const bool_val = Value.initBool(true);
const int_val = Value.initInt(42);
const float_val = Value.initFloat(3.14159);
const str_val = Value.initString("hello");
const bytes_val = Value.initBytes(&[_]u8{0x01, 0x02, 0x03});

// Temporal types
const date = Value.initDate(2025, 1, 24);
const time = Value.initTime(14, 30, 45);
const timestamp = Value.initTimestamp(date.date, time.time);

// Collections
const arr = Value.initArray(&[_]Value{ int_val, str_val });

// Type checking
if (int_val.isInt()) {
    const i = try int_val.asInt();
}

// JSON conversion
const json = try value.toJson(allocator);
defer json.deinit();
const back = Value.fromJson(json.value);
```

**Supported Types:**

| Type | Constructor | Accessor | Description |
|------|-------------|----------|-------------|
| `null` | `initNull()` | `isNull()` | Null value |
| `boolean` | `initBool(bool)` | `asBool()` | Boolean |
| `integer` | `initInt(i64)` | `asInt()` | 64-bit integer |
| `float` | `initFloat(f64)` | `asFloat()` | 64-bit float |
| `string` | `initString([]const u8)` | `asString()` | UTF-8 string |
| `bytes` | `initBytes([]const u8)` | `asBytes()` | Binary data |
| `array` | `initArray([]Value)` | `asArray()` | Array of values |
| `object` | - | `asObject()` | Key-value map |
| `date` | `initDate(year, month, day)` | `asDate()` | Date |
| `time` | `initTime(hour, min, sec)` | `asTime()` | Time |
| `timestamp` | `initTimestamp(date, time)` | `asTimestamp()` | Date + time |
| `duration` | `initDuration(days, secs)` | `asDuration()` | Duration |
| `node` | - | `asNode()` | Graph node |
| `relationship` | - | `asRelationship()` | Graph edge |
| `path` | - | `asPath()` | Graph path |

### Query Builder

Build GQL queries programmatically:

```zig
const QueryBuilder = @import("query_builder").QueryBuilder;

var qb = QueryBuilder.init(allocator);
defer qb.deinit();

_ = try qb.match("(p:Person)");
_ = try qb.where("p.age >= $minAge");
_ = try qb.ret("p.name, p.age");
_ = try qb.orderBy("p.name");
_ = try qb.limit(10);
_ = try qb.param("minAge", Value.initInt(21));

const query = try qb.build();
defer allocator.free(query);
// Result: "MATCH (p:Person) WHERE p.age >= $minAge RETURN p.name, p.age ORDER BY p.name LIMIT 10"
```

**Available Clauses:**

| Method | Description |
|--------|-------------|
| `match(pattern)` | MATCH clause |
| `optionalMatch(pattern)` | OPTIONAL MATCH clause |
| `where(condition)` | WHERE clause |
| `with(expressions)` | WITH clause |
| `ret(expressions)` | RETURN clause |
| `orderBy(expressions)` | ORDER BY clause |
| `skip(n)` | SKIP clause |
| `limit(n)` | LIMIT clause |
| `create(pattern)` | CREATE clause |
| `merge(pattern)` | MERGE clause |
| `delete(expressions)` | DELETE clause |
| `detachDelete(expressions)` | DETACH DELETE clause |
| `set(assignments)` | SET clause |
| `remove(items)` | REMOVE clause |
| `raw(clause)` | Raw GQL clause |
| `param(name, value)` | Add parameter |

### Pattern Builder

Build graph patterns:

```zig
const PatternBuilder = @import("query_builder").PatternBuilder;

var pb = PatternBuilder.init(allocator);
defer pb.deinit();

_ = try pb.nodeLabel("a", "Person");
_ = try pb.edgeRight("KNOWS");
_ = try pb.nodeLabel("b", "Person");

const pattern = try pb.build();
defer allocator.free(pattern);
// Result: "(a:Person)-[:KNOWS]->(b:Person)"
```

**Pattern Methods:**

| Method | Description | Example |
|--------|-------------|---------|
| `nodeVar(name)` | Node with variable | `(n)` |
| `nodeLabel(var, label)` | Node with label | `(n:Person)` |
| `edgeRight(type)` | Outgoing edge | `-[:KNOWS]->` |
| `edgeLeft(type)` | Incoming edge | `<-[:KNOWS]-` |
| `relRight(var, type, props)` | Outgoing with var | `-[r:KNOWS]->` |
| `relLeft(var, type, props)` | Incoming with var | `<-[r:KNOWS]-` |
| `relUndirected(var, type, props)` | Undirected edge | `-[:CONNECTED]-` |

### Predicate Builder

Build WHERE conditions:

```zig
const PredicateBuilder = @import("query_builder").PredicateBuilder;

var pb = PredicateBuilder.init(allocator);
defer pb.deinit();

_ = try pb.gt("n.age", "minAge");
_ = try pb.andOp();
_ = try pb.isNotNull("n.email");
_ = try pb.orOp();
_ = try pb.contains("n.name", "searchTerm");

const predicate = try pb.build();
defer allocator.free(predicate);
// Result: "n.age > $minAge AND n.email IS NOT NULL OR n.name CONTAINS $searchTerm"
```

**Predicate Methods:**

| Method | Description | Example |
|--------|-------------|---------|
| `eq(prop, param)` | Equals | `n.x = $param` |
| `neq(prop, param)` | Not equals | `n.x <> $param` |
| `lt(prop, param)` | Less than | `n.x < $param` |
| `lte(prop, param)` | Less or equal | `n.x <= $param` |
| `gt(prop, param)` | Greater than | `n.x > $param` |
| `gte(prop, param)` | Greater or equal | `n.x >= $param` |
| `isNull(prop)` | Is null | `n.x IS NULL` |
| `isNotNull(prop)` | Is not null | `n.x IS NOT NULL` |
| `contains(prop, param)` | Contains string | `n.x CONTAINS $param` |
| `startsWith(prop, param)` | Starts with | `n.x STARTS WITH $param` |
| `endsWith(prop, param)` | Ends with | `n.x ENDS WITH $param` |
| `in(prop, param)` | In list | `n.x IN $param` |
| `andOp()` | AND operator | `AND` |
| `orOp()` | OR operator | `OR` |
| `raw(text)` | Raw predicate | Custom text |

### Connection Pool

Manage connection pools:

```zig
const Pool = @import("pool").Pool;
const PoolConfig = @import("pool").PoolConfig;

var pool_cfg = PoolConfig.init();
_ = pool_cfg.withMinSize(5);
_ = pool_cfg.withMaxSize(20);
_ = pool_cfg.withAcquireTimeout(30000);
_ = pool_cfg.withIdleTimeout(300000);

var pool = Pool(ConnectionType).init(allocator, client_config, pool_cfg);
defer pool.deinit();

// Acquire connection
const conn = try pool.acquire();
defer pool.release(conn);

// Use connection...

// Get statistics
const stats = pool.getStats();
std.debug.print("Active: {}, Idle: {}\n", .{
    stats.active_connections,
    stats.idle_connections,
});
```

**Pool Configuration:**

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `min_size` | `u32` | `1` | Minimum pool size |
| `max_size` | `u32` | `10` | Maximum pool size |
| `acquire_timeout_ms` | `u32` | `30000` | Timeout for acquiring connection |
| `idle_timeout_ms` | `u32` | `300000` | Idle connection timeout |
| `health_check_interval_ms` | `u32` | `30000` | Health check interval |

### Input Validation

Validate user input:

```zig
const validate = @import("validate");

// Validate query string
try validate.query("MATCH (n) RETURN n");

// Validate parameter name
try validate.paramName("myParam");

// Validate hostname
try validate.hostname("db.example.com");

// Validate port
try validate.port(3141);

// Validate page size (1-100,000)
try validate.pageSize(500);

// Check IP addresses
const is_v4 = validate.ipv4("192.168.1.1");
const is_v6 = validate.isIpv6("::1");

// Sanitize input (removes control characters)
const clean = try validate.sanitize(allocator, "input\x00with\x01control\x02chars");
defer allocator.free(clean);
```

**Validation Errors:**

| Error | Description |
|-------|-------------|
| `QueryEmpty` | Query string is empty |
| `QueryTooLong` | Query exceeds 1MB limit |
| `QueryContainsNull` | Query contains null bytes |
| `ParamNameEmpty` | Parameter name is empty |
| `ParamNameInvalid` | Invalid parameter name format |
| `ParamNameTooLong` | Parameter name exceeds 256 chars |
| `HostnameEmpty` | Hostname is empty |
| `HostnameInvalid` | Invalid hostname characters |
| `HostnameTooLong` | Hostname exceeds 253 chars |
| `PortOutOfRange` | Port not in 1-65535 range |
| `PageSizeOutOfRange` | Page size not in 1-100,000 range |

### Error Handling

The client uses ISO GQL status codes:

```zig
const GeodeError = @import("error").GeodeError;

// Create errors
const conn_err = GeodeError.connection("connection refused");
const syntax_err = GeodeError.syntax("unexpected token at position 42");
const query_err = GeodeError.query("invalid property access", "22003");

// Check error properties
if (err.isRetryable()) {
    // Retry the operation
}

// Get status category
const category = err.statusCategory();
switch (category) {
    .connection => // Handle connection error
    .syntax_error => // Handle syntax error
    .data_exception => // Handle data error
    .transaction => // Handle transaction error
    else => // Handle other errors
}

// Get formatted message
std.debug.print("Error: {s}\n", .{err.message});
std.debug.print("Code: {s}\n", .{err.status_code});
```

**Status Code Categories:**

| Code Range | Category | Description |
|------------|----------|-------------|
| `00xxx` | Success | Operation succeeded |
| `08xxx` | Connection | Connection errors |
| `22xxx` | Data | Data exceptions |
| `25xxx` | Transaction | Transaction state errors |
| `28xxx` | Authorization | Auth errors |
| `42xxx` | Syntax | Query syntax errors |

## FIPS Mode

The client ships a cryptographic seam (`src/crypto_backend.zig`) that routes
all field-encryption and authentication crypto through either the Zig standard
library (`std.crypto`) or an OpenSSL FIPS-validated provider, selected at
build time.

### Enabling FIPS mode

Pass `-Dfips=true` and `-Dopenssl_path=<prefix>` to `zig build`:

```bash
zig build -Dfips=true -Dopenssl_path=/usr/local/ssl
```

`/usr/local/ssl` is the default OpenSSL FIPS install prefix. Override with the
`OPENSSL_PREFIX` environment variable when using the Makefile targets (see
below).

### What changes under -Dfips=true

- All field-level encryption (AES-256-GCM), HMAC-SHA256/384/512, HKDF, and
  PBKDF2 operations route through the OpenSSL FIPS 140-3 validated provider.
- All authentication credential handling (`secureZero`, timing-safe compares)
  uses the seam rather than `std.crypto` directly.
- The future gRPC TLS transport will use the `tls` package (FIPS-routed) and
  must never call `std.crypto.tls` directly in a security path.
- Under `-Dfips=false` (the default), the same API surface is backed by
  `std.crypto` with no OpenSSL dependency.

### Dual-mode test gate

```bash
# Run tests with std.crypto shim only (no OpenSSL required)
make test-shim

# Run tests with OpenSSL FIPS provider
make test-fips

# Run both modes (CI gate — both must be green)
make test-dual

# Override OpenSSL prefix
OPENSSL_PREFIX=/opt/openssl-fips make test-fips
OPENSSL_PREFIX=/opt/openssl-fips make test-dual
```

`make test-dual` is the recommended pre-commit and CI gate for FIPS parity: it
runs the full test suite — including the KAT (Known-Answer Test) suite in
`src/fips_parity_test.zig` — under both backends and asserts that SHA-256,
HMAC-SHA256, AES-256-GCM, and HKDF-SHA256 produce identical, spec-correct
outputs regardless of which backend is active.

## Building

```bash
# Build debug version
make build

# Build release version
make release

# Clean build artifacts
make clean
```

## Testing

```bash
# Run unit tests
make test

# Run integration tests (requires Geode server)
make test-integration

# Run integration tests with Docker
make test-integration-docker

# Run property-based/fuzz tests
make test-fuzz

# Run benchmarks
make bench

# Run full CI pipeline
make ci
```

## Performance

The client is optimized for high performance:

- **Connection establishment**: ~2ms with connection pooling
- **Query execution**: <1ms for simple queries
- **Value serialization**: Nanosecond-level JSON conversion
- **Memory efficiency**: Zero-copy where possible

Run benchmarks with `make bench` for detailed performance metrics.

### Concurrency Model

Concurrency is provided by `src/executor.zig`, a thin facade over
[`devnw/zig/thread-pool`](https://gitlab.com/devnw/zig/thread-pool). A
single shared `Executor` owns the pool; `Pool`, `Batch`, and
`GeodeClient` consume it by parameter. The runner can be built with a
dedicated blocking lane so network I/O (connect, query, health check)
runs on workers reserved for syscalls without starving CPU-bound
tasks (proto encode/decode, idle-sweeping).

Public APIs that accept an `*Executor`:

- `Pool.cleanupExpiredAsync` / `startIdleSweeper` — async idle-connection maintenance
- `Batch.runParallel` — concurrent per-query dispatch with `WaitGroup` fan-out
- `GeodeClient.queryAsync` / `queryBatchParallel` — async query execution

See `CLAUDE.md` for the full Executor module docs and the `.default` /
`.blocking` lane rationale.

### System-Level QUIC Optimizations

For optimal QUIC throughput on high-bandwidth connections, configure UDP buffer sizes at the OS level.

**Linux:**

```bash
# Increase UDP buffer sizes to 7MB
sudo sysctl -w net.core.rmem_max=7340032
sudo sysctl -w net.core.wmem_max=7340032

# Persist across reboots
echo "net.core.rmem_max=7340032" | sudo tee -a /etc/sysctl.d/99-geode-quic.conf
echo "net.core.wmem_max=7340032" | sudo tee -a /etc/sysctl.d/99-geode-quic.conf
```

**BSD/macOS:**

```bash
sudo sysctl -w kern.ipc.maxsockbuf=8441037
```

**GSO (Generic Segmentation Offload)**: Available on Linux 4.18+, batches UDP packets to reduce syscall overhead. Enabled automatically by the QUIC implementation.

**Path MTU Discovery (DPLPMTUD)**: Enabled by default, probes for optimal packet sizes to reduce per-packet overhead.

## Wire Protocol

The client uses protobuf binary format with a 4-byte big-endian length prefix:

```
[4 bytes: message length (big-endian)] [protobuf message body]
```

**Transport Options:**

| Transport | Protocol | Port | Description |
|-----------|----------|------|-------------|
| QUIC | UDP + TLS 1.3 | 3141 | Low-latency, multiplexed streams |
| gRPC | HTTP/2 (+ TLS) | 50051 | Standard gRPC with 5-byte framing |

**Client Messages:**

- `HelloRequest` - Connection handshake with authentication
- `ExecuteRequest` - Execute GQL query with parameters
- `PullRequest` - Fetch paginated results
- `BeginRequest`/`CommitRequest`/`RollbackRequest` - Transaction control
- `PingRequest` - Keep-alive

**Server Responses:**

- `HelloResponse` - Handshake acknowledgment with session ID
- `ExecuteResponse` - Query result with schema and bindings
- `ErrorResponse` - Error details with ISO GQL status code
- `PongResponse` - Ping acknowledgment

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes following the code style
4. Run tests: `make test test-fuzz`
5. Run formatter: `make fmt`
6. Submit a pull request

### Code Style

- Follow Zig standard library conventions
- Use `errdefer` for cleanup on error paths
- Use `defer` for cleanup in all paths
- All public items must have doc comments
- Run `make fmt` before committing

## License

Apache License 2.0

Copyright (c) 2024-2026 CodePros

## See Also

- [Geode Database](https://gitlab.com/devnw/geode)
- [ISO/IEC 39075:2024 GQL Standard](https://www.iso.org/standard/76120.html)
- [CLAUDE.md](CLAUDE.md) - Developer guidance for this codebase
