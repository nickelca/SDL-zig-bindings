const Display = @This();

/// Millisecond time stamp of event
time_stamp: u32,
display_index: u32,
/// ::SDL_DisplayEventID
event: u8,
/// Event dependent data
data: i32,

pub fn From_C(e: SDL.c.SDL_DisplayEvent) SDL.Event {
    return switch (e.type) {
        SDL.c.SDL_DISPLAYEVENT => .{
            .time_stamp = e.timestamp,
            .display_index = e.display,
            .event = e.event,
            .data = e.data1,
        },
        else => unreachable,
    };
}

/// Expects .display to be active
pub fn To_C(e: SDL.Event) SDL.c.SDL_DisplayEvent {
    return switch (e) {
        .display => |payload| .{
            .type = SDL.c.SDL_DISPLAYEVENT,
            .timestamp = payload.time_stamp,
            .display = payload.display_index,
            .event = payload.event,
            .padding1 = 0,
            .padding2 = 0,
            .padding3 = 0,
            .data1 = payload.data,
        },
        else => unreachable,
    };
}

const SDL = @import("../../SDL.zig");
