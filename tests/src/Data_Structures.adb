-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

with GBA.BIOS;
with GBA.BIOS.Thumb;
with GBA.Display;
with GBA.DMA;
with GBA.Input;
with GBA.Input.Buffered;
with GBA.Interrupts;
with GBA.Memory;
with GBA.Memory.Default_Heaps;
with GBA.Memory.IO_Registers;
with GBA.Timers;
with Interfaces;

with HLI.Allocation.Bounded_Linear_Pools;
with HLI.Allocation.Bounded_Arena_Pools;

with System.Unsigned_Types;

with Integer_Vectors;

with Ada.Unchecked_Deallocation;

with Test;

procedure Data_Structures is

  use GBA.BIOS.Thumb;
  use GBA.Display;
  use GBA.Interrupts;
  use GBA.Input;
  use GBA.Input.Buffered;
  use GBA.Memory;
  use GBA.Memory.IO_Registers;
  use Interfaces;

begin

  Test.Initialize_Framework;

  loop
    Wait_For_VBlank;
  end loop;

end Data_Structures;