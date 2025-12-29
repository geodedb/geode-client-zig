const std = @import("std");
const quic = @import("../../src/transport/quic.zig");
const protocol = @import("../../src/protocol.zig");

// v0.16.0 Client - QUIC+TLS only, no TCP support
pub const GeodeClient = struct {
    allocator: std.mem.Allocator,
    config: Config,
    transport: ?*quic.QuicTransport,
    connection: ?*quic.QuicConnection,

    pub const Config = struct {
        host: []const u8 = "127.0.0.1",
        port: u16 = 3141, // v0.16.0: Default QUIC port
        page_size: usize = 1000,
        client_name: []const u8 = "geode-zig-client",
        client_version: []const u8 = "0.16.0",
        conformance: []const u8 = "min",
    };

    pub fn init(allocator: std.mem.Allocator, config: Config) GeodeClient {
        return .{
            .allocator = allocator,
            .config = config,
            .transport = null,
            .connection = null,
        };
    }

    pub fn deinit(self: *GeodeClient) void {
        if (self.connection) |conn| {
            conn.close();
            self.allocator.destroy(conn);
        }
        if (self.transport) |t| {
            t.deinit();
            self.allocator.destroy(t);
        }
    }

    pub fn connect(self: *GeodeClient) !void {
        // v0.16.0: QUIC+TLS is mandatory
        const transport_config = quic.QuicTransport.Config{
            .address = self.config.host,
            .port = self.config.port,
            .cert_path = "certs/client.crt",
            .key_path = "certs/client.key",
        };

        self.transport = try self.allocator.create(quic.QuicTransport);
        self.transport.?.* = try quic.QuicTransport.init(self.allocator, transport_config);

        // Connect to server
        self.connection = try self.transport.?.connect(self.config.host, self.config.port);

        // Send HELLO
        const hello = protocol.Message{
            .type = .hello,
            .payload = try std.fmt.allocPrint(self.allocator, "{{\"client_name\":\"{s}\",\"client_ver\":\"{s}\",\"wanted_conformance\":\"{s}\"}}", .{ self.config.client_name, self.config.client_version, self.config.conformance }),
        };
        defer self.allocator.free(hello.payload);

        try self.sendMessage(hello);

        // Read HELLO response
        const response = try self.readMessage();
        defer self.allocator.free(response.payload);

        // Validate successful connection
        if (response.type != .hello_ack) {
            return error.HandshakeFailed;
        }
    }

    pub fn query(self: *GeodeClient, text: []const u8, params: ?std.json.Value) !QueryResult {
        if (self.connection == null) return error.NotConnected;

        // Send RUN_GQL
        const run_gql = protocol.Message{
            .type = .run_gql,
            .payload = try self.formatRunGql(text, params),
        };
        defer self.allocator.free(run_gql.payload);

        try self.sendMessage(run_gql);

        // Read SCHEMA
        const schema_msg = try self.readMessage();
        defer self.allocator.free(schema_msg.payload);

        if (schema_msg.type != .schema) {
            return error.UnexpectedResponse;
        }

        // Parse schema
        const schema = try self.parseSchema(schema_msg.payload);

        return QueryResult{
            .client = self,
            .schema = schema,
            .current_page = null,
            .is_final = false,
        };
    }

    pub fn beginTransaction(self: *GeodeClient) !void {
        const msg = protocol.Message{
            .type = .begin,
            .payload = "{}",
        };
        try self.sendMessage(msg);

        const response = try self.readMessage();
        defer self.allocator.free(response.payload);

        if (response.type != .ack) {
            return error.TransactionBeginFailed;
        }
    }

    pub fn commit(self: *GeodeClient) !void {
        const msg = protocol.Message{
            .type = .commit,
            .payload = "{}",
        };
        try self.sendMessage(msg);

        const response = try self.readMessage();
        defer self.allocator.free(response.payload);

        if (response.type != .ack) {
            return error.CommitFailed;
        }
    }

    pub fn rollback(self: *GeodeClient) !void {
        const msg = protocol.Message{
            .type = .rollback,
            .payload = "{}",
        };
        try self.sendMessage(msg);

        const response = try self.readMessage();
        defer self.allocator.free(response.payload);

        if (response.type != .ack) {
            return error.RollbackFailed;
        }
    }

    fn sendMessage(self: *GeodeClient, msg: protocol.Message) !void {
        const conn = self.connection orelse return error.NotConnected;
        try conn.send(msg.encode());
    }

    fn readMessage(self: *GeodeClient) !protocol.Message {
        const conn = self.connection orelse return error.NotConnected;
        const data = try conn.receive();
        return protocol.Message.decode(data);
    }

    fn formatRunGql(self: *GeodeClient, text: []const u8, params: ?std.json.Value) ![]u8 {
        if (params) |p| {
            return std.fmt.allocPrint(self.allocator, "{{\"text\":\"{s}\",\"params\":{s}}}", .{ text, try std.json.stringify(p, .{}, self.allocator) });
        } else {
            return std.fmt.allocPrint(self.allocator, "{{\"text\":\"{s}\"}}", .{text});
        }
    }

    fn parseSchema(self: *GeodeClient, payload: []const u8) !Schema {
        _ = self;
        _ = payload;
        // Parse JSON schema
        return Schema{ .columns = &[_]Column{} };
    }
};

pub const QueryResult = struct {
    client: *GeodeClient,
    schema: Schema,
    current_page: ?Page,
    is_final: bool,

    pub fn next(self: *QueryResult) !?Page {
        if (self.is_final) return null;

        // Send PULL
        const pull = protocol.Message{
            .type = .pull,
            .payload = try std.fmt.allocPrint(self.client.allocator, "{{\"page_size\":{d}}}", .{self.client.config.page_size}),
        };
        defer self.client.allocator.free(pull.payload);

        try self.client.sendMessage(pull);

        // Read BINDINGS
        const bindings_msg = try self.client.readMessage();
        defer self.client.allocator.free(bindings_msg.payload);

        if (bindings_msg.type != .bindings) {
            return error.UnexpectedResponse;
        }

        // Parse page
        // TODO: Parse JSON bindings
        const page = Page{
            .rows = &[_]Row{},
            .ordered = false,
            .order_keys = &[_][]const u8{},
            .final = false,
        };

        self.is_final = page.final;
        self.current_page = page;

        return page;
    }
};

pub const Schema = struct {
    columns: []const Column,
};

pub const Column = struct {
    name: []const u8,
    type: []const u8,
};

pub const Page = struct {
    rows: []const Row,
    ordered: bool,
    order_keys: []const []const u8,
    final: bool,
};

pub const Row = std.StringHashMap(Value);

pub const Value = union(enum) {
    null: void,
    bool: bool,
    int: i64,
    float: f64,
    string: []const u8,
    array: []const Value,
    object: std.StringHashMap(Value),
};

// Example usage
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // v0.16.0: Connect with QUIC+TLS
    var client = GeodeClient.init(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
    });
    defer client.deinit();

    try client.connect();
    std.debug.print("Connected to Geode v0.16.0 via QUIC+TLS\n", .{});

    // Begin transaction
    try client.beginTransaction();

    // Execute query
    var result = try client.query("RETURN 1 AS x ORDER BY x LIMIT 1", null);

    // Fetch results
    while (try result.next()) |page| {
        for (page.rows) |row| {
            if (row.get("x")) |val| {
                switch (val) {
                    .int => |i| std.debug.print("x = {d}\n", .{i}),
                    else => {},
                }
            }
        }
    }

    // Commit transaction
    try client.commit();

    std.debug.print("Transaction completed successfully\n", .{});
}
