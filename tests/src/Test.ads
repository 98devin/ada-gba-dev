
-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

with GBA.BIOS;
with GBA.BIOS.Thumb;
with GBA.Display;
with GBA.Interrupts;
with GBA.Memory;
with GBA.Memory.IO_Registers;

with System.Unsigned_Types;
use  System.Unsigned_Types;

with Interfaces;


package Test is

  subtype Test_Character is
    Character range Character'Val(16#00#) .. Character'Val(16#7F#);

  type Test_String is
    array (Positive range <>) of Test_Character;


  procedure Initialize_Framework;


  type Test_Handler is limited interface;
  type Handler_Ref is not null access all Test_Handler'Class;

  procedure Assert (Handler : Test_Handler; Expect : Boolean; Desc : Test_String := "")
    is abstract;


  type Test_Scheduler is limited interface;
  type Scheduler_Ref is not null access all Test_Scheduler'Class;

  procedure Add
    ( Scheduler : in out Test_Scheduler;
      Name      : Test_String;
      Run       : not null access procedure
        (Handler : Handler_Ref) ) is abstract;

  procedure Group
    ( Scheduler : in out Test_Scheduler;
      Name      : Test_String;
      Schedule  : not null access procedure (Scheduler : Scheduler_Ref) ) is abstract;


  procedure Run_Top_Level_Tests
    ( Schedule : not null access procedure (Scheduler : Scheduler_Ref) );


end Test;