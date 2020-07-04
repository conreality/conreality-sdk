// This is free and unencumbered software released into the public domain.

test "net/*" { // zig test --library c --main-pkg-path .. src/net.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
