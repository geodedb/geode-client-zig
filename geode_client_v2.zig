const std = @import("std");
const quic = @import("quic");
const uuid = @import("uuid");
pub const proto = @import("proto");
pub const config = @import("config");
const validate = @import("validate");
pub const grpc = @import("grpc");
pub const executor_mod = @import("executor");
pub const tp = @import("thread_pool");
const obs = @import("observability");
const ca_bundle = @import("src/ca_bundle.zig");
const client_identity = @import("src/client_identity.zig");
const dial_host = @import("src/dial_host.zig");
// Re-export the otel bootstrap helper so consumers can call
// `geode_client.observability_init.Otel.init(...)` from `main()`. The
// import is gated by the seam's `enabled` const: when `-Dwith_otel=false`,
// the `observability_init` module is never registered in build.zig, so
// the @import never fires and this resolves to an empty struct.
pub const observability_init = if (obs.enabled) @import("observability_init") else struct {};
pub const observability = obs;

// CANARY: REQ=REQ-ZIG-CLIENT-002; FEATURE="Zig Client v2"; ASPECT=QuicPackageClient; STATUS=IMPL; OWNER=clients; UPDATED=2026-01-24
// Zig client uses the quic package from zig package manager for full compatibility with the server.
// CANARY: REQ=REQ-ZIG-CLIENT-003; FEATURE="gRPC Transport"; ASPECT=TransportAbstraction; STATUS=IMPL; OWNER=clients; UPDATED=2026-02-05
// Client now supports both QUIC and gRPC transports selectable via Config.transport.

/// Transport type for client connections
pub const Transport = config.Transport;

/// Maximum receive buffer size (16MB).
/// SECURITY: Prevents resource exhaustion from malicious server responses (CWE-400).
/// See GAP_ANALYSIS.md Finding 16.
pub const MAX_RECV_BUFFER_SIZE: usize = 16 * 1024 * 1024;

const deadline = @import("src/deadline.zig");
const nowNs = deadline.nowNs;

