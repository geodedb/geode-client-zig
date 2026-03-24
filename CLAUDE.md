# CLAUDE.md

This file provides guidance to Claude Code when working with the geode-client-zig codebase.

## Project Overview

This is the **Zig client library** for **Geode**, an enterprise-ready graph database implementing the ISO/IEC 39075:2024 Graph Query Language (GQL) standard.

**Status**: Production-ready (Phase 8 Complete)
**Zig Version**: 0.15.1+
**Transport**: QUIC + TLS 1.3 (default), gRPC over HTTP/2 (optional)
**Wire Format**: Protobuf (JSON protocol removed)
**Default Ports**: 3141 (QUIC), 50051 (gRPC)

## Repository Structure

```
geode-client-zig/
├── build.zig              # Build configuration with module definitions
├── build.zig.zon          # Package manifest with dependencies
├── Makefile               # Build and test automation
├── geode_client_v2.zig    # Main client implementation
├── src/                   # Core modules
│   ├── error.zig          # Error types with ISO GQL status codes
│   ├── types.zig          # Value type system (GQL types)
│   ├── config.zig         # Configuration and DSN parsing (quic://, grpc://)
│   ├── pool.zig           # Connection pooling
│   ├── query_builder.zig  # Fluent query builder API
│   ├── validate.zig       # Input validation
│   ├── proto.zig          # Protobuf encoding/decoding (wire format)
│   ├── grpc.zig           # gRPC transport module (HTTP/2)
│   ├── prepared.zig       # Prepared statement support
│   ├── explain.zig        # Query explain/profile support
│   ├── batch.zig          # Batch query execution
│   └── auth.zig           # Authentication and RLS policies
├── tests/                 # Integration tests
│   └── integration.zig    # Comprehensive integration test suite
├── benchmarks/            # Performance benchmarks
│   └── bench.zig          # Comprehensive benchmark suite (59 benchmarks)
├── fuzz/                  # Fuzz/property-based tests
│   ├── fuzz_dsn.zig       # DSN parsing fuzz tests
│   ├── fuzz_types.zig     # Value type fuzz tests
│   ├── fuzz_query_builder.zig  # Query builder fuzz tests
│   ├── fuzz_validate.zig  # Validation fuzz tests
│   └── fuzz_pool.zig      # Connection pool fuzz tests
├── test_connection.zig    # Connection test executable
└── test_connection_v2.zig # V2 connection test executable
```

## Build Commands

```bash
# Build
make build              # Debug build
make release            # Release build (ReleaseSafe)
make clean              # Clean build artifacts

# Testing
make test               # Run all unit tests
make test-unit          # Run unit tests only
make test-integration   # Run integration tests (requires server)
make test-integration-docker  # Run with Docker Geode server

# Docker (for integration tests)
make docker-start       # Start Geode server container
make docker-stop        # Stop container
make docker-logs        # View container logs

# Benchmarks
make bench              # Run performance benchmarks (59 benchmarks)

# Fuzzing / Property-Based Tests
make test-fuzz          # Run property-based tests (93 tests)

# CI
make ci                 # Full CI pipeline
make ci-quick           # Quick CI (unit tests only)
```

## Dependencies

External dependencies are managed via `build.zig.zon` with local path references:

- **quic**: QUIC transport protocol (main networking)
- **json**: JSON parsing/serialization
- **dns**: DNS resolution
- **config**: Configuration file parsing (YAML, TOML, JSON)
- **slog**: Structured logging
- **uri**: URI parsing
- **strings**: String utilities

Dependencies are located at `~/src/gl/devnw/zig/*`.

## Module Overview

### Error Module (`src/error.zig`)

Provides structured error handling with ISO GQL status codes:

```zig
const GeodeError = @import("error.zig").GeodeError;

// Create specific error types
const err = GeodeError.connection("connection refused");
const err = GeodeError.syntax("unexpected token");
const err = GeodeError.query("invalid query", "42601");

// Check error properties
if (err.isRetryable()) { ... }
const category = err.statusCategory(); // .connection, .syntax_error, etc.
```

**Status Categories**:

- `00xxx`: Success
- `08xxx`: Connection exception
- `22xxx`: Data exception
- `25xxx`: Invalid transaction state
- `28xxx`: Invalid authorization
- `42xxx`: Syntax error

