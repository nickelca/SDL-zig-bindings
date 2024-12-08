const Mouse_Motion = @This();

/// Millisecond time stamp of event
time_stamp: u32,
/// The window with mouse focus, if any
window_id: u32,
/// The mouse instance id, or SDL_TOUCH_MOUSEID
which: u32,
/// The current button state
state: u32,
/// X coordinate, relative to window
x: i32,
/// Y coordinate, relative to window
y: i32,
/// The relative motion in the X direction
x_rel: i32,
/// The relative motion in the Y direction
y_rel: i32,

/// Expects .mouse_motion to be active
pub fn To_C(e: SDL.Event) SDL.C.SDL_MouseMotionEvent {
    const tag = switch (e) {
        .mouse_motion => SDL.C.SDL_MOUSEMOTION,
        else => unreachable,
    };
    return switch (e) {
        .mouse_motion => |active| .{
            .type = tag,
            .timestamp = active.time_stamp,
            .windowID = active.window_id,
            .which = active.which,
            .state = active.state,
            .x = active.x,
            .y = active.y,
            .xrel = active.x_rel,
            .yrel = active.x_rel,
        },
        else => unreachable,
    };
}

pub fn From_C(e: SDL.C.SDL_Event) Mouse_Motion {
    return .{
        .time_stamp = e.motion.timestamp,
        .window_id = e.motion.windowID,
        .which = e.motion.which,
        .state = e.motion.state,
        .x = e.motion.x,
        .y = e.motion.y,
        .x_rel = e.motion.xrel,
        .y_rel = e.motion.yrel,
    };
}

const SDL = @import("root");
