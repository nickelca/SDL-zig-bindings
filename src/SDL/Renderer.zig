const Renderer = @This();

handle: *SDL.c.SDL_Renderer,

pub fn Create(window: SDL.Window, index: ?i32, flags: CreateFlags) !Renderer {
    const handle = SDL.c.SDL_CreateRenderer(
        window.handle,
        index orelse -1,
        @bitCast(flags),
    ) orelse {
        SDL.Log_Error("Renderer.Create");
        return error.SDL_Renderer_Create;
    };
    return .{
        .handle = handle,
    };
}

pub fn Destroy(self: Renderer) void {
    SDL.c.SDL_DestroyRenderer(self.handle);
}

pub fn Set_Draw_Color(self: Renderer, color: SDL.Color) !void {
    const fail = SDL.c.SDL_SetRenderDrawColor(
        self.handle,
        color.r,
        color.g,
        color.b,
        color.a,
    );
    if (fail != 0) {
        SDL.Log_Error("Renderer.Set_Draw_Color");
        return error.SDL_Set_Renderer_Draw_Color;
    }
}

pub fn Get_Draw_Color(self: Renderer) !SDL.Color {
    var color: SDL.Color = .white;
    const fail = SDL.c.SDL_GetRenderDrawColor(
        self.handle,
        &color.r,
        &color.g,
        &color.b,
        &color.a,
    );
    if (fail < 0) {
        SDL.Log_Error("Renderer.Get_Draw_Color");
        return error.SDL_Get_Renderer_Draw_Color;
    }
    return color;
}

pub fn Clear(self: Renderer) !void {
    const fail = SDL.c.SDL_RenderClear(self.handle);
    if (fail != 0) {
        SDL.Log_Error("Renderer.Clear");
        return error.SDL_Renderer_Clear;
    }
}

pub fn Present(self: Renderer) void {
    SDL.c.SDL_RenderPresent(self.handle);
}

pub fn Fill_Rect(self: Renderer, rect: ?SDL.Rect(.i32)) !void {
    const fail = fill: {
        const r = rect orelse
            break :fill SDL.c.SDL_RenderFillRect(self.handle, null);
        const c_rect = r.To_C();
        break :fill SDL.c.SDL_RenderFillRect(self.handle, &c_rect);
    };

    if (fail != 0) {
        SDL.Log_Error("Renderer.Fill_Rect");
        return error.SDL_Renderer_Fill_Rect;
    }
}

const CreateFlags = packed struct(u32) {
    software: bool = false,
    accelerated: bool = false,
    present_vsync: bool = false,
    target_texture: bool = false,
    __pad1: u28 = 0,
};

pub fn Draw_Point(self: Renderer, x: i32, y: i32) !void {
    const err = SDL.c.SDL_RenderDrawPoint(self.handle, x, y);
    if (err < 0) {
        SDL.Log_Error("Renderer.Draw_Point");
        return error.SDL_Renderer_Draw_Point;
    }
}

pub const Blend_Mode = enum(u32) {
    /// No blending.
    /// dstRGBA = srcRGBA.
    none = SDL.c.SDL_BLENDMODE_NONE,
    /// Alpha blending.
    /// dstRGB = (srcRGB * srcA) + (dstRGB * (1-srcA)).
    /// dstA = srcA + (dstA * (1-srcA)).
    blend = SDL.c.SDL_BLENDMODE_BLEND,
    /// Additive blending.
    /// dstRGB = (srcRGB * srcA) + dstRGB.
    /// dstA = dstA.
    add = SDL.c.SDL_BLENDMODE_ADD,
    /// Color modulate.
    /// dstRGB = srcRGB * dstRGB.
    /// dstA = dstA.
    mod = SDL.c.SDL_BLENDMODE_MOD,
    /// Color multiply.
    /// dstRGB = (srcRGB * dstRGB) + (dstRGB * (1-srcA)).
    /// dstA = dstA.
    multiply = SDL.c.SDL_BLENDMODE_MUL,
    /// TODO: What this do?
    invalid = SDL.c.SDL_BLENDMODE_INVALID,
    /// Additional custom blend modes can be returned by SDL_ComposeCustomBlendMode().
    _,
};

pub fn Set_Blend_Mode(self: Renderer, blend_mode: Blend_Mode) !void {
    const ret = SDL.c.SDL_SetRenderDrawBlendMode(self.handle, @intFromEnum(blend_mode));
    if (ret < 0) {
        SDL.Log_Error("Renderer.Set_Blend_Mode");
        return error.SDL_Renderer_Set_Blend_Mode;
    }
}

pub fn Copy_Texture(
    self: Renderer,
    texture: SDL.Texture,
    source: ?SDL.Rect(.i32),
    dest: ?SDL.Rect(.i32),
) !void {
    const src = if (source) |src| &src.To_C() else null;
    const dst = if (dest) |dst| &dst.To_C() else null;
    const ret = SDL.c.SDL_RenderCopy(self.handle, texture.handle, src, dst);
    if (ret < 0) {
        SDL.Log_Error("Renderer.Copy_Texture");
        return error.SDL_Renderer_Copy_Texture;
    }
}

const SDL = @import("../SDL.zig");
const std = @import("std");
