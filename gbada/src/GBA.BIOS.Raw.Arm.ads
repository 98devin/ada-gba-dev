
with GBA.Interrupts;
use  GBA.Interrupts;

with GBA.Numerics;
use  GBA.Numerics;

with GBA.Memory;
use  GBA.Memory;

with Interfaces;
use  Interfaces;

with GBA.BIOS.Generic_Interface;

package GBA.BIOS.Raw.Arm is

  IMPORT_PREFIX : constant String := "bios_arm__";

  procedure Soft_Reset
    with Import, External_Name => IMPORT_PREFIX & "soft_reset";

  procedure Hard_Reset
    with Import, External_Name => IMPORT_PREFIX & "hard_reset";

  procedure Register_RAM_Reset(Flags : Register_RAM_Reset_Flags)
    with Import, External_Name => IMPORT_PREFIX & "register_ram_reset";

  procedure Halt
    with Import, External_Name => IMPORT_PREFIX & "halt";

  procedure Stop
    with Import, External_Name => IMPORT_PREFIX & "stop";

  procedure Wait_For_Interrupt
    ( New_Only : Boolean; Wait_For : Interrupt_Flags)
    with Import, External_Name => IMPORT_PREFIX & "wait_for_interrupt";

  procedure Wait_For_VBlank
    with Import, External_Name => IMPORT_PREFIX & "wait_for_vblank";


  function Div_Mod (Num, Denom : Integer) return Long_Long_Integer
      with Import, Pure_Function, External_Name => IMPORT_PREFIX & "div_mod";
      
  function Div_Mod_Arm (Denom, Num : Integer) return Long_Long_Integer
      with Import, Pure_Function, External_Name => IMPORT_PREFIX & "div_mod_arm";

  function Sqrt(Num : Unsigned_32) return Unsigned_16
      with Import, Pure_Function, External_Name => IMPORT_PREFIX & "sqrt";

  function Arc_Tan(X, Y : Fixed_2_14) return Radians_16
      with Import, Pure_Function, External_Name => IMPORT_PREFIX & "arc_tan2";


  procedure Cpu_Set (Src, Dest : Address; Config : Cpu_Set_Config)
    with Import, External_Name => IMPORT_PREFIX & "cpu_set";

  procedure Cpu_Fast_Set (Src, Dest : Address; Config : Cpu_Set_Config)
    with Import, External_Name => IMPORT_PREFIX & "cpu_fast_set";

  function Bios_Checksum return Unsigned_32
    with Import, External_Name => IMPORT_PREFIX & "get_bios_checksum";

  -- TODO: Understand exact parameter specifications
  -- BG_Affine_Set
  -- Obj_Affine_Set

  package Generic_Interface is new GBA.BIOS.Generic_Interface;

end GBA.BIOS.Raw.Arm;