### Types Module (`src/types.zig`)

Provides a Value type supporting all GQL types:

```zig
const Value = @import("types.zig").Value;

// Primitive types
const v1 = Value.initNull();
const v2 = Value.initBool(true);
const v3 = Value.initInt(42);
const v4 = Value.initFloat(3.14);
const v5 = Value.initString("hello");

// Temporal types
const v6 = Value.initDate(2025, 1, 24);
const v7 = Value.initTime(14, 30, 45);
const v8 = Value.initTimestamp(date, time);

// Type checking and conversion
if (v.isInt()) {
    const i = try v.asInt();
}

// JSON conversion
const json_val = try value.toJson(allocator);
const value = Value.fromJson(json);
```

### Config Module (`src/config.zig`)

Handles configuration and DSN parsing:

```zig
const Config = @import("config.zig").Config;
const parseDSN = @import("config.zig").parseDSN;

// Default configuration
var cfg = Config.init();

// Parse DSN strings
// URL format: quic://user:pass@host:port?params
const cfg = try parseDSN(allocator, "quic://admin:secret@localhost:3141?insecure_tls_skip_verify=true");

// Simple format: host:port
const cfg = try parseDSN(allocator, "localhost:8443");

// Builder pattern
var cfg = Config.init();
_ = cfg.withCredentials("admin", "secret");
_ = cfg.withInsecure(true);
_ = cfg.withPageSize(500);
_ = cfg.withTimeout(60000);
```

**Supported Query Parameters**:

- `insecure`, `insecure_skip_verify`: Allow unverified TLS
- `page_size`, `pageSize`: Result pagination size
- `timeout`, `timeout_ms`: Connection timeout
- `username`, `user`: Authentication username
- `password`, `pass`: Authentication password

### Pool Module (`src/pool.zig`)

Connection pooling with concurrency control:

```zig
const Pool = @import("pool.zig").Pool;
const PoolConfig = @import("pool.zig").PoolConfig;

// Configure pool
var pool_cfg = PoolConfig.init();
_ = pool_cfg.withMinSize(5);
_ = pool_cfg.withMaxSize(20);
_ = pool_cfg.withAcquireTimeout(30000);
_ = pool_cfg.withIdleTimeout(300000);

// Create and use pool
var pool = Pool(ConnectionType).init(allocator, client_config, pool_cfg);
defer pool.deinit();

const conn = try pool.acquire();
defer pool.release(conn);

// Get statistics
const stats = pool.getStats();
// stats.total_connections, stats.active_connections, stats.idle_connections, etc.
```

### Query Builder Module (`src/query_builder.zig`)

Fluent API for constructing GQL queries:

```zig
const QueryBuilder = @import("query_builder.zig").QueryBuilder;
const PatternBuilder = @import("query_builder.zig").PatternBuilder;
const PredicateBuilder = @import("query_builder.zig").PredicateBuilder;

// Build queries
var qb = QueryBuilder.init(allocator);
defer qb.deinit();

_ = try qb.match("(n:Person)");
_ = try qb.where("n.age > $minAge");
_ = try qb.ret("n.name, n.age");
_ = try qb.orderBy("n.name");
_ = try qb.limit(10);
_ = try qb.param("minAge", Value.initInt(25));

const query = try qb.build();
const params = qb.getParams();

// Build patterns
var pb = PatternBuilder.init(allocator);
defer pb.deinit();

_ = try pb.nodeLabel("a", "Person");
_ = try pb.edgeRight("KNOWS");
_ = try pb.nodeLabel("b", "Person");

const pattern = try pb.build(); // "(a:Person)-[:KNOWS]->(b:Person)"

// Build predicates
var pred = PredicateBuilder.init(allocator);
defer pred.deinit();

_ = try pred.gt("n.age", "minAge");
_ = try pred.andOp();
_ = try pred.isNotNull("n.email");

const condition = try pred.build(); // "n.age > $minAge AND n.email IS NOT NULL"
```

### Validate Module (`src/validate.zig`)

Input validation for queries, parameters, and configuration:

