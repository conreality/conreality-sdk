// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "sys/linux/*" { // zig test --library c --main-pkg-path .. src/sys/linux.zig
    meta.refAllDecls(@This());
}
