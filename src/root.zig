pub fn Init(flags: Init_Flags) !void {
    if (C.SDL_Init(@bitCast(flags)) < 0) {
        Log_Error("Init");
        return error.SDL_Init;
    }
}

pub fn Deinit() void {
    C.SDL_Quit();
}

pub fn Get_Error() ?[*:0]const u8 {
    return C.SDL_GetError();
}

pub fn Version_At_Least(major: i32, minor: i32, patch: u32) bool {
    return major <= major_version and
        (major < major_version or minor <= minor_version) and
        (major < major_version or minor < minor_version or patch <= patch_level);
}

pub fn Wait_Event() !Event {
    var e: C.SDL_Event = undefined;
    if (C.SDL_WaitEvent(&e) != 1) {
        Log_Error("Wait_Event");
        return error.SDL_Wait_Error;
    }
    return Event.From_C(e);
}

pub fn Poll_Event() ?Event {
    var e: C.SDL_Event = undefined;
    if (C.SDL_PollEvent(&e) == 0) {
        return null;
    }
    return Event.From_C(e);
}

pub const Init_Flags = packed struct(u32) {
    timer: bool = false,
    __pad1: u2 = 0,
    audio: bool = false,
    video: bool = false, // Implies InitFlags.events
    __pad2: u4 = 0,
    joystick: bool = false, // Implies InitFlags.events
    __pad3: u2 = 0,
    haptic: bool = false,
    game_controller: bool = false, // Implies InitFlags.joystick
    events: bool = false,
    sensor: bool = false,
    __pad4: u4 = 0,
    no_parachute: bool = false, // compatibility; this flag is ignored.
    __pad5: u11 = 0,
};

pub fn Set_Hint(hint: Hint, value: [:0]const u8) !void {
    const ret = C.SDL_SetHint(hint.Get_Str(), value);
    if (ret == 0) {
        Log_Error("Set_Hint");
        return error.SDL_Set_Hint;
    }
}

pub const Mouse_State = struct {
    pub const Buttons = packed struct(u32) {
        left: bool,
        middle: bool,
        right: bool,
        __pad: u29,
    };

    pressed: Buttons,
    x: i32,
    y: i32,

    pub fn Get() Mouse_State {
        var res: Mouse_State = .{
            .pressed = @bitCast(@as(u32, 0)),
            .x = 0,
            .y = 0,
        };
        const mask: u32 = C.SDL_GetMouseState(&res.x, &res.y);
        res.pressed = @bitCast(mask);
        return res;
    }
};

pub fn Log_Error(function_name: []const u8) void {
    std.log.err(
        \\[SDL] {s}
        \\[SDL] > {?s}
        \\
    , .{ function_name, Get_Error() });
}

pub const major_version = C.SDL_MAJOR_VERSION;
pub const minor_version = C.SDL_MINOR_VERSION;
pub const patch_level = C.SDL_PATCHLEVEL;

pub const Window = @import("Window.zig");
pub const Renderer = @import("Renderer.zig");
pub const Rect = @import("Rect.zig").Rect;
pub const Color = @import("Color.zig");
pub const Event = @import("Event.zig").Event;
pub const Surface = @import("Surface.zig");
pub const Texture = @import("Texture.zig");
pub const Hint = @import("Hint.zig").Hint;

pub const C = @import("C");
const std = @import("std");
