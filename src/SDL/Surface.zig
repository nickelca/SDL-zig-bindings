const Surface = @This();

handle: *SDL.c.SDL_Surface,

pub fn Destroy(self: Surface) void {
    SDL.c.SDL_FreeSurface(self.handle);
}

const SDL = @import("../SDL.zig");
