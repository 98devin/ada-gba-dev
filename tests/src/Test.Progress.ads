
--  Copyright (c) 2022 Devin Hill
--  zlib License -- see LICENSE for details.

with GBA.Display.Tiles;
with GBA.Display.Palettes;
with GBA.Memory;

use  GBA.Display.Tiles;
use  GBA.Display.Palettes;
use  GBA.Memory;

with Test.Status;
use  Test.Status;

private
package Test.Progress is

  type Progress_Type is
    delta 2.0 ** (-3) range 0.0 .. 30.0;

  type Progress_Remainder is
    mod 2 ** 3;

  function Remainder (Value : Progress_Type)
    return Progress_Remainder
    with Inline;

  type Tile_Set is
    array (Status_Type, Progress_Remainder) of Tile_Data_4;

  function Init_Remainder_Tile
    ( Value  : Progress_Remainder;
      Fill   : Color_Index_16;
      Back   : Color_Index_16 := 0
    )
    return Tile_Data_4
    with No_Inline;

  First_Progress_Index : array (Status_Type) of BG_Tile_Index;

  procedure Fill_Progress_Bar
    ( Status     : Status_Type;
      Progress   : Progress_Type;
      Tiles_Addr : Address
    )
    with No_Inline, Linker_Section => ".iwram.fill_progress_bar";

  pragma Machine_Attribute (Fill_Progress_Bar, "target", "arm");

end Test.Progress;