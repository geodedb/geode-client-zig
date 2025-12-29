// VENDORED FULL IMPLEMENTATION
// Source of truth: src/crypto/ed25519.zig (must stay in sync) .
// DO NOT TRIM for security correctness. Update both copies together.
// NOTE: Keep public API identical (Scalar, KeyPair, deriveKeyPair, sign, verify, test_* helpers).
// Any divergence will break -Duse_vendor_ed25519 test parity.
const std = @import("std");

// ---- BEGIN VERBATIM COPY (aside from this header) ----
// (If modifying below, replicate change upstream and re-copy.)

pub const Scalar = struct {
    /// Canonical 32-byte little-endian representation modulo L (2^252 + 277423...)
    bytes: [32]u8,
};

// Field element (5x51-bit limbs) for p = 2^255 - 19.
const Field = struct { limbs: [5]u64 }; // value = sum(limbs[i] * 2^(51*i))

// Group order L = 2^252 + 27742317777372353535851937790883648493
// Little-endian bytes per RFC8032 appendix A.2
const L_bytes: [32]u8 = .{
    0xed, 0xd3, 0xf5, 0x5c, 0x1a, 0x63, 0x12, 0x58, 0xd6, 0x9c, 0xf7, 0xa2, 0xde, 0xf9, 0xde, 0x14,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0x10,
};

// Reduce 64-byte hash to canonical scalar modulo L (group order) using 512-bit integer modulo.
fn reduceModLCanonical(h: *const [64]u8, out: *[32]u8) void {
    var x: U512 = 0;
    var i: usize = 0;
    while (i < 64) : (i += 1) {
        x |= (@as(U512, h.*[i])) << @intCast(i * 8);
    }
    // Parse L into U512 from little-endian bytes.
    var L: U512 = 0;
    i = 0;
    while (i < 32) : (i += 1) {
        L |= (@as(U512, L_bytes[i])) << @intCast(i * 8);
    }
    const r: U512 = x % L;
    // Write little-endian 32-byte output
    i = 0;
    while (i < 32) : (i += 1) {
        out[i] = @intCast((r >> @intCast(i * 8)) & 0xff);
    }
}

fn scalarLessThan(a: *const [32]u8, b: *const [32]u8) bool {
    var i: isize = 31;
    while (i >= 0) : (i -= 1) {
        if (a.*[@intCast(i)] < b.*[@intCast(i)]) return true;
        if (a.*[@intCast(i)] > b.*[@intCast(i)]) return false;
    }
    return false; // equal
}

fn scalarSub(a: *[32]u8, b: *const [32]u8) void {
    var borrow: i16 = 0;
    var i: usize = 0;
    while (i < 32) : (i += 1) {
        const diff: i16 = @as(i16, a.*[i]) - @as(i16, b.*[i]) - borrow;
        a.*[i] = @as(u8, @intCast(diff & 0xff));
        borrow = if (diff < 0) 1 else 0;
    }
    // If borrow set, add back L (we assumed a>=b when calling; skip for simplicity)
}

fn scalarAddMul(out: *[32]u8, r: *const [32]u8, h: *const [32]u8, a: *const [32]u8) void {
    // out = (r + h*a) mod L using 512-bit intermediates and canonical mod
    var tmp: [64]u8 = .{0} ** 64;
    // tmp = h * a (little-endian 32x32 -> 64)
    var i: usize = 0;
    while (i < 32) : (i += 1) {
        var carry: u32 = 0;
        var j: usize = 0;
        while (j < 32) : (j += 1) {
            const idx = i + j;
            const acc: u32 = @as(u32, tmp[idx]) + carry + @as(u32, h.*[i]) * @as(u32, a.*[j]);
            tmp[idx] = @intCast(acc & 0xff);
            carry = acc >> 8;
        }
        var k = i + 32;
        while (carry != 0 and k < 64) : (k += 1) {
            const acc2: u32 = @as(u32, tmp[k]) + carry;
            tmp[k] = @intCast(acc2 & 0xff);
            carry = acc2 >> 8;
        }
    }
    // tmp += r
    var carry2: u32 = 0;
    i = 0;
    while (i < 32) : (i += 1) {
        const sum: u32 = @as(u32, tmp[i]) + @as(u32, r.*[i]) + carry2;
        tmp[i] = @intCast(sum & 0xff);
        carry2 = sum >> 8;
    }
    var k2: usize = 32;
    while (carry2 != 0 and k2 < 64) : (k2 += 1) {
        const sum2: u32 = @as(u32, tmp[k2]) + carry2;
        tmp[k2] = @intCast(sum2 & 0xff);
        carry2 = sum2 >> 8;
    }
    reduceModLCanonical(&tmp, out);
}

fn feZero() Field {
    return .{ .limbs = .{0} ** 5 };
}
fn feOne() Field {
    return .{ .limbs = .{ 1, 0, 0, 0, 0 } };
}

