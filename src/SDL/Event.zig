///! Todo: more events
pub const Event = union(enum) {
    untranslated: SDL.c.SDL_Event,

    /// User-requested quit
    quit: Quit,

    /// Key pressed
    key_down: Keyboard,
    /// Key released
    key_up: Keyboard,

    /// Mouse moved
    mouse_motion: Mouse_Motion,

    /// Mouse button pressed
    mouse_button_down: Mouse_Button,
    /// Mouse button released
    mouse_button_up: Mouse_Button,

    /// Mouse wheel motion
    mouse_wheel: Mouse_Wheel,

    const Group = enum {
        /// Keyboard event data
        keyboard,
        /// Mouse motion event data
        mouse_motion,
        /// Mouse button event data
        mouse_button,
        /// Mouse wheel event data
        mouse_wheel,
        /// Quit request event data
        quit,
    };

    pub fn Get_Group(e: Event) Group {
        return switch (e) {
            .quit => .quit,

            .key_down, .key_up => .keyboard,

            .mouse_motion => .mouse_motion,
            .mouse_button_down, .mouse_button_up => .mouse_button,
            .mouse_wheel => .mouse_wheel,
        };
    }

    pub fn To_C(e: Event) SDL.c.SDL_Event {
        return switch (e) {
            .quit => .{ .quit = Quit.To_C(e) },
            .key_down, .key_up => .{ .key = Keyboard.To_C(e) },
            .mouse_motion => .{ .motion = Mouse_Motion.To_C(e) },
            .mouse_button_down, .mouse_button_up => .{ .button = Mouse_Button.To_C(e) },
            .mouse_wheel => .{ .wheel = Mouse_Wheel.To_C(e) },
            .untranslated => |payload| payload,
        };
    }

    pub fn From_C(e: SDL.c.SDL_Event) Event {
        return switch (e.type) {
            SDL.c.SDL_QUIT => .{ .quit = Quit.From_C(e) },
            SDL.c.SDL_KEYDOWN => .{ .key_down = Keyboard.From_C(e) },
            SDL.c.SDL_KEYUP => .{ .key_up = Keyboard.From_C(e) },
            SDL.c.SDL_MOUSEMOTION => .{ .mouse_motion = Mouse_Motion.From_C(e) },
            SDL.c.SDL_MOUSEBUTTONDOWN => .{ .mouse_button_down = Mouse_Button.From_C(e) },
            SDL.c.SDL_MOUSEBUTTONUP => .{ .mouse_button_up = Mouse_Button.From_C(e) },
            SDL.c.SDL_MOUSEWHEEL => .{ .mouse_wheel = Mouse_Wheel.From_C(e) },
            else => .{ .untranslated = e },
        };
    }
};

pub const Keyboard = @import("Event/Keyboard.zig");
pub const Mouse_Motion = @import("Event/Mouse_Motion.zig");
pub const Mouse_Button = @import("Event/Mouse_Button.zig");
pub const Mouse_Wheel = @import("Event/Mouse_Wheel.zig");
pub const Quit = @import("Event/Quit.zig");

const SDL = @import("../SDL.zig");