```zig
const validate = @import("validate.zig");

// Validate query
try validate.query("MATCH (n) RETURN n");

// Validate parameter names
try validate.paramName("myParam");

// Validate hostname
try validate.hostname("localhost");

// Validate port
try validate.port(3141);

// Validate page size
try validate.pageSize(1000);

// Check IP addresses
if (validate.ipv4("192.168.1.1")) { ... }
if (validate.isIpv6("::1")) { ... }

// Sanitize input
const clean = try validate.sanitize(allocator, "hello\x00world");
```

### Protocol Module (`src/proto.zig`)

Protobuf encoding/decoding for the Geode wire protocol. Wire format: 4-byte Big Endian length prefix + protobuf message body, aligned with the `geode.proto` schema from the server.

```zig
const proto = @import("proto.zig");

// Message types (structs matching geode.proto)
var hello = proto.HelloRequest{
    .username = "admin",
    .password = "secret",
    .client_name = "geode-zig",
    .client_version = "0.1.0",
    .wanted_conformance = "minimum",
};

// Execute query
var exec = proto.ExecuteRequest.init(allocator);
defer exec.deinit(allocator);
exec.query = "MATCH (n:Person) RETURN n";
try exec.addParam(allocator, "minAge", proto.Value.initInt(25));

// Pull results
var pull = proto.PullRequest{ .request_id = 1, .page_size = 1000 };

// Transaction control
var begin = proto.BeginRequest{ .read_only = false };
var commit = proto.CommitRequest{};
var rollback = proto.RollbackRequest{};

// Savepoints
var sp = proto.SavepointRequest{ .name = "sp1" };
var rb_to = proto.RollbackToRequest{ .name = "sp1" };

// Ping
var ping = proto.PingRequest{};

// QUIC message wrappers
var client_msg = proto.QuicClientMessage{ .hello = hello };
var server_msg: proto.QuicServerMessage = ...; // decoded from wire
defer server_msg.deinit(allocator);

// Encoding helpers
var buf = std.ArrayList(u8).init(allocator);
try proto.encodeString(buf.writer(), 1, "hello");
try proto.encodeVarint(buf.writer(), 42);
```

**Request Types** (QUIC client messages):

- `HelloRequest`: Connection handshake with credentials
- `ExecuteRequest`: Execute GQL query with parameters
- `PullRequest`: Fetch result pages
- `BeginRequest`/`CommitRequest`/`RollbackRequest`: Transaction control
- `SavepointRequest`/`RollbackToRequest`: Savepoint management
- `PingRequest`: Keep-alive

**Response Types** (QUIC server messages):

- `HelloResponse`: Handshake acknowledgment with session ID and capabilities
- `ExecutionResponse`: Query result with status, schema, data page, error, and metrics
- `PullResponse`: Paginated result wrapper
- `BeginResponse`: Transaction ID
- `CommitResponse`/`RollbackResponse`: Success flag
- `PingResponse`: OK flag

**Data Types**:

- `Value`: Protobuf value union (null, int, double, bool, string)
- `Row`: List of values
- `DataPage`: Rows + pagination metadata (final, ordered, order_keys)
- `SchemaDefinition`/`ColumnDefinition`: Result schema
- `ProtoError`: Error with code, message, type, anchor
- `Status`: ISO GQL status class/subclass
- `ExecutionMetrics`: Parse/plan/execute/total duration in nanoseconds

### Prepared Statement Module (`src/prepared.zig`)

Prepared statement support for efficient repeated query execution:

```zig
const PreparedStatement = @import("prepared.zig").PreparedStatement;

// Create prepared statement
const stmt = try PreparedStatement.init(
    allocator,
    "MATCH (n:Person) WHERE n.name = $name AND n.age > $minAge RETURN n",
);
defer @constCast(&stmt).deinit();

// Check extracted parameters
const param_count = stmt.parameterCount();  // 2
const has_name = stmt.hasParameter("name"); // true
const params = stmt.getParameters();        // ["name", "minAge"]

// Validate parameters before execution
var query_params = std.StringHashMap(Value).init(allocator);
try query_params.put("name", Value.initString("Alice"));
try query_params.put("minAge", Value.initInt(21));
try stmt.validateParams(query_params);

// Build message for execution
const msg = try stmt.buildMessage(query_params);
defer allocator.free(msg);
```

