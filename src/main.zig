//! Firmware for Isomatter::Labs battlebot
//! submitted to the 2024 Battlebots competition
//! in the ant-weight division.
//!
//! To build, run:
//! `zig build`, and flash the resulting `zig-out/bin/firmware.uf2` file
//! to the RP2040 using the UF2 interface.

const microzig = @import("microzig");
const rp2040 = microzig.hal;
const time = rp2040.time;

const pin_config = rp2040.pins.GlobalConfiguration{
    // Motor configuration
    .GPIO1 = .{
        .name = "motor1",
        .function = .PWM0_B,
    },
    .GPIO2 = .{
        .name = "motor1_rev",
        .function = .PWM1_A,
    },
    .GPIO3 = .{
        .name = "motor2",
        .function = .PWM1_B,
    },
    .GPIO4 = .{
        .name = "motor2_rev",
        .function = .PWM2_A,
    },
    .GPIO5 = .{
        .name = "motor3",
        .function = .PWM2_B,
    },
    .GPIO6 = .{
        .name = "motor3_rev",
        .function = .PWM3_A,
    },
    .GPIO7 = .{
        .name = "motor4",
        .function = .PWM3_B,
    },
    .GPIO8 = .{
        .name = "motor4_rev",
        .function = .PWM4_A,
    },

    // Weapons configuration
    .GPIO9 = .{
        .name = "fire",
        .direction = .out,
    },
    .GPIO10 = .{
        .name = "retract",
        .direction = .out,
    },
    .GPIO11 = .{
        .name = "auto_led",
        .direction = .out,
    },

    // Control configuration
    .GPIO26 = .{
        .name = "left_x_axis",
        .direction = .in,
    },
    .GPIO27 = .{
        .name = "left_y_axis",
        .direction = .in,
    },
    .GPIO14 = .{
        .name = "right_x_axis",
        .direction = .in,
    },
    .GPIO15 = .{
        .name = "right_y_axis",
        .direction = .in,
    },
    .GPIO16 = .{
        .name = "left_trigger",
        .direction = .in,
    },
    .GPIO17 = .{
        .name = "right_trigger",
        .direction = .in,
    },
};

fn incWrap(val: u16, max: u16) u16 {
    return val + 1 % max;
}

pub fn main() !void {
    const pins = pin_config.apply();

    var lvl: u16 = 0;
    while (true) : (lvl = incWrap(lvl, 100)) {
        // const forward_motion = pins.left_x_axis.read();
        // _ = forward_motion;
        // const lateral_motion = pins.left_y_axis.read();
        // _ = lateral_motion;

        pins.motor1.slice().set_wrap(100);
        pins.motor1.set_level(lvl);
        pins.motor1.slice().enable();

        pins.motor2.slice().set_wrap(100);
        pins.motor2.set_level(lvl);
        pins.motor2.slice().enable();

        pins.motor3.slice().set_wrap(100);
        pins.motor3.set_level(lvl);
        pins.motor3.slice().enable();

        pins.motor4.slice().set_wrap(100);
        pins.motor4.set_level(lvl);
        pins.motor4.slice().enable();

        if (false) {
            pins.retract.write(false);
            pins.fire.write(true);
            time.sleep(100);
            pins.fire.write(false);
            pins.retract.write(true);
        }
    }
}
