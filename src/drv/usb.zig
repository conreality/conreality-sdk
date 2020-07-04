// This is free and unencumbered software released into the public domain.

test "drv/usb/*" { // zig test --library c --main-pkg-path .. src/drv/usb.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
