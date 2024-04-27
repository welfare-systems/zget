const std = @import("std");
const app = @import("./cli/zget.zig").app;
const cli = @import("./modules/zig-cli/main.zig");

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

pub fn main() !void {
    return cli.run(app, allocator);
}
