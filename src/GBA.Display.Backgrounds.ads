
with GBA.Memory.IO_Registers;
use  GBA.Memory.IO_Registers;

with GBA.Display.Palettes;
use  GBA.Display.Palettes;


package GBA.Display.Backgrounds is

  type Tile_Block_Index is mod 4
    with Size => 2;

  type Data_Block_Index is mod 32
    with Size => 5;


  type Boundary_Behavior is
    ( Cutoff
    , Wrap
    )
    with Size => 2;

  for Boundary_Behavior use
    ( Cutoff => 0
    , Wrap   => 1
    );


  type Background_Kind is
    ( Regular
    , Rotation_Scaling
    );


  -- Interpretation of this size depends
  -- on the display mode of the background.
  -- It should not be set directly, only with
  -- more usefully named library routines.
  type Background_Size is range 0 .. 3;


  type Background_Scroll_Offset is mod 512;


  type Background_Reference_Point_Type is 
    delta 2.0**(-8) range -2.0**19 .. 2.0**19
    with Size => 32;


  type Background_Rot_Scale_Parameter_Type is
    delta 2.0**(-8) range -2.0**7 .. 2.0**7
    with Size => 16;


  type Zero_Padding is range 0 .. 0
    with Default_Value => 0;


  type Background_Control_Info is
    record
      Priority      : Display_Priority;
      Tile_Block    : Tile_Block_Index;
      Padding       : Zero_Padding;
      Enable_Mosaic : Boolean;
      Color_Mode    : Palette_Mode;
      Data_Block    : Data_Block_Index;
      Boundary_Mode : Boundary_Behavior;
      Size          : Background_Size;
    end record
      with Size => 16;

  for Background_Control_Info use
    record
      Priority      at 0 range 0 .. 1;
      Tile_Block    at 0 range 2 .. 3;
      Padding       at 0 range 4 .. 5;
      Enable_Mosaic at 0 range 6 .. 6;
      Color_Mode    at 0 range 7 .. 7;
      Data_Block    at 1 range 0 .. 4;
      Boundary_Mode at 1 range 5 .. 5;
      Size          at 1 range 6 .. 7;
    end record;

end GBA.Display.Backgrounds;