pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libsdl_dep = b.dependency("libsdl", .{});
    const libsdl_include_path = libsdl_dep.path("zig-out/include/SDL2");
    const libsdl_lib_path = libsdl_dep.path("zig-out/lib");

    const c = b.addTranslateC(.{
        .root_source_file = b.path("src/includes.h"),
        .target = target,
        .optimize = optimize,
    });
    c.addIncludePath(libsdl_include_path);

    const sdl = b.addModule("SDL", .{
        .root_source_file = b.path("src/SDL.zig"),
        .link_libc = true,
        .target = target,
        .optimize = optimize,
    });
    sdl.addLibraryPath(libsdl_lib_path);
    sdl.linkSystemLibrary("SDL2", .{});
}

const std = @import("std");
