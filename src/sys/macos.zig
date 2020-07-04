// This is free and unencumbered software released into the public domain.

test "sys/macos/*" { // zig test --library c --main-pkg-path .. src/sys/macos.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
