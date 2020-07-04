// This is free and unencumbered software released into the public domain.

test "util/*" { // zig test --library c --main-pkg-path .. src/util.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