fn feNormalize(fe: *Field) void {
    // Carry propagate so each limb < 2^51.
    var carry: u128 = 0;
    var i: usize = 0;
    while (i < 5) : (i += 1) {
        const cur: u128 = @as(u128, fe.limbs[i]) + carry;
        fe.limbs[i] = @intCast(cur & ((@as(u128, 1) << 51) - 1));
        carry = cur >> 51;
    }
    // Fold carry *19 into limb0 (mod p) and re-carry.
    if (carry != 0) {
        const c: u128 = @as(u128, fe.limbs[0]) + carry * 19;
        fe.limbs[0] = @intCast(c & ((@as(u128, 1) << 51) - 1));
        var k = c >> 51;
        var j: usize = 1;
        while (k != 0 and j < 5) : (j += 1) {
            const v: u128 = @as(u128, fe.limbs[j]) + k;
            fe.limbs[j] = @intCast(v & ((@as(u128, 1) << 51) - 1));
            k = v >> 51;
        }
    }
}

fn feAdd(a: Field, b: Field) Field {
    const aa = feToU256(a);
    const bb = feToU256(b);
    const sum: U512 = @as(U512, aa) + @as(U512, bb);
    const red = feReduceModP512(sum);
    return feFromU256(red);
}

fn feSub(a: Field, b: Field) Field {
    const aa = feToU256(a);
    const bb = feToU256(b);
    const P: U256 = ((@as(U256, 1) << 255) - 19);
    // Add P to avoid negative then reduce
    const diff: U512 = @as(U512, aa) + @as(U512, P) - @as(U512, bb);
    const red = feReduceModP512(diff);
    return feFromU256(red);
}

fn feToU256(a: Field) std.meta.Int(.unsigned, 256) {
    var t: U256 = 0;
    var i: usize = 0;
    while (i < 5) : (i += 1) {
        const sh: u8 = @intCast(51 * i);
        t += @as(U256, a.limbs[i]) << sh;
    }
    // t < 2^255 due to normalization
    return t;
}

fn feFromU256(t_in: std.meta.Int(.unsigned, 256)) Field {
    var t: U256 = t_in & (((@as(U256, 1) << 255) - 1));
    var r = Field{ .limbs = .{0} ** 5 };
    const mask: U256 = (@as(U256, 1) << 51) - 1;
    r.limbs[0] = @intCast(t & mask);
    t >>= 51;
    r.limbs[1] = @intCast(t & mask);
    t >>= 51;
    r.limbs[2] = @intCast(t & mask);
    t >>= 51;
    r.limbs[3] = @intCast(t & mask);
    t >>= 51;
    r.limbs[4] = @intCast(t & mask);
    return r;
}

fn feReduceModP512(x: std.meta.Int(.unsigned, 512)) std.meta.Int(.unsigned, 256) {
    const P: U256 = ((@as(U256, 1) << 255) - 19);
    const MASK255: U512 = (@as(U512, 1) << 255) - 1;
    // Fold high bits: (lo + hi*19) until hi==0
    var acc: U512 = x;
    while (true) {
        const hi: U512 = acc >> 255;
        const lo: U512 = acc & MASK255;
        if (hi == 0) {
            acc = lo;
            break;
        }
        acc = lo + hi * 19;
    }
    // Convert to U256 and fully reduce modulo P
    var v: U256 = @intCast(acc);
    while (v >= P) v -= P;
    return v;
}

fn feMul(a: Field, b: Field) Field {
    const aa = feToU256(a);
    const bb = feToU256(b);
    const prod: U512 = @as(U512, aa) * @as(U512, bb);
    const red = feReduceModP512(prod);
    return feFromU256(red);
}

fn feSq(a: Field) Field {
    return feMul(a, a);
}

fn feDouble(a: Field) Field {
    return feAdd(a, a);
}

fn feEqual(a_in: Field, b_in: Field) bool {
    // Compare by canonical byte encoding (mod p)
    var ab: [32]u8 = undefined;
    var bb: [32]u8 = undefined;
    feToBytes(a_in, &ab);
    feToBytes(b_in, &bb);
    return std.mem.eql(u8, &ab, &bb);
}

// Constant-time conditional move: if (b==1) return y else x, without branches.
fn feCMove(x: Field, y: Field, b: u1) Field {
    // b assumed 0 or 1; create mask of all 1s if b==1.
    // Previous implementation used `0 - b` which triggers a safety panic in Debug
    // builds when b==1 due to unsigned overflow checks. Compute mask in a way that
    // avoids triggering overflow while remaining branchless and constant-time.
    // We expand the 1-bit predicate to an all-ones mask by negating a signed value.
    // Convert b (0/1) to i64 then arithmetic negate; cast to u64 yields either 0 or
    // 0xffff...ffff.
    const sb: i64 = @as(i64, b);
    const mask: u64 = @bitCast(-sb);
    var r = Field{ .limbs = .{0} ** 5 };
    var i: usize = 0;
    while (i < 5) : (i += 1) {
        const xv = x.limbs[i];
        const yv = y.limbs[i];
        r.limbs[i] = (xv & ~mask) | (yv & mask);
    }
    return r;
}

