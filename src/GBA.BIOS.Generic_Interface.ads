-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.

-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.Interrupts;
use  GBA.Interrupts;

with GBA.Numerics;
use  GBA.Numerics;

with GBA.Memory;
use  GBA.Memory;

with Interfaces;
use  Interfaces;

generic

  with procedure Soft_Reset is <>;
  with procedure Hard_Reset is <>;
  with procedure Halt       is <>;
  with procedure Stop       is <>;

  with procedure Register_RAM_Reset (Flags : Register_RAM_Reset_Flags) is <>;

  with procedure Wait_For_Interrupt
    ( New_Only : Boolean; Wait_For : Interrupt_Flags ) is <>;

  with procedure Wait_For_VBlank is <>;

  with function Div_Mod     (N, D : Integer) return Long_Long_Integer is <>;
  with function Div_Mod_Arm (D, N : Integer) return Long_Long_Integer is <>;

  with function Sqrt (N : Unsigned_32) return Unsigned_16 is <>;
  with function Arc_Tan (X, Y : Fixed_2_14) return Radians_16 is <>;

  with procedure Cpu_Set      (S, D : Address; Config : Cpu_Set_Config) is <>;
  with procedure Cpu_Fast_Set (S, D : Address; Config : Cpu_Set_Config) is <>;

  with function Bios_Checksum return Unsigned_32 is <>;

  with procedure Affine_Set_Ext
    (Parameters : Address; Transform : Address; Count : Integer) is <>;

  with procedure Affine_Set
    (Parameters : Address; Transform : Address; Count, Stride : Integer) is <>;

package GBA.BIOS.Generic_Interface is end;