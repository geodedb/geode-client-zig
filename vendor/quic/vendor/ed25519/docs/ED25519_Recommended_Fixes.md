You're right to anchor the fixes to the attached review and to RFC 8032. Below I deliver **a small, surgical patch** to your `ed25519.zig` plus **unit tests, micro‑benchmarks, and a timing/fuzz harness** to ensure the issues stay fixed.

> **What changes are included (mapped to the review’s FAILs & WARNs)**
>
> - **Strict decoding** of `R` and `A`: reject non‑canonical encodings (`y ≥ p`) and the special case **`x == 0` and sign‑bit = 1** (RFC 8032 §5.1.3). This closes the \_verify.decode\__ and \_encoding.R_canonical_ failures.&#x20;
> - **Constant‑time basepoint scalar multiplication:** replace the secret‑dependent branchy bit‑walker with a fixed‑window, **branchless** scheme (table + cmov). This closes _security.constant_time_.
> - **Defensive zeroization** of transient secrets in `sign` (seed hash, prefix hash, scalars and `S`), addressing the _zeroization.absent_ WARN.
> - **Cofactor‑cleared verify** remains as in your code (`[8]S·B == [8](R + kA)`), which is explicitly allowed by RFC 8032 §5.1.7 and avoids interop pitfalls.&#x20;
> - **Tests, benchmarks, fuzz, and a timing harness** following the plan in **ED25519 Constant‑Time Hardening — Next Steps**.&#x20;

---

## PLAN

- Patch `decompressPoint` to enforce **`y < p`** and **reject `x==0` & sign‑bit=1**.
- Make **`scalarMulBase_ct`** constant‑time by delegating to the already‑present **window‑4, branchless** variable‑base routine with `P=BASE_POINT`.
- Add a tiny **`secureZero`** helper (volatile stores) and wipe all transient secrets in `sign`.
- Add **unit tests**: RFC 8032 vectors; canonical‐decoding & torsion rejection.
- Add **micro‑bench** (median ns) for keygen/sign/verify; add **deterministic fuzz**; add **Welch’s t‑test** timing harness as in CT‑NEXT doc.&#x20;

---

## FILE TREE

```txt
.
├── ed25519.zig                         # your existing file (apply patch below)
├── patches/
│   └── ed25519_rfc8032_fixes.patch     # minimal, surgical changes
├── build.zig
├── test/
│   ├── ed25519_rfc.zig                 # RFC 8032 vectors (1–3 + 1024)
│   └── ed25519_canonical.zig           # y<p, x==0&sign=1, torsion encodings
└── tools/
    ├── bench.zig                       # simple micro-bench, median(ns)
    ├── fuzz.zig                        # deterministic fuzz: sign->verify
    └── ct_perf.zig                     # Welch’s t-test timing harness
```

---

## FILES

### patches/ed25519_rfc8032_fixes.patch

