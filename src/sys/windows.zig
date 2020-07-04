// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "sys/windows/*" { // zig test --library c --main-pkg-path .. src/sys/windows.zig
    meta.refAllDecls(@This());
}
