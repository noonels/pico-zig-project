# battlebot-sw
Firmware for Isomatter::Labs battlebot
submitted to the 2024 Battlebots competition
in the ant-weight division.

## Building Instructions
To build, run:
`zig build`, and flash the resulting `zig-out/bin/firmware.uf2` file
to the RP2040 using the UF2 interface.

## Wiring
```mermaid
flowchart TD
    A[Logic Board] -->|GPIO 1| B{H-Bridge}
    A --> |GPIO 2| B
    A --> |GPIO 3| B
    A --> |GPIO 4| B
    A --> |GPIO 5| B
    A --> |GPIO 6| B
    A --> |GPIO 7| B
    A --> |GPIO 8| B
    
    B --> |fwd/reverse pair| C[Motor 1]
    B --> |fwd/reverse pair| D[Motor 2]
    B --> |fwd/reverse pair| E[Motor 3]
    B --> |fwd/reverse pair| F[Motor 4]
    
    A --> |GPIO 9| G[Pnumatic Piston Fire]
    A --> |GPIO 10| H[Pneumatic Piston Retract]
    
    A --> |GPIO 11| I(Auto-Fire Indicator Light)
    
    J(RC transiever) --> |GPIO 12 - GPIO 16| A
```
