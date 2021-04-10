
with Freeze;

with GBA.Memory;
use  GBA.Memory;

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

  type Palette_Index_16 is range 0 .. 15
    with Size => 4;


  type Palette_16 is array (Color_Index_16) of Color;

  Palette_RAM : constant Address := Palette_RAM_Address'First;

  Palette_256 : array (Color_Index_256) of Color
    with Import, Volatile_Components, Address => Palette_RAM;

  Palette_16x16 : array (Palette_Index_16, Color_Index_16) of Color
    with Import, Volatile_Components, Address => Palette_RAM;


  function Indexed_Color (Ix : Color_Index_256) return Color;
  function Indexed_Color (Pal : Palette_Index_16; Ix : Color_Index_16) return Color;


  type Color_Ref (Data : access Color) is limited private
    with Implicit_Dereference => Data;


  type Palette_16_Ref is tagged private
    with Variable_Indexing => Index_16;

  function Index_16 (Pal : Palette_16_Ref; Ix : Color_Index_16) return Color_Ref;

  type Palette_16_Ref_Ptr is access all Palette_16_Ref
    with Storage_Size => 0;


  type Palette_256_Ref is tagged private
    with Variable_Indexing => Index_256;

  function Index_256 (Pal : Palette_256_Ref;     Ix : Color_Index_256) return Color_Ref;
  function Index_256 (Pal : Palette_256_Ref; Subpal : Palette_Index_16; Ix : Color_Index_16) return Color_Ref;

  function Subpalette (Pal : Palette_256_Ref; Subpal : Palette_Index_16) return Palette_16_Ref_Ptr;

private

  type Color_Ref (Data : access Color) is null record;
    
  type Palette_16_Ref is tagged
    record
      Ptr : Address;
    end record;

  type Palette_256_Ref is tagged 
    record
      Ptr : Address;
    end record;

end GBA.Display.Palettes;