// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "drv/usb/*" { // zig test --library c --main-pkg-path .. src/drv/usb.zig
    meta.refAllDecls(@This());
}
