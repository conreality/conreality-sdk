// This is free and unencumbered software released into the public domain.

const builtin = @import("builtin");

pub usingnamespace switch (builtin.os.tag) {
    .ios, .tvos, .watchos => @import("sys/ios.zig"),
    .linux => switch (builtin.abi) {
        .android => @import("sys/android.zig"),
        else => @import("sys/linux.zig"),
    },
    .macosx => @import("sys/macos.zig"),
    .windows => @import("sys/windows.zig"),
    else => struct {},
};

test "sys/*" { // zig test --library c --main-pkg-path .. src/sys.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