### Explain/Profile Module (`src/explain.zig`)

Query plan analysis and execution profiling:

```zig
const explain = @import("explain.zig");

// Build EXPLAIN message
const explain_msg = try explain.buildExplainMessage(allocator, "MATCH (n) RETURN n");
defer allocator.free(explain_msg);

// Build PROFILE message
const profile_msg = try explain.buildProfileMessage(allocator, "MATCH (n) RETURN n");
defer allocator.free(profile_msg);

// Create query plan (for parsing server response)
var plan = try explain.QueryPlan.init(allocator, "MATCH (n) RETURN n");
defer plan.deinit();
try plan.setRawPlan(server_response);

// Create query profile
var profile = try explain.QueryProfile.init(allocator, "MATCH (n) RETURN n");
defer profile.deinit();
profile.total_time_ns = 1_500_000;
const time_ms = profile.totalTimeMs(); // 1.5

// Format for display
var buf: [1024]u8 = undefined;
var stream = std.io.fixedBufferStream(&buf);
try profile.format(stream.writer());
```

### Batch Module (`src/batch.zig`)

Batch query execution for multiple queries in a single round-trip:

```zig
const batch = @import("batch.zig");

// Create batch with fluent API
var builder = batch.BatchBuilder.init(allocator);
defer builder.deinit();

_ = try builder.query("CREATE (n:Person {name: 'Alice'})");
_ = try builder.query("CREATE (m:Person {name: 'Bob'})");
_ = try builder.query("CREATE (n)-[:KNOWS]->(m)");
_ = builder.transactional();  // Execute in transaction
_ = builder.stopOnError();    // Stop on first error

const msg = try builder.build();
defer allocator.free(msg);

// Or use Batch directly
var b = batch.Batch.init(allocator);
defer b.deinit();

_ = try b.add("MATCH (n) RETURN n");
_ = try b.add("MATCH (m) RETURN m");
_ = b.withStopOnError(true);
_ = b.withTransaction(true);

const batch_msg = try b.buildMessage();
defer allocator.free(batch_msg);

// Check batch status
const count = b.count();
const is_empty = b.isEmpty();
```

### Auth Module (`src/auth.zig`)

Authentication, user management, and Row-Level Security (RLS) policies:

```zig
const auth = @import("auth.zig");

// Create auth client
var client = auth.AuthClient.init(allocator);
defer client.deinit();

// Build login message
const login_msg = try client.buildLoginMessage("admin", "secret");
defer std.heap.page_allocator.free(login_msg);

// Build logout message
const logout_msg = try client.buildLogoutMessage();
defer allocator.free(logout_msg);

// Create user
const roles = [_][]const u8{ "reader", "writer" };
const create_user_msg = try client.buildCreateUserMessage("newuser", "password", &roles);

// Create role
const perms = [_][]const u8{ "read", "write" };
const create_role_msg = try client.buildCreateRoleMessage("editor", "Can edit", &perms);

// Assign role to user
const assign_msg = try client.buildAssignRoleMessage("alice", "admin");

// Create RLS policy
var policy = try auth.RlsPolicy.init(
    allocator,
    "user_data_policy",
    "Person",
    .select,
    "n.owner = $current_user",
);
defer policy.deinit();
const rls_msg = try client.buildCreateRlsPolicyMessage(policy);

// Track authentication state
try client.setAuthenticated("admin", "token123");
const is_auth = client.isAuthenticated();
const user = client.getCurrentUser();
client.clearAuthentication();
```

**RLS Policy Types**:

- `.select`: Filter on SELECT queries
- `.insert`: Filter on INSERT operations
- `.update`: Filter on UPDATE operations
- `.delete`: Filter on DELETE operations
- `.all`: Apply to all operations

## Development Guidelines

### Code Style

- Follow Zig standard library conventions
- Use `errdefer` for cleanup on error paths
- Use `defer` for cleanup in all paths
- Prefer explicit error handling over silent failures

### Memory Management

- Always pair allocations with deallocations
- Use `ArrayListUnmanaged` for collections (Zig 0.15+ API)
- Pass allocator to methods that need to allocate/deallocate

### Testing

