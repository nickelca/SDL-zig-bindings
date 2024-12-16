pub fn Init() !void {
    const ret = C.TTF_Init();
    if (ret < 0) {
        return error.TTF_Init;
    }
}

pub fn Deinit() void {
    C.TTF_Quit();
}

pub const Font = @import("TTF/Font.zig");
pub const C = @import("C");

const SDL = @import("root.zig");
const std = @import("std");
