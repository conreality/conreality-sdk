// This is free and unencumbered software released into the public domain.

pub usingnamespace @import("drv/bt.zig");
pub usingnamespace @import("drv/usb.zig");

test "drv/*" { // zig test --library c --main-pkg-path .. src/drv.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
