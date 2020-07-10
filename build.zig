// This is free and unencumbered software released into the public domain.

const builtin = @import("builtin");
const std = @import("std");
const fmt = std.fmt;

const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;

const library_name = "conreality";
const library_api = "src/api.zig";
const build_directory = "build";

pub fn build(b: *Builder) !void {
    var pathBuffer: [64]u8 = undefined;
    const version = b.version(20, 0, 0); // TODO: parse the VERSION file
    const mode = b.standardReleaseOptions();

    try b.makePath("build");

    const static_step = b.step("static", "Build static libraries for this host");
    const static_lib = static(b, version, mode);
    static_step.dependOn(&static_lib.step);

    const shared_step = b.step("shared", "Build shared libraries for this host");
    const shared_lib = shared(b, version, mode);
    shared_step.dependOn(&shared_lib.step);
}

fn static(b: *Builder, version: builtin.Version, mode: builtin.Mode) *LibExeObjStep {
    const lib = b.addStaticLibrary(library_name, library_api);
    lib.setBuildMode(mode);
    lib.linkLibC();
    lib.setOutputDir(build_directory);
    lib.install();
    return lib;
}

fn shared(b: *Builder, version: builtin.Version, mode: builtin.Mode) *LibExeObjStep {
    const lib = b.addSharedLibrary(library_name, library_api, version);
    lib.setBuildMode(mode);
    lib.linkLibC();
    lib.setOutputDir(build_directory);
    lib.install();
    return lib;
}
