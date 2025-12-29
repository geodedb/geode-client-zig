const std = @import("std");

/// Example Zig client demonstrating v0.17.0 features
pub fn main() !void {
    _ = std.heap.page_allocator; // Would be used for actual client connection

    std.debug.print("Geode v0.17.0 Client Examples\n", .{});
    std.debug.print("==============================\n\n", .{});

    // Note: These are example GQL queries demonstrating new features
    // In a real client, you would send these via QUIC to port 3141

    // 1. MATCH with complex patterns
    const match_complex =
        \\MATCH (p:Person {name: 'Alice'})-[k:KNOWS*1..3]->(f:Person)
        \\WHERE f.age > 25 AND EXISTS {
        \\  MATCH (f)-[:WORKS_AT]->(c:Company)
        \\  WHERE c.name = 'TechCorp'
        \\}
        \\OPTIONAL MATCH (p)-[r:RELATED_TO]->(f)
        \\RETURN p.name, f.name, length(k) AS distance
        \\ORDER BY distance, f.name
        \\LIMIT 10
    ;
    std.debug.print("1. Complex MATCH with nested OPTIONAL and filtered paths:\n", .{});
    std.debug.print("{s}\n\n", .{match_complex});

    // 2. DML operations with property management
    const dml_insert =
        \\INSERT (:Person {
        \\  name: 'Bob',
        \\  age: 30,
        \\  email: 'bob@example.com',
        \\  created: timestamp()
        \\})
    ;
    std.debug.print("2. INSERT node with properties:\n", .{});
    std.debug.print("{s}\n\n", .{dml_insert});

    const dml_update =
        \\MATCH (p:Person {name: 'Bob'})
        \\UPDATE p SET p.age = 31, p.updated = timestamp()
        \\RETURN p
    ;
    std.debug.print("3. UPDATE node properties:\n", .{});
    std.debug.print("{s}\n\n", .{dml_update});

    // 3. WHERE with subqueries and advanced predicates
    const where_advanced =
        \\MATCH (p:Person)
        \\WHERE p.age IN [25, 30, 35] AND
        \\      ANY(skill IN p.skills WHERE skill = 'Zig') AND
        \\      EXISTS {
        \\        MATCH (p)-[:FRIENDS_WITH]->(f:Person)
        \\        WHERE f.age > p.age
        \\      }
        \\RETURN p.name, p.age
    ;
    std.debug.print("4. WHERE with IN, ANY, EXISTS predicates:\n", .{});
    std.debug.print("{s}\n\n", .{where_advanced});

    // 4. Graph algorithms as functions
    const graph_algorithms =
        \\MATCH (start:Person {name: 'Alice'}), (end:Person {name: 'Charlie'})
        \\RETURN shortestPath((start)-[*]-(end)) AS path
    ;
    std.debug.print("5. Graph algorithm - shortestPath():\n", .{});
    std.debug.print("{s}\n\n", .{graph_algorithms});

    const pagerank =
        \\MATCH (n:Person)
        \\RETURN n.name, pageRank(n) AS rank
        \\ORDER BY rank DESC
        \\LIMIT 10
    ;
    std.debug.print("6. Graph algorithm - pageRank():\n", .{});
    std.debug.print("{s}\n\n", .{pagerank});

    // 5. Cost-based optimizer hint (when GEODE_ENABLE_CBO=1)
    std.debug.print("7. Cost-Based Optimizer:\n", .{});
    std.debug.print("   Set environment variable GEODE_ENABLE_CBO=1 to enable\n", .{});
    std.debug.print("   The optimizer will automatically choose optimal join orders\n\n", .{});

    // 6. CDC configuration (programmatic)
    std.debug.print("8. CDC Sinks Configuration:\n", .{});
    std.debug.print("   Kafka sink: endpoint='localhost:9092', retry_count=3\n", .{});
    std.debug.print("   Webhook sink: endpoint='https://api.example.com/cdc', retry_count=3\n", .{});
    std.debug.print("   Both support at-least-once delivery with DLQ\n\n", .{});

    // 7. Connection info
    std.debug.print("Connection Details:\n", .{});
    std.debug.print("===================\n", .{});
    std.debug.print("Protocol: QUIC+TLS (mandatory)\n", .{});
    std.debug.print("Default Port: 3141\n", .{});
    std.debug.print("TCP Support: REMOVED in v0.17.0\n", .{});
    std.debug.print("Certificates: Auto-generated if missing\n\n", .{});

    // 8. Example connection code
    std.debug.print("Example connection (pseudo-code):\n", .{});
    std.debug.print("----------------------------------\n", .{});
    const connection_example =
        \\const transport = try QuicTransport.init(allocator, .{
        \\    .address = "127.0.0.1",
        \\    .port = 3141,
        \\    .cert_path = "certs/client.crt", // Optional, auto-generated
        \\    .key_path = "certs/client.key",   // Optional, auto-generated
        \\});
        \\defer transport.deinit();
        \\
        \\try transport.connect();
        \\const response = try transport.sendQuery(query);
    ;
    std.debug.print("{s}\n", .{connection_example});
}

test "v0.17.0 features" {
    // Test that new features compile correctly
    _ = std.testing.allocator; // Would be used for actual allocations

    // Test MATCH pattern structure
    const pattern = struct {
        nodes: []const u8,
        edges: []const u8,
        optional: bool,
        variable_length: bool,
    }{
        .nodes = "Person",
        .edges = "KNOWS",
        .optional = true,
        .variable_length = true,
    };

    try std.testing.expect(pattern.optional == true);
    try std.testing.expect(pattern.variable_length == true);

    // Test DML operation types
    const DMLOp = enum {
        insert,
        update,
        delete,
    };

    const op = DMLOp.insert;
    try std.testing.expect(op == .insert);

    // Test CDC sink configuration
    const CdcSink = enum {
        Kafka,
        Webhook,
    };

    const sink = CdcSink.Kafka;
    try std.testing.expect(sink == .Kafka);
}
