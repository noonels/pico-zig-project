const std = @import("std");
const uf2 = @import("deps/uf2/src/main.zig");
const rp2040 = @import("deps/raspberrypi-rp2040/build.zig");

// the hardware support package should have microzig as a dependency
const microzig = @import("deps/raspberrypi-rp2040/deps/microzig/build.zig");

pub fn build(b: *std.build.Builder) !void {
    const optimize = b.standardOptimizeOption(.{});
    var exe = rp2040.addPiPicoExecutable(b, .{
        .name = "firmware",
        .source_file = .{
            .path = "src/main.zig",
        },
        .optimize = optimize,
    });

    const uf2_step = uf2.Uf2Step.create(exe.inner, .{ .family_id = .RP2040 });
    uf2_step.install();
}
