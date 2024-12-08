pub const Window = @This();

handle: *SDL.C.SDL_Window,

const Coordinate = enum(i32) {
    pub const centered: Coordinate = .From_I32(SDL.C.SDL_WINDOWPOS_CENTERED);
    pub const @"undefined": Coordinate = .From_I32(SDL.C.SDL_WINDOWPOS_UNDEFINED);
    _,

    pub fn From_I32(v: i32) Coordinate {
        return @enumFromInt(v);
    }
};

pub fn Create(title: [:0]const u8, x: Coordinate, y: Coordinate, w: i32, h: i32, flags: Create_Flags) !Window {
    const handle = SDL.C.SDL_CreateWindow(
        title.ptr,
        @intFromEnum(x),
        @intFromEnum(y),
        w,
        h,
        @bitCast(flags),
    ) orelse {
        SDL.Log_Error("Window.Create");
        return error.Creation_Failed;
    };
    return .{
        .handle = handle,
    };
}

pub fn Destroy(self: Window) void {
    SDL.C.SDL_DestroyWindow(self.handle);
}

pub const Create_Flags = packed struct(u32) {
    fullscreen: bool = false, // fullscreen window
    opengl: bool = false, // window usable with OpenGL context
    shown: bool = false, // window is visible
    hidden: bool = false, // window is not visible
    borderless: bool = false, // no window decoration
    resizable: bool = false, // window can be resized
    minimized: bool = false, // window is minimized
    maximized: bool = false, // window is maximized
    mouse_grabbed: bool = false, // window has grabbed mouse input
    // input_grabbed: bool = false, // equivalent to SDL_WINDOW_MOUSE_GRABBED for compatibility
    input_focus: bool = false, // window has input focus
    mouse_focus: bool = false, // window has mouse focus
    foreign: bool = false, // window not created by SDL
    desktop: bool = false, // Use with WindowFlags.fullscreen
    allow_highdpi: bool = false, // window should be created in high-DPI mode if supported.
    //   On macOS NSHighResolutionCapable must be set true in the
    //   application's Info.plist for this to have any effect.
    mouse_capture: bool = false, // window has mouse captured (unrelated to mouse_grabbed)
    always_on_top: bool = false, // window should always be above others
    skip_taskbar: bool = false, // window should not be added to the taskbar
    utility: bool = false, // window should be treated as a utility window
    tooltip: bool = false, // window should be treated as a tooltip
    popup_menu: bool = false, // window should be treated as a popup menu
    keyboard_grabbed: bool = false, // window has grabbed keyboard input
    __pad1: u7 = 0,
    vulkan: bool = false, // window usable for Vulkan surface
    metal: bool = false, // window usable for Metal view
    __pad2: u2 = 0,
};

const SDL = @import("root.zig");
const std = @import("std");