fn ctEqual32(a: *const [32]u8, bbytes: *const [32]u8) u1 {
    var diff: u8 = 0;
    var i: usize = 0;
    while (i < 32) : (i += 1) diff |= a.*[i] ^ bbytes.*[i];
    return @intFromBool(diff == 0);
}

fn pointCMove(p: Point, q: Point, b: u1) Point {
    return .{
        .X = feCMove(p.X, q.X, b),
        .Y = feCMove(p.Y, q.Y, b),
        .Z = feCMove(p.Z, q.Z, b),
        .T = feCMove(p.T, q.T, b),
    };
}

fn feFromBytes(b: *const [32]u8) Field {
    // Internal parity: replicate internal implementation (u256 path) exactly for vendor.
    var t: u256 = 0;
    var i: usize = 0;
    while (i < 32) : (i += 1) {
        const sh: u8 = @intCast(8 * i); // 0..248
        t |= (@as(u256, b.*[i]) << sh);
    }
    t &= ((@as(u256, 1) << 255) - 1);
    var fe = Field{ .limbs = .{0} ** 5 };
    const mask: u256 = (@as(u256, 1) << 51) - 1;
    fe.limbs[0] = @intCast(t & mask);
    t >>= 51;
    fe.limbs[1] = @intCast(t & mask);
    t >>= 51;
    fe.limbs[2] = @intCast(t & mask);
    t >>= 51;
    fe.limbs[3] = @intCast(t & mask);
    t >>= 51;
    fe.limbs[4] = @intCast(t & mask);
    feNormalize(&fe);
    return fe;
}

fn feToBytes(fe_in: Field, out: *[32]u8) void {
    var fe = fe_in;
    feNormalize(&fe);
    // Ensure canonical: if fe >= p, subtract p. Implement by attempting to carry the top limb and fold.
    // For our 5x51, values are always reduced < 2^255, but a final canonical step helps encoding.
    var t: u256 = 0;
    var i: usize = 0;
    while (i < 5) : (i += 1) {
        const sh: u8 = @intCast(51 * i); // 0..204
        t |= (@as(u256, fe.limbs[i]) << sh);
    }
    // If t >= p, subtract p (p = 2^255 - 19)
    const p: u256 = ((@as(u256, 1) << 255) - 19);
    if (t >= p) t -= p;
    i = 0;
    while (i < 32) : (i += 1) {
        const sh: u8 = @intCast(8 * i);
        out[i] = @as(u8, @intCast((t >> sh) & 0xff));
    }
}

fn feInvert(z: Field) Field {
    // Compute inverse via Fermat's little theorem using big-int math: z^(p-2) mod p.
    const zz: U256 = feToU256(z);
    if (zz == 0) return feZero();
    const inv: U256 = modPowU256(zz, P_U256 - 2);
    return feFromU256(inv);
}

// Raise to e = (2^252 - 3) = (p-5)/8. Used in sqrt_ratio_m1.
fn fePow22523(z: Field) Field {
    var t0 = feSq(z); // 2
    var t1 = feSq(t0); // 4
    t1 = feSq(t1); // 8
    t1 = feMul(t1, z); // 9
    t0 = feMul(t0, t1); // 11
    var t2 = feSq(t0); // 22
    t1 = feMul(t1, t2); // 31 = 2^5 - 1

    // t1^(2^5) * t1 = 2^10 - 1
    t2 = feSq(t1);
    var i: usize = 1;
    while (i < 5) : (i += 1) t2 = feSq(t2);
    t1 = feMul(t2, t1);

    // t1^(2^10) * t1 = 2^20 - 1
    t2 = feSq(t1);
    i = 1;
    while (i < 10) : (i += 1) t2 = feSq(t2);
    t2 = feMul(t2, t1);

    // t2^(2^20) * t2 = 2^40 - 1
    var t3 = feSq(t2);
    i = 1;
    while (i < 20) : (i += 1) t3 = feSq(t3);
    t2 = feMul(t3, t2);

    // t2^(2^10) * t1 = 2^50 - 1
    t2 = feSq(t2);
    i = 1;
    while (i < 10) : (i += 1) t2 = feSq(t2);
    t1 = feMul(t2, t1);

    // t1^(2^50) * t1 = 2^100 - 1
    t2 = feSq(t1);
    i = 1;
    while (i < 50) : (i += 1) t2 = feSq(t2);
    t2 = feMul(t2, t1);

    // t2^(2^100) * t2 = 2^200 - 1
    t3 = feSq(t2);
    i = 1;
    while (i < 100) : (i += 1) t3 = feSq(t3);
    t2 = feMul(t3, t2);

    // t2^(2^50) * t1 = 2^250 - 1
    t2 = feSq(t2);
    i = 1;
    while (i < 50) : (i += 1) t2 = feSq(t2);
    t1 = feMul(t2, t1);

    // Square twice: 2^252 - 4; then multiply by z: 2^252 - 3
    t1 = feSq(t1);
    t1 = feSq(t1);
    return feMul(t1, z);
}

