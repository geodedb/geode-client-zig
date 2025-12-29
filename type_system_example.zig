const std = @import("std");
const client = @import("client.zig");

// Example demonstrating extended type system in Geode v0.18.0
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Configure and connect
    const config = client.Config{
        .host = "127.0.0.1",
        .port = 3141, // v0.18.0: QUIC+TLS port
        .use_quic = true,
    };

    var geode = client.Client.init(allocator, config);
    defer geode.deinit();

    try geode.connect();
    defer geode.disconnect();

    std.debug.print("=== Geode Extended Type System Examples (Zig) ===\n\n", .{});

    // 1. Network Types
    std.debug.print("1. Network Types:\n", .{});

    // Create network device
    _ = try geode.query(
        \\CREATE (d:Device {
        \\  hostname: "switch-01",
        \\  ip_address: IpAddr("2001:db8::1"),
        \\  subnet: Subnet("2001:db8::/32"),
        \\  mac_address: Mac("00:11:22:33:44:55")
        \\})
    , null);

    // Query IP containment
    var iter = try geode.query(
        \\MATCH (d:Device)
        \\WHERE ip_contains(Subnet("2001:db8::/32"), d.ip_address)
        \\RETURN d.hostname, ip_family(d.ip_address) AS family
    , null);
    defer iter.close();

    while (try iter.next()) |row| {
        std.debug.print("   Device: {s} (IP family: {s})\n", .{
            row.get("d.hostname").?.string,
            row.get("family").?.string,
        });
    }

    // 2. Geographic Types
    std.debug.print("\n2. Geographic Types:\n", .{});

    // Create locations
    _ = try geode.query(
        \\CREATE (l:Location {
        \\  name: "Zürich",
        \\  coordinates: LatLon(47.3769, 8.5417),
        \\  altitude: LatLonAlt(47.3769, 8.5417, 408.0, "ellipsoid")
        \\})
    , null);

    _ = try geode.query(
        \\CREATE (l:Location {
        \\  name: "Geneva",
        \\  coordinates: LatLon(46.2044, 6.1432)
        \\})
    , null);

    // Calculate distance
    var dist_iter = try geode.query(
        \\MATCH (l1:Location {name: "Zürich"})
        \\MATCH (l2:Location {name: "Geneva"})
        \\RETURN distance_haversine(l1.coordinates, l2.coordinates) AS distance_m
    , null);
    defer dist_iter.close();

    if (try dist_iter.next()) |row| {
        std.debug.print("   Distance Zürich to Geneva: {} meters\n", .{
            row.get("distance_m").?.integer,
        });
    }

    // 3. Vector Types
    std.debug.print("\n3. Vector Types:\n", .{});

    // Create vectors
    _ = try geode.query(
        \\CREATE (v1:Vector {
        \\  name: "vec1",
        \\  data: Vector([1.0, 2.0, 3.0])
        \\})
    , null);

    _ = try geode.query(
        \\CREATE (v2:Vector {
        \\  name: "vec2",
        \\  data: Vector([4.0, 5.0, 6.0])
        \\})
    , null);

    // Calculate dot product
    var vec_iter = try geode.query(
        \\MATCH (v1:Vector {name: "vec1"})
        \\MATCH (v2:Vector {name: "vec2"})
        \\RETURN vector_dot(v1.data, v2.data) AS dot_product,
        \\       vector_l2(v1.data, v2.data) AS l2_distance
    , null);
    defer vec_iter.close();

    if (try vec_iter.next()) |row| {
        std.debug.print("   Dot product: {}\n", .{row.get("dot_product").?.integer});
        std.debug.print("   L2 distance: {d:.6}\n", .{row.get("l2_distance").?.float});
    }

    // 4. Security Types (Hash)
    std.debug.print("\n4. Security Types:\n", .{});

    // Create user with hash
    _ = try geode.query(
        \\CREATE (u:User {
        \\  username: "bob",
        \\  password_hash: Hash("SHA3-256", "abc123def456789...")
        \\})
    , null);

    // Verify hash
    const verify_params = .{
        .hash = "SHA3-256:abc123def456789...",
    };

    var hash_iter = try geode.query(
        \\MATCH (u:User {username: "bob"})
        \\WHERE hash_equals(u.password_hash, Hash("SHA3-256", $hash))
        \\RETURN u.username, hash_alg(u.password_hash) AS alg
    , verify_params);
    defer hash_iter.close();

    if (try hash_iter.next()) |row| {
        std.debug.print("   User {s} verified with {s}\n", .{
            row.get("u.username").?.string,
            row.get("alg").?.string,
        });
    }

    // 5. Financial Types
    std.debug.print("\n5. Financial Types:\n", .{});

    // Create multi-currency transaction
    _ = try geode.query(
        \\CREATE (t:Transaction {
        \\  id: "TXN-002",
        \\  amount: 999.99,
        \\  currency: Currency("EUR")
        \\})
    , null);

    var currency_iter = try geode.query(
        \\MATCH (t:Transaction)
        \\RETURN t.id, t.currency, minor_units(t.currency) AS decimals
    , null);
    defer currency_iter.close();

    while (try currency_iter.next()) |row| {
        std.debug.print("   Transaction {s}: {s} ({} decimal places)\n", .{
            row.get("t.id").?.string,
            row.get("t.currency").?.string,
            row.get("decimals").?.integer,
        });
    }

    // 6. Scientific Types
    std.debug.print("\n6. Scientific Types:\n", .{});

    // Create sensor reading
    _ = try geode.query(
        \\CREATE (r:SensorReading {
        \\  sensor_id: "TEMP-01",
        \\  temperature: Temperature(25.5, "C"),
        \\  pressure: Pressure(101.3, "kPa")
        \\})
    , null);

    var sensor_iter = try geode.query(
        \\MATCH (r:SensorReading)
        \\WHERE r.temperature > Temperature(20, "C")
        \\RETURN r.sensor_id, r.temperature, r.pressure
    , null);
    defer sensor_iter.close();

    while (try sensor_iter.next()) |row| {
        std.debug.print("   Sensor {s}: {s}, {s}\n", .{
            row.get("r.sensor_id").?.string,
            row.get("r.temperature").?.string,
            row.get("r.pressure").?.string,
        });
    }

    // 7. Combined IoT Example
    std.debug.print("\n7. IoT Device Monitoring:\n", .{});

    // Create IoT device
    _ = try geode.query(
        \\CREATE (iot:IoTDevice {
        \\  device_id: "IOT-ZIG-001",
        \\  ip: IpAddr("10.0.1.50"),
        \\  mac: Mac("de:ad:be:ef:00:01"),
        \\  location: LatLon(47.3769, 8.5417),
        \\  temp: Temperature(18.5, "C"),
        \\  status_hash: Hash("SHA3-256", "device_ok")
        \\})
    , null);

    // Complex query
    var iot_iter = try geode.query(
        \\MATCH (iot:IoTDevice)
        \\WHERE ip_contains(Subnet("10.0.0.0/16"), iot.ip)
        \\  AND NOT mac_is_multicast(iot.mac)
        \\RETURN iot.device_id, iot.ip, iot.location
    , null);
    defer iot_iter.close();

    while (try iot_iter.next()) |row| {
        std.debug.print("   IoT Device {s} at {s} (location: {s})\n", .{
            row.get("iot.device_id").?.string,
            row.get("iot.ip").?.string,
            row.get("iot.location").?.string,
        });
    }

    std.debug.print("\n=== Extended Type System Demo Complete ===\n", .{});
}
