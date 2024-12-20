const window_width = 800;
const window_height = 600;

pub fn main() !void {
    try SDL.Init(.{ .video = true });
    defer SDL.Deinit();

    if (builtin.os.tag == .linux and comptime SDL.Version_At_Least(2, 0, 8)) {
        try SDL.Set_Hint(.video_x11_net_wm_bypass_compositor, "0");
    }

    const window: SDL.Window = try .Create(
        "Example window",
        .undefined,
        .undefined,
        window_width,
        window_height,
        .{ .shown = true },
    );
    defer window.Destroy();

    const renderer: SDL.Renderer = try .Create(window, null, .{ .accelerated = true });
    defer renderer.Destroy();
    try renderer.Set_Blend_Mode(.blend);

    var rect: SDL.Rect(.i32) = .{
        .width = @min(window_width, window_height) / 2,
        .height = @min(window_width, window_height) / 2,
        .x = window_width / 2,
        .y = window_height / 2,
    };
    rect.x -= @divFloor(rect.width, 2);
    rect.y -= @divFloor(rect.height, 2);

    var quit: bool = false;
    while (!quit) {
        while (SDL.Poll_Event()) |e| switch (e) {
            .quit => quit = true,
            else => {},
        };

        try renderer.Set_Draw_Color(.white);
        try renderer.Clear();
        try renderer.Set_Draw_Color(.red);
        try renderer.Fill_Rect(rect);

        renderer.Present();
    }
}

const SDL = @import("SDL");
const builtin = @import("builtin");
const std = @import("std");