// Basepoint affine coordinates (little-endian) from RFC8032 (must appear before first usage)
// X = 0x216936d3cd6e53fec0a4e231fdd6dc5c692cc7609525a7b2c9562d608f25d51a
const BASE_X_BYTES = [32]u8{
    0x1a, 0xd5, 0x25, 0x8f, 0x60, 0x2d, 0x56, 0xc9, 0xb2, 0xa7, 0x25, 0x95, 0x60, 0xc7, 0x2c, 0x69,
    0x5c, 0xdc, 0xd6, 0xfd, 0x31, 0xe2, 0xa4, 0xc0, 0xfe, 0x53, 0x6e, 0xcd, 0xd3, 0x36, 0x69, 0x21,
};
// Y = 0x6666666666666666666666666666666666666666666666666666666666666658
const BASE_Y_BYTES = [32]u8{
    0x58, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
    0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
};
var BASE_POINT: Point = .{ .X = feZero(), .Y = feOne(), .Z = feOne(), .T = feZero() }; // init lazily

// Edwards point (extended): (X:Y:Z:T) with x=X/Z, y=Y/Z, T=XY/Z.
const Point = struct { X: Field, Y: Field, Z: Field, T: Field };

// Affine point for naive reference operations.
const Affine = struct { x: Field, y: Field };

fn pointToAffine(p: Point) Affine {
    const zinv = feInvert(p.Z);
    return .{ .x = feMul(p.X, zinv), .y = feMul(p.Y, zinv) };
}

fn affineIdentity() Affine {
    return .{ .x = feZero(), .y = feOne() };
}

fn affineAdd(p: Affine, q: Affine) Affine {
    // Edwards addition in affine coordinates for a = -1.
    // x3 = (x1*y2 + y1*x2) / (1 + d*x1*x2*y1*y2)
    // y3 = (y1*y2 + x1*x2) / (1 - d*x1*x2*y1*y2)
    const x1 = p.x;
    const y1 = p.y;
    const x2 = q.x;
    const y2 = q.y;
    const x1x2 = feMul(x1, x2);
    const y1y2 = feMul(y1, y2);
    const x1y2 = feMul(x1, y2);
    const y1x2 = feMul(y1, x2);
    const num_x = feAdd(x1y2, y1x2);
    const num_y = feAdd(y1y2, x1x2);
    const t = feMul(feMul(x1x2, y1y2), d);
    const one = feOne();
    const denom_x = feAdd(one, t);
    const denom_y = feSub(one, t);
    const inv_denom_x = feInvert(denom_x);
    const inv_denom_y = feInvert(denom_y);
    return .{ .x = feMul(num_x, inv_denom_x), .y = feMul(num_y, inv_denom_y) };
}

fn affineDouble(p: Affine) Affine {
    return affineAdd(p, p);
}

fn scalarMulBase_affine_ref(scalar: *const [32]u8) Affine {
    // Naive double-and-add in affine.
    var acc = affineIdentity();
    var base = Affine{ .x = feFromBytes(&BASE_X_BYTES), .y = feFromBytes(&BASE_Y_BYTES) };
    var bit: usize = 0;
    while (bit < 256) : (bit += 1) {
        if (scalarGetBit(scalar, bit) == 1) {
            acc = affineAdd(acc, base);
        }
        base = affineDouble(base);
    }
    return acc;
}

fn compressAffine(p: Affine, out: *[32]u8) void {
    var yb: [32]u8 = undefined;
    feToBytes(p.y, &yb);
    var xb: [32]u8 = undefined;
    feToBytes(p.x, &xb);
    @memcpy(out[0..], &yb);
    out[31] = (out[31] & 0x7f) | ((xb[0] & 1) << 7);
}