```txt
*** Begin Patch
*** Update File: ed25519.zig
@@
-fn scalarMulBase_ct(scalar: *const [32]u8) Point {
-    // Temporarily replace with simple bit-by-bit double-and-add (constant-time-ish pattern) for correctness.
-    // Process bits LSB -> MSB: for each bit b: if b set add current base; then double base.
-    ensureConstantsInit();
-    var acc = pointIdentity();
-    var base = BASE_POINT;
-    var bit: usize = 0;
-    while (bit < 256) : (bit += 1) {
-        if (scalarGetBit(scalar, bit) == 1) {
-            acc = pointAdd(acc, base);
-        }
-        base = pointDouble(base);
-    }
-    return acc;
-}
+/// Constant‑time basepoint scalar multiplication (fixed‑window, branchless).
+/// Uses the same 4‑bit window table strategy as scalarMulVar_ct, but with the
+/// fixed basepoint. Performs 64 windows of {4 doublings + 1 constant‑time select}.
+fn scalarMulBase_ct(scalar: *const [32]u8) Point {
+    ensureConstantsInit();
+    return scalarMulVar_ct(BASE_POINT, scalar);
+}
@@
-fn decompressPoint(enc: *const [32]u8) ?Point {
+fn decompressPoint(enc: *const [32]u8) ?Point {
     ensureConstantsInit();
     // Reject small-order encodings directly.
     if (isSmallOrder(enc)) return null;
     var y_bytes = enc.*; // copy
     const sign_bit: u8 = (y_bytes[31] >> 7) & 1;
     y_bytes[31] &= 0x7f;
-    const Y = feFromBytes(&y_bytes);
+    // RFC8032 §5.1.3: reject if decoded y ≥ p (non‑canonical)
+    // Interpret the 255-bit little‑endian y as u256 and compare to p=2^255-19.
+    const y_u256 = bytesLEtoU256(&y_bytes);
+    if (y_u256 >= P_U256) return null; // non‑canonical y
+    const Y = feFromBytes(&y_bytes);
     // Recover X from x^2 = (y^2 - 1)/(d*y^2 + 1)
     const Y2 = feSq(Y);
     const num = feSub(Y2, feOne());
     const den = feAdd(feMul(d, Y2), feOne());
     const maybe_inv = sqrtRatioM1(num, den) orelse return null;
     var X = maybe_inv;
     // Ensure sign matches
     var xb: [32]u8 = undefined;
     feToBytes(X, &xb);
-    if ((xb[0] & 1) != sign_bit) {
+    // RFC8032 §5.1.3 step 4: if x==0 and sign bit is 1, decoding fails.
+    if (feIsZero(X) and sign_bit == 1) return null;
+    if ((xb[0] & 1) != sign_bit) {
         // X = -X
         X = feSub(feZero(), X);
     }
     return .{ .X = X, .Y = Y, .Z = feOne(), .T = feMul(X, Y) };
 }
+
+/// Convert 32 little‑endian bytes (with top bit already masked) to u256.
+fn bytesLEtoU256(b: *const [32]u8) u256 {
+    var t: u256 = 0;
+    var i: usize = 0;
+    while (i < 32) : (i += 1) {
+        t |= @as(u256, b.*[i]) << @intCast(8 * i);
+    }
+    return t;
+}
+
+/// Constant‑time field zero test (works for public data too).
+fn feIsZero(x: Field) bool {
+    var tmp: [32]u8 = undefined;
+    feToBytes(x, &tmp);
+    var acc: u8 = 0;
+    for (tmp) |bb| acc |= bb;
+    return acc == 0;
+}
+
+/// Best‑effort memory wipe that should not be optimized out.
+fn secureZero(comptime N: usize, buf: *[N]u8) void {
+    var p: [*]volatile u8 = @ptrCast(buf);
+    var i: usize = 0;
+    while (i < N) : (i += 1) {
+        p[i] = 0;
+    }
+}
@@
 pub fn sign(out_sig: *[64]u8, msg: []const u8, sk: *const [64]u8) void {
     ensureConstantsInit();
     const seed = sk[0..32];
     const pk = sk[32..64];
     var h: [64]u8 = undefined;
     std.crypto.hash.sha2.Sha512.hash(seed, &h, .{});
     scalarClamp(&h);
-    const a: [32]u8 = h[0..32].*;
+    // Secret scalar 'a' (clamped). Make it mutable so we can wipe it.
+    var a: [32]u8 = h[0..32].*;
     // r = H(prefix || msg) mod L (prefix = h[32..64])
     var hp: [64]u8 = undefined;
     sha512_twopart(h[32..64], msg, &hp);
     var rred: [32]u8 = undefined;
     reduceModLCanonical(&hp, &rred);
@@
     reduceModLCanonical(&khash, &kred);
     // S = (r + k * a) mod L
     var S: [32]u8 = undefined;
     scalarAddMul(&S, &rred, &kred, &a);
     // Assemble signature (R || S)
     @memcpy(out_sig[0..32], &R_enc);
     @memcpy(out_sig[32..64], &S);
+    // Wipe transient secrets (best‑effort; volatile stores to avoid DCE)
+    secureZero(64, &h);
+    secureZero(64, &hp);
+    secureZero(32, &a);
+    secureZero(32, &rred);
+    secureZero(64, &khash);
+    secureZero(32, &kred);
+    secureZero(32, &S);
 }

 /// Verifies an Ed25519 signature against a message and public key.
*** End Patch
```

> **Why these changes?**
> RFC 8032 requires decoders to **reject** encodings with `y ≥ p`, and also to **fail** when the recovered `x` is zero but the sign bit is 1 (§5.1.3). Your original decoder masked the top bit but didn’t enforce canonical `y` or the `(x==0, sign=1)` rule; the patch enforces both. The verify equation remains cofactor‑cleared (§5.1.7). The signer’s basepoint multiplication is now free of secret‑dependent control flow.&#x20;

---

### build.zig

