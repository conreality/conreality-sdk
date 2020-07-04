// This is free and unencumbered software released into the public domain.

test "sys/ios/*" { // zig test --library c --main-pkg-path .. src/sys/ios.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
