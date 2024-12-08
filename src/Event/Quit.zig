const Quit = @This();

/// Millisecond time stamp of event
time_stamp: u32,

/// Expects .quit to be active
pub fn To_C(e: SDL.Event) SDL.C.SDL_QuitEvent {
    const tag: u32 = switch (e) {
        .quit => SDL.C.SDL_QUIT,
        else => unreachable,
    };
    return switch (e) {
        .quit => |active| .{
            .type = tag,
            .timestamp = active.time_stamp,
        },
        else => unreachable,
    };
}

/// Expects ::SDL_QUIT to be active
pub fn From_C(e: SDL.C.SDL_Event) Quit {
    return .{
        .time_stamp = e.quit.timestamp,
    };
}

const SDL = @import("../root.zig");
