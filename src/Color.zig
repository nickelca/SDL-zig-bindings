pub const Color = @This();

r: u8,
g: u8,
b: u8,
a: u8,

pub const red: Color = .{ .r = 0xFF, .g = 0x00, .b = 0x00, .a = 0xFF };
pub const green: Color = .{ .r = 0x00, .g = 0xFF, .b = 0x00, .a = 0xFF };
pub const blue: Color = .{ .r = 0x00, .g = 0x00, .b = 0xFF, .a = 0xFF };
pub const black: Color = .{ .r = 0x00, .g = 0x00, .b = 0x00, .a = 0xFF };
pub const white: Color = .{ .r = 0xFF, .g = 0xFF, .b = 0xFF, .a = 0xFF };
pub const yellow: Color = .{ .r = 0xFF, .g = 0xFF, .b = 0x00, .a = 0xFF };
pub const purple: Color = .{ .r = 0xFF, .g = 0x00, .b = 0xFF, .a = 0xFF };
pub const sinon: Color = .{ .r = 0x00, .g = 0xFF, .b = 0xFF, .a = 0xFF };

pub fn From_RGB(r: u8, g: u8, b: u8, a: u8) Color {
    return .{
        .r = r,
        .g = g,
        .b = b,
        .a = a,
    };
}

pub fn To_C(color: Color) SDL.C.SDL_Color {
    return .{
        .r = color.r,
        .g = color.g,
        .b = color.b,
        .a = color.a,
    };
}

const SDL = @import("root");
