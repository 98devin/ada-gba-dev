
# GBADA

Gameboy Advance software library for the Ada programming language.

## Requirements

- An arm-eabi cross compiler for ADA, e.g. GNAT Pro or [GNAT Community Edition 2020](https://www.adacore.com/download/more)
  
  Note that code compiled to run on the GBA uses custom runtime libraries derived from GNAT FSF,
  and opts out of the default Ada standard library. This should mean afaik that even using GNAT
  Community Edition, there is no requirement to license the result under GPL, as all standard
  library files are either not linked or fall under the GCC exceptions.

  GNAT FSF _should_ also work. I have not tested its support of ARM-eabi and custom runtimes.
  Development for this project has been primarily on Windows. Linux and GNAT FSF support
  will be a goal; contributions welcome.

## Building a GBA project

- Ensure that the files in `linker_scripts/` are visible to your toolchain.
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
    - [x] Custom zero-footprint runtime  
    - [x] Secondary stack for dynamic allocations
    - [x] Tagged types for polymorphism and OOP

      No IO, exceptions, tasking, finalization, standard containers.
      Currently no software floating-point (but Ada supports fixed-point natively).
    

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
    - [ ] BG and OBJ affine matrix computation routines
    - [ ] Sound driver functionality
- [ ] Display control
    - [x] Display registers
    - [ ] Backgrounds
        - [x] Types
        - [ ] Background registers
        - [ ] Convenient scrolling/transform manipulation
    - [x] Window control registers
    - [x] Palette memory
    - [ ] Character/Tile memory
    - [ ] Object attribute memory
    - [ ] Per-graphics-mode interface for backgrounds
    - [ ] Convenient HDMA control
- [ ] Timers
- [ ] Audio
    - [ ] Audio control registers
    - [ ] DMA-to-FIFO interface
- [ ] Serial Communications
- [ ] Gamepak EEPROM / Flash ROM
- [ ] Special Add-ons (solar, tilt, rumble, etc.)
- [ ] Undocumented goodies
    - [x] Greenswap
    - [ ] Waitstates/Prefetch
    - [ ] Low-power halting
    - [ ] Memory layout swapping
- [ ] Utilities
    - [ ] General allocation abstractions
    - [ ] IWRAM/EWRAM default heaps
    - [ ] OAM / VRAM allocation helpers
    - [ ] Text processing
    - [ ] MOD Mixer
- [ ] Documentation and comments


## Notes

Thanks to the sources of information used to construct this library, including
- GBATek
- Tonc
- Cowbite
- Community help (GBADev)
- etc.