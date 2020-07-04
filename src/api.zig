// This is free and unencumbered software released into the public domain.

pub usingnamespace @import("api/crCreateContext.zig");
pub usingnamespace @import("api/crEnumerateDrivers.zig");
pub usingnamespace @import("api/crEnumerateFeatures.zig");
pub usingnamespace @import("api/crEnumerateModules.zig");
pub usingnamespace @import("api/crGetVersion.zig");
pub usingnamespace @import("api/crGetVersionString.zig");
pub usingnamespace @import("api/crIsDriverLoaded.zig");
pub usingnamespace @import("api/crIsFeatureEnabled.zig");
pub usingnamespace @import("api/crIsModuleLoaded.zig");
pub usingnamespace @import("api/crLoadDriver.zig");
pub usingnamespace @import("api/crLoadModule.zig");
pub usingnamespace @import("api/crRegisterAllocatorCallbacks.zig");
pub usingnamespace @import("api/crRegisterErrorCallback.zig");
pub usingnamespace @import("api/crReleaseContext.zig");

test "api/*" { // zig test --library c --main-pkg-path .. src/api.zig
    const meta = @import("std").meta;
    meta.refAllDecls(@This());
}
