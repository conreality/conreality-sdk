// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

pub usingnamespace @import("drv/bt.zig");
pub usingnamespace @import("drv/usb.zig");

test "drv/*" { // zig test --library c --main-pkg-path .. src/drv.zig
    meta.refAllDecls(@This());
}
