// This is free and unencumbered software released into the public domain.

const builtin = @import("builtin");
const std = @import("std");

const CrossTarget = std.zig.CrossTarget;
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;

const library_name = "conreality";
const library_api = "src/api.zig";
const build_directory = "build";

pub fn build(b: *Builder) !void {
    var buffer: [256]u8 = undefined;
    const version = b.version(20, 0, 0); // TODO: parse the VERSION file

    b.setPreferredReleaseMode(.ReleaseSafe);
    const mode = b.standardReleaseOptions();

    try b.makePath(build_directory);
    b.verbose = true;

    const static_step = b.step("static", "Build static libraries for this host");
    const static_lib = static(b, null, version, mode);
    static_step.dependOn(&static_lib.step);

    const shared_step = b.step("shared", "Build shared libraries for this host");
    const shared_lib = shared(b, null, version, mode);
    shared_step.dependOn(&shared_lib.step);

    for (targets) |target| {
        const build_dir = try std.fmt.bufPrint(buffer[0..], "{}/{}", .{ build_directory, target.id });
        try b.makePath(build_dir);

        const target_info = try CrossTarget.parse(.{
            .arch_os_abi = target.arch_os_abi,
            .cpu_features = target.mcpu,
        });

        const target_static_lib = static(b, target_info, version, mode);
        target_static_lib.setOutputDir(build_dir);
        target_static_lib.setTarget(target_info);
        target_static_lib.setLibCFile(target.libc);

        const target_shared_lib = shared(b, target_info, version, mode);
        target_shared_lib.setOutputDir(build_dir);
        target_shared_lib.setTarget(target_info);
        target_shared_lib.setLibCFile(target.libc);

        if (target_info.os_tag != null) {
            switch (target_info.os_tag.?) {
                .windows => {
                    // See: https://docs.microsoft.com/en-us/cpp/c-runtime-library/crt-library-features
                    target_shared_lib.linkSystemLibrary("libcmt");
                    target_shared_lib.linkSystemLibrary("libvcruntime");
                    target_shared_lib.linkSystemLibrary("libucrt");
                },
                else => {},
            }
        }

        const target_step = b.step(target.id, "Build static/shared libraries for a target");
        target_step.dependOn(&target_static_lib.step);
        target_step.dependOn(&target_shared_lib.step);
    }
}

fn static(b: *Builder, target_info: ?CrossTarget, version: builtin.Version, mode: builtin.Mode) *LibExeObjStep {
    const lib_name = if (target_info != null and target_info.?.os_tag != null) switch (target_info.?.os_tag.?) {
        .windows => "lib" ++ library_name,
        else => library_name,
    } else library_name;
    const lib = b.addStaticLibrary(lib_name, library_api);
    lib.single_threaded = true;
    lib.force_pic = true;
    lib.bundle_compiler_rt = true;
    lib.linkLibC();
    lib.setBuildMode(mode);
    lib.setOutputDir(build_directory);
    lib.install();
    return lib;
}

fn shared(b: *Builder, target_info: ?CrossTarget, version: builtin.Version, mode: builtin.Mode) *LibExeObjStep {
    const lib = b.addSharedLibrary(library_name, library_api, version);
    lib.single_threaded = true;
    lib.force_pic = true;
    lib.linkLibC();
    lib.setBuildMode(mode);
    lib.setOutputDir(build_directory);
    lib.install();
    return lib;
}

const Target = struct {
    id: []const u8,
    arch_os_abi: []const u8,
    mcpu: ?[]const u8 = null,
    cflags: ?[]const u8 = null, // TODO: append to args
    libc: ?[]const u8 = null,
};

const targets = [_]Target{
    // Android:
    Target{
        .id = "android/arm",
        .arch_os_abi = "arm-linux-android",
        .mcpu = "generic+v7a+thumb2+vfp3d16",
        .cflags = "-mfloat-abi=softfp",
        .libc = "etc/libc/android-4.1/arm.txt",
    },
    Target{
        .id = "android/arm64",
        .arch_os_abi = "aarch64-linux-android",
        .mcpu = "generic+reserve_x18",
        .libc = "etc/libc/android-5.0/arm64.txt",
    },
    Target{
        .id = "android/x86_64",
        .arch_os_abi = "x86_64-linux-android",
        .mcpu = "x86_64+mmx+sse+sse2+sse3+ssse3+sse4_1+sse4_2+popcnt",
        .libc = "etc/libc/android-5.0/x86_64.txt",
    },
    // Linux:
    Target{
        .id = "linux/arm",
        .arch_os_abi = "arm-linux-musleabihf",
        .mcpu = "generic+v7a+thumb2+vfp3d16",
        .cflags = "-mfloat-abi=softfp",
    },
    Target{
        .id = "linux/arm64",
        .arch_os_abi = "aarch64-linux-musl",
        .mcpu = "generic+reserve_x18",
    },
    Target{
        .id = "linux/x86_64",
        .arch_os_abi = "x86_64-linux-musl",
        .mcpu = "x86_64+mmx+sse+sse2+sse3+ssse3+sse4_1+sse4_2+popcnt",
    },
    // macOS:
    Target{
        .id = "macos/x86_64",
        .arch_os_abi = "x86_64-native", // FIXME: cross-compiling doesn't pass -lSystem to `lld`
        .mcpu = "x86_64+mmx+sse+sse2+sse3+ssse3+sse4_1+sse4_2+popcnt",
    },
    // Windows:
    Target{
        .id = "windows/x86_64",
        .arch_os_abi = "x86_64-windows-msvc",
        .mcpu = "x86_64+mmx+sse+sse2+sse3+ssse3+sse4_1+sse4_2+popcnt",
        .libc = "etc/libc/windows/x64-msvc.txt",
    },
};
