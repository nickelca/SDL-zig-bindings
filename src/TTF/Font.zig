const Font = @This();

handle: *TTF.C.TTF_Font,

pub fn Open(path: [:0]const u8, pt_size: i32) !Font {
    const font: *TTF.C.TTF_Font = TTF.C.TTF_OpenFont(path, pt_size) orelse {
        return error.TTF_Font_Open;
    };
    return .{
        .handle = font,
    };
}

pub fn Close(self: Font) void {
    TTF.C.TTF_CloseFont(self.handle);
}

pub fn Render_Text_Solid(self: Font, text: [:0]const u8, color: SDL.Color) !SDL.Surface {
    const surface: *SDL.C.SDL_Surface = TTF.C.TTF_RenderText_Solid(
        self.handle,
        text,
        color.To_C(),
    ) orelse {
        return error.TTF_Font_Render_Text_Solid;
    };
    return .{
        .handle = surface,
    };
}

const SDL = @import("../root.zig");
const TTF = @import("../TTF.zig");
