const root = @import("root");
const std = root.std;

pub const Cli = struct {
    stdout: *std.Io.Writer,
    stdin: *std.Io.Reader,
    stderr: *std.Io.Writer,

    pub fn parse_args(self: Cli, allocator: std.mem.Allocator) !void {
        _ = self;
        var args = try std.process.argsWithAllocator(allocator);
        defer args.deinit();

        _ = args.skip();

        var commands_list: std.ArrayList([]const u8) = .empty;
        defer commands_list.deinit(allocator);

        while (args.next()) |arg| {
            if (std.mem.eql(u8, arg, "--help")) {
                return error.Help;
            } else if (std.mem.eql(u8, arg, "--version")) {
                return error.Version;
            } else if (std.mem.eql(u8, arg, "--instances")) {
                try commands_list.append(allocator, args.next().?);
            }
        }
    }
};