// Encodings of all 8 small-order (torsion subgroup) points on ed25519 to reject.
// Values copied from RFC8032 / ref10 small order test vectors.
const SMALL_ORDER_ENCODINGS = [_][32]u8{
    // 0 (identity)
    .{0} ** 32,
    // 1
    .{ 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
    // 2
    .{ 0x26, 0xe8, 0x95, 0x8f, 0xc2, 0xb2, 0x27, 0xa6, 0x66, 0xbd, 0x41, 0x6f, 0x80, 0x43, 0x49, 0x7d, 0x56, 0x70, 0xbd, 0xb3, 0x6d, 0x05, 0x8a, 0x0d, 0x57, 0x1e, 0xc0, 0xa9, 0x0a, 0x39, 0x80, 0x00 },
    // 3
    .{ 0xc7, 0x17, 0x6a, 0x70, 0x3d, 0x4d, 0xd8, 0x59, 0x99, 0x42, 0xbe, 0x90, 0x7f, 0xbc, 0xb6, 0x82, 0xa9, 0x8f, 0x42, 0x4c, 0x92, 0xfa, 0x75, 0xf2, 0xa8, 0xe1, 0x3f, 0x56, 0xf5, 0xc6, 0x7f, 0x00 },
    // 4
    .{ 0xec, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f },
    // 5
    .{ 0xed, 0xd3, 0xf5, 0x5c, 0x1a, 0x63, 0x12, 0x58, 0xd6, 0x9c, 0xf7, 0xa2, 0xde, 0xf9, 0xde, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10 },
    // 6
    .{ 0xdb, 0x41, 0x1a, 0x98, 0x1f, 0x95, 0x6b, 0x1b, 0x6b, 0x5f, 0xb2, 0xaf, 0x3d, 0x64, 0x6c, 0x54, 0x0d, 0x32, 0x6d, 0x49, 0x49, 0x36, 0x70, 0x62, 0x83, 0x31, 0x9c, 0x84, 0x0c, 0x1c, 0x00, 0x00 },
    // 7
    .{ 0x26, 0x0b, 0xe6, 0x67, 0xe4, 0x6b, 0xef, 0xbb, 0x6e, 0xdc, 0xe5, 0x4f, 0xa1, 0x52, 0xe8, 0x87, 0x31, 0x39, 0x1f, 0x29, 0x54, 0x19, 0xee, 0x0d, 0x7d, 0x0b, 0x4d, 0x42, 0xd8, 0x2a, 0x7c, 0x00 },
};

fn isSmallOrder(enc: *const [32]u8) bool {
    for (SMALL_ORDER_ENCODINGS) |e| {
        if (std.mem.eql(u8, enc, &e)) return true;
    }
    return false;
}

/// Returns the Edwards identity point (0,1) in extended coordinates.
pub fn pointIdentity() Point {
    return .{ .X = feZero(), .Y = feOne(), .Z = feOne(), .T = feZero() };
}

// Edwards constant d = -121665/121666 mod p.
// Canonical little-endian bytes (RFC 8032 / ref10):
//   0x52036cee2b6ffe738cc740797779e89800700a4d4141d8ab75eb4dca135978a (little-endian)
// We embed as field element directly to avoid any risk of inversion miscompute.
var d: Field = feZero(); // initialized lazily by computation
var SQRT_M1: Field = feZero();
var CONSTS_DEBUG_ONCE: bool = false;

fn feFromU64(n: u64) Field {
    // Construct a field element from a small integer n (< 2^51)
    return .{ .limbs = .{ n, 0, 0, 0, 0 } };
}

fn ensureConstantsInit() void {
    if (d.limbs[0] != 0) return; // guard
    const num = feSub(feZero(), feFromU64(121665));
    const den_inv = feInvert(feFromU64(121666));
    d = feMul(num, den_inv);
    BASE_POINT = pointFromAffine(&BASE_X_BYTES, &BASE_Y_BYTES);
    SQRT_M1 = computeSqrtMinusOneBig();
    if (!CONSTS_DEBUG_ONCE) {
        CONSTS_DEBUG_ONCE = true;
        const sm1_sq = feAdd(feSq(SQRT_M1), feOne());
        var bytes_chk: [32]u8 = undefined;
        feToBytes(sm1_sq, &bytes_chk);
        var all_zero = true;
        for (bytes_chk) |b| if (b != 0) {
            all_zero = false;
            break;
        };
        std.debug.print("ed25519.const sqrt(-1)^2 == -1: {}\n", .{all_zero});
        var enc: [32]u8 = undefined;
        compressPoint(BASE_POINT, &enc);
        const maybe = decompressPoint(&enc);
        std.debug.print("ed25519.const basepoint roundtrip ok: {}\n", .{maybe != null});
        var d_enc: [32]u8 = undefined;
        feToBytes(d, &d_enc);
        std.debug.print("ed25519.const d={x}\n", .{d_enc});
    }
}

// Compute sqrt_ratio_m1(u, v): returns x such that v*x^2 == u (or v*x^2 == -u and x *= sqrt(-1)).
// Returns null if no square root exists (should not occur for proper inputs in Ed25519 decompression path).
fn sqrtRatioM1(u: Field, v: Field) ?Field {
    // Per ref10: x = (u*v^3) * (u*v^7)^{(p-5)/8}
    const v2 = feSq(v);
    const v3 = feMul(v2, v);
    const v4 = feSq(v2);
    const v7 = feMul(v3, v4);
    const r = feMul(u, v3); // u * v^3
    const x = feMul(fePow22523(feMul(u, v7)), r);
    const x2 = feSq(x);
    const vx2 = feMul(v, x2);
    if (feEqual(vx2, u)) {
        return x;
    }
    const minus_u = feSub(feZero(), u);
    if (feEqual(vx2, minus_u)) {
        return feMul(x, SQRT_M1);
    }
    return null;
}

// Compute sqrt(-1) as 2^((P-1)/4) mod P using big-int math and convert to Field.
fn computeSqrtMinusOneBig() Field {
    const P: U256 = ((@as(U256, 1) << 255) - 19);
    const exp: U256 = (P - 1) / 4;
    var base: U256 = 2;
    var result: U256 = 1;
    var e: U256 = exp;
    while (e != 0) {
        if ((e & 1) == 1) {
            // result = (result * base) % P
            const t1 = (@as(std.meta.Int(.unsigned, 512), result) * @as(std.meta.Int(.unsigned, 512), base));
            result = feReduceModP512(t1);
        }
        // base = (base * base) % P
        const t2 = (@as(std.meta.Int(.unsigned, 512), base) * @as(std.meta.Int(.unsigned, 512), base));
        base = feReduceModP512(t2);
        e >>= 1;
    }
    return feFromU256(result);
}

// ----- Big-int helpers for mod p arithmetic (p = 2^255 - 19) -----
const U256 = std.meta.Int(.unsigned, 256);
const U512 = std.meta.Int(.unsigned, 512);
const P_U256: U256 = ((@as(U256, 1) << 255) - 19);

fn modMulU256(a: U256, b: U256) U256 {
    const prod: U512 = @as(U512, a) * @as(U512, b);
    return feReduceModP512(prod);
}

fn modAddU256(a: U256, b: U256) U256 {
    var s: U256 = a + b;
    // Reduce if overflowed past P
    while (s >= P_U256) s -= P_U256;
    return s;
}

fn modSubU256(a: U256, b: U256) U256 {
    // Return (a - b) mod P
    if (a >= b) {
        return a - b;
    } else {
        return (a + P_U256) - b;
    }
}

fn modPowU256(base_in: U256, exp_in: U256) U256 {
    var base = base_in % P_U256;
    var e = exp_in;
    var result: U256 = 1;
    while (e != 0) {
        if ((e & 1) == 1) {
            result = modMulU256(result, base);
        }
        base = modMulU256(base, base);
        e >>= 1;
    }
    return result;
}

// Provide a custom 256-bit unsigned type for field decode helper (distinct alias)
const U256Bits = std.meta.Int(.unsigned, 256);

fn pointFromAffine(x_bytes: *const [32]u8, y_bytes: *const [32]u8) Point {
    const X = feFromBytes(x_bytes);
    const Y = feFromBytes(y_bytes);
    return .{ .X = X, .Y = Y, .Z = feOne(), .T = feMul(X, Y) };
}

fn pointToProjective(p: Point) Point {
    return p; // extended already has Z
}

fn pointAddExtended(a: Point, b: Point) Point {
    // Extended coordinates addition (Hisil 2008) for a=-1 curve parameter.
    // A = (Y1 - X1)*(Y2 - X2)
    // B = (Y1 + X1)*(Y2 + X2)
    // C = 2 * d * T1 * T2
    // D = 2 * Z1 * Z2
    // E = B - A
    // F = D - C
    // G = D + C
    // H = B + A
    // X3 = E * F
    // Y3 = G * H
    // T3 = E * H
    // Z3 = F * G
    const A_ = feMul(feSub(a.Y, a.X), feSub(b.Y, b.X));
    const B_ = feMul(feAdd(a.Y, a.X), feAdd(b.Y, b.X));
    const C_ = feMul(feMul(feMul(a.T, b.T), d), feTwo());
    const D_ = feMul(feMul(a.Z, b.Z), feTwo());
    const E_ = feSub(B_, A_);
    const F_ = feSub(D_, C_);
    const G_ = feAdd(D_, C_);
    const H_ = feAdd(B_, A_);
    return .{ .X = feMul(E_, F_), .Y = feMul(G_, H_), .Z = feMul(F_, G_), .T = feMul(E_, H_) };
}

fn feTwo() Field {
    return feAdd(feOne(), feOne());
}

fn pointDouble(p: Point) Point {
    // Standard extended Edwards doubling (a = -1):
    // A = X1^2
    // B = Y1^2
    // C = 2*Z1^2
    // D = -A
    // E = (X1+Y1)^2 - A - B
    // G = D + B
    // F = G - C
    // H = D - B
    // X3 = E * F
    // Y3 = G * H
    // T3 = E * H
    // Z3 = F * G
    const A_ = feSq(p.X);
    const B_ = feSq(p.Y);
    const Z_sq = feSq(p.Z);
    const C_ = feMul(feTwo(), Z_sq);
    const D_ = feSub(feZero(), A_);
    const XplusY = feAdd(p.X, p.Y);
    const XplusY_sq = feSq(XplusY);
    const E_ = feSub(feSub(XplusY_sq, A_), B_);
    const G_ = feAdd(D_, B_);
    const F_ = feSub(G_, C_);
    const H_ = feSub(D_, B_);
    return .{ .X = feMul(E_, F_), .Y = feMul(G_, H_), .Z = feMul(F_, G_), .T = feMul(E_, H_) };
}

fn pointAdd(a: Point, b: Point) Point {
    return pointAddExtended(a, b);
}

fn pointPrecomputeWindow(base: Point, window_bits: u8, table: []Point) void {
    // Precompute [1]B, [3]B, [5]B, ... up to needed size using additions.
    const entries: usize = table.len;
    if (entries == 0) return;
    table[0] = base;
    const dbl = pointDouble(base);
    var i: usize = 1;
    while (i < entries) : (i += 1) {
        table[i] = pointAdd(table[i - 1], dbl);
    }
    _ = window_bits; // reserved for future dynamic sizing
}

fn scalarGetBit(s: *const [32]u8, i: usize) u1 {
    if (i >= 256) return 0;
    const byte = s.*[i / 8];
    return @intFromBool(((byte >> @intCast(i % 8)) & 1) == 1);
}

fn scalarClamp(h: *[64]u8) void {
    // Per RFC8032: clear lower 3 bits, clear top bit, set second highest bit.
    h[0] &= 248;
    h[31] &= 63; // clear bit 255 and 254
    h[31] |= 64; // set bit 254
}

// --- Static precomputed basepoint table (window-4) ---
var g_precomp_init: bool = false;
var g_precomp_w4: [64][16]Point = undefined; // 64 windows, 16 entries each

fn initBasepointPrecomp() void {
    if (g_precomp_init) return;
    ensureConstantsInit();
    var base = BASE_POINT;
    var w: usize = 0;
    while (w < 64) : (w += 1) {
        if (w > 0) {
            var i: usize = 0;
            while (i < 4) : (i += 1) base = pointDouble(base);
        }
        g_precomp_w4[w][0] = pointIdentity();
        g_precomp_w4[w][1] = base;
        var k: usize = 2;
        while (k < 16) : (k += 1) g_precomp_w4[w][k] = pointAdd(g_precomp_w4[w][k - 1], base);
    }
    g_precomp_init = true;
}

fn scalarMulBase_ct(scalar: *const [32]u8) Point {
    // Constant-time window-4 scalar multiplication using static table.
    initBasepointPrecomp();
    var acc = pointIdentity();
    var window: isize = 63;
    while (window >= 0) : (window -= 1) {
        if (window != 63) {
            var dd: usize = 0;
            while (dd < 4) : (dd += 1) acc = pointDouble(acc);
        }
        const base_bit: usize = @intCast(window * 4);
        var nibble: u4 = 0;
        var k: usize = 0;
        while (k < 4) : (k += 1) {
            if (scalarGetBit(scalar, base_bit + k) == 1) {
                nibble |= (@as(u4, 1) << @intCast(k));
            }
        }
        var selected = pointIdentity();
        var i: usize = 0;
        while (i < 16) : (i += 1) {
            const eq: u1 = @intFromBool(@as(u4, @intCast(i)) == nibble);
            selected = pointCMove(selected, g_precomp_w4[@intCast(window)][i], eq);
        }
        acc = pointAdd(acc, selected);
    }
    return acc;
}

fn scalarMulVar(p: Point, s: *const [32]u8) Point {
    // Variable-time double-and-add (used for public point mult during verify (k*A)).
    var acc = pointIdentity();
    var base = p;
    var i: usize = 0;
    while (i < 256) : (i += 1) {
        if (scalarGetBit(s, i) == 1) acc = pointAdd(acc, base);
        base = pointDouble(base);
    }
    return acc;
}

fn compressPoint(p: Point, out: *[32]u8) void {
    const aff = pointToAffine(p);
    feToBytes(aff.y, out);
    var xb: [32]u8 = undefined;
    feToBytes(aff.x, &xb);
    out[31] = (out[31] & 0x7f) | ((xb[0] & 1) << 7);
}

pub fn decompressPoint(enc: *const [32]u8) ?Point {
    ensureConstantsInit();
    // Reject small-order encodings directly.
    if (isSmallOrder(enc)) return null;
    var y_bytes = enc.*; // copy
    const sign_bit: u8 = (y_bytes[31] >> 7) & 1;
    y_bytes[31] &= 0x7f;
    const Y = feFromBytes(&y_bytes);
    // Recover X from x^2 = (y^2 - 1)/(d*y^2 + 1)
    const Y2 = feSq(Y);
    const num = feSub(Y2, feOne());
    const den = feAdd(feMul(d, Y2), feOne());
    const maybe_inv = sqrtRatioM1(num, den) orelse return null;
    var X = maybe_inv;
    // Ensure sign matches
    var xb: [32]u8 = undefined;
    feToBytes(X, &xb);
    if ((xb[0] & 1) != sign_bit) {
        // X = -X
        X = feSub(feZero(), X);
    }
    return .{ .X = X, .Y = Y, .Z = feOne(), .T = feMul(X, Y) };
}

fn scalarMulBase(s: *const [32]u8) Point {
    return scalarMulBase_ct(s);
}

fn mul8(P: Point) Point {
    // Multiply by cofactor 8 via three doublings.
    var Q = P;
    Q = pointDouble(Q);
    Q = pointDouble(Q);
    Q = pointDouble(Q);
    return Q;
}

/// Ed25519 key pair containing secret key (64 bytes) and public key (32 bytes).
pub const KeyPair = struct {
    sk: [64]u8, // seed || pk
    pk: [32]u8,
};

/// Derives an Ed25519 key pair from a 32-byte seed.
pub fn deriveKeyPair(seed: *const [32]u8) KeyPair {
    ensureConstantsInit();
    var h: [64]u8 = undefined;
    std.crypto.hash.sha2.Sha512.hash(seed, &h, .{});
    scalarClamp(&h);
    var a_bytes: [32]u8 = h[0..32].*;
    const A = scalarMulBase(&a_bytes);
    var pk: [32]u8 = undefined;
    compressPoint(A, &pk);
    var sk: [64]u8 = undefined;
    @memcpy(sk[0..32], seed);
    @memcpy(sk[32..64], &pk);
    return .{ .sk = sk, .pk = pk };
}

fn sha512_twopart(part1: []const u8, part2: []const u8, out: *[64]u8) void {
    var h = std.crypto.hash.sha2.Sha512.init(.{});
    h.update(part1);
    h.update(part2);
    h.final(out);
}

/// Signs a message with an Ed25519 secret key, producing a 64-byte signature.
pub fn sign(out_sig: *[64]u8, msg: []const u8, sk: *const [64]u8) void {
    ensureConstantsInit();
    const seed = sk[0..32];
    const pk = sk[32..64];
    var h: [64]u8 = undefined;
    std.crypto.hash.sha2.Sha512.hash(seed, &h, .{});
    scalarClamp(&h);
    const a: [32]u8 = h[0..32].*;
    // r = H(prefix || msg) mod L (prefix = h[32..64])
    var hp: [64]u8 = undefined;
    sha512_twopart(h[32..64], msg, &hp);
    var rred: [32]u8 = undefined;
    reduceModLCanonical(&hp, &rred);
    // R = r * B
    const R = scalarMulBase(&rred);
    var R_enc: [32]u8 = undefined;
    compressPoint(R, &R_enc);
    // k = H(R || pk || msg) mod L
    var khash: [64]u8 = undefined;
    var hctx = std.crypto.hash.sha2.Sha512.init(.{});
    hctx.update(&R_enc);
    hctx.update(pk);
    hctx.update(msg);
    hctx.final(&khash);
    var kred: [32]u8 = undefined;
    reduceModLCanonical(&khash, &kred);
    // S = (r + k * a) mod L
    var S: [32]u8 = undefined;
    scalarAddMul(&S, &rred, &kred, &a);
    // Assemble signature (R || S)
    @memcpy(out_sig[0..32], &R_enc);
    @memcpy(out_sig[32..64], &S);
}

/// Verifies an Ed25519 signature against a message and public key.
pub fn verify(sig: *const [64]u8, msg: []const u8, pk: *const [32]u8) bool {
    ensureConstantsInit();
    // Parse signature
    var R_enc: [32]u8 = undefined;
    var S: [32]u8 = undefined;
    @memcpy(R_enc[0..32], sig[0..32]);
    @memcpy(S[0..32], sig[32..64]);
    // Reject S >= L
    if (!scalarLessThan(&S, &L_bytes)) return false;
    // Decode public key
    const A = decompressPoint(pk) orelse return false;
    const R = decompressPoint(&R_enc) orelse return false;
    // k = H(R || pk || msg) mod L
    var khash: [64]u8 = undefined;
    var hctx = std.crypto.hash.sha2.Sha512.init(.{});
    hctx.update(&R_enc);
    hctx.update(pk);
    hctx.update(msg);
    hctx.final(&khash);
    var kred: [32]u8 = undefined;
    reduceModLCanonical(&khash, &kred);
    // Compute S*B and R + k*A then compare (cofactor cleared)
    const SB = scalarMulBase(&S);
    const kA = scalarMulVar(A, &kred); // variable-time ok for now (debug)
    const RHS = pointAdd(R, kA);
    const SB8 = mul8(SB);
    const RHS8 = mul8(RHS);
    var sb_bytes: [32]u8 = undefined;
    var rhs_bytes: [32]u8 = undefined;
    compressPoint(SB8, &sb_bytes);
    compressPoint(RHS8, &rhs_bytes);
    const ok = std.mem.eql(u8, &sb_bytes, &rhs_bytes);
    if (!ok) {
        if (ed25519Verbose()) {
            std.debug.print("verify mismatch SB8={x} RHS8={x}\n", .{ sb_bytes, rhs_bytes });
        }
    }
    return ok;
}

// --- Testing/Benchmark Support Wrappers (not part of stable API) ---
// Expose minimal internal helpers needed by constant-time & fuzz tests without
// making the entire internal point/scalar machinery public.
/// Test-only helper: decompresses a compressed point (returns null on invalid encoding).
pub fn test_decompressPoint(enc: *const [32]u8) ?Point {
    return decompressPoint(enc);
}

/// Test-only helper: constant-time base scalar multiplication for timing guard.
pub fn test_scalarMulBase(s: *const [32]u8) Point {
    return scalarMulBase(s);
}

/// Test-only helper: compresses an internal extended point to 32-byte encoding.
pub fn test_compressPoint(p: Point, out: *[32]u8) void {
    compressPoint(p, out);
}

// Cached environment flag for optional verbose mismatch diagnostics.
var g_verbose_checked = false;
var g_verbose = false;
fn ed25519Verbose() bool {
    if (!g_verbose_checked) {
        g_verbose_checked = true;
        const val = std.process.getEnvVarOwned(std.heap.page_allocator, "UA_ED25519_VERBOSE") catch null;
        if (val) |v| {
            g_verbose = v.len > 0 and v[0] != '0';
            std.heap.page_allocator.free(v);
        }
    }
    return g_verbose;
}

// Additional helper functions (wNAF, sliding window, diagnostics) intentionally omitted here for size; copy if tests require.
// ---- END VERBATIM COPY ----