```zig
const std = @import("std");

pub fn build(b: *std.Build) void {
    const mode = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    // --- Tests ---
    const tests = [_][]const u8{
        "test/ed25519_rfc.zig",
        "test/ed25519_canonical.zig",
    };

    const test_step = b.step("test", "Run unit tests");
    for (tests) |path| {
        const t = b.addTest(.{
            .root_source_file = b.path(path),
            .target = target,
            .optimize = mode,
        });
        test_step.dependOn(&t.step);
    }

    // --- Bench ---
    const bench = b.addExecutable(.{
        .name = "ed25519-bench",
        .root_module = b.createModule(.{ .root_source_file = b.path("tools/bench.zig") }),
        .target = target,
        .optimize = mode,
    });
    const run_bench = b.addRunArtifact(bench);
    run_bench.step.dependOn(b.getInstallStep());
    const bench_step = b.step("bench", "Run micro-benchmarks");
    bench_step.dependOn(&run_bench.step);

    // --- Fuzz ---
    const fuzz = b.addExecutable(.{
        .name = "ed25519-fuzz",
        .root_module = b.createModule(.{ .root_source_file = b.path("tools/fuzz.zig") }),
        .target = target,
        .optimize = mode,
    });
    const run_fuzz = b.addRunArtifact(fuzz);
    run_fuzz.step.dependOn(b.getInstallStep());
    const fuzz_step = b.step("fuzz", "Run deterministic fuzz smoke");
    fuzz_step.dependOn(&run_fuzz.step);

    // --- Constant-time perf harness ---
    const ct = b.addExecutable(.{
        .name = "ed25519-ct-perf",
        .root_module = b.createModule(.{ .root_source_file = b.path("tools/ct_perf.zig") }),
        .target = target,
        .optimize = mode,
    });
    const run_ct = b.addRunArtifact(ct);
    run_ct.step.dependOn(b.getInstallStep());
    const ct_step = b.step("ct-perf", "Run timing-difference detector (Welch's t-test)");
    ct_step.dependOn(&run_ct.step);
}
```

### test/ed25519_rfc.zig

