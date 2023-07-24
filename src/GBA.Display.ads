-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.Numerics;

with GBA.Memory.IO_Registers;
use  GBA.Memory.IO_Registers;

package GBA.Display is

  type Video_Mode is
    ( Mode_0  -- 4 text BGs
    , Mode_1  -- 2 text BGs + 1 rot/scale BGs
    , Mode_2  -- 2 rot/scale bgs
    , Mode_3  -- 15-bit color 240x160 bitmap
    , Mode_4  --  8-bit color 240x160 bitmap + buffering
    , Mode_5  -- 15-bit color 160x128 bitmap + buffering
    )
    with Size => 3;

  for Video_Mode use
    ( Mode_0 => 0
    , Mode_1 => 1
    , Mode_2 => 2
    , Mode_3 => 3
    , Mode_4 => 4
    , Mode_5 => 5
    );


  type Character_Mapping_Style is
    ( Two_Dimensional  -- Each row of tiles spans the same columns of tile data.
    , One_Dimensional  -- Each row of tiles immediately succeeds the last row.
    );

  for Character_Mapping_Style use
    ( Two_Dimensional => 0
    , One_Dimensional => 1
    );


  type Vertical_Counter_Type is range 0 .. 227
    with Size => 8;

  type Display_Priority is range 0 .. 3
    with Size => 2;


  type Toggleable_Display_Element is
    ( Background_0
    , Background_1
    , Background_2
    , Background_3
    , Object_Sprites
    , Window_0
    , Window_1
    , Object_Window
    );

  for Toggleable_Display_Element use
    ( Background_0    => 0
    , Background_1    => 1
    , Background_2    => 2
    , Background_3    => 3
    , Object_Sprites  => 4
    , Window_0        => 5
    , Window_1        => 6
    , Object_Window   => 7
    );


  procedure Set_Display_Mode (Mode : Video_Mode; Forced_Blank : Boolean := False)
    with Inline;

  procedure Enable_Display_Element
    (Element : Toggleable_Display_Element; Enable : Boolean := True)
    with Inline;

  procedure Request_VBlank_Interrupt (Request : Boolean := True)
    with Inline;

  procedure Request_HBlank_Interrupt (Request : Boolean := True)
    with Inline;


  type Displayed_Element_Flags is
    array (Toggleable_Display_Element range <>) of Boolean
    with Pack;

  type Bitmap_Frame_Choice is mod 2;

  type Display_Control_Info is
    record
      Mode                 : Video_Mode;
      Bitmap_Frame         : Bitmap_Frame_Choice; -- Only relevant for mode 4 and 5
      Free_HBlank_Interval : Boolean;
      Character_Mapping    : Character_Mapping_Style;
      Forced_Blank         : Boolean;
      Displayed_Elements   : Displayed_Element_Flags (Toggleable_Display_Element);
    end record
      with Size => 16;

  for Display_Control_Info use
    record
      Mode                 at 0 range 0 .. 2;
      Bitmap_Frame         at 0 range 4 .. 4;
      Free_HBlank_Interval at 0 range 5 .. 5;
      Character_Mapping    at 0 range 6 .. 6;
      Forced_Blank         at 0 range 7 .. 7;
      Displayed_Elements   at 1 range 0 .. 7;
    end record;


  type Display_Status_Info is
    record
      Is_VBlank                : Boolean;
      Is_HBlank                : Boolean;
      Is_Matching_VCount       : Boolean;
      Request_VBlank_Interrupt : Boolean;
      Request_HBlank_Interrupt : Boolean;
      Request_VCount_Interrupt : Boolean;
      VCount_Value_Setting     : Vertical_Counter_Type;
    end record
      with Size => 16;

  for Display_Status_Info use
    record
      Is_VBlank                at 0 range 0 .. 0;
      Is_HBlank                at 0 range 1 .. 1;
      Is_Matching_VCount       at 0 range 2 .. 2;
      Request_VBlank_Interrupt at 0 range 3 .. 3;
      Request_HBlank_Interrupt at 0 range 4 .. 4;
      Request_VCount_Interrupt at 0 range 5 .. 5;
      VCount_Value_Setting     at 1 range 0 .. 7;
    end record;


  Display_Control : Display_Control_Info
    with Import, Volatile, Address => DISPCNT;

  Display_Status : Display_Status_Info
    with Import, Volatile, Address => DISPSTAT;

  Vertical_Counter : Vertical_Counter_Type
    with Import, Volatile, Address => VCOUNT;

  Green_Swap : Boolean
    with Import, Volatile, Address => GREENSWAP;

end GBA.Display;