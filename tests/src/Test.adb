
--  Copyright (c) 2022 Devin Hill
--  zlib License -- see LICENSE for details.

with System.Nonlocal_Jumps;

with GBA.Display.Backgrounds;
with GBA.Display.Palettes;
with GBA.Display.Tiles;

with Test.Font;
with Test.Progress;
with Test.Status;

package body Test is

  use GBA.BIOS.Thumb;
  use GBA.Display;
  use GBA.Display.Tiles;
  use GBA.Display.Backgrounds;
  use GBA.Display.Palettes;
  use GBA.Interrupts;
  use GBA.Memory;
  use GBA.Memory.IO_Registers;

  use Test.Progress;
  use Test.Status;

  use Interfaces;


  Tile_Block      : constant Tile_Block_Index   := 1;
  Tile_Address    : constant Address            := Tile_Block_Address (Tile_Block);

  Screen_Block_BG : constant Screen_Block_Index := 0;
  Screen_Block_FG : constant Screen_Block_Index := 1;

  -- Screen_Address_BG : constant Address := Screen_Block_Address (Screen_Block_BG);
  -- Screen_Address_FG : constant Address := Screen_Block_Address (Screen_Block_FG);

  Screen_BG : Screen_Block_16
    with Import, Address => Screen_Block_Address (Screen_Block_BG);

  Screen_FG : Screen_Block_16
    with Import, Address => Screen_Block_Address (Screen_Block_FG);


  procedure Write_Progress
    ( Line        : Integer;
      Progress    : Progress_Type;
      Status      : Status_Type
    ) is
  begin
    Fill_Progress_Bar
      ( Status     => Status
      , Progress   => Progress
      , Tiles_Addr => Screen_BG (Line, 1)'Address
      );
  end Write_Progress;


  procedure Write_Text
    ( Line        : Integer;
      Text        : Test_String;
      Start_At    : Positive := 1;
      Clear_After : Boolean := False
    )
  is
    Screen_X : Integer := Start_At;
  begin
    for I in Text'Range loop
      Screen_FG (Line, Screen_X) :=
        ( Tile            => Character'Pos (Text (I))
        , Palette_Index   => 0
        , Flip_Horizontal => False
        , Flip_Vertical   => False
        );
      Screen_X := @ + 1;
      exit when Screen_X not in Screen_FG'Range(2);
    end loop;
    if Clear_After then
      while Screen_X in Screen_FG'Range(2) loop
        Screen_FG (Line, Screen_X) :=
          ( Tile            => Character'Pos (' ')
          , Palette_Index   => 0
          , Flip_Horizontal => False
          , Flip_Vertical   => False
          );
        Screen_X := @ + 1;
      end loop;
    end if;
  end Write_Text;


  procedure Initialize_Framework is

    procedure Set_Display_Modes is
    begin
      Enable_Interrupt (VBlank);
      Request_VBlank_Interrupt;

      Set_Display_Mode (Mode_0);
      Enable_Display_Element (Background_0);
      Enable_Display_Element (Background_1);

      BG_Control (BG_0) :=
        ( Tile_Block    => Tile_Block
        , Screen_Block  => Screen_Block_BG
        , Priority      => 1
        , Enable_Mosaic => False
        , Color_Mode    => Colors_16
        , Boundary_Mode => Cutoff
        , Size          => 0
        );

      BG_Control (BG_1) :=
        ( Tile_Block    => Tile_Block
        , Screen_Block  => Screen_Block_FG
        , Priority      => 0
        , Enable_Mosaic => False
        , Color_Mode    => Colors_16
        , Boundary_Mode => Cutoff
        , Size          => 0
        );

    end Set_Display_Modes;

    procedure Load_Font_Data is
      Data_Size : constant Unsigned := Test.Font.Font_Data_Length;
      Data_Src  : constant Address  := Test.Font.Font_Data_Address;

      Unpack_Config : constant Bit_Unpack_Config :=
        ( Src_Data_Bytes  => Unsigned_16 (Data_Size)
        , Src_Data_Width  => 1
        , Dest_Data_Width => 4
        , Data_Offset     => 0
        , Offset_Zeros    => False
        );
    begin
      Bit_Unpack
        ( Src    => Data_Src
        , Dest   => Tile_Address
        , Config => Unpack_Config
        );
    end Load_Font_Data;

    procedure Load_Tile_Data is
      Tiles : Tile_Block_4 (0 .. 512)
        with Import, Address => Tile_Address;

      T : BG_Tile_Index := 128;
    begin
      for C in Color_Index_16 range 1 .. 4 loop
        Tiles (T + 0) := Init_Remainder_Tile (Value => 0, Fill => 0, Back => C);
        Tiles (T + 1) := Init_Remainder_Tile (Value => 1, Fill => C, Back => 0);
        Tiles (T + 2) := Init_Remainder_Tile (Value => 2, Fill => C, Back => 0);
        Tiles (T + 3) := Init_Remainder_Tile (Value => 3, Fill => C, Back => 0);
        Tiles (T + 4) := Init_Remainder_Tile (Value => 4, Fill => C, Back => 0);
        Tiles (T + 5) := Init_Remainder_Tile (Value => 5, Fill => C, Back => 0);
        Tiles (T + 6) := Init_Remainder_Tile (Value => 6, Fill => C, Back => 0);
        Tiles (T + 7) := Init_Remainder_Tile (Value => 7, Fill => C, Back => 0);
        T := T + 8;
      end loop;
      First_Progress_Index (Success)     := 136;
      First_Progress_Index (Failure)     := 144;
      First_Progress_Index (In_Progress) := 152;
    end Load_Tile_Data;

    procedure Load_Palette_Data is
      Palette : Palette_16 renames BG_Palette_16x16 (0);
    begin
      Palette (0) := Color'( 0,  0,  0);
      Palette (1) := Color'(31, 31, 31);
      Palette (2) := Color'( 8, 20,  5);
      Palette (3) := Color'(25,  5,  8);
      Palette (4) := Color'( 5, 10, 25);
    end Load_Palette_Data;

    procedure Load_Test_Pattern is
    begin
      for I in Screen_FG'Range(1) loop
        Write_Text (Line => I, Text => "!? !? !? !? !? !? !? !? !? !? ");
      end loop;
    end Load_Test_Pattern;

  begin
    Set_Display_Modes;
    Load_Font_Data;
    Load_Tile_Data;
    Load_Palette_Data;
    Load_Test_Pattern;

    for I in Screen_BG'Range(1) loop
      Write_Progress (Line => I, Progress => 30.0 / 20.0 * I, Status => Success);
    end loop;
  end Initialize_Framework;


  type Counting_Scheduler is new Test_Scheduler with
    record
      Test_Count : Integer := 0;
    end record;

  overriding
  procedure Add
    ( Scheduler : in out Counting_Scheduler;
      Name      : Test_String;
      Run       : not null access procedure (Handler : Handler_Ref) );

  overriding
  procedure Group
    ( Scheduler : in out Counting_Scheduler;
      Name      : Test_String;
      Schedule  : not null access procedure (Scheduler : Scheduler_Ref) );


  overriding
  procedure Add
    ( Scheduler : in out Counting_Scheduler;
      Name      : Test_String;
      Run       : not null access procedure (Handler : Handler_Ref) ) is
  begin
    Scheduler.Test_Count := @ + 1;
  end Add;

  overriding
  procedure Group
    ( Scheduler : in out Counting_Scheduler;
      Name      : Test_String;
      Schedule  : not null access procedure (Scheduler : Scheduler_Ref) ) is
  begin
    Scheduler.Test_Count := @ + 1;
  end Group;


  type Show_Names_Scheduler is new Counting_Scheduler with
    null record;

  overriding
  procedure Add
    ( Scheduler : in out Show_Names_Scheduler;
      Name      : Test_String;
      Run       : not null access procedure (Handler : Handler_Ref) );

  overriding
  procedure Group
    ( Scheduler : in out Show_Names_Scheduler;
      Name      : Test_String;
      Schedule  : not null access procedure (Scheduler : Scheduler_Ref) );

  overriding
  procedure Add
    ( Scheduler : in out Show_Names_Scheduler;
      Name      : Test_String;
      Run       : not null access procedure (Handler : Handler_Ref) ) is
  begin
    Counting_Scheduler (Scheduler).Add (Name, Run);
    if Scheduler.Test_Count <= 20 then
      Write_Text (Scheduler.Test_Count, Name, Clear_After => True);
    end if;
  end Add;

  overriding
  procedure Group
    ( Scheduler : in out Show_Names_Scheduler;
      Name      : Test_String;
      Schedule  : not null access procedure (Scheduler : Scheduler_Ref) ) is
  begin
    Counting_Scheduler (Scheduler).Group (Name, Schedule);
    if Scheduler.Test_Count <= 20 then
      Write_Text (Scheduler.Test_Count, Name, Clear_After => True);
    end if;
  end Group;


  procedure Run_Top_Level_Tests
    ( Schedule : not null access procedure (Scheduler : Scheduler_Ref) ) is

    Counter : Scheduler_Ref := new Show_Names_Scheduler;

  begin

    Schedule (Counter);

    declare
      Progress     : Progress_Type := 0.0;
      Max_Progress : Progress_Type := 1.0 * Show_Names_Scheduler (Counter.all).Test_Count;
    begin
      loop
        declare
          Current_Progress : Progress_Type := Progress_Type'(Progress / Max_Progress) * 30.0;
        begin
          for I in Screen_BG'Range(2) loop
            Write_Progress (Line => I, Progress => Current_Progress, Status => In_Progress);
          end loop;

          if Progress = Max_Progress then
            Progress := 0.0;
          else
            Progress := @ + 0.125;
          end if;
        end;

        Wait_For_VBlank;
        Wait_For_VBlank;
        Wait_For_VBlank;
      end loop;
    end;

  end Run_Top_Level_Tests;


end Test;