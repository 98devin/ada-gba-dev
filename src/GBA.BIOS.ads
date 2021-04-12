
package GBA.BIOS is

  pragma Preelaborate;
  
  type System_Call is
    ( Soft_Reset              --
    , Register_RAM_Reset      --
    , Halt                    --
    , Stop                    --
    , Intr_Wait               --
    , VBlank_Intr_Wait        --
    , Div                     --
    , Div_Arm                 --
    , Sqrt                    --
    , Arc_Tan                 --
    , Arc_Tan2                --
    , Cpu_Set                 --
    , Cpu_Fast_Set            --
    , Get_Bios_Checksum       --
    , BG_Affine_Set           
    , Obj_Affine_Set
    
    , Bit_Unpack
    , LZ77_Uncomp_Write8      -- for WRAM
    , LZ77_Uncomp_Write16     -- for VRAM
    , Huff_Uncomp
    , RL_Uncomp_Write8        -- for WRAM
    , RL_Uncomp_Write16       -- for VRAM
    , Diff_8_Unfilter_Write8  -- for WRAM
    , Diff_8_Unfilter_Write16 -- for VRAM
    , Diff_16_Unfilter

    , Sound_Bias
    , Sound_Driver_Init
    , Sound_Driver_Mode
    , Sound_Driver_Main
    , Sound_Driver_VSync
    , Sound_Channel_Clear
    , Midi_Key_To_Freq
    , Sound_Whatever0
    , Sound_Whatever1
    , Sound_Whatever2
    , Sound_Whatever3
    , Sound_Whatever4
    , Multi_Boot
    , Hard_Reset              --
    , Sound_Driver_VSync_Off
    , Sound_Driver_VSync_On
    , Sound_Get_Jump_List
    );

  for System_Call use
    ( Soft_Reset              => 16#00#
    , Register_RAM_Reset      => 16#01#
    , Halt                    => 16#02#
    , Stop                    => 16#03#
    , Intr_Wait               => 16#04#
    , VBlank_Intr_Wait        => 16#05#
    , Div                     => 16#06#
    , Div_Arm                 => 16#07#
    , Sqrt                    => 16#08#
    , Arc_Tan                 => 16#09#
    , Arc_Tan2                => 16#0A#
    , Cpu_Set                 => 16#0B#
    , Cpu_Fast_Set            => 16#0C#
    , Get_Bios_Checksum       => 16#0D#
    , BG_Affine_Set           => 16#0E#
    , Obj_Affine_Set          => 16#0F#
    , Bit_Unpack              => 16#10#
    , LZ77_Uncomp_Write8      => 16#11# 
    , LZ77_Uncomp_Write16     => 16#12# 
    , Huff_Uncomp             => 16#13#
    , RL_Uncomp_Write8        => 16#14# 
    , RL_Uncomp_Write16       => 16#15# 
    , Diff_8_Unfilter_Write8  => 16#16# 
    , Diff_8_Unfilter_Write16 => 16#17# 
    , Diff_16_Unfilter        => 16#18#
    , Sound_Bias              => 16#19#
    , Sound_Driver_Init       => 16#1A#
    , Sound_Driver_Mode       => 16#1B#
    , Sound_Driver_Main       => 16#1C#
    , Sound_Driver_VSync      => 16#1D#
    , Sound_Channel_Clear     => 16#1E#
    , Midi_Key_To_Freq        => 16#1F#
    , Sound_Whatever0         => 16#20#
    , Sound_Whatever1         => 16#21#
    , Sound_Whatever2         => 16#22#
    , Sound_Whatever3         => 16#23#
    , Sound_Whatever4         => 16#24#
    , Multi_Boot              => 16#25#
    , Hard_Reset              => 16#26#
    , Sound_Driver_VSync_Off  => 16#28#
    , Sound_Driver_VSync_On   => 16#29#
    , Sound_Get_Jump_List     => 16#2A#
    );

  type Register_RAM_Reset_Flags is
    record
      Clear_External_WRAM   : Boolean := False;
      Clear_Internal_WRAM   : Boolean := False;
      Clear_Palette         : Boolean := False;
      Clear_VRAM            : Boolean := False;
      Clear_OAM             : Boolean := False;
      Reset_SIO_Registers   : Boolean := False;
      Reset_Sound_Registers : Boolean := False;
      Reset_Other_Registers : Boolean := False;
    end record
      with Size => 8;

  for Register_RAM_Reset_Flags use
    record
      Clear_External_WRAM   at 0 range 0..0;
      Clear_Internal_WRAM   at 0 range 1..1;
      Clear_Palette         at 0 range 2..2;
      Clear_VRAM            at 0 range 3..3;
      Clear_OAM             at 0 range 4..4;
      Reset_SIO_Registers   at 0 range 5..5;
      Reset_Sound_Registers at 0 range 6..6;
      Reset_Other_Registers at 0 range 7..7;
    end record;

  type Cpu_Set_Mode is
    ( Copy, Fill );

  for Cpu_Set_Mode use
    ( Copy => 0, Fill => 1 );

  type Cpu_Set_Unit_Size is
    ( Half_Word, Word );

  for Cpu_Set_Unit_Size use
    ( Half_Word => 0, Word => 1 );
    
  type Cpu_Set_Unit_Count is mod 2**21
    with Object_Size => 32;
    
  type Cpu_Set_Config is
    record
      Unit_Count : Cpu_Set_Unit_Count;
      Copy_Mode  : Cpu_Set_Mode;
      Unit_Size  : Cpu_Set_Unit_Size;
    end record
    with Size => 32;

  for Cpu_Set_Config use
    record
      Unit_Count at 0 range 0  .. 20;
      Copy_Mode  at 0 range 24 .. 24;
      Unit_Size  at 0 range 26 .. 26;
    end record;


end GBA.BIOS;