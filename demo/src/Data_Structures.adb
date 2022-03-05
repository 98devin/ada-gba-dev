-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

with GBA.Allocation;
with GBA.BIOS;
with GBA.BIOS.Arm;
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

with System.Unsigned_Types;

with Integer_Vectors;

procedure Data_Structures is

  use GBA.Allocation;
  use GBA.BIOS.Arm;
  use GBA.Display;
  use GBA.Interrupts;
  use GBA.Input;
  use GBA.Input.Buffered;
  use GBA.Memory;
  use GBA.Memory.IO_Registers;
  use Interfaces;
  use System.Unsigned_Types;

  use all type Integer_Vectors.Index;
  use all type Integer_Vectors.Vector;

  subtype Index  is Integer_Vectors.Index;
  subtype Vector is Integer_Vectors.Vector;

  function Make_Vector return Vector
    with No_Inline is
  begin
    return Vec : Vector (0, 9);
  end Make_Vector;

  V : Vector := Make_Vector;

begin

  Enable_Interrupt (VBlank);
  Enable_Interrupt (Timer_0_Overflow);

  Request_VBlank_Interrupt;
  Wait_For_VBlank;

  Set_Display_Mode (Mode_3);
  Enable_Display_Element (Background_2);

  V.Push (16#11111111#);
  V.Push (16#11111111#);
  V.Push (16#11111111#);
  V.Push (16#11111111#);

  loop
    Wait_For_VBlank;
  end loop;

end Data_Structures;