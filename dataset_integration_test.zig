// Dataset integration tests for Zig client
// Tests the migration system and all extended type features

const std = @import("std");
const testing = std.testing;
const client = @import("client.zig");

const test_timeout = 30 * std.time.ns_per_s;

// Helper to load migration files
fn loadMigration(conn: *client.Connection, allocator: std.mem.Allocator, path: []const u8) !void {
    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    const content = try file.readToEndAlloc(allocator, 10 * 1024 * 1024); // 10MB max
    defer allocator.free(content);

    // Split by semicolons and execute each statement
    var iter = std.mem.split(u8, content, ";");
    while (iter.next()) |statement| {
        const trimmed = std.mem.trim(u8, statement, " \n\r\t");
        if (trimmed.len == 0) continue;
        if (std.mem.startsWith(u8, trimmed, "--")) continue;

        // Execute statement
        var stmt_with_semi = try allocator.alloc(u8, trimmed.len + 1);
        defer allocator.free(stmt_with_semi);
        std.mem.copy(u8, stmt_with_semi[0..trimmed.len], trimmed);
        stmt_with_semi[trimmed.len] = ';';

        _ = conn.query(stmt_with_semi) catch |err| {
            // Skip expected errors for comments, empty statements
            if (err != error.EmptyQuery) {
                std.debug.print("Migration statement failed: {s}\n", .{trimmed});
                return err;
            }
        };
    }
}

test "load dataset migrations" {
    const allocator = testing.allocator;

    // Connect to server
    var conn = try client.connect(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
        .use_quic = true,
    });
    defer conn.close();

    // Load migrations in order
    const migrations = [_][]const u8{
        "../../migrations/001_social_network_schema.gql",
        "../../migrations/002_social_network_data.gql",
        "../../migrations/003_social_network_relationships.gql",
        "../../migrations/004_social_network_events_products.gql",
    };

    for (migrations) |migration| {
        std.debug.print("Loading migration: {s}\n", .{migration});
        try loadMigration(&conn, allocator, migration);
    }

    // Verify data was loaded
    const result = try conn.query("MATCH (n) RETURN count(n) AS count");
    defer result.deinit();

    try testing.expect(result.rows.len > 0);
    const count = result.rows[0].get("count").?.asInt();
    try testing.expect(count >= 100);
}

test "network types - IP address operations" {
    const allocator = testing.allocator;

    var conn = try client.connect(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
        .use_quic = true,
    });
    defer conn.close();

    // Test IP private check
    {
        const result = try conn.query("MATCH (u:User {id: 'user-1'}) RETURN ip_is_private(u.ip_address) AS is_private");
        defer result.deinit();

        try testing.expect(result.rows.len > 0);
        const is_private = result.rows[0].get("is_private").?.asBool();
        try testing.expect(is_private == true);
    }

    // Test subnet containment
    {
        const result = try conn.query("MATCH (d:Device {id: 'device-1'}) RETURN ip_contains(d.subnet, d.ip_address) AS contained");
        defer result.deinit();

        try testing.expect(result.rows.len > 0);
        const contained = result.rows[0].get("contained").?.asBool();
        try testing.expect(contained == true);
    }

    // Test MAC vendor OUI
    {
        const result = try conn.query("MATCH (d:Device {id: 'device-1'}) RETURN mac_vendor_oui(d.mac_address) AS oui");
        defer result.deinit();

        try testing.expect(result.rows.len > 0);
        const oui = result.rows[0].get("oui").?.asArray();
        try testing.expect(oui.len == 3);
    }
}

test "geographic types - distance calculations" {
    const allocator = testing.allocator;

    var conn = try client.connect(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
        .use_quic = true,
    });
    defer conn.close();

    const result = try conn.query("MATCH (l1:Location {name: 'San Francisco'}), (l2:Location {name: 'New York'}) " ++
        "RETURN distance_haversine(l1.coordinates, l2.coordinates) AS distance");
    defer result.deinit();

    try testing.expect(result.rows.len > 0);
    const distance = result.rows[0].get("distance").?.asFloat();
    // Distance should be approximately 4,130,000 meters
    try testing.expect(distance > 4_000_000 and distance < 4_200_000);
}

test "vector similarity search" {
    const allocator = testing.allocator;

    var conn = try client.connect(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
        .use_quic = true,
    });
    defer conn.close();

    const result = try conn.query("MATCH (p1:Post {id: 'post-1'}), (p2:Post) " ++
        "WHERE p1 <> p2 AND vector_cosine_similarity(p1.content_vector, p2.content_vector) > 0.5 " ++
        "RETURN count(p2) AS similar_count");
    defer result.deinit();

    try testing.expect(result.rows.len > 0);
    const similar_count = result.rows[0].get("similar_count").?.asInt();
    try testing.expect(similar_count >= 2);
}

test "currency type operations" {
    const allocator = testing.allocator;

    var conn = try client.connect(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
        .use_quic = true,
    });
    defer conn.close();

    const result = try conn.query("MATCH (c:Company {id: 'comp-1'}) " ++
        "RETURN c.name AS name, c.revenue AS revenue, currency_code(c.revenue) AS currency");
    defer result.deinit();

    try testing.expect(result.rows.len > 0);
    const currency = result.rows[0].get("currency").?.asString();
    try testing.expectEqualStrings("USD", currency);
}

