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
with System.Nonlocal_Jumps;

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

  use System.Nonlocal_Jumps;

  use Test;


  V : Integer := 0
    with Export;

  Buf : aliased Jump_Buffer;

  procedure Finish_And_Jump with No_Inline is
  begin

    V := @ + 1;

    Jump (Buf'Access);

    V := @ + 1;

  end Finish_And_Jump;

  procedure Continue_After_Set with No_Inline is
  begin

    V := @ * 10;

    Finish_And_Jump;

    V := @ * 10;

  end Continue_After_Set;

  procedure Begin_And_Set with No_Inline is
  begin
    V := @ + 3;

    if Set_Jump (Buf'Access) = 1 then
      return;
    end if;

    Continue_After_Set;

    V := @ + 3;

  end Begin_And_Set;


  procedure Example_Schedule (Scheduler : in out Test_Schedule'Class) with No_Inline;
  pragma Machine_Attribute (Example_Schedule, "target", "arm");

  procedure Example_Schedule (Scheduler : in out Test_Schedule'Class) is
    procedure Dummy (Handler : Test_Handler'Class) is null;
  begin
    Scheduler.Add_Test ("Wahoo", Dummy'Unrestricted_Access);
    Scheduler.Add_Test ("Wahee", Dummy'Unrestricted_Access);
    Scheduler.Add_Test ("Wahaa", Dummy'Unrestricted_Access);
    declare
      S : Test_Schedule'Class := Scheduler.Add_Group ("Group1");
    begin
      S.Add_Test ("Wahuu", Dummy'Unrestricted_Access);
    end;
  end Example_Schedule;

  A : Positive := -1;

begin

  Test.Initialize_Framework;

  declare
    Scheduler : Test_Schedule'Class := Get_Main_Schedule;
  begin
    Example_Schedule (Scheduler);
    Scheduler.Run;
  end;

  loop
    Wait_For_VBlank;
  end loop;

end Data_Structures;