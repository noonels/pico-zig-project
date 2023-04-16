const std = @import("std");
const rp2040 = @import("deps/raspberrypi-rp2040/build.zig");

// the hardware support package should have microzig as a dependency
const microzig = @import("deps/raspberrypi-rp2040/deps/microzig/build.zig");

pub fn build(b: *std.build.Builder) !void {
    const optimize = b.standardOptimizeOption(.{});
    var exe = microzig.addEmbeddedExecutable(b, .{
        .name = "my-executable",
        .source_file = .{
            .path = "src/main.zig",
        },
        .backing = .{
            .board = rp2040.boards.raspberry_pi_pico,

            // instead of a board, you can use the raw chip as well
            // .chip = atmega.chips.atmega328p,
        },
        .optimize = optimize,
    });
    exe.install();
}