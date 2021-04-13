
with GBA.Interrupts;
use  GBA.Interrupts;

with GBA.Numerics;
use  GBA.Numerics;

with GBA.Memory;
use  GBA.Memory;

with Interfaces;
use  Interfaces;


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



  -- More convenient interfaces to Raw functions --

  -- All such routines should be Inline_Always, and delegate to the underlying Raw routine.

  -- Any functionality which needs to compose results from multiple such BIOS calls
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
      Unit_Size    : Cpu_Set_Unit_Size)
    with Inline_Always;

  procedure Cpu_Fast_Set
    ( Source, Dest : Address;
      Word_Count   : Cpu_Set_Unit_Count;
      Mode         : Cpu_Set_Mode)
    with Inline_Always;

end GBA.BIOS.Extended_Interface;