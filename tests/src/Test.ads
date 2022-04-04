
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

with System.Nonlocal_Jumps;

with Interfaces;


package Test is

  procedure Initialize_Framework
    with No_Inline;


  subtype Test_Character is
    Character range Character'Val(16#00#) .. Character'Val(16#7F#);

  type Test_String is
    array (Positive range <>) of Test_Character;

  type Progress_Type is
    delta 2.0 ** (-3) range 0.0 .. 30.0;

  type Status_Type is
    ( In_Progress
    , Success
    , Failure
    );


  type Test_Handler is limited interface;
  type Test_Runner_Procedure is access procedure (Handler : Test_Handler'Class);

  procedure Assert (Handler : Test_Handler; Expect : Boolean; Desc : Test_String)
    is abstract;


  type Test_Schedule is limited interface;

  procedure Add_Test  (Schedule : in out Test_Schedule; Name : Test_String; Run : Test_Runner_Procedure) is abstract;
  function Add_Group (Schedule : in out Test_Schedule; Name : Test_String) return Test_Schedule'Class is abstract;

  procedure Run (Schedule : in out Test_Schedule) is abstract;

  function Get_Main_Schedule return Test_Schedule'Class;

  procedure Write_Progress
    ( Line        : Integer;
      Progress    : Progress_Type;
      Status      : Status_Type
    );

  procedure Write_Text
    ( Line        : Integer;
      Text        : Test_String;
      Start_At    : Positive := 1;
      Clear_After : Boolean := False
    );

  procedure Last_Chance_Handler
    ( Msg : System.Address; Line : Integer )
    with Export, External_Name => "__gnat_last_chance_handler";

private

  type Test_Item;
  type Test_Item_Ptr is access Test_Item;
  type Test_String_Ptr is access Test_String;

  type Test_Item_List is
    record
      First : Test_Item_Ptr := null;
      Last  : Test_Item_Ptr := null;
    end record;

  type Test_Case is limited
    record
      Runner   : Test_Runner_Procedure;
      Name     : Test_String_Ptr := null;
      Finished : Boolean         := False;
      Failed   : Boolean         := False;
    end record;

  type Test_Group is limited
    record
      Name     : Test_String_Ptr;
      Items    : aliased Test_Item_List;
      Progress : Progress_Type := 0.0;
    end record;

  type Item_Kind is
    ( Item_Test
    , Item_Group
    );

  type Test_Item (Kind : Item_Kind) is limited
    record
      Index : Natural       := 0;
      Next  : Test_Item_Ptr := null;
      Prev  : Test_Item_Ptr := null;

      case Kind is
      when Item_Test =>
        Test_Value  : Test_Case;
      when Item_Group =>
        Group_Value : Test_Group;
      end case;
    end record;


  procedure Append (List : in out Test_Item_List; Item : Test_Item_Ptr);

  function Length (List : Test_Item_List) return Integer;


  type Main_Schedule is limited new Test_Schedule with
    record
      Item_Count : Natural := 0;
      Items      : Test_Item_List;
    end record;

  overriding
  procedure Add_Test  (Schedule : in out Main_Schedule; Name : Test_String; Run : Test_Runner_Procedure);

  overriding
  function Add_Group (Schedule : in out Main_Schedule; Name : Test_String) return Test_Schedule'Class;

  overriding
  procedure Run (Schedule : in out Main_Schedule);


  type Group_Schedule is limited new Test_Schedule with
    record
      Items : access Test_Item_List;
    end record;

  overriding
  procedure Add_Test  (Schedule : in out Group_Schedule; Name : Test_String; Run : Test_Runner_Procedure);

  overriding
  function Add_Group (Schedule : in out Group_Schedule; Name : Test_String) return Test_Schedule'Class;

  overriding
  procedure Run (Schedule : in out Group_Schedule);


  type Main_Handler is limited new Test_Handler with
    record
      Abort_Jump_Buf : System.Nonlocal_Jumps.Jump_Buffer;
    end record;

  overriding
  procedure Assert (Handler : Main_Handler; Expect : Boolean; Desc : Test_String);



end Test;