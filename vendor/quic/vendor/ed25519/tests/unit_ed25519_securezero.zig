const std = @import("std");
const ed = @import("../src/ed25519.zig");

test "ed25519 secureZero wipes buffer" {
    var buf: [64]u8 = undefined;
    // Fill with pattern
    for (buf, 0..) |_, i| buf[i] = @intCast((i * 37) & 0xff);
    // Ensure non-zero present
    var any_non_zero = false;
    for (buf) |b| {
        if (b != 0) {
            any_non_zero = true;
            break;
        }
    }
    try std.testing.expect(any_non_zero);
    ed.secureZero(buf[0..]);
    for (buf) |b| try std.testing.expect(b == 0);
}
