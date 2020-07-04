// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "net/*" { // zig test --library c --main-pkg-path .. src/net.zig
    meta.refAllDecls(@This());
}