pub const GeodeClient = struct {
    allocator: std.mem.Allocator,
    host: []const u8,
    port: u16,
    insecure: bool,
    ca_cert_path: ?[]const u8 = null,
    ca_chain_der: ?[]const []const u8 = null,
    client_cert_path: ?[]const u8 = null,
    client_key_path: ?[]const u8 = null,
    /// DER client certificate and key loaded from client_cert_path /
    /// client_key_path; must outlive the endpoint (SONNY-6457).
    client_identity: ?client_identity.ClientIdentity = null,
    server_name: ?[]const u8 = null,
    username: []const u8,
    password: []const u8,
    transport: Transport,

    // QUIC transport state
    endpoint: ?*quic.QuicEndpoint = null,
    /// Address family `endpoint` is bound to (SONNY-6494).
    endpoint_family: dial_host.Family = .ip4,
    conn: ?*quic.QuicConnection = null,
    stream_id: ?u64 = null,
    recv_buffer: std.ArrayList(u8),
    recv_offset: usize = 0,
    session_id: []const u8 = "",

    // gRPC transport state
    grpc_client: ?grpc.GrpcClient = null,

    // Request tracking
    last_request_id: ?[]const u8 = null,

    // Graph binding from DSN or config
    graph: ?[]const u8 = null,

    // Multi-tenant id sent in HELLO field 3 (GAP-0841). Null in single-tenant.
    tenant: ?[]const u8 = null,
    // FLE role sent in HELLO field 8 (GAP-0841). Null when not using FLE.
    role: ?[]const u8 = null,

    /// How long the client waits for the server: the QUIC handshake or the
    /// gRPC TCP connect, the HELLO answer, the first answer to a query,
    /// begin, commit, rollback or ping, and a write held up by flow control
    /// (Config.timeout_ms; DSN timeout_ms / connect_timeout; SONNY-6589,
    /// SONNY-6617). A query's later pages wait at most 5 s each, or this if
    /// shorter. `connect` refuses a value outside 1..3600000 with
    /// `error.InvalidTimeout` (only a Config built or changed in code can hold
    /// one: the DSN parsers refuse it or fall back to the default).
    timeout_ms: u32 = config.DEFAULT_TIMEOUT_MS,
    /// Rows per page (Config.page_size; DSN page_size).
    page_size: u32 = config.DEFAULT_PAGE_SIZE,
    /// TLS on a gRPC connection (Config.tls; QUIC always uses TLS). Null on
    /// a client built in code: TLS is then `!insecure`, as before.
    tls: ?bool = null,
    /// HELLO fields 4-6 (Config.hello_name / hello_ver / conformance), owned.
    /// Null sends the protocol defaults (proto.HelloRequest).
    hello_name: ?[]const u8 = null,
    hello_ver: ?[]const u8 = null,
    conformance: ?[]const u8 = null,

    /// Initialize a QUIC client (backward compatible).
    pub fn init(allocator: std.mem.Allocator, host: []const u8, port: u16, insecure: bool, username: []const u8, password: []const u8) !GeodeClient {
        return initWithTransport(allocator, host, port, insecure, username, password, .quic);
    }

    /// Initialize a client with explicit transport selection.
    pub fn initWithTransport(allocator: std.mem.Allocator, host: []const u8, port: u16, insecure: bool, username: []const u8, password: []const u8, transport: Transport) !GeodeClient {
        const owned_host = try allocator.dupe(u8, host);
        errdefer allocator.free(owned_host);
        const owned_username = try allocator.dupe(u8, username);
        errdefer allocator.free(owned_username);
        const owned_password = try allocator.dupe(u8, password);
        errdefer {
            std.crypto.secureZero(u8, owned_password);
            allocator.free(owned_password);
        }
        return .{
            .allocator = allocator,
            .host = owned_host,
            .port = port,
            .insecure = insecure,
            .username = owned_username,
            .password = owned_password,
            .transport = transport,
            .endpoint = null,
            .conn = null,
            .stream_id = null,
            .recv_buffer = try std.ArrayList(u8).initCapacity(allocator, 4096),
            .grpc_client = null,
        };
    }

    /// Initialize a client from a Config struct.
    pub fn initFromConfig(allocator: std.mem.Allocator, cfg: config.Config) !GeodeClient {
        var client = try initWithTransport(
            allocator,
            cfg.host,
            cfg.port,
            cfg.insecure,
            cfg.username orelse "",
            cfg.password orelse "",
            cfg.transport,
        );
        errdefer client.deinit();
        client.timeout_ms = cfg.timeout_ms;
        client.page_size = cfg.page_size;
        client.tls = cfg.tls;
        client.hello_name = try allocator.dupe(u8, cfg.hello_name);
        client.hello_ver = try allocator.dupe(u8, cfg.hello_ver);
        client.conformance = try allocator.dupe(u8, cfg.conformance);
        if (cfg.graph) |g| {
            client.graph = try allocator.dupe(u8, g);
        }
        if (cfg.tenant) |t| {
            client.tenant = try allocator.dupe(u8, t);
        }
        if (cfg.role) |r| {
            client.role = try allocator.dupe(u8, r);
        }
        if (cfg.ca_cert) |path| {
            client.ca_cert_path = try allocator.dupe(u8, path);
        }
        if (cfg.client_cert) |path| {
            client.client_cert_path = try allocator.dupe(u8, path);
        }
        if (cfg.client_key) |path| {
            client.client_key_path = try allocator.dupe(u8, path);
        }
        if (cfg.server_name) |name| {
            client.server_name = try allocator.dupe(u8, name);
        }
        return client;
    }

    pub fn deinit(self: *GeodeClient) void {
        self.recv_buffer.deinit(self.allocator);

        if (self.host.len > 0) {
            self.allocator.free(self.host);
            self.host = "";
        }

        // Securely zero and free sensitive credentials (always owned copies)
        if (self.password.len > 0) {
            std.crypto.secureZero(u8, @constCast(self.password));
        }
        self.allocator.free(self.password);
        self.password = "";

        if (self.username.len > 0) {
            std.crypto.secureZero(u8, @constCast(self.username));
        }
        self.allocator.free(self.username);
        self.username = "";

        if (self.session_id.len > 0) {
            std.crypto.secureZero(u8, @constCast(self.session_id));
            self.allocator.free(self.session_id);
            self.session_id = "";
        }

        // Clean up request ID
        if (self.last_request_id) |rid| {
            self.allocator.free(rid);
            self.last_request_id = null;
        }

        // Clean up graph binding
        if (self.graph) |g| {
            self.allocator.free(g);
            self.graph = null;
        }

        // Clean up tenant id and FLE role (GAP-0841)
        if (self.tenant) |t| {
            self.allocator.free(t);
            self.tenant = null;
        }
        if (self.role) |r| {
            self.allocator.free(r);
            self.role = null;
        }

        if (self.ca_cert_path) |path| {
            self.allocator.free(path);
            self.ca_cert_path = null;
        }
        if (self.client_cert_path) |path| {
            self.allocator.free(path);
            self.client_cert_path = null;
        }
        if (self.client_key_path) |path| {
            std.crypto.secureZero(u8, @constCast(path));
            self.allocator.free(path);
            self.client_key_path = null;
        }
        if (self.server_name) |name| {
            self.allocator.free(name);
            self.server_name = null;
        }
        inline for (.{ "hello_name", "hello_ver", "conformance" }) |field| {
            if (@field(self, field)) |v| {
                self.allocator.free(v);
                @field(self, field) = null;
            }
        }

        // Clean up QUIC resources. Flush the endpoint after close so the server
        // sees stream/connection shutdown instead of carrying half-dead test
        // connections forward until idle timeout.
        if (self.conn) |c| {
            if (self.stream_id) |sid| {
                quic.closeStream(c, sid, 0) catch {};
                self.stream_id = null;
            }
            if (self.endpoint) |ep| {
                quic.flush(ep, 2);
            }
            quic.closeConnection(c, 0) catch {};
            if (self.endpoint) |ep| {
                quic.flush(ep, 8);
                quic.destroy(ep, c);
            }
            self.conn = null;
        }
        if (self.endpoint) |ep| {
            quic.endpointDeinit(ep);
            self.endpoint = null;
        }
        if (self.ca_chain_der) |chain| {
            ca_bundle.deinit(self.allocator, chain);
            self.ca_chain_der = null;
        }
        if (self.client_identity) |*identity| {
            identity.deinit(self.allocator);
            self.client_identity = null;
        }

        // Clean up gRPC resources
        if (self.grpc_client) |*gc| {
            gc.deinit();
            self.grpc_client = null;
        }
    }

    /// Generate a UUID v4 string for use as a request identifier.
    /// The returned string is heap-allocated; the client tracks and frees it
    /// automatically on the next call or on deinit.
    pub fn generateRequestId(self: *GeodeClient) ![]const u8 {
        // Free previous request ID
        if (self.last_request_id) |rid| {
            self.allocator.free(rid);
            self.last_request_id = null;
        }

        const id = try uuid.newV4();
        const str = try id.toStringAlloc(self.allocator);
        self.last_request_id = str;
        return str;
    }

    /// Return the request ID from the most recent query, or null if no query
    /// has been executed yet.
    pub fn getLastRequestId(self: *const GeodeClient) ?[]const u8 {
        return self.last_request_id;
    }

    /// Create the QUIC endpoint (TLS trust anchors and client identity
    /// loaded) without dialling; `connect` calls it. The endpoint is bound
    /// to the family of an address literal host, and to IPv4 for a host
    /// name; `connect` rebuilds it when the name resolves to IPv6 only.
    pub fn ensureEndpoint(self: *GeodeClient) !void {
        return self.ensureEndpointFor(dial_host.literalFamily(self.host) orelse .ip4);
    }

    /// SONNY-6494: an endpoint bound to `family` (0.0.0.0:0 or [::]:0); the
    /// vendored quic endpoint sends from one socket of one family.
    fn ensureEndpointFor(self: *GeodeClient, family: dial_host.Family) !void {
        if (self.endpoint) |ep| {
            if (self.endpoint_family == family) return;
            if (self.conn != null) return error.AlreadyConnected;
            quic.endpointDeinit(ep);
            self.endpoint = null;
            if (self.ca_chain_der) |owned| {
                ca_bundle.deinit(self.allocator, owned);
                self.ca_chain_der = null;
            }
            if (self.client_identity) |*owned| {
                owned.deinit(self.allocator);
                self.client_identity = null;
            }
        }

        const chain = if (self.ca_cert_path) |path| try ca_bundle.load(self.allocator, path) else null;
        errdefer if (chain) |owned| ca_bundle.deinit(self.allocator, owned);
        // SONNY-6457: the client certificate goes in the client TLS fields
        // (client_identity.apply); a cert_path would make the endpoint a server.
        var identity = try client_identity.load(self.allocator, self.client_cert_path, self.client_key_path);
        errdefer if (identity) |*owned| owned.deinit(self.allocator);

        var cfg = quic.QuicConfig{
            .version = .v1,
            .alpn = &[_][]const u8{"geode/1"},
            .cc = .cubic,
            .enable_datagram = false,
            .enable_spin_bit = false,
            .grease = true,
            .compatible_vn = false,
            .enable_retry = false,
            .token_secret = null,
            .token_expiry_ms = 60000,
            .enable_pacing = false,
            .max_datagram_size = 1200,
            .max_idle_timeout_ms = 30000,
            .max_udp_payload = 1350,
            .cert_path = null,
            .key_path = null,
            .ca_path = self.ca_cert_path,
            .inline_ca_chain_der = chain,
            .allow_insecure = self.insecure,
            .aead_confidentiality_limit_override = null,
            .aead_integrity_limit_override = null,
            .inline_server_cert_der = null,
            .inline_server_priv_p256 = null,
        };

        client_identity.apply(&cfg, identity);

        self.endpoint = try quic.endpointInit(&self.allocator, dial_host.bindAddress(family), &cfg);
        self.endpoint_family = family;
        self.ca_chain_der = chain;
        self.client_identity = identity;
    }

    pub fn connect(self: *GeodeClient) !void {
        // SONNY-6550: port 0 cannot be dialled (a Config built in code
        // skips the DSN parsers' check).
        validate.port(self.port) catch return error.InvalidPort;
        // SONNY-6589: 0 would give up at once (a lenient DSN keeps it).
        validate.timeout(self.timeout_ms) catch return error.InvalidTimeout;
        const transport_tag: obs.Transport = switch (self.transport) {
            .quic => .quic,
            .grpc => .grpc,
        };
        const span = obs.startConnectSpan(self.host, self.port, transport_tag);
        defer span.end(null);
        errdefer obs.markSpanError(span, "");
        switch (self.transport) {
            .quic => try self.connectQuic(),
            .grpc => try self.connectGrpc(),
        }
    }

    /// Connect using QUIC transport.
    fn connectQuic(self: *GeodeClient) !void {
        // SONNY-6494: dial a numeric address from an endpoint of its family;
        // an IPv6 address is bracketed. A name prefers IPv4, else IPv6.
        var dial = try dial_host.resolveAlloc(self.allocator, self.host);
        defer dial.deinit(self.allocator);
        try self.ensureEndpointFor(dial.family);
        const ep = self.endpoint.?;

        const server_addr = try dial.formatAlloc(self.allocator, self.port);
        defer self.allocator.free(server_addr);

        // When skipping verification, empty server_name is acceptable; otherwise pass host for SNI.
        // Always provide SNI; allow_insecure disables verification when requested.
        self.conn = try quic.connect(ep, server_addr, self.server_name orelse dial_host.unbracket(self.host));

        // Wait for handshake confirmation using poll()-based blocking.
        // poll() blocks on epoll/kqueue until packets arrive, so there is no
        // need for an additional sleep between iterations.
        const timeout_ns: u64 = @as(u64, self.timeout_ms) * std.time.ns_per_ms;
        const start = nowNs();
        while (true) {
            const remaining = remainingMs(start, timeout_ns);
            if (remaining == 0) break;
            quic.poll(ep, @intCast(@min(remaining, 100))) catch {};
            if (quic.isHandshakeConfirmed(self.conn.?)) return;
        }

        return error.ConnectionTimeout;
    }

    /// Connect using gRPC transport.
    fn connectGrpc(self: *GeodeClient) !void {
        var grpc_cfg = grpc.GrpcConfig.init();
        _ = grpc_cfg.withHost(self.host);
        _ = grpc_cfg.withPort(self.port);
        _ = grpc_cfg.withInsecure(self.insecure);
        _ = grpc_cfg.withTls(self.tls orelse !self.insecure);
        _ = grpc_cfg.withTimeout(self.timeout_ms);

        self.grpc_client = grpc.GrpcClient.init(self.allocator, grpc_cfg);
        // SONNY-6617: the TCP connect gives up after timeout_ms, as the QUIC
        // handshake does.
        self.grpc_client.?.connect() catch |err| return switch (err) {
            error.Timeout => error.ConnectionTimeout,
            else => err,
        };
    }

    pub fn openStream(self: *GeodeClient) !void {
        // gRPC doesn't need explicit stream opening
        if (self.transport == .grpc) return;

        if (self.conn == null) return error.NotConnected;
        if (self.stream_id != null) return;

        const sid = try quic.openStream(self.conn.?, true);
        self.stream_id = sid;
    }

    /// Close the current QUIC stream so the next send opens a fresh stream.
    pub fn closeStream(self: *GeodeClient) void {
        if (self.transport == .grpc) return;
        if (self.conn) |conn| {
            if (self.stream_id) |sid| {
                quic.closeStream(conn, sid, 0) catch {};
                self.stream_id = null;
            }
        }
        self.recv_buffer.items.len = 0;
        self.recv_offset = 0;
    }

    /// Expose transport polling for callers that need to drive keepalives.
    pub fn pollTransport(self: *GeodeClient, timeout_ms: u32) void {
        self.poll(timeout_ms);
    }

    fn poll(self: *GeodeClient, timeout_ms: u32) void {
        if (self.endpoint) |ep| {
            quic.poll(ep, @intCast(timeout_ms)) catch {};
        }
    }

    const remainingMs = deadline.remainingMs;

    fn writeAll(self: *GeodeClient, data: []const u8, fin: bool) !void {
        if (self.conn == null or self.stream_id == null) return error.NoStream;
        var written: usize = 0;

        // PERF-002: Use poll()-based blocking instead of sleep-based polling.
        // quic.poll() uses epoll/kqueue internally, so it returns as soon as
        // the transport is ready rather than sleeping a fixed duration.
        // SONNY-6617: the client's timeout (a fixed 30 s before).
        const write_timeout_ns: u64 = @as(u64, self.timeout_ms) * std.time.ns_per_ms;
        const start = nowNs();

        while (written < data.len or (fin and data.len == 0)) {
            const remaining = remainingMs(start, write_timeout_ns);
            if (remaining == 0) return error.WriteError;

            const slice = data[written..];
            const n = quic.writeStream(self.conn.?, self.stream_id.?, slice, fin and written + slice.len == data.len) catch |err| switch (err) {
                error.KeysNotReady, error.FlowControlBlocked, error.WouldBlock, error.OutOfStreams => blk: {
                    // Block in poll() until the transport is ready, up to remaining timeout
                    self.poll(@min(remaining, 10));
                    break :blk 0;
                },
                else => return err,
            };

            if (n == 0) {
                self.poll(@min(remaining, 10));
                continue;
            }

            written += n;
            if (written >= data.len) break;
        }
    }

    /// Send a protobuf message with 4-byte big-endian length prefix.
    pub fn sendProto(self: *GeodeClient, msg: proto.QuicClientMessage) !void {
        switch (self.transport) {
            .quic => {
                if (self.stream_id == null) try self.openStream();

                const payload = try proto.encodeWithLengthPrefix(self.allocator, msg);
                defer self.allocator.free(payload);

                try self.writeAll(payload, false);
            },
            .grpc => {
                if (self.grpc_client) |*gc| {
                    try gc.sendProto(msg);
                } else {
                    return error.NotConnected;
                }
            },
        }
    }

    /// Send an already-framed QUIC packet payload over the active QUIC stream.
    pub fn sendRawFramed(self: *GeodeClient, data: []const u8) !void {
        if (self.transport != .quic) return error.UnsupportedTransport;
        if (self.stream_id == null) try self.openStream();
        try self.writeAll(data, false);
    }

    /// Receive a protobuf message with 4-byte big-endian length prefix.
    pub fn receiveProto(self: *GeodeClient, timeout_ms: u64) !proto.QuicServerMessage {
        switch (self.transport) {
            .quic => return try self.receiveProtoQuic(timeout_ms),
            .grpc => {
                if (self.grpc_client) |*gc| {
                    // SONNY-6617: the gRPC read waited until the server
                    // answered or closed.
                    return gc.receiveProtoTimeout(timeout_ms) catch |err| switch (err) {
                        error.Timeout => error.ReceiveTimeout,
                        else => err,
                    };
                } else {
                    return error.NotConnected;
                }
            },
        }
    }

    /// Receive a raw QUIC frame body (without the 4-byte length prefix).
    pub fn receiveRawFrame(self: *GeodeClient, allocator: std.mem.Allocator, timeout_ms: u64) ![]u8 {
        if (self.transport != .quic) return error.UnsupportedTransport;
        const framed = try self.receiveFramedPayloadQuic(timeout_ms);
        defer self.finishReceiveFramedPayload(framed.total_len);
        return try allocator.dupe(u8, framed.payload);
    }

    /// Read raw bytes from the active QUIC stream without interpreting a length
    /// prefix. This is used by administrative flows like remote backups that
    /// switch from framed protobuf control messages to raw byte streaming.
    pub fn receiveRawBytes(self: *GeodeClient, dest: []u8, timeout_ms: u64) !usize {
        if (self.transport != .quic) return error.UnsupportedTransport;
        if (self.conn == null or self.stream_id == null) return error.NoStream;
        if (dest.len == 0) return 0;

        if (self.recv_offset > self.recv_buffer.items.len / 2) {
            self.compactRecvBuffer();
        }

        if (self.recvAvailable() > 0) {
            const available = self.recv_buffer.items[self.recv_offset..];
            const copied = @min(dest.len, available.len);
            @memcpy(dest[0..copied], available[0..copied]);
            self.recv_offset += copied;
            if (self.recv_offset == self.recv_buffer.items.len) {
                self.recv_buffer.items.len = 0;
                self.recv_offset = 0;
            }
            return copied;
        }

        const timeout_ns: u64 = timeout_ms * std.time.ns_per_ms;
        const start = nowNs();

        while (true) {
            const remaining = remainingMs(start, timeout_ns);
            if (remaining == 0) return error.ReceiveTimeout;

            const n = quic.readStream(self.conn.?, self.stream_id.?, dest) catch |err| switch (err) {
                error.WouldBlock => blk: {
                    self.poll(@min(remaining, 100));
                    break :blk 0;
                },
                error.InvalidStream => return error.NoStream,
            };

            if (n > 0) return n;
            self.poll(@min(remaining, 100));
        }
    }

    /// Return the number of unconsumed bytes in the receive buffer.
    fn recvAvailable(self: *const GeodeClient) usize {
        return self.recv_buffer.items.len - self.recv_offset;
    }

    /// Compact the receive buffer by shifting unconsumed data to the front.
    /// Called when recv_offset exceeds half the buffer length to amortize copy cost.
    fn compactRecvBuffer(self: *GeodeClient) void {
        if (self.recv_offset == 0) return;
        const remaining = self.recv_buffer.items.len - self.recv_offset;
        if (remaining > 0) {
            std.mem.copyForwards(u8, self.recv_buffer.items[0..remaining], self.recv_buffer.items[self.recv_offset..]);
        }
        self.recv_buffer.items.len = remaining;
        self.recv_offset = 0;
    }

    /// Receive a protobuf message using QUIC transport.
    fn receiveProtoQuic(self: *GeodeClient, timeout_ms: u64) !proto.QuicServerMessage {
        const framed = try self.receiveFramedPayloadQuic(timeout_ms);
        defer self.finishReceiveFramedPayload(framed.total_len);
        return try proto.decodeQuicServerMessage(self.allocator, framed.payload);
    }

    fn receiveFramedPayloadQuic(self: *GeodeClient, timeout_ms: u64) !struct {
        payload: []const u8,
        total_len: usize,
    } {
        if (self.conn == null or self.stream_id == null) return error.NoStream;

        // PERF-007: Compact only when offset exceeds half the buffer length (amortized O(1)).
        if (self.recv_offset > self.recv_buffer.items.len / 2) {
            self.compactRecvBuffer();
        }

        const timeout_ns: u64 = timeout_ms * std.time.ns_per_ms;
        const start = nowNs();

        var temp_buf: [4096]u8 = undefined;

        // PERF-001: Use poll()-based blocking instead of sleep-based polling.
        // quic.poll() uses epoll/kqueue internally and blocks until data
        // arrives or the timeout expires, eliminating the 5ms latency floor
        // that sleep-based polling imposed on every read.

        // Read until we have at least 4 bytes for length prefix
        while (self.recvAvailable() < 4) {
            const remaining = remainingMs(start, timeout_ns);
            if (remaining == 0) return error.ReceiveTimeout;

            const n = quic.readStream(self.conn.?, self.stream_id.?, temp_buf[0..]) catch |err| switch (err) {
                error.WouldBlock => blk: {
                    // Block in poll() until data arrives, up to remaining timeout
                    self.poll(@min(remaining, 100));
                    break :blk 0;
                },
                error.InvalidStream => return error.NoStream,
            };

            if (n > 0) {
                if (self.recv_buffer.items.len + n > MAX_RECV_BUFFER_SIZE) {
                    return error.ResponseTooLarge;
                }
                try self.recv_buffer.appendSlice(self.allocator, temp_buf[0..n]);
            } else {
                // No data yet; let poll() block until the transport has data
                self.poll(@min(remaining, 100));
            }
        }

        // Decode length prefix (big-endian u32)
        const msg_len = proto.decodeLengthPrefix(self.recv_buffer.items[self.recv_offset..][0..4]) catch return error.InvalidMessage;

        // SECURITY: Check message size
        if (msg_len > MAX_RECV_BUFFER_SIZE - 4) {
            return error.ResponseTooLarge;
        }

        const total_len: usize = 4 + @as(usize, msg_len);

        // Read until we have the complete message
        while (self.recvAvailable() < total_len) {
            const remaining = remainingMs(start, timeout_ns);
            if (remaining == 0) return error.ReceiveTimeout;

            const n = quic.readStream(self.conn.?, self.stream_id.?, temp_buf[0..]) catch |err| switch (err) {
                error.WouldBlock => blk: {
                    self.poll(@min(remaining, 100));
                    break :blk 0;
                },
                error.InvalidStream => return error.NoStream,
            };

            if (n > 0) {
                if (self.recv_buffer.items.len + n > MAX_RECV_BUFFER_SIZE) {
                    return error.ResponseTooLarge;
                }
                try self.recv_buffer.appendSlice(self.allocator, temp_buf[0..n]);
            } else {
                self.poll(@min(remaining, 100));
            }
        }

        // Decode the protobuf message
        return .{
            .payload = self.recv_buffer.items[self.recv_offset + 4 .. self.recv_offset + total_len],
            .total_len = total_len,
        };
    }

    fn finishReceiveFramedPayload(self: *GeodeClient, total_len: usize) void {
        // PERF-007: Advance read cursor instead of shifting data.
        self.recv_offset += total_len;

        // Reset buffer when fully consumed to reclaim memory.
        if (self.recv_offset == self.recv_buffer.items.len) {
            self.recv_buffer.items.len = 0;
            self.recv_offset = 0;
        }
    }

    /// Attempt to read a complete buffered protobuf message without waiting for more data.
    /// Returns null when no full message is buffered yet.
    pub fn tryReceiveBufferedProto(self: *GeodeClient) !?proto.QuicServerMessage {
        if (self.recvAvailable() < 4) return null;

        const msg_len = proto.decodeLengthPrefix(self.recv_buffer.items[self.recv_offset..][0..4]) catch return null;
        const total_len: usize = 4 + @as(usize, msg_len);

        if (self.recvAvailable() < total_len) return null;

        const msg_data = self.recv_buffer.items[self.recv_offset + 4 .. self.recv_offset + total_len];
        const msg = try proto.decodeQuicServerMessage(self.allocator, msg_data);

        // PERF-007: Advance read cursor instead of shifting data.
        self.recv_offset += total_len;

        // Reset buffer when fully consumed to reclaim memory.
        if (self.recv_offset == self.recv_buffer.items.len) {
            self.recv_buffer.items.len = 0;
            self.recv_offset = 0;
        }

        return msg;
    }

    /// Send HELLO and store session_id from response.
    pub fn sendHello(self: *GeodeClient) !void {
        // tenant_id (field 3) and role (field 8) ride the HELLO only when
        // set so single-tenant / non-FLE connections send absent fields
        // (GAP-0841). encodeString omits empty/absent optional strings.
        var hello_req = proto.HelloRequest{
            .username = self.username,
            .password = self.password,
            .tenant_id = self.tenant,
            .graph = self.graph,
            .role = self.role,
        };
        if (self.hello_name) |v| hello_req.client_name = v;
        if (self.hello_ver) |v| hello_req.client_version = v;
        if (self.conformance) |v| hello_req.wanted_conformance = v;
        try self.sendProto(.{ .hello = hello_req });

        // Wait for hello response
        var response = try self.receiveProto(self.timeout_ms);
        defer response.deinit(self.allocator);
        if (response.hello) |hello| {
            if (hello.success) {
                // Store session ID, freeing any previous one first
                if (hello.session_id.len > 0) {
                    if (self.session_id.len > 0) {
                        std.crypto.secureZero(u8, @constCast(self.session_id));
                        self.allocator.free(self.session_id);
                    }
                    self.session_id = try self.allocator.dupe(u8, hello.session_id);
                }
            } else {
                return error.AuthenticationFailed;
            }
        } else {
            return error.InvalidResponse;
        }
    }

    /// Execute a GQL query and return the result.
    /// Context for `queryAsync`. The caller owns allocation; must
    /// outlive the submitted task (stack-allocated + waited on is fine).
    pub const AsyncQueryCtx = struct {
        client: *GeodeClient,
        gql: []const u8,
        params: ?std.StringHashMapUnmanaged([]const u8),
        result: *?QueryResult,
        err: *?anyerror,

        fn run(raw: *anyopaque, _: *tp.TaskContext) void {
            const self: *AsyncQueryCtx = @ptrCast(@alignCast(raw));
            const r = self.client.query(self.gql, self.params) catch |e| {
                self.err.* = e;
                return;
            };
            self.result.* = r;
        }
    };

    /// Submit a query to run asynchronously on the runner's blocking
    /// lane (falls back to default lane if none is configured).
    /// Returns a task handle the caller can `runner.wait(handle)` on.
    /// The `ctx` allocation MUST outlive the task.
    pub fn queryAsync(
        self: *GeodeClient,
        runner: *executor_mod.Executor,
        ctx: *AsyncQueryCtx,
    ) !tp.TaskHandle {
        _ = self;
        return runner.submit(AsyncQueryCtx.run, ctx, .blocking) catch |e| switch (e) {
            error.BlockingLaneDisabled => runner.submit(AsyncQueryCtx.run, ctx, .default),
            else => return e,
        };
    }

    /// Run N queries across the runner's blocking lane in parallel.
    /// Returns results in submission order. On the first query failure,
    /// returns `error.QueryFailed` (remaining queries have still run).
    ///
    /// LIMITATION: all tasks share `self`, which is a single connection.
    /// If the Geode protocol does not multiplex queries on a single
    /// stream, tasks will serialize on the stream mutex — parallelism
    /// here is bounded by the protocol's stream semantics, NOT by the
    /// number of blocking-lane workers. For true parallelism, use a
    /// connection pool and call `queryAsync` per pooled client.
    pub fn queryBatchParallel(
        self: *GeodeClient,
        runner: *executor_mod.Executor,
        queries: []const []const u8,
        results: []QueryResult,
    ) !void {
        if (results.len < queries.len) return error.BufferTooSmall;
        if (queries.len == 0) return;

        const Slot = struct {
            client: *GeodeClient,
            gql: []const u8,
            result: *QueryResult,
            err: std.atomic.Value(u32), // 0 = ok, 1 = error

            fn run(raw: *anyopaque, _: *tp.TaskContext) void {
                const s: *@This() = @ptrCast(@alignCast(raw));
                const r = s.client.query(s.gql, null) catch {
                    s.err.store(1, .release);
                    return;
                };
                s.result.* = r;
            }
        };

        const slots = try self.allocator.alloc(Slot, queries.len);
        defer self.allocator.free(slots);

        var wg = runner.waitGroup();

        for (queries, 0..) |gql, i| {
            slots[i] = .{
                .client = self,
                .gql = gql,
                .result = &results[i],
                .err = std.atomic.Value(u32).init(0),
            };
            _ = runner.pool.submit(Slot.run, &slots[i], .{
                .lane = .blocking,
                .backpressure = .block,
                .wait_group = &wg,
            }) catch |e| switch (e) {
                error.BlockingLaneDisabled => {
                    _ = try runner.pool.submit(Slot.run, &slots[i], .{
                        .lane = .default,
                        .backpressure = .block,
                        .wait_group = &wg,
                    });
                },
                else => return e,
            };
        }

        wg.wait();

        for (slots) |s| {
            if (s.err.load(.acquire) != 0) return error.QueryFailed;
        }
    }

    /// Automatically generates a UUID v4 request ID for tracing.
    /// The caller may pass an explicit request_id; if null, one is generated.
    pub fn query(self: *GeodeClient, gql: []const u8, params: ?std.StringHashMapUnmanaged([]const u8)) !QueryResult {
        const span = obs.startQuerySpan(gql, "EXECUTE");
        defer span.end(null);
        errdefer obs.markSpanError(span, "");
        const request_id = try self.generateRequestId();

        var execute = proto.ExecuteRequest{
            .session_id = self.session_id,
            .query = gql,
            .request_id = request_id,
        };

        // Copy parameters if provided
        if (params) |p| {
            var iter = p.iterator();
            while (iter.next()) |entry| {
                // Convert string parameters to proto.Value
                const value = proto.Value{ .string_val = entry.value_ptr.* };
                try execute.addParam(self.allocator, entry.key_ptr.*, value);
            }
        }
        defer execute.deinit(self.allocator);

        const msg = proto.QuicClientMessage{
            .execute = execute,
        };
        try self.sendProto(msg);

        var result = QueryResult{
            .allocator = self.allocator,
            .columns = .empty,
            .rows = .empty,
            .err = null,
        };
        errdefer result.deinit();

        // SONNY-6617: the first answer waits the client's timeout (a fixed
        // 30 s before); a later page at most 5 s, or the timeout if shorter.
        var timeout_ms: u64 = self.timeout_ms;
        while (true) {
            var response = try self.receiveProto(timeout_ms);
            defer response.deinit(self.allocator);

            const expect_more = try self.appendQueryResponse(&result, response);
            if (!expect_more) {
                return result;
            }

            // Follow-up frames for the same query should already be queued or
            // arrive quickly after the initial schema response.
            timeout_ms = @min(@as(u64, self.timeout_ms), 5000);
        }
    }

    fn appendQueryResponse(self: *GeodeClient, result: *QueryResult, response: proto.QuicServerMessage) !bool {
        if (response.execute) |exec| {
            return try self.appendExecutionResponse(result, exec);
        }

        if (response.pull) |pull| {
            if (pull.response) |exec| {
                return try self.appendExecutionResponse(result, exec);
            }
            return false;
        }

        return error.InvalidResponse;
    }

    fn appendExecutionResponse(self: *GeodeClient, result: *QueryResult, exec: proto.ExecutionResponse) !bool {
        if (exec.err) |err| {
            result.err = try copyProtoError(self.allocator, err);
            return false;
        }

        if (exec.schema) |schema| {
            for (schema.columns.items) |col| {
                try result.columns.append(self.allocator, try self.allocator.dupe(u8, col.name));
            }
        }

        if (exec.page) |page| {
            for (page.rows.items) |row| {
                var row_values: std.ArrayListUnmanaged(proto.Value) = .empty;
                errdefer {
                    for (row_values.items) |*value| {
                        value.deinit(self.allocator);
                    }
                    row_values.deinit(self.allocator);
                }

                for (row.values.items) |val| {
                    try row_values.append(self.allocator, try copyValue(self.allocator, val));
                }
                try result.rows.append(self.allocator, row_values);
            }
            return !page.final;
        }

        // Status-only responses (e.g. CREATE/UPDATE) complete on the first
        // frame. A schema-only response expects at least one follow-up page.
        return exec.schema != null;
    }

    /// Begin a transaction.
    pub fn begin(self: *GeodeClient) ![]const u8 {
        const span = obs.startBeginSpan();
        defer span.end(null);
        errdefer obs.markSpanError(span, "");
        const msg = proto.QuicClientMessage{
            .begin = proto.BeginRequest{
                .read_only = false,
                .session_id = self.session_id,
            },
        };
        try self.sendProto(msg);

        var response = try self.receiveProto(self.timeout_ms);
        defer response.deinit(self.allocator);
        if (response.begin) |begin_resp| {
            if (begin_resp.tx_id.len > 0) {
                return try self.allocator.dupe(u8, begin_resp.tx_id);
            }
        }
        return error.InvalidResponse;
    }

    /// Commit the current transaction.
    pub fn commit(self: *GeodeClient) !void {
        const span = obs.startCommitSpan();
        defer span.end(null);
        errdefer obs.markSpanError(span, "");
        const msg = proto.QuicClientMessage{
            .commit = proto.CommitRequest{ .session_id = self.session_id },
        };
        try self.sendProto(msg);

        var response = try self.receiveProto(self.timeout_ms);
        defer response.deinit(self.allocator);
        if (response.commit) |commit_resp| {
            if (!commit_resp.success) {
                return error.CommitFailed;
            }
        } else {
            return error.InvalidResponse;
        }
    }

    /// Rollback the current transaction.
    pub fn rollback(self: *GeodeClient) !void {
        const span = obs.startRollbackSpan();
        defer span.end(null);
        errdefer obs.markSpanError(span, "");
        const msg = proto.QuicClientMessage{
            .rollback = proto.RollbackRequest{ .session_id = self.session_id },
        };
        try self.sendProto(msg);

        var response = try self.receiveProto(self.timeout_ms);
        defer response.deinit(self.allocator);
        if (response.rollback) |rollback_resp| {
            if (!rollback_resp.success) {
                return error.RollbackFailed;
            }
        } else {
            return error.InvalidResponse;
        }
    }

    /// Ping the server.
    pub fn ping(self: *GeodeClient) !bool {
        const span = obs.startPingSpan();
        defer span.end(null);
        errdefer obs.markSpanError(span, "");
        const msg = proto.QuicClientMessage{
            .ping = proto.PingRequest{},
        };
        try self.sendProto(msg);

        var response = try self.receiveProto(self.timeout_ms);
        defer response.deinit(self.allocator);
        if (response.ping) |ping_resp| {
            return ping_resp.ok;
        }
        return false;
    }
};

