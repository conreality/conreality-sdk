// This is free and unencumbered software released into the public domain.

test "core/*" { // zig test --library c --main-pkg-path .. src/core.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
