
--  Copyright (c) 2022 Devin Hill
--  zlib License -- see LICENSE for details.

with GBA.Display.Backgrounds;
with GBA.Display.Palettes;
with GBA.Display.Tiles;

with Test.Font;
with Test.Progress;

package body Test is

  procedure Initialize_Framework is

    use GBA.BIOS.Thumb;
    use GBA.Display;
    use GBA.Display.Backgrounds;
    use GBA.Display.Palettes;
    use GBA.Display.Tiles;
    use GBA.Interrupts;
    use GBA.Memory;
    use GBA.Memory.IO_Registers;

    use System.Unsigned_Types;

    use Interfaces;

    Tile_Block   : constant Tile_Block_Index   := 1;
    Screen_Block : constant Screen_Block_Index := 0;

    procedure Set_Display_Modes is
    begin
      Enable_Interrupt (VBlank);
      Request_VBlank_Interrupt;

      Set_Display_Mode (Mode_0);
      Enable_Display_Element (Background_0);

      BG_Control (BG_0) :=
        ( Tile_Block    => Tile_Block
        , Screen_Block  => Screen_Block
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
      VRAM_Dest : constant Address  := Tile_Block_Address (Tile_Block);

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
        , Dest   => VRAM_Dest
        , Config => Unpack_Config
        );


      declare
        Tiles : Tile_Block_4 (0 .. 256)
          with Import, Address => VRAM_Dest;
      begin
        Tiles (128) := Test.Progress.Init_Remainder_Tile (Value => 0, Fill => 1, Back => 0);
        Tiles (129) := Test.Progress.Init_Remainder_Tile (Value => 1, Fill => 1, Back => 0);
        Tiles (130) := Test.Progress.Init_Remainder_Tile (Value => 2, Fill => 1, Back => 0);
        Tiles (131) := Test.Progress.Init_Remainder_Tile (Value => 3, Fill => 1, Back => 0);
        Tiles (132) := Test.Progress.Init_Remainder_Tile (Value => 4, Fill => 1, Back => 0);
        Tiles (133) := Test.Progress.Init_Remainder_Tile (Value => 5, Fill => 1, Back => 0);
        Tiles (134) := Test.Progress.Init_Remainder_Tile (Value => 6, Fill => 1, Back => 0);
        Tiles (135) := Test.Progress.Init_Remainder_Tile (Value => 7, Fill => 1, Back => 0);
      end;

    end Load_Font_Data;


    procedure Load_Test_Pattern is

      Palette : Palette_16 renames BG_Palette_16x16 (0);

      Screen  : Screen_Block_16
        with Import, Address => Screen_Block_Address (Screen_Block);

    begin

      Palette (0) := Color'( 0,  0,  0);
      Palette (1) := Color'(31, 31, 31);

      for I in Screen'Range(1) loop
        for J in Screen'Range(2) loop
          Screen (I, J) :=
            ( Tile            => Character'Pos('!')
            , Palette_Index   => 0
            , others          => <>
            );
        end loop;
      end loop;

    end Load_Test_Pattern;

  begin

    Set_Display_Modes;
    Load_Font_Data;
    Load_Test_Pattern;

  end Initialize_Framework;

end Test;