-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.Memory;
use  GBA.Memory;

use type GBA.Memory.Address;

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

  Transparent_Color_Index : constant := 0;


  type Palette_Index_16 is range 0 .. 15
    with Size => 4;


  type Color_Ref is access all Color
    with Storage_Size => 0;


  type Palette_16 is array (Color_Index_16) of Color
    with Volatile_Components;

  type Palette_16_Ptr is access all Palette_16
    with Storage_Size => 0;


  type Palette_256 is array (Color_Index_256) of Color
    with Volatile_Components;

  type Palette_256_Ptr is access all Palette_256
    with Storage_Size => 0;


  type Palette_16x16 is
    array (Palette_Index_16) of aliased Palette_16;

  type Palette_16x16_Ptr is access all Palette_16x16
    with Storage_Size => 0;



  BG_Palette_RAM  : constant Address := 16#05000000#;
  OBJ_Palette_RAM : constant Address := 16#05000200#;

  BG_Palette_256 : aliased Palette_256
    with Import, Address => BG_Palette_RAM;

  BG_Palette_16x16 : Palette_16x16
    with Import, Address => BG_Palette_RAM;

  OBJ_Palette_256 : aliased Palette_256
    with Import, Address => OBJ_Palette_RAM;

  OBJ_Palette_16x16 : Palette_16x16
    with Import, Address => OBJ_Palette_RAM;

end GBA.Display.Palettes;