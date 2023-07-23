-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


with Interfaces;
use  Interfaces;

with GBA.Memory.IO_Registers;
use  GBA.Memory.IO_Registers;

package GBA.Timers is

  subtype Timer_Value is Unsigned_16;

  type Timer_Scale is
    ( x1
    , x64
    , x256
    , x1024
    );

  for Timer_Scale use
    ( x1    => 0
    , x64   => 1
    , x256  => 2
    , x1024 => 3
    );


  type Timer_Increment_Type is
    ( Independent
    , Linked_To_Previous
    );

  for Timer_Increment_Type use
    ( Independent        => 0
    , Linked_To_Previous => 1
    );


  type Timer_Control_Info is
    record
      Scale       : Timer_Scale;
      Increment   : Timer_Increment_Type;
      Trigger_IRQ : Boolean;
      Enabled     : Boolean;
    end record
      with Size => 16;

  for Timer_Control_Info use
    record
      Scale       at 0 range 0 .. 1;
      Increment   at 0 range 2 .. 2;
      Trigger_IRQ at 0 range 6 .. 6;
      Enabled     at 0 range 7 .. 7;
    end record;


  type Timer is
    record
      Value        : Timer_Value;
      Control_Info : Timer_Control_Info;
    end record;


  type Timer_ID is range 0 .. 3;

  Timers : array (Timer_ID) of Timer
    with Import, Address => TM0CNT_L;

  function Get_Count (ID : Timer_ID) return Timer_Value
    with Inline_Always;

  procedure Set_Initial_Value (ID : Timer_ID; Value : Timer_Value)
    with Inline_Always;

  procedure Start_Timer (ID : Timer_ID)
    with Inline_Always;

  procedure Set_Timer_Scale (ID : Timer_ID; Scale : Timer_Scale)
    with Inline_Always;

  procedure Set_Timer_Increment_Type (ID : Timer_ID; Increment : Timer_Increment_Type)
    with Inline_Always;


end GBA.Timers;