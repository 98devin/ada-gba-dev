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

  procedure Cpu_Set (S, D : Address; Config : Cpu_Set_Config)
    renames Raw.Cpu_Set with Inline_Always;

  procedure Cpu_Fast_Set (S, D : Address; Config : Cpu_Set_Config)
    renames Raw.Cpu_Fast_Set with Inline_Always;

  function Bios_Checksum return Unsigned_32
    renames Raw.Bios_Checksum with Inline_Always;

  procedure Affine_Set_Ext (Parameters : Address; Transform : Address; Count : Integer)
    renames Raw.Affine_Set_Ext with Inline_Always;

  procedure Affine_Set (Parameters : Address; Transform : Address; Count, Stride : Integer)
    renames Raw.Affine_Set with Inline_Always;

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