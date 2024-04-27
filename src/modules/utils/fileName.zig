pub fn extractFileName(path: []const u8) ![]const u8 {
    var fileNameStart = path.len - 1;
    while (fileNameStart >= 0 and path[fileNameStart] != '/' and path[fileNameStart] != '\\') {
        fileNameStart -= 1;
    }

    return path[fileNameStart + 1 ..];
}
