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
        .root_source_file = b.path("src/root.zig"),
        .link_libc = true,
        .target = target,
        .optimize = optimize,
    });
    sdl.addLibraryPath(libsdl_lib_path);
    sdl.linkSystemLibrary("SDL2", .{});
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
