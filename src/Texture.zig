const Texture = @This();

handle: *SDL.C.SDL_Texture,

pub fn From_Surface(renderer: SDL.Renderer, surface: SDL.Surface) !Texture {
    const texture: *SDL.C.SDL_Texture = SDL.C.SDL_CreateTextureFromSurface(
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
    SDL.C.SDL_DestroyTexture(self.handle);
}

const SDL = @import("root.zig");
