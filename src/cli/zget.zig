const std = @import("std");
const cli = @import("../modules/zig-cli/main.zig");
const fileName = @import("../modules/utils/fileName.zig");

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

pub const app = &cli.App{
    .command = cli.Command{
        .name = "zget",
        .options = &.{&host_option},
        .description = cli.Description{
            .one_line = "Download a file from the web",
        },
        .target = cli.CommandTarget{ .action = cli.CommandAction{ .exec = connnectByGet } },
    },
};

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

    try std.testing.expectEqual(req.response.status, .ok);

    var rdr = req.reader();

    const name = try fileName.extractFileName(config.host);
    var output_file = try std.fs.cwd().createFile(
        name,
        .{ .read = true },
    );
    defer output_file.close();

    var buffer: [1024]u8 = undefined;

    while (true) {
        const chunk = try rdr.read(buffer[0..]);
        if (chunk == 0) {
            // End of file
            break;
        }

        // Write the chunk to the output file
        try output_file.writeAll(buffer[0..chunk]);
    }
}
