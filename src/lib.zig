// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "lib/*" { // zig test --library c --main-pkg-path .. src/lib.zig
    meta.refAllDecls(@This());
}
