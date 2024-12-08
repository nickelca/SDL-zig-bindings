const Window = @This();

/// Millisecond time stamp of event
time_stamp: u32,
/// Associated window id
id: u32,
/// ::SDL_WindowEventID
event: u8,

data1: i32,
data2: i32,

pub fn From_C(e: SDL.C.SDL_WindowEvent) SDL.Event {
    return .{ .window = .{
        .time_stamp = e.timestamp,
        .display_index = e.display,
        .event = e.event,
        .data = e.data1,
    } };
}

/// Expects .window to be active
pub fn To_C(e: SDL.Event) SDL.C.SDL_WindowEvent {
    return switch (e) {
        .window => |payload| .{
            .type = 0x150,
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

const SDL = @import("root");
