const microzig = @import("microzig");
const rp2040 = microzig.hal;
const time = rp2040.time;

const pin_config = rp2040.pins.GlobalConfiguration{
    .GPIO25 = .{
        .name = "led",
        .direction = .out,
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
        pins.led.toggle();
        time.sleep_ms(500);
    }
}