/// Result of a query execution.
pub const QueryResult = struct {
    allocator: std.mem.Allocator,
    columns: std.ArrayListUnmanaged([]const u8) = .empty,
    rows: std.ArrayListUnmanaged(std.ArrayListUnmanaged(proto.Value)) = .empty,
    err: ?proto.ProtoError,

    pub fn deinit(self: *QueryResult) void {
        for (self.rows.items) |*row| {
            for (row.items) |*value| {
                value.deinit(self.allocator);
            }
            row.deinit(self.allocator);
        }
        self.rows.deinit(self.allocator);
        for (self.columns.items) |col| {
            self.allocator.free(col);
        }
        self.columns.deinit(self.allocator);
        if (self.err) |*err| {
            err.deinit(self.allocator);
        }
    }

    pub fn hasError(self: *const QueryResult) bool {
        return self.err != null;
    }

    pub fn errorMessage(self: *const QueryResult) ?[]const u8 {
        if (self.err) |e| {
            return e.message;
        }
        return null;
    }
};

fn copyValue(allocator: std.mem.Allocator, value: proto.Value) !proto.Value {
    var copy = value;
    if (value.string_val) |s| {
        copy.string_val = try allocator.dupe(u8, s);
    }
    return copy;
}

fn copyProtoError(allocator: std.mem.Allocator, err: proto.ProtoError) !proto.ProtoError {
    return .{
        .code = try allocator.dupe(u8, err.code),
        .message = try allocator.dupe(u8, err.message),
        .error_type = try allocator.dupe(u8, err.error_type),
        .anchor = try allocator.dupe(u8, err.anchor),
    };
}