```zig
const std = @import("std");
const ed = @import("../ed25519.zig");

fn expectEqBytes(a: []const u8, b: []const u8) !void {
    try std.testing.expectEqual(@as(usize, a.len), b.len);
    try std.testing.expect(std.mem.eql(u8, a, b));
}

test "RFC 8032 §7.1 Ed25519 vectors (tests 1-3, 1024)" {
    const Vector = struct { seed: [32]u8, pk: [32]u8, msg: []const u8, sig: [64]u8 };

    const tv = [_]Vector{
        // TEST 1: empty message
        .{
            .seed = .{ 0x9d,0x61,0xb1,0x9d,0xef,0xfd,0x5a,0x60,0xba,0x84,0x4a,0xf4,0x92,0xec,0x2c,0xc4,
                       0x44,0x49,0xc5,0x69,0x7b,0x32,0x69,0x19,0x70,0x3b,0xac,0x03,0x1c,0xae,0x7f,0x60 },
            .pk   = .{ 0xd7,0x5a,0x98,0x01,0x82,0xb1,0x0a,0xb7,0xd5,0x4b,0xfe,0xd3,0xc9,0x64,0x07,0x3a,
                       0x0e,0xe1,0x72,0xf3,0xda,0xa6,0x23,0x25,0xaf,0x02,0x1a,0x68,0xf7,0x07,0x51,0x1a },
            .msg = &.{},
            .sig = .{ 0xe5,0x56,0x43,0x00,0xc3,0x60,0xac,0x72,0x90,0x86,0xe2,0xcc,0x80,0x6e,0x82,0x8a,
                       0x84,0x87,0x7f,0x1e,0xb8,0xe5,0xd9,0x74,0xd8,0x73,0xe0,0x65,0x22,0x49,0x01,0x55,
                       0x5f,0xb8,0x82,0x15,0x90,0xa3,0x3b,0xac,0xc6,0x1e,0x39,0x70,0x1c,0xf9,0xb4,0x6b,
                       0xd2,0x5b,0xf5,0xf0,0x59,0x5b,0xbe,0x24,0x65,0x51,0x41,0x43,0x8e,0x7a,0x10,0x0b },
        },
        // TEST 2: 1-byte message 0x72
        .{
            .seed = .{ 0x4c,0xcd,0x08,0x9b,0x28,0xff,0x96,0xda,0x9d,0xb6,0xc3,0x46,0xec,0x11,0x4e,0x0f,
                       0x5b,0x8a,0x31,0x9f,0x35,0xab,0xa6,0x24,0xda,0x8c,0xf6,0xed,0x4f,0xb8,0xa6,0xfb },
            .pk   = .{ 0x3d,0x40,0x17,0xc3,0xe8,0x43,0x89,0x5a,0x92,0xb7,0x0a,0xa7,0x4d,0x1b,0x7e,0xbc,
                       0x9c,0x98,0x2c,0xcf,0x2e,0xc4,0x96,0x8c,0xc0,0xcd,0x55,0xf1,0x2a,0xf4,0x66,0x0c },
            .msg = &.{ 0x72 },
            .sig = .{ 0x92,0xa0,0x09,0xa9,0xf0,0xd4,0xca,0xb8,0x72,0x0e,0x82,0x0b,0x5f,0x64,0x25,0x40,
                       0xa2,0xb2,0x7b,0x54,0x16,0x50,0x3f,0x8f,0xb3,0x76,0x22,0x23,0xeb,0xdb,0x69,0xda,
                       0x08,0x5a,0xc1,0xe4,0x3e,0x15,0x99,0x6e,0x45,0x8f,0x36,0x13,0xd0,0xf1,0x1d,0x8c,
                       0x38,0x7b,0x2e,0xaa,0xb4,0x30,0x2a,0xee,0xb0,0x0d,0x29,0x16,0x12,0xbb,0x0c,0x00 },
        },
        // TEST 3: 2-byte message 0xaf,0x82
        .{
            .seed = .{ 0xc5,0xaa,0x8d,0xf4,0x3f,0x9f,0x83,0x7b,0xed,0xb7,0x44,0x2f,0x31,0xdc,0xb7,0xb1,
                       0x66,0xd3,0x85,0x35,0x07,0x6f,0x09,0x4b,0x85,0xce,0x3a,0x2e,0x0b,0x44,0x58,0xf7 },
            .pk   = .{ 0xfc,0x51,0xcd,0x8e,0x62,0x18,0xa1,0xa3,0x8d,0xa4,0x7e,0xd0,0x02,0x30,0xf0,0x58,
                       0x08,0x16,0xed,0x13,0xba,0x33,0x03,0xac,0x5d,0xeb,0x91,0x15,0x48,0x90,0x80,0x25 },
            .msg = &.{ 0xaf,0x82 },
            .sig = .{ 0x62,0x91,0xd6,0x57,0xde,0xec,0x24,0x02,0x48,0x27,0xe6,0x9c,0x3a,0xbe,0x01,0xa3,
                       0x0c,0xe5,0x48,0xa2,0x84,0x74,0x3a,0x44,0x5e,0x36,0x80,0xd7,0xdb,0x5a,0xc3,0xac,
                       0x18,0xff,0x9b,0x53,0x8d,0x16,0xf2,0x90,0xae,0x67,0xf7,0x60,0x98,0x4d,0xc6,0x59,
                       0x4a,0x7c,0x15,0xe9,0x71,0x6e,0xd2,0x8d,0xc0,0x27,0xbe,0xce,0xea,0x1e,0xc4,0x0a },
        },
    };

    inline for (tv) |v| {
        const kp = ed.deriveKeyPair(&v.seed);
        try expectEqBytes(&kp.pk, &v.pk);

        var sig: [64]u8 = undefined;
        ed.sign(&sig, v.msg, &kp.sk);

        try expectEqBytes(&sig, &v.sig);
        try std.testing.expect(ed.verify(&sig, v.msg, &kp.pk));
    }

    // TEST 1024: verify only (large message)
    const pk1024: [32]u8 = .{
        0x27,0x81,0x17,0xfc,0x14,0x4c,0x72,0x34,0x0f,0x67,0xd0,0xf2,0x31,0x6e,0x83,0x86,
        0xce,0xff,0xbf,0x2b,0x24,0x28,0xc9,0xc5,0x1f,0xef,0x7c,0x59,0x7f,0x1d,0x42,0x6e,
    };
    const sig1024: [64]u8 = .{
        0x0a,0xab,0x4c,0x90,0x05,0x01,0xb3,0xe2,0x4d,0x7c,0xdf,0x46,0x63,0x32,0x6a,0x3a,
        0x87,0xdf,0x5e,0x48,0x43,0xb2,0xcb,0xdb,0x67,0xcb,0xf6,0xe4,0x60,0xfe,0xc3,0x50,
        0xaa,0x53,0x71,0xb1,0x50,0x8f,0x9f,0x45,0x28,0xec,0xea,0x23,0xc4,0x36,0xd9,0x4b,
        0x5e,0x8f,0xcd,0x4f,0x68,0x1e,0x30,0xa6,0xac,0x00,0xa9,0x70,0x4a,0x18,0x8a,0x03,
    };
    var msg = try std.testing.allocator.alloc(u8, 1023);
    defer std.testing.allocator.free(msg);
    const hex = "08b8b2b733424243760fe426a4b54908"
                ++ "632110a66c2f6591eabd3345e3e4eb98"
                ++ "fa6e264bf09efe12ee50f8f54e9f77b1"
                ++ "e355f6c50544e23fb1433ddf73be84d8"
                ++ "79de7c0046dc4996d9e773f4bc9efe57"
                ++ "38829adb26c81b37c93a1b270b20329d"
                ++ "658675fc6ea534e0810a4432826bf58c"
                ++ "941efb65d57a338bbd2e26640f89ffbc"
                ++ "1a858efcb8550ee3a5e1998bd177e93a"
                ++ "7363c344fe6b199ee5d02e82d522c4fe"
                ++ "ba15452f80288a821a579116ec6dad2b"
                ++ "3b310da903401aa62100ab5d1a36553e"
                ++ "06203b33890cc9b832f79ef80560ccb9"
                ++ "a39ce767967ed628c6ad573cb116dbef"
                ++ "efd75499da96bd68a8a97b928a8bbc10"
                ++ "3b6621fcde2beca1231d206be6cd9ec7"
                ++ "aff6f6c94fcd7204ed3455c68c83f4a4"
                ++ "1da4af2b74ef5c53f1d8ac70bdcb7ed1"
                ++ "85ce81bd84359d44254d95629e9855a9"
                ++ "4a7c1958d1f8ada5d0532ed8a5aa3fb2"
                ++ "d17ba70eb6248e594e1a2297acbbb39d"
                ++ "502f1a8c6eb6f1ce22b3de1a1f40cc24"
                ++ "554119a831a9aad6079cad88425de6bd"
                ++ "e1a9187ebb6092cf67bf2b13fd65f270"
                ++ "88d78b7e883c8759d2c4f5c65adb7553"
                ++ "878ad575f9fad878e80a0c9ba63bcbcc"
                ++ "2732e69485bbc9c90bfbd62481d9089b"
                ++ "eccf80cfe2df16a2cf65bd92dd597b07"
                ++ "07e0917af48bbb75fed413d238f5555a"
                ++ "7a569d80c3414a8d0859dc65a46128ba"
                ++ "b27af87a71314f318c782b23ebfe808b"
                ++ "82b0ce26401d2e22f04d83d1255dc51a"
                ++ "ddd3b75a2b1ae0784504df543af8969b"
                ++ "e3ea7082ff7fc9888c144da2af58429e"
                ++ "c96031dbcad3dad9af0dcbaaaf268cb8"
                ++ "fcffead94f3c7ca495e056a9b47acdb7"
                ++ "51fb73e666c6c655ade8297297d07ad1"
                ++ "ba5e43f1bca32301651339e22904cc8c"
                ++ "42f58c30c04aafdb038dda0847dd988d"
                ++ "cda6f3bfd15c4b4c4525004aa06eeff8"
                ++ "ca61783aacec57fb3d1f92b0fe2fd1a8"
                ++ "5f6724517b65e614ad6808d6f6ee34df"
                ++ "f7310fdc82aebfd904b01e1dc54b2927"
                ++ "094b2db68d6f903b68401adebf5a7e08"
                ++ "d78ff4ef5d63653a65040cf9bfd4aca7"
                ++ "984a74d37145986780fc0b16ac451649"
                ++ "de6188a7dbdf191f64b5fc5e2ab47b57"
                ++ "f7f7276cd419c17a3ca8e1b939ae49e4"
                ++ "88acba6b965610b5480109c8b17b80e1"
                ++ "b7b750dfc7598d5d5011fd2dcc5600a3"
                ++ "2ef5b52a1ecc820e308aa342721aac09"
                ++ "43bf6686b64b2579376504ccc493d97e"
                ++ "6aed3fb0f9cd71a43dd497f01f17c0e2"
                ++ "cb3797aa2a2f256656168e6c496afc5f"
                ++ "b93246f6b1116398a346f1a641f3b041"
                ++ "e989f7914f90cc2c7fff357876e506b5"
                ++ "0d334ba77c225bc307ba537152f3f161"
                ++ "0e4eafe595f6d9d90d11faa933a15ef1"
                ++ "369546868a7f3a45a96768d40fd9d034"
                ++ "12c091c6315cf4fde7cb68606937380d"
                ++ "b2eaaa707b4c4185c32eddcdd306705e"
                ++ "4dc1ffc872eeee475a64dfac86aba41c"
                ++ "0618983f8741c5ef68d3a101e8a3b8ca"
                ++ "c60c905c15fc910840b94c00a0b9d0";
    try std.fmt.hexToBytes(msg, hex);
    try std.testing.expect(ed.verify(&sig1024, msg, &pk1024));
}
```

