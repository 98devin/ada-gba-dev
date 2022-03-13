
# ADA GBA

Gameboy Advance software library for the Ada programming language.

## Requirements

- `gprbuild`
- An `arm-eabi` compiler for Ada.

  Recommended is SweetAda or GNAT FSF, which should work across all major OS platforms.
  If you use Alire, you can obtain a compatible `gnat_arm_elf` toolchain easily. This is the most tested configuration.

- (Optionally) `pwsh` is used as a cross-platform shell to write build scripts which convert the finished ELF binary
  into a valid GBA ROM image.

Note that code compiled to run on the GBA uses custom runtime libraries derived from GNAT FSF and SweetAda,
and opts out of the default Ada standard library. All elements of the custom runtime library
are either licensed under the GPL3 with runtime exception (derived from GCC source), or ZLIB licenses (new/custom code).
The `gba_crt0.s` file is licensed under MPL 2.0; a new implementation is under development if this is a problem for you.

The runtime also incorporates work from the excellent AGBABI implementation of `__aeabi` functions to avoid
linking with `libc` or `libg++`.

## Building a GBA project

### ...In a Container

Provided in the `.devcontainer/` subfolder is a `Dockerfile` which will build a container image suitable
for GBA development in Ada. This includes the appropriate Alire-provided GNAT FSF compiler and binutils.

This can be built and developed within automatically from VS Code, or manually with your workspace mounted as a volume.


### ...With Alire

ADA GBA has an included `alire.toml` to allow depending on this package directly with the Alire package manager.
Clone and include this repo in any Alire index visible to your installation, and simply `alr with gba` from your project.

Building the library or executables can then be done simply with `alr build`. It is still recommended to create
a custom `gpr` file rather than the default Alire template, as you will want to inherit from
the provided `GBA_Program.gpr` abstract package.

### ...Manually

- Create a `.gpr` project file which extends from `GBA_Program.gpr` provided here.
- Use `gprbuild` to handle project compilation to an ARM-ELF executable.
- Use `arm-eabi-objcopy -O binary` to produce a `.gba` binary file from the `.o` file.
- If necessary, use `gbafix` to fill in a valid checksum for your `.gba` file.

Sample executables to make sure your build environment works and to demonstrate GBA library features
are provided in the `demo/` directory. The demos will be expanded and adapted as necessary to fit
the requirements and features of this library.

---

## Feature Completion Progress

- Toolchain and system runtime
    - [x] Compile Ada targeting embedded Arm
        - [x] Freely intermix Arm and Thumb mode.
        - [x] Custom small-footprint runtime
        - [x] Secondary stack for easy dynamic allocations
        - [x] Tagged types and interfaces for polymorphism and OOP
        - [x] Native fixed-point math
        - [x] Custom memory allocator support

        No IO, exception propagation, tasking, finalization, standard containers.
        Currently no software floating-point option.

- Hardware Access Layer
    - [x] All IO Register mnemonics
    - [x] Keypad input
        - [x] Control registers
        - [x] Input registers
    - [x] Direct Memory Access
        - [x] Control registers
        - [x] DMA-to-FIFO settings
    - [x] Interrupts
        - [x] Default interrupt handler in Ada + Asm
        - [x] Per-interrupt callbacks
        - [x] Enable/disable interrupts
    - [ ] BIOS functions
        - [x] Accessible from ARM or Thumb mode
        - [x] Inlineable definitions for LTO support
        - [x] Halting, Stopping, Resetting
        - [x] Waiting for interrupts
        - [x] Arithmetic functions (division, arctangent, square root)
        - [x] Memory copy functions
        - [x] Decompression routines
        - [x] BG and OBJ affine matrix computation routines
        - [ ] Sound driver functionality
    - [x] Display control
        - [x] Display registers
        - [x] Backgrounds
        - [x] Windows
        - [x] Palette+ memory
        - [x] Character/Tile memory
        - [x] Object attribute memory
    - [x] Timers
        - [x] Timer control registers
        - [x] Some helper functions for clarity
    - [x] Audio
        - [x] Audio control registers
    - [ ] Serial Communications
    - [x] Gamepak EEPROM / Flash ROM
        - [x] Manual access
    - [ ] Special Add-ons (solar, tilt, rumble, etc.)
    - [ ] Undocumented goodies
        - [x] Greenswap
        - [ ] Waitstates/Prefetch
        - [ ] Low-power halting
        - [ ] Memory layout swapping
    - [ ] Documentation and comments
        - [x] Gnatdoc-built index of files and declarations
        - [ ] More detailed explanations of all library functions
        - [ ] Walkthrough document for examples and getting started

- High Level Interface
    - [x] Keypad input
        - [x] Buffered input
        - [x] Press vs. Held vs. Released checks
    - [ ] Display
        - [ ] Abstract over affine vs. regular BGs
        - [ ] Convenient scrolling/transform manipulation
        - [ ] Per-graphics-mode interface for using backgrounds
        - [ ] Convenient HDMA control
        - [ ] More useful "sprite" abstraction
    - [ ] Allocation abstractions
        - [x] Simple linear allocators
        - [x] IWRAM/EWRAM default memory heaps
        - [ ] More complex general purpose allocators
        - [ ] Domain-specific OAM / VRAM allocation helpers
        - [ ] Resource allocation of timers, DMA channels, backgrounds
    - [ ] IWRAM overlays
    - [ ] Text processing
        - [ ] Rendering text into tiles, sprites etc.
    - [ ] MOD Mixer
    - [ ] Gamepak ROM/Flash
        - [ ] Helper procedures for safe usage
        - [ ] Save file management
    - [ ] Asset management
        - [ ] Build process for compiling graphics assets with palettes
        - [ ] Light filesystem abstraction for identifying assets
        - [ ] Tracking groups of related assets and loading properly
        - [ ] Integration with overlays
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

Integration with the Alire package manager has helped simplify the build process.
Thanks to the greater Ada community for working on it.