test "graph traversals - relationships" {
    const allocator = testing.allocator;

    var conn = try client.connect(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
        .use_quic = true,
    });
    defer conn.close();

    // Test follower count
    {
        const result = try conn.query("MATCH (u:User)-[:FOLLOWS]->(u2:User {id: 'user-3'}) RETURN count(u) AS followers");
        defer result.deinit();

        try testing.expect(result.rows.len > 0);
        const followers = result.rows[0].get("followers").?.asInt();
        try testing.expect(followers >= 3);
    }

    // Test post count
    {
        const result = try conn.query("MATCH (u:User {id: 'user-1'})-[:POSTED]->(p:Post) RETURN count(p) AS posts");
        defer result.deinit();

        try testing.expect(result.rows.len > 0);
        const posts = result.rows[0].get("posts").?.asInt();
        try testing.expect(posts >= 1);
    }

    // Test event attendance
    {
        const result = try conn.query("MATCH (u:User)-[:ATTENDING]->(e:Event {id: 'event-1'}) RETURN count(u) AS attendees");
        defer result.deinit();

        try testing.expect(result.rows.len > 0);
        const attendees = result.rows[0].get("attendees").?.asInt();
        try testing.expect(attendees >= 2);
    }
}

test "transactions - commit and rollback" {
    const allocator = testing.allocator;

    var conn = try client.connect(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
        .use_quic = true,
    });
    defer conn.close();

    // Test rollback
    {
        try conn.beginTransaction();
        try conn.query("CREATE (:TestNode {id: 'rollback-test', value: 42})");
        try conn.rollback();

        const result = try conn.query("MATCH (n:TestNode {id: 'rollback-test'}) RETURN count(n) AS count");
        defer result.deinit();

        const count = result.rows[0].get("count").?.asInt();
        try testing.expect(count == 0);
    }

    // Test commit
    {
        try conn.beginTransaction();
        try conn.query("CREATE (:TestNode {id: 'commit-test', value: 42})");
        try conn.commit();

        const result = try conn.query("MATCH (n:TestNode {id: 'commit-test'}) RETURN n.value AS value");
        defer result.deinit();

        try testing.expect(result.rows.len > 0);
        const value = result.rows[0].get("value").?.asInt();
        try testing.expect(value == 42);

        // Clean up
        _ = try conn.query("MATCH (n:TestNode {id: 'commit-test'}) DELETE n");
    }
}

test "constraint enforcement" {
    const allocator = testing.allocator;

    var conn = try client.connect(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
        .use_quic = true,
    });
    defer conn.close();

    // Try to violate unique constraint - should fail
    const result = conn.query("CREATE (:User {id: 'test-dup', email: 'alice.johnson@example.com', username: 'test'})");

    // Expect an error
    try testing.expectError(error.ConstraintViolation, result);
}

test "index performance" {
    const allocator = testing.allocator;

    var conn = try client.connect(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
        .use_quic = true,
    });
    defer conn.close();

    const start = std.time.nanoTimestamp();
    const result = try conn.query("MATCH (u:User) WHERE u.email = 'alice.johnson@example.com' RETURN u.username AS username");
    const elapsed = std.time.nanoTimestamp() - start;
    defer result.deinit();

    try testing.expect(result.rows.len > 0);
    const username = result.rows[0].get("username").?.asString();
    try testing.expectEqualStrings("alice_j", username);

    // Should complete quickly with index (< 100ms)
    try testing.expect(elapsed < 100 * std.time.ns_per_ms);
}

test "spatial queries with R-tree index" {
    const allocator = testing.allocator;

    var conn = try client.connect(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
        .use_quic = true,
    });
    defer conn.close();

    // Find events near San Francisco
    const result = try conn.query("MATCH (e:Event) " ++
        "WHERE distance_haversine(e.location, LatLon(37.7749, -122.4194)) < 100000 " ++
        "RETURN count(e) AS nearby_events");
    defer result.deinit();

    try testing.expect(result.rows.len > 0);
    const nearby_events = result.rows[0].get("nearby_events").?.asInt();
    try testing.expect(nearby_events >= 1);
}

test "full-text search" {
    const allocator = testing.allocator;

    var conn = try client.connect(allocator, .{
        .host = "127.0.0.1",
        .port = 3141,
        .use_quic = true,
    });
    defer conn.close();

    const result = try conn.query("MATCH (p:Post) " ++
        "WHERE fulltext_search(p.content, 'graph database') " ++
        "RETURN count(p) AS matches");
    defer result.deinit();

    try testing.expect(result.rows.len > 0);
    const matches = result.rows[0].get("matches").?.asInt();
    try testing.expect(matches >= 1);
}

// CANARY: REQ=REQ-GQL-DATASET-ZIG; FEATURE="DatasetIntegrationZigClient"; ASPECT=Testing; STATUS=TESTED; TEST=dataset_integration_test.zig; BENCH=benchmark_dataset_client.zig; OWNER=client-team; UPDATED=2025-09-29
