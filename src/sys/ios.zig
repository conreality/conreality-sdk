// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "sys/ios/*" { // zig test --library c --main-pkg-path .. src/sys/ios.zig
    meta.refAllDecls(@This());
}
