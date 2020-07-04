// This is free and unencumbered software released into the public domain.

const meta = @import("std").meta;

test "abi/*" { // zig test --library c --main-pkg-path .. src/abi.zig
    meta.refAllDecls(@This());
}