/// Helper function to execute a query.
/// Opens a connection, sends HELLO, executes the query, and returns the result.
pub fn executeQuery(
    allocator: std.mem.Allocator,
    host: []const u8,
    port: u16,
    gql: []const u8,
    params: ?std.StringHashMapUnmanaged([]const u8),
    insecure: bool,
    username: []const u8,
    password: []const u8,
) !QueryResult {
    var client = try GeodeClient.init(allocator, host, port, insecure, username, password);
    defer client.deinit();

    try client.connect();
    try client.sendHello();

    return try client.query(gql, params);
}

// =============================================================================
// Unit Tests for Protobuf Encoding
// =============================================================================

test "proto encoding: HelloRequest encodes correctly" {
    const allocator = std.testing.allocator;
    const msg = proto.QuicClientMessage{
        .hello = proto.HelloRequest{
            .username = "test_user",
            .password = "test_pass",
            .tenant_id = "",
        },
    };
    const encoded = try proto.encodeWithLengthPrefix(allocator, msg);
    defer allocator.free(encoded);

    // Verify length prefix is present (4 bytes)
    try std.testing.expect(encoded.len >= 4);

    // Verify length prefix is correct
    const length = proto.decodeLengthPrefix(encoded[0..4]) catch unreachable;
    try std.testing.expectEqual(encoded.len - 4, @as(usize, length));
}

