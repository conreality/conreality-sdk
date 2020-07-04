// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "sys/macos/*" { // zig test --library c --main-pkg-path .. src/sys/macos.zig
    meta.refAllDecls(@This());
}
