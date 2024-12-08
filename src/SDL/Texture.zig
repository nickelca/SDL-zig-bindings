const Texture = @This();

handle: *SDL.c.SDL_Texture,

pub fn From_Surface(renderer: SDL.Renderer, surface: SDL.Surface) !Texture {
    const texture: *SDL.c.SDL_Texture = SDL.c.SDL_CreateTextureFromSurface(
        renderer.handle,
        surface.handle,
    ) orelse {
        SDL.Log_Error("Texture.From_Surface");
        return error.SDL_Texture_From_Surface;
    };
    return .{
        .handle = texture,
    };
}

pub fn Destroy(self: Texture) void {
    SDL.c.SDL_DestroyTexture(self.handle);
}

const SDL = @import("../SDL.zig");
