-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.Memory;
use  GBA.Memory;

with GBA.Numerics;
use  GBA.Numerics;

with GBA.Display.Tiles;
use  GBA.Display.Tiles;

with GBA.Display.Palettes;
use  GBA.Display.Palettes;

with Interfaces;
use  Interfaces;


package GBA.Display.Backgrounds is

  type Boundary_Behavior is
    ( Cutoff
    , Wrap
    ) with Size => 2;

  for Boundary_Behavior use
    ( Cutoff => 0
    , Wrap   => 1
    );


  type BG_ID is
    ( BG_0
    , BG_1
    , BG_2
    , BG_3
    );

  type BG_Kind is
    ( Regular
    , Affine
    );


  type BG_Size is range 0 ..3
    with Size => 2;


  type BG_Scroll_Offset is new Integer_16;


  type BG_Control_Info is
    record
      Priority      : Display_Priority;
      Tile_Block    : Tile_Block_Index;
      Enable_Mosaic : Boolean;
      Color_Mode    : Palette_Mode;
      Screen_Block  : Screen_Block_Index;
      Boundary_Mode : Boundary_Behavior;
      Size          : BG_Size;
    end record
      with Size => 16;

  for BG_Control_Info use
    record
      Priority      at 0 range 0 .. 1;
      Tile_Block    at 0 range 2 .. 3;
      Enable_Mosaic at 0 range 6 .. 6;
      Color_Mode    at 0 range 7 .. 7;
      Screen_Block  at 1 range 0 .. 4;
      Boundary_Mode at 1 range 5 .. 5;
      Size          at 1 range 6 .. 7;
    end record;


  BG_Control : array (BG_ID) of BG_Control_Info
    with Import, Volatile_Components, Address => BG0CNT;


  type BG_Offset_Info is
    record
      X, Y : BG_Scroll_Offset;
    end record
      with Size => 32;

  for BG_Offset_Info use
    record
      X at 0 range 0 .. 15;
      Y at 2 range 0 .. 15;
    end record;


  procedure Set_X_Offset (BG : BG_ID; Value : BG_Scroll_Offset)
    with Inline;

  procedure Set_Y_Offset (BG : BG_ID; Value : BG_Scroll_Offset)
    with Inline;

  procedure Set_Offset (BG : BG_ID; X, Y : BG_Scroll_Offset)
    with Inline;

  procedure Set_Offset (BG : BG_ID; Offsets : BG_Offset_Info)
    with Inline;


  subtype BG_Reference_Point_Coordinate is
    GBA.Numerics.Fixed_20_8;


  type BG_Reference_Point is
    record
      X, Y : BG_Reference_Point_Coordinate;
    end record
      with Size => 64;

  for BG_Reference_Point use
    record
      X at 0 range 0 .. 31;
      Y at 4 range 0 .. 31;
    end record;


  type BG_Transform_Info is
    record
      Affine_Matrix   : Affine_Transform_Matrix;
      Reference_Point : BG_Reference_Point;
    end record
      with Size => 128;

  for BG_Transform_Info use
    record
      Affine_Matrix   at 0 range 0 .. 63;
      Reference_Point at 8 range 0 .. 63;
    end record;

  type BG_Transform_Info_Array is
    array (Natural range <>) of BG_Transform_Info;


  subtype Affine_BG_ID is BG_ID range BG_2 .. BG_3;

  function Affine_Transform_Address (ID : Affine_BG_ID) return Address
    with Pure_Function, Inline_Always;

  procedure Set_X_Reference (BG : Affine_BG_ID; Value : BG_Reference_Point_Coordinate)
    with Inline;

  procedure Set_Y_Reference (BG : Affine_BG_ID; Value : BG_Reference_Point_Coordinate)
    with Inline;

  procedure Set_Reference_Point (BG : Affine_BG_ID; X, Y : BG_Reference_Point_Coordinate)
    with Inline;

  procedure Set_Reference_Point (BG : Affine_BG_ID; Reference_Point : BG_Reference_Point)
    with Inline;

  procedure Set_Affine_Matrix (BG : Affine_BG_ID; Matrix : Affine_Transform_Matrix)
    with Inline;

  procedure Set_Transform (BG : Affine_BG_ID; Transform : BG_Transform_Info)
    with Inline;

private

  -- This is private because it is a write-only set of registers.
  -- Using the setter procedures above is therefore a more faithful interface.

  BG_Offsets : array (BG_ID) of BG_Offset_Info
    with Import, Volatile_Components, Address => BG0HOFS;

  BG_Transforms : array (BG_2 .. BG_3) of BG_Transform_Info
    with Import, Volatile_Components, Address => BG2PA;

end GBA.Display.Backgrounds;