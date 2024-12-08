const Mouse_Wheel = @This();

/// Millisecond time stamp of event
time_stamp: u32,
/// The window with mouse focus, if any
window_id: u32,
/// The mouse instance id, or SDL_TOUCH_MOUSEID
which: u32,
/// The amount scrolled horizontally, positive to the right and negative to the left
x: i32,
/// The amount scrolled vertically, positive away from the user and negative toward the user
y: i32,
/// Set to one of the SDL_MOUSEWHEEL_* defines.
/// When FLIPPED the values in X and Y will be opposite.
/// Multiply by -1 to change them back
direction: u32,
/// The amount scrolled horizontally, positive to the right and negative to the left,
/// with float precision (added in 2.0.18)
precise_x: f32,
/// The amount scrolled vertically, positive away from the user and negative toward the user,
/// with float precision (added in 2.0.18)
precise_y: f32,
/// X coordinate, relative to window (added in 2.26.0)
mouse_x: i32,
/// Y coordinate, relative to window (added in 2.26.0)
mouse_y: i32,

/// Expects .mouse_button_down or .mouse_button_up to be active
pub fn To_C(e: SDL.Event) SDL.C.SDL_MouseWheelEvent {
    const tag: u32 = switch (e) {
        .mouse_wheel => SDL.C.SDL_MOUSEWHEEL,
        else => unreachable,
    };
    return switch (e) {
        .mouse_wheel => |active| .{
            .type = tag,
            .timestamp = active.time_stamp,
            .windowID = active.window_id,
            .which = active.which,
            .x = active.x,
            .y = active.y,
            .direction = active.direction,
            .preciseX = active.precise_x,
            .preciseY = active.precise_y,
            .mouseX = active.mouse_x,
            .mouseY = active.mouse_y,
        },
        else => unreachable,
    };
}

/// Expects ::SDL_MOUSEWHEEL to be active
pub fn From_C(e: SDL.C.SDL_Event) Mouse_Wheel {
    return .{
        .time_stamp = e.wheel.timestamp,
        .window_id = e.wheel.windowID,
        .which = e.wheel.which,
        .x = e.wheel.x,
        .y = e.wheel.y,
        .direction = e.wheel.direction,
        .precise_x = e.wheel.preciseX,
        .precise_y = e.wheel.preciseY,
        .mouse_x = e.wheel.mouseX,
        .mouse_y = e.wheel.mouseY,
    };
}

const SDL = @import("root.zig");
