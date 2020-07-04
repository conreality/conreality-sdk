// This is free and unencumbered software released into the public domain.

test "sys/linux/*" { // zig test --library c --main-pkg-path .. src/sys/linux.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
