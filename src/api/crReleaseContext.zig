// This is free and unencumbered software released into the public domain.

const cr = @import("../abi/cr.zig");

pub export fn crReleaseContext(context: ?*cr.context) cr.status {
    return cr.status.FAILURE; // TODO
}
