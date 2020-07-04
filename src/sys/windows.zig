// This is free and unencumbered software released into the public domain.

test "sys/windows/*" { // zig test --library c --main-pkg-path .. src/sys/windows.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
