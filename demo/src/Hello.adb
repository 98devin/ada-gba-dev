
with GBA.BIOS;
with GBA.BIOS.Thumb;
with GBA.BIOS.Memset;

with GBA.Display;
with GBA.Display.Tiles;
with GBA.Display.Backgrounds;
with GBA.Display.Objects;
with GBA.Display.Palettes;
with GBA.Display.Windows;

with GBA.Memory;
with GBA.Memory.Default_Secondary_Stack;

with GBA.Numerics;

with GBA.Interrupts;

with GBA.Input;
with GBA.Input.Buffered;

with Interfaces;

procedure Hello is

  use GBA.BIOS;
  use GBA.BIOS.Thumb;

  use GBA.Display;
  use GBA.Display.Palettes;
  use GBA.Display.Backgrounds;

  use GBA.Numerics;

  use GBA.Input;
  use GBA.Input.Buffered;

  VRAM : array (1 .. 160, 1 .. 240) of Color
    with Import, Volatile, Address => 16#6000000#;

  Color_Palette : Palette_16_Ptr := BG_Palette_16x16 (0)'Access;

  Color_BG : aliased Color with Volatile;

  procedure Adjust_Color (Y : Positive) is
    Index : Color_Index_16 := Color_Index_16 ((Y - 1) mod 128 / 32);
  begin
    Color_BG := Color_Palette (Index + 1);
  end;

  Y_Offset : Natural := 0;

  function Return_Unsized return String is
    ("Very Long String Argument") with No_Inline;

  S : String := Return_Unsized;

  Origin : BG_Reference_Point := (X => 0.0, Y => 0.0);
  Origin_X_Velocity : Fixed_20_8 := 3.0;

begin

  Color_Palette (0 .. 4) :=
    ( ( 0,  0,  0)
    , (19, 23, 19)
    , (31, 25, 21)
    , (31, 16, 15)
    , (29,  9, 11)
    );

  GBA.Interrupts.Enable_Receiving_Interrupts;
  GBA.Interrupts.Enable_Interrupt (GBA.Interrupts.VBlank);

  Request_VBlank_Interrupt;
  Wait_For_VBlank;

  Set_Display_Mode (Mode_3);
  Enable_Display_Element (Background_2);

  loop
    Update_Key_State;

    for Y in VRAM'Range (1) loop
      for X in 1 .. 4 loop
        Adjust_Color (Y + Y_Offset * X);
        Cpu_Set
          ( Source     => Color_BG'Address
          , Dest       => VRAM (Y, 1 + (X-1) * 60)'Address
          , Unit_Count => 60
          , Unit_Size  => Half_Word
          , Mode       => Fill);
      end loop;
    end loop;

    if Are_Any_Down (A_Button or B_Button) then
      Y_Offset := @ + 5;
    else
      Y_Offset := @ + 1;
    end if;

    Origin.X := @ + Origin_X_Velocity;
    if Origin.X > 0.0 then
      Origin_X_Velocity := @ - 0.25;
    else
      Origin_X_Velocity := @ + 0.25;
    end if;

    Wait_For_VBlank;

    Set_Reference_Point(BG_2, Origin);

  end loop;

end;
