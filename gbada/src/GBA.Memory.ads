
with System;

package GBA.Memory is

  pragma Preelaborate;
  
  -- Total addressable memory of 28 bits.
  subtype Address is System.Address
    range 16#0000000# .. 16#FFFFFFF#;

  subtype BIOS_Address is Address
    range 16#0000000# .. 16#00003FFF#;

  subtype External_WRAM_Address is Address
    range 16#2000000# .. 16#203FFFF#;

  subtype Internal_WRAM_Address is Address
    range 16#3000000# .. 16#3007FFF#;

  subtype Reserved_Internal_WRAM_Adddress is Internal_WRAM_Address
    range 16#3007F00# .. 16#3007FFF#;
  
  subtype IO_Register_Address is Address
    range 16#4000000# .. 16#40003FF#;
  
  subtype Palette_RAM_Address is Address
    range 16#5000000# .. 16#50003FF#;
  
  subtype Video_RAM_Address is Address
    range 16#6000000# .. 16#6017FFF#;

  subtype OAM_Address is Address
    range 16#7000000# .. 16#70003FF#;

  subtype ROM_Address is Address
    range 16#8000000# .. 16#DFFFFFF#;

  BIOS_Size          : constant := BIOS_Address'Range_Length;          -- 16kB
  External_WRAM_Size : constant := External_WRAM_Address'Range_Length; -- 256kB
  Internal_WRAM_Size : constant := Internal_WRAM_Address'Range_Length; -- 32kB
  IO_Registers_Size  : constant := IO_Register_Address'Range_Length;   -- 1kB
  Palette_RAM_Size   : constant := Palette_RAM_Address'Range_Length;   -- 1kB
  Video_RAM_Size     : constant := Video_RAM_Address'Range_Length;     -- 96kB
  OAM_Size           : constant := OAM_Address'Range_Length;           -- 1kB
  ROM_Size           : constant := ROM_Address'Range_Length;           -- 32mB

end GBA.Memory;