// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "core/*" { // zig test --library c --main-pkg-path .. src/core.zig
    meta.refAllDecls(@This());
}
