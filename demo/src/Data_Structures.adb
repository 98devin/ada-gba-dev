-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

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

with HLI.Allocation.Bounded_Linear_Pools;
with HLI.Allocation.Bounded_Arena_Pools;

with System.Unsigned_Types;

with Integer_Vectors;

with Ada.Unchecked_Deallocation;

procedure Data_Structures is

  use GBA.BIOS.Arm;
  use GBA.Display;
  use GBA.Interrupts;
  use GBA.Input;
  use GBA.Input.Buffered;
  use GBA.Memory;
  use GBA.Memory.IO_Registers;
  use Interfaces;

  package Arena_Pools is new HLI.Allocation.Bounded_Arena_Pools
    ( Block_Size_In_Bytes => 128 );

  use all type Arena_Pools.Arena_Pool;
  use all type Integer_Vectors.Index;
  use all type Integer_Vectors.Vector;

  subtype Arena_Pool is Arena_Pools.Arena_Pool;
  subtype Index      is Integer_Vectors.Index;
  subtype Vector     is Integer_Vectors.Vector;

  Local_Arena_Pool : Arena_Pool'Class := Create_With_Capacity (4);

  type Vector_Ptr is access Vector;
  for Vector_Ptr'Storage_Pool use Local_Arena_Pool;

  procedure Free is
    new Ada.Unchecked_Deallocation (Vector, Vector_Ptr);

begin

  Enable_Interrupt (VBlank);
  Enable_Interrupt (Timer_0_Overflow);

  Request_VBlank_Interrupt;
  Wait_For_VBlank;

  Set_Display_Mode (Mode_3);
  Enable_Display_Element (Background_2);

  for I in Index range 1 .. 4 loop
    declare
      V : Vector_Ptr := null;
    begin
      V := new Vector (1, 4);
      V.Push (16#11111111# * Integer (I));
      V.Push (16#11111111# * Integer (I));
      V.Push (16#11111111# * Integer (I));
      V.Push (16#11111111# * Integer (I));

      V (I) := 16#55555555#;

      Free (V);
    end;
  end loop;

  Wait_For_Interrupt (Wait_For => 2 ** 7);

end Data_Structures;