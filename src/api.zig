// This is free and unencumbered software released into the public domain.

test "api/*" { // zig test --library c --main-pkg-path .. src/api.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
