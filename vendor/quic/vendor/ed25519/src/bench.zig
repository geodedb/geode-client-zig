const std = @import("std");
const ed = @import("ed25519");

const SignCtx = struct { sk: *const [64]u8, msg: []const u8, out: *[64]u8 };
const VerifyCtx = struct { pk: *const [32]u8, msg: []const u8, sig: *[64]u8 };
const KeygenCtx = struct { seed: *[32]u8 };

fn doSign(c: SignCtx) void {
    ed.sign(c.out, c.msg, c.sk);
}
fn doVerify(c: VerifyCtx) void {
    _ = ed.verify(c.sig, c.msg, c.pk);
}
fn doKeygen(c: KeygenCtx) void {
    const local = ed.deriveKeyPair(c.seed);
    std.mem.doNotOptimizeAway(local.pk);
}

fn bench(name: []const u8, iters: usize, ctx: anytype, func: fn (@TypeOf(ctx)) void) void {
    const t0 = std.time.nanoTimestamp();
    var i: usize = 0;
    while (i < iters) : (i += 1) func(ctx);
    const dt = std.time.nanoTimestamp() - t0;
    const per = @divTrunc(dt, @as(i128, @intCast(iters)));
    std.debug.print("{s}: iters={d} total_ns={d} ns_per={d}\n", .{ name, iters, dt, per });
}

pub fn main() !void {
    var seed: [32]u8 = undefined;
    for (&seed, 0..) |*b, idx| b.* = @as(u8, @intCast(idx));
    var kp = ed.deriveKeyPair(&seed);

    var msg_small: [64]u8 = undefined;
    for (&msg_small, 0..) |*b, idx| b.* = @as(u8, @intCast(255 - idx));

    // Copy data into global static for nested fn access pattern.
    var sig: [64]u8 = undefined;

    bench("keygen", 10_000, KeygenCtx{ .seed = &seed }, doKeygen);
    bench("sign", 10_000, SignCtx{ .sk = &kp.sk, .msg = msg_small[0..], .out = &sig }, doSign);
    // Precompute one signature for verify to avoid sign cost in verify loop.
    ed.sign(&sig, msg_small[0..], &kp.sk);
    bench("verify", 10_000, VerifyCtx{ .pk = &kp.pk, .msg = msg_small[0..], .sig = &sig }, doVerify);
}
