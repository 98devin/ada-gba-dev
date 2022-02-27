-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.Interrupts;
use  GBA.Interrupts;

with GBA.Numerics;
use  GBA.Numerics;

with GBA.Memory;
use  GBA.Memory;

with Interfaces;
use  Interfaces;

with GBA.Display.Backgrounds;
use  GBA.Display.Backgrounds;

with GBA.Display.Objects;
use  GBA.Display.Objects;

with GBA.BIOS.Generic_Interface;

generic
  with package Raw is new GBA.BIOS.Generic_Interface (<>);

package GBA.BIOS.Extended_Interface is

  -- Reexport functionality from Raw interface --

  -- Marked Inline_Always so that link-time optimization
  -- takes place and reduces these to a pure `svc` instruction.
  -- This eliminates the overhead of a function call to BIOS routines.

  -- Unfortunately, due to the numeric code of the interrupts
  -- being different in ARM and THUMB mode, we still need to have
  -- two versions of this package. We share as much as possible by
  -- making them instances of this same generic package.

  procedure Soft_Reset renames Raw.Soft_Reset with Inline_Always;
  procedure Hard_Reset renames Raw.Hard_Reset with Inline_Always;
  procedure Halt       renames Raw.Halt       with Inline_Always;
  procedure Stop       renames Raw.Stop       with Inline_Always;

  procedure Register_RAM_Reset (Flags : Register_RAM_Reset_Flags)
    renames Raw.Register_RAM_Reset with Inline_Always;

  procedure Wait_For_Interrupt (New_Only : Boolean; Wait_For : Interrupt_Flags)
    renames Raw.Wait_For_Interrupt with Inline_Always;

  procedure Wait_For_VBlank
    renames Raw.Wait_For_VBlank with Inline_Always;

  function Div_Mod (N, D : Integer) return Long_Long_Integer
    renames Raw.Div_Mod with Inline_Always;

  function Div_Mod_Arm (D, N : Integer) return Long_Long_Integer
    renames Raw.Div_Mod_Arm with Inline_Always;

  function Sqrt (N : Unsigned_32) return Unsigned_16
    renames Raw.Sqrt with Inline_Always;

  function Arc_Tan (X, Y : Fixed_2_14) return Radians_16
    renames Raw.Arc_Tan with Inline_Always;

  procedure Cpu_Set (Src, Dest : Address; Config : Cpu_Set_Config)
    renames Raw.Cpu_Set with Inline_Always;

  procedure Cpu_Fast_Set (Src, Dest : Address; Config : Cpu_Set_Config)
    renames Raw.Cpu_Fast_Set with Inline_Always;

  function Bios_Checksum return Unsigned_32
    renames Raw.Bios_Checksum with Inline_Always;

  procedure Affine_Set_Ext (Parameters : Address; Transform : Address; Count : Integer)
    renames Raw.Affine_Set_Ext with Inline_Always;

  procedure Affine_Set (Parameters : Address; Transform : Address; Count, Stride : Integer)
    renames Raw.Affine_Set with Inline_Always;

  procedure Bit_Unpack (Src, Dest : Address; Config : Address)
    renames Raw.Bit_Unpack with Inline_Always;

  procedure LZ77_Decompress_Write8 (Data : Address; Dest : Address)
    renames Raw.LZ77_Decompress_Write8 with Inline_Always;

  procedure LZ77_Decompress_Write16 (Data : Address; Dest : Address)
    renames Raw.LZ77_Decompress_Write16 with Inline_Always;

  procedure Huffman_Decompress_Write32 (Data : Address; Dest : Address)
    renames Raw.Huffman_Decompress_Write32 with Inline_Always;

  procedure Run_Length_Decompress_Write8 (Data : Address; Dest : Address)
    renames Raw.Run_Length_Decompress_Write8 with Inline_Always;

  procedure Run_Length_Decompress_Write16 (Data : Address; Dest : Address)
    renames Raw.Run_Length_Decompress_Write16 with Inline_Always;

  procedure Diff_Unfilter8_Write8 (Data : Address; Dest : Address)
    renames Raw.Diff_Unfilter8_Write8 with Inline_Always;

  procedure Diff_Unfilter8_Write16 (Data : Address; Dest : Address)
    renames Raw.Diff_Unfilter8_Write16 with Inline_Always;

  procedure Diff_Unfilter16_Write16 (Data : Address; Dest : Address)
    renames Raw.Diff_Unfilter16_Write16 with Inline_Always;


  -- More convenient interfaces to Raw functions --

  -- Most routines should be Inline_Always, and delegate to the underlying Raw routine.

  -- Any functionality which needs to compose results from multiple BIOS calls
  -- should be external to this package, and depend on it either by being generic,
  -- or importing the Arm or Thumb instantiations as required.

  procedure Register_RAM_Reset
    ( Clear_External_WRAM
    , Clear_Internal_WRAM
    , Clear_Palette
    , Clear_VRAM
    , Clear_OAM
    , Reset_SIO_Registers
    , Reset_Sound_Registers
    , Reset_Other_Registers
    : Boolean := False)
    with Inline_Always;

  procedure Wait_For_Interrupt (Wait_For : Interrupt_Flags)
    with Inline_Always;

  function Divide (Num, Denom : Integer) return Integer
    with Pure_Function, Inline_Always;

  function Remainder (Num, Denom : Integer) return Integer
    with Pure_Function, Inline_Always;

  procedure Div_Mod (Num, Denom : Integer; Quotient, Remainder : out Integer)
    with Inline_Always;

  procedure Cpu_Set
    ( Source, Dest : Address;
      Unit_Count   : Cpu_Set_Unit_Count;
      Mode         : Cpu_Set_Mode;
      Unit_Size    : Cpu_Set_Unit_Size )
    with Inline_Always;

  procedure Cpu_Fast_Set
    ( Source, Dest : Address;
      Word_Count   : Cpu_Set_Unit_Count;
      Mode         : Cpu_Set_Mode )
    with Inline_Always;

  --
  -- Single-matrix affine transform computation
  --

  procedure Affine_Set
    ( Parameters : Affine_Parameters;
      Transform  : out Affine_Transform_Matrix )
    with Inline_Always;

  procedure Affine_Set
    ( Parameters : Affine_Parameters;
      Transform  : OBJ_Affine_Transform_Index )
    with Inline_Always;

  procedure Affine_Set_Ext
    ( Parameters : Affine_Parameters_Ext;
      Transform  : out BG_Transform_Info )
    with Inline_Always;

  --
  -- Multiple-matrix affine transform computation
  --


  type OBJ_Affine_Parameter_Array is
    array (OBJ_Affine_Transform_Index range <>) of Affine_Parameters;

  procedure Affine_Set (Parameters : OBJ_Affine_Parameter_Array)
    with Inline_Always;


  type BG_Affine_Parameter_Ext_Array is
    array (Affine_BG_ID range <>) of Affine_Parameters_Ext;

  procedure Affine_Set_Ext (Parameters : BG_Affine_Parameter_Ext_Array)
    with Inline_Always;


  type Affine_Parameter_Array is
    array (Natural range <>) of Affine_Parameters;

  type Affine_Transform_Array is
    array (Natural range <>) of Affine_Transform_Matrix;

  procedure Affine_Set
    ( Parameters : Affine_Parameter_Array;
      Transforms : out Affine_Transform_Array )
    with Inline_Always;


  type Affine_Parameter_Ext_Array is
    array (Natural range <>) of Affine_Parameters_Ext;

  procedure Affine_Set_Ext
    ( Parameters : Affine_Parameter_Ext_Array;
      Transforms : out BG_Transform_Info_Array )
    with Inline_Always;


  type Bit_Unpack_Width is new Unsigned_8
    with Static_Predicate => Bit_Unpack_Width in 1 | 2 | 4 | 8 | 16 | 32;
  subtype Bit_Src_Unpack_Width is Bit_Unpack_Width
    with Static_Predicate => Bit_Src_Unpack_Width < 16;

  type Unsigned_31 is mod 2 ** 31;

  type Bit_Unpack_Config is
    record
      Src_Data_Bytes : Unsigned_16;
      Src_Data_Width : Bit_Src_Unpack_Width;
      Dst_Data_Width : Bit_Unpack_Width;
      Data_Offset    : Unsigned_31;
      Offset_Zeros   : Boolean;
    end record
      with Size => 64;

  for Bit_Unpack_Config use
    record
      Src_Data_Bytes at 0 range  0 .. 15;
      Src_Data_Width at 2 range  0 ..  7;
      Dst_Data_Width at 3 range  0 ..  7;
      Data_Offset    at 4 range  0 .. 30;
      Offset_Zeros   at 4 range 31 .. 31;
    end record;

  procedure Bit_Unpack (Src, Dest : Address; Config : Bit_Unpack_Config)
    with Inline_Always;


  type Compression_Type is
    ( LZ77
    , Huffman
    , Run_Length_Encoded
    , Diff_Filtered
    ) with Size => 4;

  for Compression_Type use
    ( LZ77               => 1
    , Huffman            => 2
    , Run_Length_Encoded => 3
    , Diff_Filtered      => 8
    );

  type Unsigned_4  is mod 2 ** 4;
  type Unsigned_24 is mod 2 ** 24;

  type Decompress_Data_Header is
    record
      Kind              : Compression_Type;
      Kind_Metadata     : Unsigned_4 := 0;
      Uncompressed_Size : Unsigned_24;
    end record
      with Size => 32;

  for Decompress_Data_Header use
    record
      Kind              at 0 range 4 ..  7;
      Kind_Metadata     at 0 range 0 ..  3;
      Uncompressed_Size at 0 range 8 .. 31;
    end record;

end GBA.BIOS.Extended_Interface;