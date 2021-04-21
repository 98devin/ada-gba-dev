
with GBA.Interrupts;
use  GBA.Interrupts;

with GBA.Memory;
use  GBA.Memory;

with GBA.BIOS.Generic_Interface;

package GBA.BIOS.Raw.Thumb is

  IMPORT_PREFIX : constant String := "bios_thumb__";

  procedure Soft_Reset
    with Import, External_Name => IMPORT_PREFIX & "soft_reset";

  procedure Hard_Reset
    with Import, External_Name => IMPORT_PREFIX & "hard_reset";

  procedure Register_RAM_Reset (Flags : Register_RAM_Reset_Flags)
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

  function Sqrt (Num : Unsigned_32) return Unsigned_16
      with Import, Pure_Function, External_Name => IMPORT_PREFIX & "sqrt";

  function Arc_Tan (X, Y : Fixed_2_14) return Radians_16
      with Import, Pure_Function, External_Name => IMPORT_PREFIX & "arc_tan2";


  procedure Cpu_Set (Src, Dest : Address; Config : Cpu_Set_Config)
    with Import, External_Name => IMPORT_PREFIX & "cpu_set";

  procedure Cpu_Fast_Set (Src, Dest : Address; Config : Cpu_Set_Config)
    with Import, External_Name => IMPORT_PREFIX & "cpu_fast_set";

  function Bios_Checksum return Unsigned_32
    with Import, External_Name => IMPORT_PREFIX & "get_bios_checksum";


  procedure Affine_Set_Ext (Parameters : Address; Transform : Address; Count : Integer)
    with Import, External_Name => IMPORT_PREFIX & "bg_affine_set";

  procedure Affine_Set
    (Parameters : Address; Transform : Address; Count, Stride : Integer)
    with Import, External_Name => IMPORT_PREFIX & "obj_affine_set";


  package Generic_Interface is new GBA.BIOS.Generic_Interface;

end GBA.BIOS.Raw.Thumb;