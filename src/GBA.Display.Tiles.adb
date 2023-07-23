-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


with System;
use type System.Address;

package body GBA.Display.Tiles is

  function Tile_Block_Address (Ix : Tile_Block_Index) return Address is
  begin
    return Video_RAM_Address'First + (Address (Ix) * 16#4000#);
  end;

  function Screen_Block_Address (Ix : Screen_Block_Index) return Address is
  begin
    return Video_RAM_Address'First + (Address (Ix) * 16#800#);
  end;

end GBA.Display.Tiles;