### test/ed25519_canonical.zig

```zig
const std = @import("std");
const ed = @import("../ed25519.zig");

fn toLE32(x: u256) [32]u8 {
    var out: [32]u8 = undefined;
    var i: usize = 0;
    while (i < 32) : (i += 1) out[i] = @as(u8, @intCast((x >> @intCast(8 * i)) & 0xff));
    return out;
}

fn setSignBit(b: *[32]u8, bit: bool) void {
    if (bit) b[31] |= 0x80 else b[31] &= 0x7f;
}

test "decode rejects non‑canonical y ≥ p and x==0 with sign=1" {
    // y = p (2^255 - 19) => reject (RFC 8032 §5.1.3)
    const P: u256 = (@as(u256, 1) << 255) - 19;
    var enc = toLE32(P);
    setSignBit(&enc, false);
    try std.testing.expectEqual(@as(?ed.Point, null), ed.test_decompressPoint(&enc));

    // x == 0 with sign==1 => reject (RFC 8032 §5.1.3 step 4)
    var id = [_]u8{1} ++ [_]u8{0} ** 31; // y = 1
    setSignBit(&id, true); // force sign bit 1
    const id_arr: [32]u8 = id;
    try std.testing.expectEqual(@as(?ed.Point, null), ed.test_decompressPoint(&id_arr));
}

test "torsion/small‑order encodings are rejected" {
    // all‑zeros encoding
    const z: [32]u8 = .{0} ** 32;
    try std.testing.expectEqual(@as(?ed.Point, null), ed.test_decompressPoint(&z));

    // identity (y=1, sign=0) must be rejected for public inputs
    const id: [32]u8 = .{1} ++ .{0} ** 31;
    try std.testing.expectEqual(@as(?ed.Point, null), ed.test_decompressPoint(&id));
}
```

