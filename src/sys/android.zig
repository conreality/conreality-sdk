// This is free and unencumbered software released into the public domain.

test "sys/android/*" { // zig test --library c --main-pkg-path .. src/sys/android.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
