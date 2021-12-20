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

  procedure Soft_Reset renames Raw.Soft_Reset;
  procedure Hard_Reset renames Raw.Hard_Reset;
  procedure Halt       renames Raw.Halt;
  procedure Stop       renames Raw.Stop;

  procedure Register_RAM_Reset (Flags : Register_RAM_Reset_Flags)
    renames Raw.Register_RAM_Reset;

  procedure Wait_For_Interrupt (New_Only : Boolean; Wait_For : Interrupt_Flags)
    renames Raw.Wait_For_Interrupt;

  procedure Wait_For_VBlank
    renames Raw.Wait_For_VBlank;

  function Div_Mod (N, D : Integer) return Long_Long_Integer
    renames Raw.Div_Mod;

  function Div_Mod_Arm (D, N : Integer) return Long_Long_Integer
    renames Raw.Div_Mod_Arm;

  function Sqrt (N : Unsigned_32) return Unsigned_16
    renames Raw.Sqrt;

  function Arc_Tan (X, Y : Fixed_2_14) return Radians_16
    renames Raw.Arc_Tan;

  procedure Cpu_Set (S, D : Address; Config : Cpu_Set_Config)
    renames Raw.Cpu_Set;

  procedure Cpu_Fast_Set (S, D : Address; Config : Cpu_Set_Config)
    renames Raw.Cpu_Fast_Set;

  function Bios_Checksum return Unsigned_32
    renames Raw.Bios_Checksum;

  procedure Affine_Set_Ext (Parameters : Address; Transform : Address; Count : Integer)
    renames Raw.Affine_Set_Ext;

  procedure Affine_Set (Parameters : Address; Transform : Address; Count, Stride : Integer)
    renames Raw.Affine_Set;



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

end GBA.BIOS.Extended_Interface;