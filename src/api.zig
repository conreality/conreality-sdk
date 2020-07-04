// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "api/*" { // zig test --library c --main-pkg-path .. src/api.zig
    meta.refAllDecls(@This());
}
