// This is free and unencumbered software released into the public domain.

test "drv/bt/*" { // zig test --library c --main-pkg-path .. src/drv/bt.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