test "proto encoding: ExecuteRequest encodes query correctly" {
    const allocator = std.testing.allocator;
    var execute = proto.ExecuteRequest.init();
    defer execute.deinit(allocator);
    execute.session_id = "session123";
    execute.query = "RETURN 1 AS x";

    const msg = proto.QuicClientMessage{
        .execute = execute,
    };
    const encoded = try proto.encodeWithLengthPrefix(allocator, msg);
    defer allocator.free(encoded);

    try std.testing.expect(encoded.len >= 4);
}

test "proto decoding: length prefix decodes correctly" {
    // Test big-endian encoding of length 256 (0x00000100)
    const data = [_]u8{ 0x00, 0x00, 0x01, 0x00 };
    const length = try proto.decodeLengthPrefix(&data);
    try std.testing.expectEqual(@as(u32, 256), length);
}

test "proto decoding: length prefix insufficient data" {
    const data = [_]u8{ 0x00, 0x00, 0x01 }; // Only 3 bytes
    const result = proto.decodeLengthPrefix(&data);
    try std.testing.expectError(error.InsufficientData, result);
}

// =============================================================================
// Security Tests - Receive Buffer Size Limit (CWE-400)
// =============================================================================

test "MAX_RECV_BUFFER_SIZE constant is defined" {
    // Verify the constant exists and has a reasonable value
    try std.testing.expect(MAX_RECV_BUFFER_SIZE > 0);
    try std.testing.expectEqual(@as(usize, 16 * 1024 * 1024), MAX_RECV_BUFFER_SIZE);
}

