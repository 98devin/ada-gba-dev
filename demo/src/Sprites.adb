-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.BIOS;
with GBA.BIOS.Arm;
with GBA.BIOS.Thumb;
with GBA.Display;
with GBA.Display.Backgrounds;
with GBA.Display.Objects;
with GBA.Display.Palettes;
with GBA.Display.Tiles;
with GBA.Memory;
with GBA.Numerics;
with GBA.Input;
with GBA.Input.Buffered;
with GBA.Interrupts;
with Interfaces;

procedure Sprites is

  use GBA.BIOS;
  use GBA.BIOS.Arm;
  use GBA.Display;
  use GBA.Display.Backgrounds;
  use GBA.Display.Objects;
  use GBA.Display.Palettes;
  use GBA.Display.Tiles;
  use GBA.Input;
  use GBA.Input.Buffered;
  use GBA.Numerics;
  use Interfaces;


  Tile_Red : constant Tile_Data_4 :=
    ( ( 0, 0, 1, 1, 1, 1, 0, 0 )
    , ( 0, 1, 1, 1, 1, 1, 1, 0 )
    , ( 1, 1, 1, 1, 1, 1, 1, 1 )
    , ( 1, 1, 1, 1, 1, 1, 1, 1 )
    , ( 1, 1, 1, 1, 1, 1, 1, 1 )
    , ( 1, 1, 1, 1, 1, 1, 1, 1 )
    , ( 0, 1, 1, 1, 1, 1, 1, 0 )
    , ( 0, 0, 1, 1, 1, 1, 0, 0 ) );

  Tile_Blue : constant Tile_Data_4 :=
    ( ( 0, 0, 2, 2, 2, 2, 0, 0 )
    , ( 0, 2, 2, 2, 2, 2, 2, 0 )
    , ( 2, 2, 2, 2, 2, 2, 2, 2 )
    , ( 2, 2, 2, 2, 2, 2, 2, 2 )
    , ( 2, 2, 2, 2, 2, 2, 2, 2 )
    , ( 2, 2, 2, 2, 2, 2, 2, 2 )
    , ( 0, 2, 2, 2, 2, 2, 2, 0 )
    , ( 0, 0, 2, 2, 2, 2, 0, 0 ) );

  Tile_Green : constant Tile_Data_4 :=
    ( ( 0, 0, 3, 3, 3, 3, 0, 0 )
    , ( 0, 3, 3, 3, 3, 3, 3, 0 )
    , ( 3, 3, 3, 3, 3, 3, 3, 3 )
    , ( 3, 3, 3, 3, 3, 3, 3, 3 )
    , ( 3, 3, 3, 3, 3, 3, 3, 3 )
    , ( 3, 3, 3, 3, 3, 3, 3, 3 )
    , ( 0, 3, 3, 3, 3, 3, 3, 0 )
    , ( 0, 0, 3, 3, 3, 3, 0, 0 ) );

  Tile_Red_ID   : constant OBJ_Tile_Index := 1;
  Tile_Blue_ID  : constant OBJ_Tile_Index := 2;
  Tile_Green_ID : constant OBJ_Tile_Index := 3;

  function Initial_Attributes_State (Tile : OBJ_Tile_Index) return OBJ_Attributes
    with Inline_Always;

  function Initial_Attributes_State (Tile : OBJ_Tile_Index)
    return OBJ_Attributes is
  begin
    return
      ( Kind          => Regular
      , Mode          => Normal
      , Tile_Index    => Tile
      , Palette_Index => 0
      , Color_Mode    => Colors_16
      , Disabled      => False
      , Priority      => 0
      , Shape         => Square
      , Scale         => 0
      , X             => 120
      , Y             => 80
      , Enable_Mosaic   => False
      , Flip_Horizontal => False
      , Flip_Vertical   => False
      );
  end Initial_Attributes_State;


  procedure BIOS_Sin_Cos (Theta : Radians_32; Sin, Cos : out Fixed_8_8)
    with No_Inline;

  pragma Machine_Attribute (BIOS_Sin_Cos, "target", "thumb");

  procedure BIOS_Sin_Cos (Theta : Radians_32; Sin, Cos : out Fixed_8_8) is
    Affine_Sin_Cos : Affine_Transform_Matrix;
  begin
    GBA.BIOS.Thumb.Affine_Set
      ( Transform  => Affine_Sin_Cos
      , Parameters =>
        ( Scale_X | Scale_Y => 1.0
        , Angle => Radians_16 (Theta)
        )
      );
    Sin := Affine_Sin_Cos.DY;
    Cos := Affine_Sin_Cos.DX;
  end;

  X_Center : constant OBJ_X_Coordinate := 116;
  Y_Center : constant OBJ_Y_Coordinate :=  76;

  procedure Set_Position (ID : OBJ_ID; X : OBJ_X_Coordinate; Y : OBJ_Y_Coordinate)
    with Inline_Always is
    Attrs : OBJ_Attributes renames Object_Attribute_Memory (ID).Attributes;
  begin
    Attrs := (Attrs with delta
      X => X_Center + X,
      Y => Y_Center + Y
    );
  end;


  Color_Palette : Palette_16_Ptr := OBJ_Palette_16x16 (0)'Access;

  Theta   : Radians_32 := 0.0;
  X_Scale : constant Fixed_20_8 := 70.0;
  Y_Scale : constant Fixed_20_8 := 70.0;

