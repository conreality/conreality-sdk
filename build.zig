// This is free and unencumbered software released into the public domain.

const Builder = @import("std").build.Builder;
const fmt = @import("std").fmt;

pub fn build(b: *Builder) !void {
    var pathBuffer: [64]u8 = undefined;
    const version = b.version(20, 0, 0); // TODO: parse the VERSION file
    const mode = b.standardReleaseOptions();

    try b.makePath("build");

    const static_lib = b.addStaticLibrary("conreality", "src/api.zig");
    static_lib.setBuildMode(mode);
    static_lib.linkLibC();
    static_lib.setOutputDir("build");
    static_lib.install();

    const static_step = b.step("static", "Build static libraries for this host");
    static_step.dependOn(&static_lib.step);

    const shared_lib = b.addSharedLibrary("conreality", "src/api.zig", version);
    shared_lib.setBuildMode(mode);
    shared_lib.linkLibC();
    shared_lib.setOutputDir("build");
    shared_lib.install();

    const shared_step = b.step("shared", "Build shared libraries for this host");
    shared_step.dependOn(&shared_lib.step);
}
