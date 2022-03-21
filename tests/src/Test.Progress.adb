
--  Copyright (c) 2022 Devin Hill
--  zlib License -- see LICENSE for details.

package body Test.Progress is

  function Remainder (Value : Progress_Type) return Progress_Remainder
    is ( Progress_Remainder'Mod (Integer'Integer_Value (Value)) );

  function Init_Remainder_Tile
    ( Value  : Progress_Remainder;
      Fill   : Color_Index_16;
      Back   : Color_Index_16 := 0
    ) return Tile_Data_4 is

    type Tile_Data_Row is array (Progress_Remainder) of Color_Index_16
      with Pack, Size => 32;

    Row : Tile_Data_Row := (others => Back);

  begin
    for X in Row'Range loop
      if X < Value then
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


  procedure Fill_Progress_Bar
    ( Status     : Status_Type;
      Progress   : Progress_Type;
      Tiles_Addr : Address
    ) is

    Tiles : array (1 .. 30) of Screen_Entry_16
      with Import, Address => Tiles_Addr;

    Pr : Progress_Type      := Progress;
    Rm : Progress_Remainder := Remainder (Progress);
    Ix : Integer            := 1;

    Tile_0 : BG_Tile_Index  := First_Progress_Index (Status);
    Tile_M : BG_Tile_Index  := 0;
    Tile_F : BG_Tile_Index  := 0;

  begin
    if Rm /= 0 then
      Tile_M := Tile_0 + BG_Tile_Index (Rm);
    end if;

    while Pr >= 1.0 loop
      Tiles (Ix) := (Tile => Tile_0, Palette_Index => 0, others => <>);
      Ix := Ix + 1;
      Pr := Pr - 1.0;
    end loop;

    Tiles (Ix) := (Tile => Tile_M, Palette_Index => 0, others => <>);
    Ix := Ix + 1;

    while Ix <= Tiles'Last loop
      Tiles (Ix) := (Tile => Tile_F, Palette_Index => 0, others => <>);
      Ix := Ix + 1;
    end loop;
  end Fill_Progress_Bar;

end Test.Progress;