begin

  OBJ_Tile_Memory_4 (Tile_Red_ID)   := Tile_Red;
  OBJ_Tile_Memory_4 (Tile_Blue_ID)  := Tile_Blue;
  OBJ_Tile_Memory_4 (Tile_Green_ID) := Tile_Green;

  Color_Palette (0 .. 5) :=
    ( ( 0,  0,  0)
    , (29,  9, 11)
    , (00, 26, 26)
    , (19, 26, 21)
    , (31, 25, 21)
    , (31, 16, 15)
    );

  Object_Attribute_Memory (0).Attributes := Initial_Attributes_State (Tile_Red_ID);
  Object_Attribute_Memory (1).Attributes := Initial_Attributes_State (Tile_Blue_ID);
  Object_Attribute_Memory (2).Attributes := Initial_Attributes_State (Tile_Green_ID);

  GBA.Interrupts.Enable_Receiving_Interrupts;
  GBA.Interrupts.Enable_Interrupt (GBA.Interrupts.VBlank);

  Request_VBlank_Interrupt;
  Wait_For_VBlank;

  Set_Display_Mode (Mode_0);
  Enable_Display_Element (Object_Sprites);

  loop
    Update_Key_State;

    declare
      Sin, Cos : Fixed_Snorm_32;
    begin
      Sin_Cos (Theta, Sin, Cos);
      Set_Position
        ( 0
        , OBJ_X_Coordinate (Integer (Fixed_20_8 (Sin) * X_Scale) / (2 ** 8))
        , OBJ_Y_Coordinate (Integer (Fixed_20_8 (Cos) * Y_Scale) / (2 ** 8))
        );
    end;

    declare
      Sin, Cos : Fixed_Snorm_16;
      One_Third : constant Radians_32 := 1.0 / 3.0;
    begin
      Sin_Cos_LUT (Radians_16 (Theta + One_Third), Sin, Cos);
      Set_Position
        ( 1
        , OBJ_X_Coordinate (Integer (Fixed_20_8 (Sin) * X_Scale) / (2 ** 8))
        , OBJ_Y_Coordinate (Integer (Fixed_20_8 (Cos) * Y_Scale) / (2 ** 8))
        );
    end;

    declare
      Sin, Cos : Fixed_8_8;
      Two_Thirds : constant Radians_32 := 2.0 / 3.0;
    begin
      BIOS_Sin_Cos (Theta + Two_Thirds, Sin, Cos);
      Set_Position
        ( 2
        , OBJ_X_Coordinate (Integer (Fixed_20_8 (Sin) * X_Scale) / (2 ** 8))
        , OBJ_Y_Coordinate (Integer (Fixed_20_8 (Cos) * Y_Scale) / (2 ** 8))
        );
    end;

    if Are_Any_Down (A_Button or B_Button) then
      Theta := @ + (1.0 / 128.0);
    else
      Theta := @ + (1.0 / 512.0);
    end if;

    Wait_For_VBlank;

  end loop;

end;
