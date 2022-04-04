
--  Copyright (c) 2022 Devin Hill
--  zlib License -- see LICENSE for details.

with GBA.Display.Backgrounds;
with GBA.Display.Palettes;
with GBA.Display.Tiles;
with GBA.Input;
with GBA.Input.Buffered;

with Test.Font;
with Test.Progress;

package body Test is

  use GBA.BIOS.Thumb;
  use GBA.Display;
  use GBA.Display.Tiles;
  use GBA.Display.Backgrounds;
  use GBA.Display.Palettes;
  use GBA.Interrupts;
  use GBA.Input;
  use GBA.Input.Buffered;
  use GBA.Memory;
  use GBA.Memory.IO_Registers;

  use Test.Progress;

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
    )
  is
    type Screen_Dim is mod 32;
    Screen_Line : Integer := Integer (Screen_Dim'Mod (Line - 1)) + 1;
  begin
    Fill_Progress_Bar
      ( Status     => Status
      , Progress   => Progress
      , Tiles_Addr => Screen_BG (Screen_Line, 1)'Address
      );
  end Write_Progress;


  procedure Write_Text
    ( Line        : Integer;
      Text        : Test_String;
      Start_At    : Positive := 1;
      Clear_After : Boolean := False
    )
  is
    type Screen_Dim is mod 32;
    Screen_Line : Integer := Integer (Screen_Dim'Mod (Line - 1)) + 1;
    Screen_X    : Integer := Start_At;
  begin
    for I in Text'Range loop
      Screen_FG (Screen_Line, Screen_X) :=
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
        Screen_FG (Screen_Line, Screen_X) :=
          ( Tile            => Character'Pos (' ')
          , Palette_Index   => 0
          , Flip_Horizontal => False
          , Flip_Vertical   => False
          );
        Screen_X := @ + 1;
      end loop;
    end if;
  end Write_Text;


  Desired_Top_Line   : Positive         := 1;
  Current_Top_Offset : BG_Scroll_Offset := 0;

  function Desired_Top_Offset return BG_Scroll_Offset is
    ( BG_Scroll_Offset (Desired_Top_Line - 1) * 8 );

  procedure Process_Line_Scroll is
  begin
    if Current_Top_Offset = Desired_Top_Offset then
      return;
    end if;
    declare
      Line_Diff : BG_Scroll_Offset := (Desired_Top_Offset - Current_Top_Offset) / 8;
    begin
      if Line_Diff = 0 then
        Line_Diff := (if Desired_Top_Offset > Current_Top_Offset then 1 else -1);
      end if;

      Current_Top_Offset := @ + Line_Diff;
      Set_Offset_Y (BG_0, Value => Current_Top_Offset);
      Set_Offset_Y (BG_1, Value => Current_Top_Offset);
    end;
  end Process_Line_Scroll;


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

  -----------
  -- Utils --
  -----------

  procedure Append (List : in out Test_Item_List; Item : Test_Item_Ptr) is
  begin
    if List.First = null then
      Item.Prev  := null;
      Item.Next  := null;

      List.First := Item;
      List.Last  := Item;
    else
      Item.Prev      := List.Last;
      Item.Next      := null;

      List.Last.Next := Item;
      List.Last      := Item;
    end if;
  end Append;

  function Length (List : Test_Item_List) return Integer is
    Count : Integer := 0;
    Item  : access Test_Item := List.First;
  begin
    while Item /= null loop
      Count := @ + 1;
      Item  := Item.Next;
    end loop;
    return Count;
  end Length;

  -------------------
  -- Main_Schedule --
  -------------------

  overriding
  procedure Add_Test (Schedule : in out Main_Schedule; Name : Test_String; Run : Test_Runner_Procedure) is
    T : Test_Item_Ptr := new Test_Item (Item_Test);
  begin
    T.Test_Value.Name   := new Test_String'(Name);
    T.Test_Value.Runner := Run;

    Append (Schedule.Items, T);
  end Add_Test;

  overriding
  function Add_Group (Schedule : in out Main_Schedule; Name : Test_String) return Test_Schedule'Class is
    G : Test_Item_Ptr := new Test_Item (Item_Group);
  begin
    G.Group_Value.Name := new Test_String'(Name);

    Append (Schedule.Items, G);
    return Group_Schedule'( Items => G.Group_Value.Items'Access );
  end Add_Group;

  overriding
  procedure Run (Schedule : in out Main_Schedule) is
    Line : Integer := 1;
    Item : Test_Item_Ptr := Schedule.Items.First;
  begin
    while Item /= null and then Line <= 20 loop
      case Item.Kind is
      when Item_Test =>
        Write_Text (Line, Item.Test_Value.Name.all,  Clear_After => True);
      when Item_Group =>
        Write_Text (Line, Item.Group_Value.Name.all, Clear_After => True);
      end case;

      Item := Item.Next;
      Line := Line + 1;
    end loop;

    loop
      Update_Key_State;

      if Was_Key_Pressed (Up_Direction) then
        Desired_Top_Line := Positive'Max (1, @ - 1);
      elsif Was_Key_Pressed (Down_Direction) then
        Desired_Top_Line := @ + 1;
      end if;

      Process_Line_Scroll;
      Wait_For_VBlank;
    end loop;
  end Run;

  --------------------
  -- Group_Schedule --
  --------------------

  overriding
  procedure Add_Test  (Schedule : in out Group_Schedule; Name : Test_String; Run : Test_Runner_Procedure) is
    T : Test_Item_Ptr := new Test_Item (Item_Test);
  begin
    T.Test_Value.Name   := new Test_String'(Name);
    T.Test_Value.Runner := Run;

    Append (Schedule.Items.all, T);
  end Add_Test;

  overriding
  function Add_Group (Schedule : in out Group_Schedule; Name : Test_String) return Test_Schedule'Class is
    G : Test_Item_Ptr := new Test_Item (Item_Group);
  begin
    G.Group_Value.Name := new Test_String'(Name);

    Append (Schedule.Items.all, G);
    return Group_Schedule'( Items => G.Group_Value.Items'Access );
  end Add_Group;

  overriding
  procedure Run (Schedule : in out Group_Schedule) is
  begin
    null;
  end Run;

  ------------------
  -- Main_Handler --
  ------------------

  overriding
  procedure Assert (Handler : Main_Handler; Expect : Boolean; Desc : Test_String) is
  begin
    null;
  end Assert;

  -----------------------
  -- Get_Main_Schedule --
  -----------------------

  function Get_Main_Schedule return Test_Schedule'Class is
  begin
    return M : Main_Schedule := (others => <>);
  end Get_Main_Schedule;

  -------------------------
  -- Last_Chance_Handler --
  -------------------------

  procedure Last_Chance_Handler
    ( Msg : System.Address; Line : Integer ) is

    use all type System.Byte;

    Byte_Msg : array (1 .. 30) of System.Byte
      with Address => Msg;

    Byte_End : Integer := 30;

  begin
    for I in 1 .. 20 loop
      Write_Progress (Line => I, Progress => 30.0, Status => Failure);
      Write_Text (Line => I, Text => "", Start_At => 1, Clear_After => True);
    end loop;

    for I in 1 .. 30 loop
      if Byte_Msg (I) = 0 then
        Byte_End := I;
        exit;
      end if;
    end loop;

    declare
      Str_Msg : Test_String (1 .. Byte_End)
        with Address => Msg;
    begin
      Write_Text (Line => 1, Text => Str_Msg, Start_At => 1,                  Clear_After => False);
      Write_Text (Line => 1, Text => ":",     Start_At => Str_Msg'Length + 1, Clear_After => False);
      Write_Text (Line => 1, Text => "100",   Start_At => Str_Msg'Length + 2, Clear_After => True);
    end;

    loop
      null;
    end loop;
  end Last_Chance_Handler;

end Test;