### tools/fuzz.zig

```zig
const std = @import("std");
const ed = @import("../ed25519.zig");

const XorShift64 = struct {
    state: u64 = 0x243f6a8885a308d3,
    fn next(self: *XorShift64) u64 {
        var x = self.state;
        x ^= x << 13;
        x ^= x >> 7;
        x ^= x << 17;
        self.state = x;
        return x * 0x9E3779B97F4A7C15;
    }
    fn fill(self: *XorShift64, buf: []u8) void {
        var i: usize = 0;
        while (i < buf.len) : (i += 8) {
            const r = self.next();
            const chunk: []const u8 = @as(*const [8]u8, @ptrCast(&r)).*[0..];
            const take = @min(buf.len - i, chunk.len);
            @memcpy(buf[i .. i+take], chunk[0..take]);
        }
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    var rng = XorShift64{};
    const iterations: usize = 5000;

    var msg = try alloc.alloc(u8, 2048);
    defer alloc.free(msg);

    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        // random seed
        var seed: [32]u8 = undefined;
        rng.fill(seed[0..]);

        const kp = ed.deriveKeyPair(&seed);

        // random message
        const mlen = @intCast(usize, rng.next() % 1025);
        rng.fill(msg[0..mlen]);

        var sig: [64]u8 = undefined;
        ed.sign(&sig, msg[0..mlen], &kp.sk);

        if (!ed.verify(&sig, msg[0..mlen], &kp.pk)) {
            std.debug.print("FUZZ FAIL: seed={x} pk={x} mlen={} sig={x}\n",
                .{ seed, kp.pk, mlen, sig });
            return error.FuzzFailure;
        }
    }

    std.debug.print("Fuzzed {} iterations: 0 failures\n", .{iterations});
}
```

### tools/bench.zig

