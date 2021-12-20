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


package GBA.Display.Objects is

  type OBJ_ID is range 0 .. 127;

  type OBJ_Y_Coordinate is mod 2**8;

  type OBJ_X_Coordinate is mod 2**9;


  type OBJ_Kind is
    ( Regular
    , Affine
    )
    with Size => 1;

  for OBJ_Kind use
    ( Regular => 0
    , Affine  => 1
    );


  type OBJ_Mode is
    ( Normal
    , Transparent
    , Window
    )
    with Size => 2;

  for OBJ_Mode use
    ( Normal      => 0
    , Transparent => 1
    , Window      => 2
    );


  type OBJ_Shape is
    ( Square
    , Wide
    , Tall
    )
     with Size => 2;

  for OBJ_Shape use
    ( Square => 0
    , Wide   => 1
    , Tall   => 2
    );


  type OBJ_Scale is range 0 .. 3
    with Size => 2;


  type OBJ_Size is
    ( Size_8x8
    , Size_16x16
    , Size_32x32
    , Size_64x64
    , Size_16x8
    , Size_32x8
    , Size_32x16
    , Size_64x32
    , Size_8x16
    , Size_8x32
    , Size_16x32
    , Size_32x64
    ) with Size => 4;

  for OBJ_Size use
    ( Size_8x8   => 2#0000#
    , Size_16x16 => 2#0001#
    , Size_32x32 => 2#0010#
    , Size_64x64 => 2#0011#
    , Size_16x8  => 2#0100#
    , Size_32x8  => 2#0101#
    , Size_32x16 => 2#0110#
    , Size_64x32 => 2#0111#
    , Size_8x16  => 2#1000#
    , Size_8x32  => 2#1001#
    , Size_16x32 => 2#1010#
    , Size_32x64 => 2#1011#
    );


  function As_Size (Shape : OBJ_Shape; Scale : OBJ_Scale) return OBJ_Size
    with Inline_Always;

  procedure As_Shape_And_Scale (Size : OBJ_Size; Shape : out OBJ_Shape; Scale : out OBJ_Scale)
    with Inline_Always;


  type OBJ_Affine_Transform_Index is range 0 .. 31
    with Size => 5;

  function Affine_Transform_Address (Ix : OBJ_Affine_Transform_Index) return Address
    with Pure_Function, Inline_Always;


  type OBJ_Attributes (Kind : OBJ_Kind := Regular) is
    record
      Y             : OBJ_Y_Coordinate;
      X             : OBJ_X_Coordinate;
      Mode          : OBJ_Mode;
      Enable_Mosaic : Boolean;
      Color_Mode    : Palette_Mode;
      Shape         : OBJ_Shape;
      Scale         : OBJ_Scale;
      Tile_Index    : OBJ_Tile_Index;
      Priority      : Display_Priority;
      Palette_Index : Palette_Index_16; -- Unused if Color_Mode is 256
      case Kind is
      when Regular =>
        Disabled        : Boolean;
        Flip_Horizontal : Boolean;
        Flip_Vertical   : Boolean;
      when Affine =>
        Double_Size     : Boolean;
        Transform_Index : OBJ_Affine_Transform_Index;
      end case;
    end record
      with Size => 48;

  for OBJ_Attributes use
    record
      Y               at 0 range 0  .. 7;
      Kind            at 0 range 8  .. 8;
      Disabled        at 0 range 9  .. 9;
      Double_Size     at 0 range 9  .. 9;
      Mode            at 0 range 10 .. 11;
      Enable_Mosaic   at 0 range 12 .. 12;
      Color_Mode      at 0 range 13 .. 13;
      Shape           at 0 range 14 .. 15;
      X               at 2 range 0  .. 8;
      Transform_Index at 2 range 9  .. 13;
      Flip_Horizontal at 2 range 12 .. 12;
      Flip_Vertical   at 2 range 13 .. 13;
      Scale           at 2 range 14 .. 15;
      Tile_Index      at 4 range 0  .. 9;
      Priority        at 4 range 10 .. 11;
      Palette_Index   at 4 range 12 .. 15;
    end record;


  type Volatile_OBJ_Attributes is new OBJ_Attributes
    with Volatile;

  type OAM_Attributes_Ptr is access all Volatile_OBJ_Attributes
    with Storage_Size => 0;


  function Attributes_Of_Object (ID : OBJ_ID) return OAM_Attributes_Ptr
    with Pure_Function, Inline_Always;

  function Attributes_Of_Object (ID : OBJ_ID) return OBJ_Attributes
    with Inline_Always;

  procedure Set_Object_Attributes (ID : OBJ_ID; Attributes : OBJ_Attributes)
    with Inline;


  type OAM_Entry is limited
    record
      Attributes          : aliased Volatile_OBJ_Attributes;
      Transform_Parameter : aliased Affine_Transform_Parameter with Volatile;
    end record
      with Size => 64;

  for OAM_Entry use
    record
      Attributes          at 0 range 0 .. 47;
      Transform_Parameter at 6 range 0 .. 15;
    end record;

  Object_Attribute_Memory : array (0 .. 127) of OAM_Entry
    with Import, Address => OAM_Address'First;


end GBA.Display.Objects;