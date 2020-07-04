// This is free and unencumbered software released into the public domain.

const cr = @import("../abi/cr.zig");

pub export fn crRegisterAllocatorCallbacks(context: cr.context, realloc: cr.realloc_callback_f, free: cr.free_callback_f) void {
    // TODO
}
