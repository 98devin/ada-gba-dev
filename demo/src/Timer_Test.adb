-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.

with GBA.BIOS;
with GBA.BIOS.Arm;
with GBA.Display;
with GBA.Display.Backgrounds;
with GBA.Display.Palettes;
with GBA.Display.Tiles;
with GBA.Interrupts;
with GBA.Memory;
with GBA.Timers;

with Interfaces;
use  Interfaces;

procedure Timer_Test is

  use GBA.BIOS;
  use GBA.BIOS.Arm;
  use GBA.Display;
  use GBA.Display.Backgrounds;
  use GBA.Display.Palettes;
  use GBA.Display.Tiles;
  use GBA.Interrupts;
  use GBA.Memory;
  use GBA.Timers;

  procedure Wait_For_Interrupt_C (New_Only : Integer_32; Flags : Interrupt_Flags)
    with Inline_Always, Import, External_Name => "bios_arm__wait_for_interrupt";

  Color_Palette : Palette_16 renames BG_Palette_16x16 (0);

  Tile_Block : Tile_Block_4 (BG_Tile_Index)
    with Address => Tile_Block_Address (0);

  Screen_Block : Screen_Block_16
    with Address => Screen_Block_Address (4);


  Tile_Black : constant Tile_Data_4 :=
    (others => (others => 0));

  Tile_White : constant Tile_Data_4 :=
    (others => (others => 1));

  Tile_Black_ID : constant BG_Tile_Index := 0;
  Tile_White_ID : constant BG_Tile_Index := 1;

  Base_Timer : constant Timer_ID := 0;
  Link_Timer : constant Timer_ID := 1;


begin
  Color_Palette (0) := Color'( 0,  0,  0);
  Color_Palette (1) := Color'(31, 31, 31);

  for Block of Screen_Block loop
    Block :=
      ( Tile            => 0
      , Flip_Horizontal => False
      , Flip_Vertical   => False
      , Palette_Index   => 0
      );
  end loop;

  Tile_Block (0) := Tile_Black;
  Tile_Block (1) := Tile_White;

  BG_Control (BG_0) :=
    ( Tile_Block   => 0
    , Screen_Block => 4
    , Color_Mode   => Colors_16
    , others       => <>
    );

  Timers (Base_Timer) :=
    ( Value        => Timer_Value'Mod(-4389)
    , Control_Info =>
      ( Scale       => x256
      , Increment   => Independent
      , Trigger_IRQ => False
      , Enabled     => True
      )
    );

  Timers (Link_Timer) :=
    ( Value        => 0
    , Control_Info =>
      ( Scale       => <> -- ignored due to increment method
      , Increment   => Linked_To_Previous
      , Trigger_IRQ => False
      , Enabled     => True
      )
    );

  GBA.Interrupts.Enable_Interrupt (GBA.Interrupts.VBlank);
  Request_VBlank_Interrupt;

  Set_Display_Mode (Mode_0);
  Enable_Display_Element (Background_0);

  loop
    declare
      Time : Timer_Value := Get_Count (Link_Timer);
    begin
      for I in 0 .. 15 loop
        if (Shift_Right (Time, I) and 1) = 1 then
          Screen_Block (1, I + 1).Tile := Tile_White_ID;
        else
          Screen_Block (1, I + 1).Tile := Tile_Black_ID;
        end if;
      end loop;
    end;

    -- Wait_For_VBlank;
    Wait_For_Interrupt_C (0, 1);
  end loop;

end Timer_Test;