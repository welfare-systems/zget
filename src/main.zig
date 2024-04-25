const std = @import("std");
const cli = @import("./modules/cli/main.zig");

const print = std.debug.print;
const http = std.http;

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

var config = struct {
    host: []const u8 = undefined,
}{};

var host_option = cli.Option{
    .long_name = "host",
    .help = "The host to search for the file to download",
    .value_ref = cli.mkRef(&config.host),
    .required = true,
};

var app = &cli.App{
    .command = cli.Command{
        .name = "zget",
        .options = &.{&host_option},
        .description = cli.Description{
            .one_line = "Download a file from the web",
        },
        .target = cli.CommandTarget{ .action = cli.CommandAction{ .exec = connnectByGet } },
    },
};

pub fn main() !void {
    return cli.run(app, allocator);
}

pub fn connnectByGet() !void {
    var client = http.Client{ .allocator = allocator };
    defer client.deinit();

    const uri = try std.Uri.parse(config.host);
    const buf = try allocator.alloc(u8, 1024 * 1024 * 4);
    defer allocator.free(buf);
    var req = try client.open(.GET, uri, .{
        .server_header_buffer = buf,
    });
    defer req.deinit();

    try req.send();
    try req.finish();
    try req.wait();

    var iter = req.response.iterateHeaders();
    while (iter.next()) |header| {
        std.debug.print("Name:{s}, Value:{s}\n", .{ header.name, header.value });
    }

    try std.testing.expectEqual(req.response.status, .ok);

    var rdr = req.reader();
    const body = try rdr.readAllAlloc(allocator, 1024 * 1024 * 4);
    defer allocator.free(body);

    print("Body:\n{s}\n", .{body});
}
