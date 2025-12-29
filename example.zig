const std = @import("std");
const client = @import("client.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    std.debug.print("=== Geode Zig Client - Full Features Example ===\n\n", .{});

    // 1. Create client with configuration
    const config = client.Config{
        .host = "127.0.0.1",
        .port = 7567,
        .use_quic = true,
        .use_tls = true,
        .client_name = "geode-zig-example",
        .client_version = "1.0.0",
    };

    var geode_client = client.Client.init(allocator, config);
    defer geode_client.deinit();

    // 2. Connect to server
    std.debug.print("1. Connection:\n", .{});
    try geode_client.connect();
    defer geode_client.disconnect();
    std.debug.print("   ✓ Connected to Geode server\n", .{});

    // 3. Authentication
    std.debug.print("\n2. Authentication:\n", .{});
    try geode_client.login("admin", "P@ssw0rd123!");
    defer geode_client.logout() catch {};
    std.debug.print("   ✓ Logged in as admin\n", .{});

    // 4. User Management
    std.debug.print("\n3. User Management:\n", .{});
    try geode_client.createUser(
        "alice",
        "alice@example.com",
        "P@ssw0rd456!",
        &[_][]const u8{"user"},
    );
    std.debug.print("   ✓ Created user: alice\n", .{});

    // 5. RLS Policy Creation (ABAC)
    std.debug.print("\n4. Row-Level Security (ABAC):\n", .{});
    try geode_client.createRLSPolicy(
        "user_own_documents",
        "documents",
        "default",
        "select",
        "owner_id = current_user_id()",
        null,
        &[_]i64{1}, // user role
    );
    std.debug.print("   ✓ Created RLS policy: user_own_documents\n", .{});

    // 6. Transaction Management
    std.debug.print("\n5. Transactions:\n", .{});
    try geode_client.beginTransaction();
    std.debug.print("   ✓ Transaction started\n", .{});

    // 7. Graph Operations - Create Nodes
    std.debug.print("\n6. Graph Operations:\n", .{});

    // Create person nodes
    var person_props1 = std.StringHashMap(client.Value).init(allocator);
    defer person_props1.deinit();
    try person_props1.put("name", .{ .string = "Alice" });
    try person_props1.put("age", .{ .int = 30 });
    try person_props1.put("email", .{ .string = "alice@example.com" });

    const alice = try geode_client.createNode(
        &[_][]const u8{"Person"},
        person_props1,
    );
    std.debug.print("   ✓ Created Person node: Alice (ID: {})\n", .{alice.id});

    var person_props2 = std.StringHashMap(client.Value).init(allocator);
    defer person_props2.deinit();
    try person_props2.put("name", .{ .string = "Bob" });
    try person_props2.put("age", .{ .int = 25 });

    const bob = try geode_client.createNode(
        &[_][]const u8{"Person"},
        person_props2,
    );
    std.debug.print("   ✓ Created Person node: Bob (ID: {})\n", .{bob.id});

    // Create company node
    var company_props = std.StringHashMap(client.Value).init(allocator);
    defer company_props.deinit();
    try company_props.put("name", .{ .string = "TechCorp" });
    try company_props.put("founded", .{ .int = 2020 });
    try company_props.put("employees", .{ .int = 100 });

    const techcorp = try geode_client.createNode(
        &[_][]const u8{"Company"},
        company_props,
    );
    std.debug.print("   ✓ Created Company node: TechCorp (ID: {})\n", .{techcorp.id});

    // Create edges
    var works_props = std.StringHashMap(client.Value).init(allocator);
    defer works_props.deinit();
    try works_props.put("since", .{ .int = 2021 });
    try works_props.put("role", .{ .string = "Engineer" });
    try works_props.put("salary", .{ .decimal = .{ .value = "75000.00", .scale = 2 } });

    const works_edge = try geode_client.createEdge(
        alice.id,
        techcorp.id,
        "WORKS_AT",
        works_props,
    );
    std.debug.print("   ✓ Created WORKS_AT edge (ID: {})\n", .{works_edge.id});

    const knows_edge = try geode_client.createEdge(
        alice.id,
        bob.id,
        "KNOWS",
        null,
    );
    std.debug.print("   ✓ Created KNOWS edge (ID: {})\n", .{knows_edge.id});

    // 8. Pattern Matching
    std.debug.print("\n7. Pattern Matching:\n", .{});
    var match_iter = try geode_client.match(
        "(p:Person)-[:WORKS_AT]->(c:Company)",
        "p.age > 25",
    );
    defer match_iter.close();

    std.debug.print("   ✓ Pattern match results:\n", .{});
    while (try match_iter.next()) |row| {
        if (row.get("p")) |person| {
            if (person.node.properties.get("name")) |name| {
                std.debug.print("     - Person: {s}\n", .{name.string});
            }
        }
    }

    // 9. Graph Algorithms
    std.debug.print("\n8. Graph Algorithms:\n", .{});
    const path = try geode_client.shortestPath(alice.id, bob.id, 5);
    std.debug.print("   ✓ Shortest path: {} nodes, {} edges\n", .{
        path.nodes.len,
        path.edges.len,
    });

    // 10. GQL Queries with ORDER BY and LIMIT
    std.debug.print("\n9. Advanced Queries:\n", .{});
    var query_iter = try geode_client.query(
        "MATCH (p:Person) " ++
            "WHERE p.age > 20 " ++
            "RETURN p.name AS name, p.age AS age " ++
            "ORDER BY p.age DESC " ++
            "LIMIT 10",
        null,
    );
    defer query_iter.close();

    std.debug.print("   ✓ Query results (ordered by age DESC):\n", .{});
    while (try query_iter.next()) |row| {
        if (row.get("name")) |name| {
            if (row.get("age")) |age| {
                std.debug.print("     - {s}, age {}\n", .{ name.string, age.int });
            }
        }
    }

    // 11. Aggregations
    std.debug.print("\n10. Aggregations:\n", .{});
    var agg_iter = try geode_client.query(
        "MATCH (p:Person) " ++
            "RETURN COUNT(p) AS total, " ++
            "AVG(p.age) AS avg_age, " ++
            "MIN(p.age) AS min_age, " ++
            "MAX(p.age) AS max_age, " ++
            "STDEV(p.age) AS stdev_age",
        null,
    );
    defer agg_iter.close();

    if (try agg_iter.next()) |row| {
        if (row.get("total")) |total| {
            std.debug.print("   ✓ Total persons: {}\n", .{total.int});
        }
        if (row.get("avg_age")) |avg| {
            std.debug.print("   ✓ Average age: {s}\n", .{avg.decimal.value});
        }
        if (row.get("min_age")) |min| {
            std.debug.print("   ✓ Min age: {}\n", .{min.int});
        }
        if (row.get("max_age")) |max| {
            std.debug.print("   ✓ Max age: {}\n", .{max.int});
        }
    }

    // 12. GROUP BY Operations
    std.debug.print("\n11. GROUP BY Operations:\n", .{});
    var group_iter = try geode_client.query(
        "MATCH (p:Person)-[:WORKS_AT]->(c:Company) " ++
            "GROUP BY c.name " ++
            "RETURN c.name AS company, COUNT(p) AS employees " ++
            "ORDER BY employees DESC",
        null,
    );
    defer group_iter.close();

    std.debug.print("   ✓ Employees per company:\n", .{});
    while (try group_iter.next()) |row| {
        if (row.get("company")) |company| {
            if (row.get("employees")) |count| {
                std.debug.print("     - {s}: {} employees\n", .{
                    company.string,
                    count.int,
                });
            }
        }
    }

    // 13. WITH Clause
    std.debug.print("\n12. WITH Clause:\n", .{});
    var with_iter = try geode_client.query(
        "MATCH (p:Person) " ++
            "WITH p, p.age * 2 AS double_age " ++
            "WHERE double_age > 50 " ++
            "RETURN p.name AS name, double_age " ++
            "ORDER BY double_age",
        null,
    );
    defer with_iter.close();

    std.debug.print("   ✓ Persons with doubled age > 50:\n", .{});
    while (try with_iter.next()) |row| {
        if (row.get("name")) |name| {
            if (row.get("double_age")) |double_age| {
                std.debug.print("     - {s}: double age = {}\n", .{
                    name.string,
                    double_age.int,
                });
            }
        }
    }

    // 14. OPTIONAL MATCH
    std.debug.print("\n13. OPTIONAL MATCH:\n", .{});
    var optional_iter = try geode_client.query(
        "MATCH (p:Person) " ++
            "OPTIONAL MATCH (p)-[:MANAGES]->(t:Team) " ++
            "RETURN p.name AS name, t.name AS team",
        null,
    );
    defer optional_iter.close();

    std.debug.print("   ✓ Persons and their teams (if any):\n", .{});
    while (try optional_iter.next()) |row| {
        if (row.get("name")) |name| {
            const team = row.get("team");
            if (team != null and team.?.kind != .null) {
                std.debug.print("     - {s} manages {s}\n", .{
                    name.string,
                    team.?.string,
                });
            } else {
                std.debug.print("     - {s} (no team)\n", .{name.string});
            }
        }
    }

    // 15. Set Operations (UNION, INTERSECT, EXCEPT)
    std.debug.print("\n14. Set Operations:\n", .{});
    var union_iter = try geode_client.query(
        "MATCH (p:Person) WHERE p.age > 25 RETURN p.name AS name " ++
            "UNION " ++
            "MATCH (c:Company) WHERE c.founded > 2015 RETURN c.name AS name",
        null,
    );
    defer union_iter.close();

    std.debug.print("   ✓ UNION results:\n", .{});
    while (try union_iter.next()) |row| {
        if (row.get("name")) |name| {
            std.debug.print("     - {s}\n", .{name.string});
        }
    }

    // 16. Commit Transaction
    std.debug.print("\n15. Commit Transaction:\n", .{});
    try geode_client.commit();
    std.debug.print("   ✓ Transaction committed successfully\n", .{});

    // 17. Profile Query
    std.debug.print("\n16. Query Profiling:\n", .{});
    var profile_iter = try geode_client.query(
        "PROFILE MATCH (p:Person)-[:WORKS_AT]->(c:Company) RETURN p.name, c.name",
        null,
    );
    defer profile_iter.close();
    std.debug.print("   ✓ Query profile generated\n", .{});

    // 18. EXPLAIN Query Plan
    std.debug.print("\n17. Query Explanation:\n", .{});
    var explain_iter = try geode_client.query(
        "EXPLAIN MATCH (p:Person)-[:WORKS_AT]->(c:Company) RETURN p.name, c.name",
        null,
    );
    defer explain_iter.close();
    std.debug.print("   ✓ Query plan explained\n", .{});

    std.debug.print("\n=== All Geode Features Demonstrated Successfully ===\n", .{});
}
