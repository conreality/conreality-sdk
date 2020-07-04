// This is free and unencumbered software released into the public domain.

const cr = @import("../abi/cr.zig");

pub export fn crGetVersionString() cr.string {
    return "20.0.0"; // TODO
}
