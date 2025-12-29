const std = @import("std");
const ed = @import("../src/ed25519.zig");

// Canonical decoding tests enforcing RFC8032 strict rules:
// 1. Reject encodings with y >= p (non-canonical field encoding)
// 2. Reject encodings of points with x == 0 and sign bit = 1 (non-unique)
// 3. Reject known small-order encodings (covered elsewhere, sanity here)
// 4. Accept a valid basepoint encoding.

fn expectDecompress(enc: [32]u8, ok: bool) !void {
    const maybe = ed.test_decompressPoint(&enc);
    try std.testing.expect((maybe != null) == ok);
}

// Helper: clone and set sign bit.
fn setSignBit(mut: *[32]u8, bit: u1) void {
    if (bit == 1) {
        mut[31] |= 0x80;
    } else {
        mut[31] &= 0x7f;
    }
}

// Encoding of basepoint (expected OK)
const BASEPOINT = [32]u8{
    0x58, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
    0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
};

// Identity (small order) 0*B encoding = all zeros (reject)
const IDENTITY = [32]u8{0} ** 32;

// y = p (non-canonical) -> little-endian p = 2^255-19 = 0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed
const Y_EQ_P = [32]u8{
    0xed, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f,
};

// Construct x=0, y=1 => identity point encoding with sign bit=1 (non-canonical due to sign bit rule for x=0).
fn xZeroSignOne() [32]u8 {
    var enc = IDENTITY; // y=0, but identity should have y=1 representation: (0,1) encodes to 01 00..00
    // Proper (0,1) encoding bytes
    enc[0] = 1; // y = 1
    // sign bit intentionally set to 1 while x=0
    setSignBit(&enc, 1);
    return enc;
}

// Another variant: (0,1) normal encoding (sign bit = 0) to ensure we still accept small-order rejection occurs (will be rejected earlier by small-order set).
fn xZeroSignZero() [32]u8 {
    var enc = IDENTITY;
    enc[0] = 1;
    setSignBit(&enc, 0);
    return enc;
}

// NOTE: small-order encodings are already rejected in decompress; we only spot-check identity variants.

// Test cases table
const Case = struct { name: []const u8, enc: [32]u8, ok: bool };

fn cases() []const Case {
    return &[_]Case{
        .{ .name = "basepoint ok", .enc = BASEPOINT, .ok = true },
        .{ .name = "y_eq_p reject", .enc = Y_EQ_P, .ok = false },
        .{ .name = "identity reject (small order)", .enc = IDENTITY, .ok = false },
        .{ .name = "x=0 sign=1 reject", .enc = xZeroSignOne(), .ok = false },
        .{ .name = "x=0 sign=0 (small-order reject)", .enc = xZeroSignZero(), .ok = false },
    };
}

test "ed25519 canonical decoding strictness" {
    for (cases()) |c| {
        const before = ed.test_decompressPoint(&c.enc);
        // We expect exact ok flag behavior.
        if ((before != null) != c.ok) {
            std.debug.print("canonical test failed: {s} enc={x} got_ok={} expected_ok={}\n", .{ c.name, c.enc, before != null, c.ok });
            try std.testing.expect(false);
        }
    }
    try std.testing.expect(true);
}
