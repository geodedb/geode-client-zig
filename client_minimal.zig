const std = @import("std");
const geode = @import("geode"); // access unicode utilities

// Minimal client for cross-compilation testing
pub const Config = struct {
    host: []const u8 = "127.0.0.1",
    port: u16 = 3141,
};

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: Config,

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator, config: Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    pub fn connect(self: *Self) !void {
        _ = self;
        // Minimal implementation for testing
    }

    pub fn disconnect(self: *Self) void {
        _ = self;
    }

    pub fn execute(self: *Self, query: []const u8) !Result {
        _ = self;
        _ = query;
        return Result{
            .schema = Schema{
                .columns = &[_]Column{
                    Column{ .name = "x", .type_name = "INT" },
                },
            },
        };
    }

    // Unicode convenience wrappers delegate to core geode unicode module
    // CANARY: REQ=REQ-GQL-UNICODE-012; FEATURE="UTF-8 -> UTF-16 Conversion"; ASPECT=ClientWrapperZig; STATUS=TESTED; TEST=TestCANARY_ClientUnicode_Utf8ToUtf16; OWNER=clients; UPDATED=2025-09-27
    pub fn utf8ToUtf16Alloc(self: *Self, src: []const u8) ![]u16 {
        return try geode.unicode.utf8ToUtf16Alloc(self.allocator, src);
    }
    // CANARY: REQ=REQ-GQL-UNICODE-013; FEATURE="UTF-16 -> UTF-8 Conversion"; ASPECT=ClientWrapperZig; STATUS=TESTED; TEST=TestCANARY_ClientUnicode_Utf16ToUtf8; OWNER=clients; UPDATED=2025-09-27
    pub fn utf16ToUtf8Alloc(self: *Self, src: []const u16) ![]u8 {
        return try geode.unicode.utf16ToUtf8Alloc(self.allocator, src);
    }
    // CANARY: REQ=REQ-GQL-UNICODE-014; FEATURE="WTF-8 Lossy Decode"; ASPECT=ClientWrapperZig; STATUS=TESTED; TEST=TestCANARY_ClientUnicode_Wtf8Lossy; OWNER=clients; UPDATED=2025-09-27
    pub fn wtf8LossyToUtf8Alloc(self: *Self, src: []const u8) ![]u8 {
        return try geode.unicode.wtf8LossyToUtf8Alloc(self.allocator, src);
    }
};

pub const Schema = struct {
    columns: []const Column,
};

pub const Column = struct {
    name: []const u8,
    type_name: []const u8,
};

pub const Result = struct {
    schema: Schema,

    pub fn deinit(self: *Result) void {
        _ = self;
    }
};
