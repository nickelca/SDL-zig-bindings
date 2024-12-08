//! A rectangle with origin at the upper left

const Kind = enum {
    i32,
    f32,
};

pub fn Rect(comptime kind: Kind) type {
    const T = switch (kind) {
        .i32 => i32,
        .f32 => f32,
    };

    return struct {
        const Self = @This();
        const C_Self = switch (kind) {
            .i32 => SDL.c.SDL_Rect,
            .f32 => SDL.c.SDL_FRect,
        };

        x: T,
        y: T,
        width: T,
        height: T,

        pub fn To_C(self: Self) C_Self {
            return .{
                .x = self.x,
                .y = self.y,
                .w = self.width,
                .h = self.height,
            };
        }
    };
}

const SDL = @import("../SDL.zig");
