// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "drv/bt/*" { // zig test --library c --main-pkg-path .. src/drv/bt.zig
    meta.refAllDecls(@This());
}
