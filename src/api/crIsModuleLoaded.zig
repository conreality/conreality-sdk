// This is free and unencumbered software released into the public domain.

const cr = @import("../abi/cr.zig");

pub export fn crIsModuleLoaded(context: cr.context, id: cr.string) cr.boolean {
    return cr.boolean.false_; // TODO
}
