const Surface = @This();

handle: *SDL.C.SDL_Surface,

pub fn Destroy(self: Surface) void {
    SDL.C.SDL_FreeSurface(self.handle);
}

const SDL = @import("root.zig");
