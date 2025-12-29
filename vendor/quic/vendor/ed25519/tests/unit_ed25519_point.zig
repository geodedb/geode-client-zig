const std = @import("std");
const ed = @import("../src/crypto/ed25519.zig");

// Basic point arithmetic sanity tests (non-RFC vectors; placeholder until encoding implemented)
// We only check that scalarMulBase(0) == identity (Z!=0, X=0) and that doubling changes coordinates.

fn isIdentity(p: anytype) bool {
    return p.X.limbs[0] == 0 and p.Y.limbs[0] == 1; // coarse check
}

pub fn main() !void {
    var zero_scalar: [32]u8 = .{0} ** 32;
    const id = ed.pointIdentity();
    const q0 = ed.scalarMulBase(&zero_scalar);
    if (!isIdentity(q0) or !isIdentity(id)) return error.TestFailed;
    // scalar=1 => basepoint (not identity)
    zero_scalar[0] = 1;
    const q1 = ed.scalarMulBase(&zero_scalar);
    if (isIdentity(q1)) return error.TestFailed;
    // Compress basepoint and compare with expected RFC encoding (Y plus sign bit)
    var enc: [32]u8 = undefined;
    ed.compressPoint(q1, &enc);
    const expected_base_enc = [_]u8{
        0x58, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
        0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
        0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
        0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
    };
    // Sign bit for basepoint X is 0 (per standard encoding)
    if (!std.mem.eql(u8, &enc, &expected_base_enc)) {
        std.debug.print("basepoint encoding mismatch got={any}\n", .{enc});
        return error.TestFailed;
    }
    // Roundtrip: decompress then recompress
    const maybe_pt = ed.decompressPoint(&enc);
    if (maybe_pt == null) return error.TestFailed;
    var enc2: [32]u8 = undefined;
    ed.compressPoint(maybe_pt.?, &enc2);
    if (!std.mem.eql(u8, &enc, &enc2)) {
        std.debug.print("roundtrip mismatch enc2={any}\n", .{enc2});
        return error.TestFailed;
    }
    // Small-order rejection: all-zero encoding must fail
    var zero_enc: [32]u8 = .{0} ** 32;
    const bad = ed.decompressPoint(&zero_enc);
    if (bad != null) return error.TestFailed;
    std.debug.print("ed25519 point base mul sanity ok\n", .{});
}
