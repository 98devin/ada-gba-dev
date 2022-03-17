
--  Copyright (c) 2022 Devin Hill
--  zlib License -- see LICENSE for details.

package body Test.Progress is

  function Remainder (Value : Progress_Type) return Progress_Remainder
    is ( Progress_Remainder'Mod (Integer'Integer_Value (Value)) );

  function Init_Remainder_Tile
    (Value  : Progress_Remainder;
     Fill   : Color_Index_16;
     Back   : Color_Index_16 := 0) return Tile_Data_4 is

    type Tile_Data_Row is array (Progress_Remainder) of Color_Index_16
      with Pack, Size => 32;

    Row : Tile_Data_Row := (others => Back);

  begin
    for X in Row'Range loop
      if X <= Value then
        Row (X) := Fill;
      end if;
    end loop;

    declare
      Tile : Tile_Data_4;
      Rows : array (1 .. 8) of Tile_Data_Row := (others => Row)
        with Address => Tile'Address;
    begin
      return Tile;
    end;
  end Init_Remainder_Tile;

end Test.Progress;