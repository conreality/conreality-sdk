// This is free and unencumbered software released into the public domain.

pub const status = extern enum(i32) {
    FAILURE = -1,
    SUCCESS = 0,
};

pub const boolean = extern enum(i32) {
    false_ = 0,
    true_ = 1,
};

pub const string = ?[*:0]const u8;

pub const context = ?*c_void;

pub const log_callback_f = ?*c_void; // TODO
pub const error_callback_f = ?*c_void; // TODO
pub const realloc_callback_f = ?*c_void; // TODO
pub const free_callback_f = ?*c_void; // TODO

test "abi/cr" { // zig test --library c --main-pkg-path .. src/abi/cr.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
