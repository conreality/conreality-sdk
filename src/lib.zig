// This is free and unencumbered software released into the public domain.

test "lib/*" { // zig test --library c --main-pkg-path .. src/lib.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
