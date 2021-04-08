
package GBA.Display.Palettes is

  type Palette_Mode is
    ( Colors_16   --  16 palettes of 15 colors + transparent (4-bit indexed color)
    , Colors_256  -- one palette of 255 colors + transparent (8-bit indexed color)
    );

  for Palette_Mode use
    ( Colors_16  => 0
    , Colors_256 => 1
    ); 


  type Unsigned_5 is mod 2**5;

  type Color is 
    record
      R, G, B : Unsigned_5;
    end record
    with Size => 16;

  for Color use
    record
      R at 0 range 0  .. 4;
      G at 0 range 5  .. 9;
      B at 0 range 10 .. 14;
    end record;


  type Color_Index_16 is range 0 .. 15
    with Size => 4;

  type Color_Index_256 is range 0 .. 255
    with Size => 8;


end GBA.Display.Palettes;