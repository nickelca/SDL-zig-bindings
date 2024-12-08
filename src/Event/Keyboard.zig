const Keyboard = @This();

/// Millisecond time stamp of event
time_stamp: u32,
/// The window with keyboard focus, if any
window_id: u32,
/// ::SDL_PRESSED or ::SDL_RELEASED
state: u8,
/// Is this a key repeat?
repeat: bool,
/// The key that was pressed or released
keysym: SDL.C.SDL_Keysym,

/// Expects .key_down or .key_up to be active
pub fn To_C(e: SDL.Event) SDL.C.SDL_KeyboardEvent {
    const tag = switch (e) {
        .key_down => SDL.C.SDL_KEYDOWN,
        .key_up => SDL.C.SDL_KEYUP,
        else => unreachable,
    };
    return switch (e) {
        .key_down, .key_up => |active| .{
            .type = tag,
            .timestamp = active.time_stamp,
            .windowID = active.window_id,
            .state = active.state,
            .repeat = @intFromBool(active.repeat),
            .padding2 = 0,
            .padding3 = 0,
            .keysym = active.keysym,
        },
        else => unreachable,
    };
}

pub fn From_C(e: SDL.C.SDL_Event) Keyboard {
    return .{
        .time_stamp = e.key.timestamp,
        .window_id = e.key.windowID,
        .state = e.key.state,
        .repeat = e.key.repeat != 0,
        .keysym = e.key.keysym,
    };
}

const SDL = @import("root.zig");
