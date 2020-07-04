// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "util/*" { // zig test --library c --main-pkg-path .. src/util.zig
    meta.refAllDecls(@This());
}
