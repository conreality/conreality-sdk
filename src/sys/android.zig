// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "sys/android/*" { // zig test --library c --main-pkg-path .. src/sys/android.zig
    meta.refAllDecls(@This());
}
