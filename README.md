# STM32F411 Bare-Metal GPIO Driver

Bare-metal GPIO driver written in C for the STM32F411 ARM Cortex-M4
microcontroller. Implements LED control through direct register
configuration without STM32 HAL libraries.

## What This Demonstrates

- RCC AHB1ENR clock enable for GPIOC peripheral
- GPIOC MODER register configuration for output mode (2-bit per pin)
- GPIOC ODR register for pin voltage control
- Custom linker script (linker.ld) defining STM32F411 memory map
- Bare-metal startup code (startup.s) — stack setup and main() entry
- arm-none-eabi-gcc toolchain with OpenOCD + ST-Link V2 flashing

## Why No HAL

STM32 HAL hides the hardware setup behind thick layers of code.
Writing directly to RCC_AHB1ENR, GPIOC_MODER and GPIOC_ODR
gives full control over which clocks are enabled and how each pin
is configured. This is how production embedded firmware is written.

## Build and Flash

make flash

Requires arm-none-eabi-gcc, OpenOCD, and ST-Link V2 programmer.

## Hardware

- WeAct STM32F411CEU6 Black Pill (ARM Cortex-M4 at 100MHz)
- ST-Link V2 programmer via SWD interface (SWDIO, SWCLK)
- Built-in LED on PC13 (active low)

## Tools

- arm-none-eabi-gcc, arm-none-eabi-objcopy
- OpenOCD 0.12.0
- ST-Link V2
- STM32F411 Reference Manual RM0383
- GNU Make
