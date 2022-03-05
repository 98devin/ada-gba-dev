-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.Allocation;
with GBA.BIOS;
with GBA.BIOS.Arm;
with GBA.BIOS.Memset;
with GBA.Display;
with GBA.Display.Tiles;
with GBA.Display.Backgrounds;
with GBA.Display.Backgrounds.Refs;
with GBA.Display.Objects;
with GBA.Display.Palettes;
with GBA.Display.Windows;
with GBA.Memory;
with GBA.Memory.Default_Heaps;
with GBA.Numerics;
with GBA.Numerics.Vectors;
with GBA.Numerics.Matrices;
with GBA.Interrupts;
with GBA.Input;
with GBA.Input.Buffered;
with GBA.Refs;

with Interfaces;
with System.Unsigned_Types;

procedure Hello is

  use GBA.Allocation;
  use GBA.BIOS;
  use GBA.BIOS.Arm;
  use GBA.Display;
  use GBA.Display.Palettes;
  use GBA.Display.Backgrounds;
  use GBA.Memory.Default_Heaps;
  use GBA.Numerics;
  use GBA.Input;
  use GBA.Input.Buffered;
  use Interfaces;
  use System.Unsigned_Types;

  use all type GBA.Refs.BG_Ref;

  VRAM : array (1 .. 160, 1 .. 240) of Color
    with Import, Volatile, Address => 16#6000000#;

  Color_Palette : Palette_16_Ptr := BG_Palette_16x16 (0)'Access;

  Color_BG : aliased Color with Volatile;

  procedure Adjust_Color (Y : Positive) is
    Index : Color_Index_16 := Color_Index_16 ((Y - 1) mod 160 / 32);
  begin
    Color_BG := Color_Palette (Index + 1);
  end;

  Y_Offset : Natural := 0;

  Origin : BG_Reference_Point := (X => 0.0, Y => 0.0);

  Theta : Radians_16 := 0.0;
  Delta_X, Delta_Y : Fixed_Snorm_16;

begin

  Color_Palette (0 .. 5) :=
    ( ( 0,  0,  0)
    , (19, 26, 21)
    , (31, 25, 21)
    , (31, 16, 15)
    , (29,  9, 11)
    , (00, 26, 26)
    );

  -- GBA.Interrupts.Enable_Receiving_Interrupts;
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
        -- VRAM (Y, 1 + (X - 1) * 60 .. 1 + X * 60) := (others => Color_BG);
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

    Sin_Cos_LUT (Theta, Delta_X, Delta_Y);
    Origin.X := 32.0 * Fixed_20_8 (Delta_X);
    Origin.Y := 32.0 * Fixed_20_8 (Delta_Y);
    Theta := @ + (1.0 / 128.0);

    Wait_For_VBlank;

    Set_Reference_Point (BG_2, Origin);

  end loop;

end;
