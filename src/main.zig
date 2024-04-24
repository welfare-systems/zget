const std = @import("std");
const cli = @import("./modules/cli/main.zig");
const get = @import("./http/connect.zig");

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
        .target = cli.CommandTarget{ .action = cli.CommandAction{ .exec = get.connnectByGet } },
    },
};

pub fn main() !void {
    return cli.run(app, allocator);
}
