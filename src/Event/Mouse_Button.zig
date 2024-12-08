const Mouse_Button = @This();

/// Millisecond time stamp of event
time_stamp: u32,
/// The window with mouse focus, if any
window_id: u32,
/// The mouse instance id, or ::SDL_TOUCH_MOUSEID
which: u32,
/// The mouse button index
button: u8,
/// The current button state
/// ::SDL_PRESSED or ::SDL_RELEASED
state: u8,
/// 1 for single-click, 2 for double-click, etc.
clicks: u8,
/// X coordinate, relative to window
x: i32,
/// Y coordinate, relative to window
y: i32,

/// Expects .mouse_button_down or .mouse_button_up to be active
pub fn To_C(e: SDL.Event) SDL.C.SDL_MouseButtonEvent {
    const tag = switch (e) {
        .mouse_button_down => SDL.C.SDL_MOUSEBUTTONDOWN,
        .mouse_button_up => SDL.C.SDL_MOUSEBUTTONUP,
        else => unreachable,
    };
    return switch (e) {
        .mouse_button_down, .mouse_button_up => |active| .{
            .type = tag,
            .timestamp = active.time_stamp,
            .windowID = active.window_id,
            .which = active.which,
            .button = active.button,
            .state = active.state,
            .clicks = active.clicks,
            .padding1 = 0,
            .x = active.x,
            .y = active.y,
        },
        else => unreachable,
    };
}

pub fn From_C(e: SDL.C.SDL_Event) Mouse_Button {
    return .{
        .time_stamp = e.button.timestamp,
        .window_id = e.button.windowID,
        .which = e.button.which,
        .button = e.button.button,
        .state = e.button.state,
        .clicks = e.button.clicks,
        .x = e.button.x,
        .y = e.button.y,
    };
}

const SDL = @import("root");