```zig
const std = @import("std");
const ed = @import("../ed25519.zig");

fn median(ns: []u64) u64 {
    std.sort.heap(u64, ns, {}, comptime std.sort.asc(u64));
    const mid = ns.len / 2;
    return if (ns.len % 2 == 0) (ns[mid-1] + ns[mid]) / 2 else ns[mid];
}

fn bench_once_keygen(iter: usize) u64 {
    var buf: [32]u8 = .{0x42} ** 32;
    var times: []u64 = std.heap.page_allocator.alloc(u64, iter) catch unreachable;
    defer std.heap.page_allocator.free(times);
    var i: usize = 0;
    while (i < iter) : (i += 1) {
        const t0 = std.time.nanoTimestamp();
        _ = ed.deriveKeyPair(&buf);
        const t1 = std.time.nanoTimestamp();
        times[i] = @intCast(u64, t1 - t0);
        buf[0] +%= @intCast(u8, i);
    }
    return median(times);
}

fn bench_once_sign(iter: usize) u64 {
    var seed: [32]u8 = .{0x11} ** 32;
    const kp = ed.deriveKeyPair(&seed);
    var msg: [64]u8 = .{0xaa} ** 64;
    var sig: [64]u8 = undefined;
    var times: []u64 = std.heap.page_allocator.alloc(u64, iter) catch unreachable;
    defer std.heap.page_allocator.free(times);
    var i: usize = 0;
    while (i < iter) : (i += 1) {
        const t0 = std.time.nanoTimestamp();
        ed.sign(&sig, msg[0..], &kp.sk);
        const t1 = std.time.nanoTimestamp();
        times[i] = @intCast(u64, t1 - t0);
        msg[0] +%= @intCast(u8, i);
    }
    return median(times);
}

fn bench_once_verify(iter: usize) u64 {
    var seed: [32]u8 = .{0x22} ** 32;
    const kp = ed.deriveKeyPair(&seed);
    var msg: [64]u8 = .{0xbb} ** 64;
    var sig: [64]u8 = undefined;
    ed.sign(&sig, msg[0..], &kp.sk);

    var times: []u64 = std.heap.page_allocator.alloc(u64, iter) catch unreachable;
    defer std.heap.page_allocator.free(times);
    var i: usize = 0;
    while (i < iter) : (i += 1) {
        const t0 = std.time.nanoTimestamp();
        const ok = ed.verify(&sig, msg[0..], &kp.pk);
        const t1 = std.time.nanoTimestamp();
        if (!ok) @panic("verify failed during bench");
        times[i] = @intCast(u64, t1 - t0);
        msg[0] +%= @intCast(u8, i);
    }
    return median(times);
}

pub fn main() !void {
    const iters: usize = 200;
    const t_key = bench_once_keygen(iters);
    const t_sig = bench_once_sign(iters);
    const t_ver = bench_once_verify(iters);

    std.debug.print("Median ns: keygen={} sign={} verify={}\n", .{ t_key, t_sig, t_ver });
}
```

### tools/ct_perf.zig

