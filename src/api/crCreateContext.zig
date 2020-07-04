// This is free and unencumbered software released into the public domain.

const cr = @import("../abi/cr.zig");

pub export fn crCreateContext(version: u64, flags: u64, context: ?*cr.context) cr.status {
    return cr.status.FAILURE; // TODO
}
