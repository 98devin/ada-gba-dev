
# GBADA

Gameboy Advance software library for the Ada programming language.

## Requirements

- An arm-eabi cross compiler for ADA. Recommended is SweetAda, which should work across all major OS platforms.
  However it is merely a convenient way to get the latest GCC with Ada + ARM support; if you already have a modern
  GCC with Ada 2012 compatibility please try it out and let me know to add a mention of compatibility.

  Note that code compiled to run on the GBA uses custom runtime libraries derived from GNAT FSF and SweetAda,
  and opts out of the default Ada standard library. All elements of the custom runtime library
  are either licensed under the GPL3 with runtime exception (derived from GCC source), or ZLIB licenses (new/custom code).
  The `gba_crt0.s` file is licensed under MPL 2.0; a new implementation is under development if this is a problem for you.

  The runtime also incorporates work from the excellent AGBABI implementation of `__aeabi` functions to avoid
  linking with `libc` or `libg++`.

## Building a GBA project

- Create a `.gpr` project file which extends from `GBA_Program.gpr` provided here.
- Use `gprbuild` to handle project compilation to an ARM-ELF executable.
- Use `objcopy -O binary` from your toolchain's binutils to produce a `.gba` binary file from the `.o` file.
- If necessary, use `gbafix` to fill in a valid checksum for your `.gba` file.

A sample project to make sure your build environment works and to demonstrate GBADA library features
is provided in the `demo/` directory. The demo(s) will be expanded and adapted as necessary to fit
the requirements and features of this library.

---

## Development Progress

- [x] Compile Ada targeting embedded Arm
    - [x] Freely intermix Arm and Thumb mode.
    - [x] Custom small-footprint runtime
    - [x] Secondary stack for easy dynamic allocations
    - [x] Tagged types for polymorphism and OOP
    - [x] Native fixed-point math support instead of Floats

      No IO, exception propagation, tasking, finalization, standard containers.
      Currently no software floating-point option.

- [x] All IO Register mnemonics
- [x] Keypad input
- [x] (basic) Direct Memory Access control
- [x] Interrupts
    - [x] Default interrupt handler in Ada + Asm
    - [x] Per-interrupt callbacks
    - [x] Enable/disable interrupts
- [ ] BIOS functions
    - [x] Accessible from ARM or Thumb mode
    - [x] Halting, Stopping, Resetting
    - [x] Waiting for interrupts
    - [x] Arithmetic functions (division, arctangent, square root)
    - [x] Memory copy functions
        - [x] Alternative to default `memset` using CpuSet
        - [ ] Alternative to default `memcpy` using CpuSet
    - [ ] Decompression routines
    - [x] BG and OBJ affine matrix computation routines
    - [ ] Sound driver functionality
- [ ] Display control
    - [x] Display registers
    - [ ] Backgrounds
        - [x] Types
        - [x] Background registers
        - [ ] Convenient scrolling/transform manipulation
    - [x] Window control registers
    - [x] Palette memory
    - [x] Character/Tile memory
    - [x] Object attribute memory
    - [ ] Per-graphics-mode interface for backgrounds
    - [ ] Convenient HDMA control
- [x] Timers
    - [x] Timer control registers
    - [x] Some helper functions for clarity
- [ ] Audio
    - [ ] Audio control registers
    - [ ] DMA-to-FIFO interface
- [ ] Serial Communications
- [ ] Gamepak EEPROM / Flash ROM
    - [x] Manual access
    - [ ] Helper procedures for safe usage
- [ ] Special Add-ons (solar, tilt, rumble, etc.)
- [ ] Undocumented goodies
    - [x] Greenswap
    - [ ] Waitstates/Prefetch
    - [ ] Low-power halting
    - [ ] Memory layout swapping
- [ ] Utilities
    - [x] General allocation abstractions
    - [x] IWRAM/EWRAM default heaps
    - [ ] IWRAM overlays
    - [ ] OAM / VRAM allocation helpers
    - [ ] Text processing
    - [ ] MOD Mixer
- [ ] Documentation and comments
    - [x] Gnatdoc-built index of files and declarations
    - [ ] More detailed explanations of all library functions
    - [ ] Walkthrough document for examples and getting started


## Notes

Thanks to the sources of information used to construct this library, including
- GBATek
- Tonc
- Cowbite
- Community help (GBADev)
- etc.

The great AGBABI library is used here to provide efficient implementations
of some built-in functions (math, memory copies, etc.)