pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const enable_ttf = b.option(bool, "ttf", "Enable SDL_ttf") orelse false;

    const libsdl_dep = b.dependency("libsdl", .{});
    const libsdl = libsdl_dep.artifact("SDL2");

    const sdl = b.addModule("SDL", .{
        .root_source_file = b.path("src/root.zig"),
        .link_libc = true,
        .target = target,
        .optimize = optimize,
    });
    sdl.linkLibrary(libsdl);
    sdl.linkSystemLibrary("SDL2", .{});

    const c = b.addTranslateC(.{
        .root_source_file = b.path("src/includes.h"),
        .target = target,
        .optimize = optimize,
    });
    c.defineCMacro(
        "SDL_TTF_ENABLED",
        if (enable_ttf) "1" else "0",
    );

    sdl.addImport("C", c.createModule());

    const example = b.addExecutable(.{
        .name = "example",
        .root_source_file = b.path("example.zig"),
        .target = target,
        .optimize = optimize,
    });
    example.root_module.addImport("SDL", sdl);

    const example_run = b.addRunArtifact(example);
    const example_step = b.step("example", "Run an example using SDL");
    example_step.dependOn(&example_run.step);
}

const std = @import("std");