- Unit tests are in the same file as the code they test
- Integration tests are in `tests/integration.zig`
- Use `std.testing.allocator` for test allocations
- Test error cases as well as success cases

### Integration Tests

The integration test suite (`tests/integration.zig`) provides comprehensive testing against a running Geode server:

**Test Categories**:

- Basic operations (ping, query, version)
- Node CRUD (create, read, update, delete)
- Relationship operations
- Transaction management (begin, commit, rollback)
- Aggregation functions (COUNT, SUM, AVG, MIN, MAX)
- Data types (null, boolean, integer, float, string, lists, maps)
- Concurrent access

**Running Integration Tests**:

```bash
# With external Geode server
GEODE_SERVER=localhost:3141 GEODE_INSECURE=1 make test-integration

# With Docker (automatic server management)
make test-integration-docker
```

**Environment Variables**:

- `GEODE_SERVER`: Server address (default: 127.0.0.1:3141)
- `GEODE_INSECURE`: Set to "1" to skip TLS verification

### Benchmarks

The benchmark suite (`benchmarks/bench.zig`) measures performance across all client components:

**Benchmark Categories (59 total)**:

- Value type creation and accessors (16 benchmarks)
- JSON conversion (10 benchmarks)
- Date/Time formatting (3 benchmarks)
- QueryBuilder operations (6 benchmarks)
- PatternBuilder operations (4 benchmarks)
- PredicateBuilder operations (3 benchmarks)
- Config/DSN parsing (5 benchmarks)
- Connection pool operations (4 benchmarks)
- Input validation (8 benchmarks)

**Running Benchmarks**:

```bash
make bench              # Run all benchmarks (uses ReleaseFast)
zig build bench         # Alternative: build and run via zig
```

Benchmarks are compiled with `ReleaseFast` optimization for accurate performance measurements.

### Fuzz / Property-Based Tests

The fuzz test suite (`fuzz/`) provides property-based testing for robustness:

**Fuzz Test Categories (93 total)**:

- DSN parsing fuzz tests (11 tests) - valid/invalid hosts, ports, URLs, query params
- Value type system tests (18 tests) - roundtrip, accessors, type checking, JSON conversion
- Query builder tests (20 tests) - clauses, mutations, patterns, predicates
- Validation tests (27 tests) - queries, params, hostnames, ports, page sizes, IPv4/IPv6
- Connection pool tests (17 tests) - config, state transitions, acquire/release, stats

**Running Fuzz Tests**:

```bash
make test-fuzz          # Run all property-based tests
zig build test-fuzz     # Alternative: build and run via zig
```

The tests use property-based testing patterns to validate:

- Input validation rejects all invalid input
- Roundtrip conversions preserve data
- State machines maintain valid states
- Edge cases are handled correctly

### Error Handling

- Return specific error types when possible
- Include ISO status codes for GQL errors
- Use `GeodeError` for client-level errors

## Wire Protocol

The client uses protobuf-encoded messages over QUIC (and optionally gRPC over HTTP/2). Each QUIC frame is a 4-byte Big Endian length prefix followed by a protobuf message body, as defined in `geode.proto`.

**Client Messages** (via `QuicClientMessage` wrapper):

- `HelloRequest`: Connection handshake with credentials and client metadata
- `ExecuteRequest`: Execute GQL query with typed parameters
- `PullRequest`: Fetch paginated results
- `BeginRequest`/`CommitRequest`/`RollbackRequest`: Transaction control
- `SavepointRequest`/`RollbackToRequest`: Savepoint management
- `PingRequest`: Keep-alive

**Server Responses** (via `QuicServerMessage` wrapper):

- `HelloResponse`: Session ID and server capabilities
- `ExecutionResponse`: Combines status, schema, data page, error, and execution metrics
- `PullResponse`: Paginated result wrapper
- `BeginResponse`: Transaction/session ID
- `CommitResponse`/`RollbackResponse`: Success flag
- `PingResponse`: OK flag

## Integration with Geode Server

The client requires a running Geode server. For local development:

```bash
# Start server (from geode/ directory)
./zig-out/bin/geode serve --listen 0.0.0.0:3141

# Or use Docker
make docker-start
```

## License

Apache License 2.0
Copyright (c) 2024-2026 CodePros
