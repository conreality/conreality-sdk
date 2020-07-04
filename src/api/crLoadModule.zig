// This is free and unencumbered software released into the public domain.

const cr = @import("../abi/cr.zig");

pub export fn crLoadModule(context: cr.context, id: cr.string) cr.status {
    return cr.status.FAILURE; // TODO
}
