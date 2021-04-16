
with GBA.Memory;
use  GBA.Memory;

with GBA.Display.Palettes;
use  GBA.Display.Palettes;


package GBA.Display.Tiles is

  type Tile_Data_4 is array (1 .. 8, 1 .. 8) of Color_Index_16
    with Pack, Size => 32 * 8;

  type Tile_Data_8 is array (1 .. 8, 1 .. 8) of Color_Index_256
    with Pack, Size => 64 * 8;


  type Tile_Block_Index is range 0 .. 3
    with Size => 2;

  type Screen_Block_Index is range 0 .. 31
    with Size => 5;


  function Tile_Block_Address (Ix : Tile_Block_Index) return Address
    with Pure_Function, Inline_Always;

  function Screen_Block_Address (Ix : Screen_Block_Index) return Address
    with Pure_Function, Inline_Always;



  -- These types are defined separately for a couple of reasons:
  --   - Indexing into different regions of tile data
  --   - Representing 64-byte offsets in 256-color mode for OBJ,
  --     but always 32-byte offsets for BGs.

  type BG_Tile_Index is range 0 .. 1023
      with Size => 10;

  type OBJ_Tile_Index is range 0 .. 1023
      with Size => 10;


  type Screen_Entry_16 is
    record
      Tile            : BG_Tile_Index;
      Flip_Horizontal : Boolean;
      Flip_Vertical   : Boolean;
      Palette_Index   : Palette_Index_16; -- ignored in 256-color mode
    end record
      with Size => 16;

  for Screen_Entry_16 use
    record
      Tile            at 0 range 0  .. 9;
      Flip_Horizontal at 0 range 10 .. 10;
      Flip_Vertical   at 0 range 11 .. 11;
      Palette_Index   at 0 range 12 .. 15;
    end record;


  subtype Affine_BG_Tile_Index is
    BG_Tile_Index range 0 .. 255;

  type Screen_Entry_8 is
    record
      Tile : Affine_BG_Tile_Index;
    end record
      with Size => 8;

  for Screen_Entry_8 use
    record
      Tile at 0 range 0 .. 7;
    end record;



  OBJ_Tile_Memory_Start : constant Video_RAM_Address := 16#6010000#;

  OBJ_Tile_Memory_4 : array (OBJ_Tile_Index) of Tile_Data_4
    with Import, Volatile, Address => OBJ_Tile_Memory_Start;

  OBJ_Tile_Memory_8 : array (OBJ_Tile_Index range 0 .. 511) of Tile_Data_8
    with Import, Volatile, Address => OBJ_Tile_Memory_Start;



  type Tile_Block_4 is
    array (BG_Tile_Index range <>) of Tile_Data_4
      with Pack;

  type Tile_Block_4_Ptr is access all Tile_Block_4
    with Storage_Size => 0;


  type Tile_Block_8 is
    array (BG_Tile_Index range <>) of Tile_Data_8
      with Pack;

  type Tile_Block_8_Ptr is access all Tile_Block_8
    with Storage_Size => 0;


  type Screen_Block_16 is
    array (1 .. 32, 1 .. 32) of Screen_Entry_16
      with Pack;

  type Screen_Block_16_Ptr is access all Screen_Block_16
    with Storage_Size => 0;


  -- Affine background map data is variably-sized.
  -- Rather than 32x32 chunks, the whole map is
  -- a large square, of up to 128x128 tiles.

  type Screen_Block_8 is
    array (Positive range <>, Positive range <>) of Screen_Entry_8
      with Pack;

  type Screen_Block_8_Ptr is access all Screen_Block_8
    with Storage_Size => 0;

end GBA.Display.Tiles;