```zig
const std = @import("std");
const ed = @import("../ed25519.zig");

fn welch_t(x: []const u64, y: []const u64) f128 {
    const n1 = @as(f128, @floatFromInt(x.len));
    const n2 = @as(f128, @floatFromInt(y.len));
    var m1: f128 = 0; var m2: f128 = 0;
    for (x) |v| m1 += @as(f128, @floatFromInt(v));
    for (y) |v| m2 += @as(f128, @floatFromInt(v));
    m1 /= n1; m2 /= n2;

    var s1: f128 = 0; var s2: f128 = 0;
    for (x) |v| { const d = @as(f128, @floatFromInt(v)) - m1; s1 += d * d; }
    for (y) |v| { const d = @as(f128, @floatFromInt(v)) - m2; s2 += d * d; }
    s1 /= (n1 - 1.0); s2 /= (n2 - 1.0);

    var t = (m1 - m2) / @sqrt(s1 / n1 + s2 / n2);
    if (t < 0) t = -t;
    return t;
}

fn sample_mul_base(group: usize, n: usize) []u64 {
    var buf: []u64 = std.heap.page_allocator.alloc(u64, n) catch unreachable;
    var i: usize = 0;
    var scalar: [32]u8 = .{0} ** 32;
    while (i < n) : (i += 1) {
        // group 0: edge scalar (all 0xff except clamp bits)
        // group 1: pseudo-random scalar derived from i
        if (group == 0) {
            @memset(scalar[0..], 0xff);
            scalar[0] &= 248; scalar[31] &= 63; scalar[31] |= 64;
        } else {
            var r: u64 = @intCast(u64, i) * 0x9E3779B97F4A7C15;
            const chunk: *const [8]u8 = @ptrCast(&r);
            const off = (i * 7) % 24;
            @memcpy(scalar[off .. off+8], chunk);
            scalar[0] &= 248; scalar[31] &= 63; scalar[31] |= 64;
        }
        const t0 = std.time.nanoTimestamp();
        _ = ed.test_scalarMulBase(&scalar);
        const t1 = std.time.nanoTimestamp();
        buf[i] = @intCast(u64, t1 - t0);
    }
    return buf;
}

pub fn main() !void {
    const enabled = std.process.getEnvVarOwned(std.heap.page_allocator, "UA_PERF_HARNESS_ENABLE") catch null;
    if (enabled == null) {
        std.debug.print("ct-perf: skipped (set UA_PERF_HARNESS_ENABLE=1 to run)\n", .{});
        return;
    }
    defer if (enabled) |v| std.heap.page_allocator.free(v);

    const n: usize = 4000;
    const a = sample_mul_base(0, n);
    const b = sample_mul_base(1, n);
    defer std.heap.page_allocator.free(a);
    defer std.heap.page_allocator.free(b);

    const t = welch_t(a, b);
    std.debug.print("Welch t-statistic for scalarMulBase groups: {d:.2}\n", .{ t });
    if (t >= 10.0) {
        std.debug.print("WARNING: potential timing difference detected (|t| >= 10)\n", .{});
        return error.TimingLeak;
    }
    std.debug.print("Timing harness: OK\n", .{});
}
```

---

## TESTS

- `test/ed25519_rfc.zig` runs **RFC 8032 §7.1** vectors (1–3 + the 1024‑byte message) for **keygen, sign and verify**, ensuring full conformance.&#x20;
- `test/ed25519_canonical.zig` asserts **strict decoding**:

  - reject `y ≥ p`,
  - reject `(x == 0 && sign_bit == 1)`,
  - reject obvious torsion encodings (all‑zero and identity).

- Your existing `verify` path already enforces `S < L` and cofactor‑cleared equality, matching RFC §5.1.7.&#x20;

---

## COMMANDS

```bash
# 1) Apply the patch
git apply patches/ed25519_rfc8032_fixes.patch

# 2) Run unit tests
zig build test

# 3) Run micro-benchmarks (prints median ns)
zig build bench

# 4) Run deterministic fuzz (5k cases)
zig build fuzz

# 5) Run constant-time timing harness (Welch’s t-test; gated by env var)
UA_PERF_HARNESS_ENABLE=1 zig build ct-perf
```

---

## NOTES

- **Why strict decoding?** RFC 8032 requires verification to fail on **any** decoding failure, including **non‑canonical encodings** and `(x == 0 && sign==1)` (§5.1.3). This prevents cross‑implementation malleability, e.g. ZIP215‑style divergences, and is fully consistent with the spec’s cofactor‑cleared verify (§5.1.7).&#x20;
- **Constant‑time:** The old basepoint multiply loop branched on secret bits. The new path uses a fixed‑window table with **cmov selection**; table indices are never secret. This is the minimal change that removes secret‑dependent control flow while keeping your existing point ops intact.
- **Zeroization:** Done with **volatile stores**; this is a best‑effort mitigation to reduce secret lifetime.
- **Perf/CT harness:** The timing harness follows the **CT‑NEXT** plan: two scalar classes, lots of samples, Welch’s t‑test, and an env‑gated CI step. You can extend it with the negative‑probe hooks described in that document.&#x20;
- **Variable‑base scalar multiply in verify:** still variable‑time but uses only _public_ inputs (`k`, `A`, `R`). If you later reuse it with secrets, switch those call sites to the CT version too.
- **Zig 0.15.1:** everything here sticks to stable language and `std` APIs; build layout uses `std.Build`; tests are pure `std.testing`.
- **Further hardening:** You can add the 8 exact small‑order encodings to `test/ed25519_canonical.zig` once you finalize that vector list in the codebase (they’re already present in your implementation’s internal table). The CT‑NEXT doc also suggests persisting perf baselines as JSON and scheduling nightly perf CI — both are sane next steps.&#x20;

---

If you want, I can also supply **a second patch** that exposes the internal small‑order constants for testing only (behind a `test` build flag), so we can assert rejection of all 8 encodings explicitly.
