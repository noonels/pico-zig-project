const microzig = @import("microzig");
const rp2040 = microzig.hal;
const time = rp2040.time;

const pin_config = rp2040.pins.GlobalConfiguration{
    // Motor configuration
    .GPIO1 = .{
        .name = "motor1",
        .direction = .out,
    },
    .GPIO2 = .{
        .name = "motor1_rev",
        .direction = .out,
    },
    .GPIO3 = .{
        .name = "motor2",
        .direction = .out,
    },
    .GPIO4 = .{
        .name = "motor2_rev",
        .direction = .out,
    },
    .GPIO5 = .{
        .name = "motor3",
        .direction = .out,
    },
    .GPIO6 = .{
        .name = "motor3_rev",
        .direction = .out,
    },
    .GPIO7 = .{
        .name = "motor4",
        .direction = .out,
    },
    .GPIO8 = .{
        .name = "motor4_rev",
        .direction = .out,
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
    .GOIO11 = .{
        .name = "auto_led",
        .direction = .out,
    },
    // Control configuration
    .GPIO12 = .{
        .name = "left_x_axis",
        .direction = .in,
    },
    .GPIO13 = .{
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

/// Firmware for Isomatter::Labs battlebot
/// submitted to the 2024 Battlebots competition
/// in the ant-weight division.
///
/// To build, run:
/// `zig build`, and flash the resulting `zig-out/bin/firmware.uf2` file
/// to the RP2040 using the UF2 interface.
pub fn main() !void {
    const pins = pin_config.apply();

    // currently, just blinks the LED as a proof of concept.
    //   ideally, in the future, this will be the firmware for the main driver board,
    //   which will control locomotion, remote control, and using the main weapon.

    //   all other functionality will be handled by the peripheral boards, which will
    //   have their own firmware, and will communicate with the main board over one-way
    //   serial (main board -> peripheral boards). This is to provide redundancy,
    //   and to prevent the possibility of having some peripheral function block the
    //   primary control loop.
    while (true) {
        for (0..100) |lvl| {
            const forward_motion = pins.left_x_axis.read();
            _ = forward_motion;
            const lateral_motion = pins.left_y_axis.read();
            _ = lateral_motion;

            pins.motor1.slice().set_wrap(100);
            pins.motor1.slice().set_level(lvl);

            pins.motor2.slice().set_wrap(100);
            pins.motor2.slice().set_level(lvl);

            pins.motor3.slice().set_wrap(100);
            pins.motor3.slice().set_level(lvl);

            pins.motor4.slice().set_wrap(100);
            pins.motor4.slice().set_level(lvl);

            if (pins.left_trigger.read()) {
                pins.retract.write(false);
                pins.fire.write(true);
                time.sleep(100);
                pins.fire.write(false);
                pins.retract.write(true);
            }
        }
    }
}
