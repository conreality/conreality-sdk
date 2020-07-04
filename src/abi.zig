// This is free and unencumbered software released into the public domain.

test "abi/*" { // zig test --library c --main-pkg-path .. src/abi.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
