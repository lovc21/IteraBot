const root = @import("root.zig");
pub const std = root.std;
const Cli = root.cli.Cli;

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stdout_buf: [256]u8 = undefined;
    var stdin_buf: [256]u8 = undefined;
    var stderr_buf: [256]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buf);
    var stdin_reader = std.fs.File.stdin().reader(&stdin_buf);
    var stderr_writer = std.fs.File.stderr().writer(&stderr_buf);
    const stdout = &stdout_writer.interface;
    const stdin = &stdin_reader.interface;
    const stderr = &stderr_writer.interface;

    const cli = Cli{
        .stdout = stdout,
        .stdin = stdin,
        .stderr = stderr,
    };

    try stdout.print("Starting isolation...\n", .{});
    try stdout.flush();

    try cli.parse_args(allocator);
}
