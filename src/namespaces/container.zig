const root = @import("root");
const std = root.std;
const linux = std.os.linux;

pub fn create_container(number: u32) !void {
    _ = number;

    const rc = linux.unshare(linux.CLONE_NEWNS);

    const err = linux.getErrno(rc);
    if (err != .SUCCESS) {
        return error.UnshareFailed;
    }
}