test "MAX_RECV_BUFFER_SIZE is 16MB" {
    // Verify the specific limit matches documentation
    const expected_mb: usize = 16;
    const expected_bytes = expected_mb * 1024 * 1024;
    try std.testing.expectEqual(expected_bytes, MAX_RECV_BUFFER_SIZE);
}

// =============================================================================
// Transport Abstraction Tests
// =============================================================================

test "GeodeClient.init creates QUIC transport by default" {
    const allocator = std.testing.allocator;
    var client = try GeodeClient.init(allocator, "localhost", 3141, false, "", "");
    defer client.deinit();

    try std.testing.expectEqual(Transport.quic, client.transport);
}

test "GeodeClient.initWithTransport creates correct transport" {
    const allocator = std.testing.allocator;

    // QUIC transport
    var quic_client = try GeodeClient.initWithTransport(allocator, "localhost", 3141, false, "", "", .quic);
    defer quic_client.deinit();
    try std.testing.expectEqual(Transport.quic, quic_client.transport);

    // gRPC transport
    var grpc_client = try GeodeClient.initWithTransport(allocator, "localhost", 50051, false, "", "", .grpc);
    defer grpc_client.deinit();
    try std.testing.expectEqual(Transport.grpc, grpc_client.transport);
}

test "GeodeClient.initFromConfig creates client from Config" {
    const allocator = std.testing.allocator;

    // QUIC config
    var quic_cfg = config.Config.init();
    quic_cfg.host = "db.example.com";
    quic_cfg.port = 3141;
    quic_cfg.transport = .quic;

    var quic_client = try GeodeClient.initFromConfig(allocator, quic_cfg);
    defer quic_client.deinit();

    try std.testing.expectEqualStrings("db.example.com", quic_client.host);
    try std.testing.expectEqual(@as(u16, 3141), quic_client.port);
    try std.testing.expectEqual(Transport.quic, quic_client.transport);

    // gRPC config
    var grpc_cfg = config.Config.init();
    grpc_cfg.host = "grpc.example.com";
    grpc_cfg.port = 50051;
    grpc_cfg.transport = .grpc;
    grpc_cfg.username = "admin";
    grpc_cfg.password = "secret";

    var grpc_client = try GeodeClient.initFromConfig(allocator, grpc_cfg);
    defer grpc_client.deinit();

    try std.testing.expectEqualStrings("grpc.example.com", grpc_client.host);
    try std.testing.expectEqual(@as(u16, 50051), grpc_client.port);
    try std.testing.expectEqual(Transport.grpc, grpc_client.transport);
    try std.testing.expectEqualStrings("admin", grpc_client.username);
    try std.testing.expectEqualStrings("secret", grpc_client.password);
}

test "Transport enum values are correct" {
    try std.testing.expectEqual(config.Transport.quic, Transport.quic);
    try std.testing.expectEqual(config.Transport.grpc, Transport.grpc);
}
