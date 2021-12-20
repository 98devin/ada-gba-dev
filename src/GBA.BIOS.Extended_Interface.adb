-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with System;

with Ada.Unchecked_Conversion;


package body GBA.BIOS.Extended_Interface is

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
    is

    Flags : Register_RAM_Reset_Flags :=
      ( Clear_External_WRAM
      , Clear_Internal_WRAM
      , Clear_Palette
      , Clear_VRAM
      , Clear_OAM
      , Reset_SIO_Registers
      , Reset_Sound_Registers
      , Reset_Other_Registers
      );
  begin
    Register_RAM_Reset (Flags);
  end;


  type Div_Mod_Result is
    record
      Quotient, Remainder : Integer;
    end record
    with Size => 64;

  function Conv is new Ada.Unchecked_Conversion (Long_Long_Integer, Div_Mod_Result);

  function Divide (Num, Denom : Integer) return Integer is
    ( Conv (Div_Mod (Num, Denom)).Quotient );

  function Remainder (Num, Denom : Integer) return Integer is
    ( Conv (Div_Mod (Num, Denom)).Remainder );

  procedure Div_Mod (Num, Denom : Integer; Quotient, Remainder : out Integer) is
    Result : constant Div_Mod_Result := Conv (Div_Mod (Num, Denom));
  begin
    Quotient  := Result.Quotient;
    Remainder := Result.Remainder;
  end;


  procedure Cpu_Set
    ( Source, Dest : Address;
      Unit_Count   : Cpu_Set_Unit_Count;
      Mode         : Cpu_Set_Mode;
      Unit_Size    : Cpu_Set_Unit_Size) is

    Config : constant Cpu_Set_Config :=
      ( Unit_Count => Unit_Count
      , Copy_Mode  => Mode
      , Unit_Size => Unit_Size
      );
  begin
    Cpu_Set (Source, Dest, Config);
  end;

  procedure Cpu_Fast_Set
    ( Source, Dest : Address;
      Word_Count   : Cpu_Set_Unit_Count;
      Mode         : Cpu_Set_Mode) is

    Config : constant Cpu_Set_Config :=
      ( Unit_Count => Word_Count
      , Copy_Mode  => Mode
      , Unit_Size  => Word -- not used by cpu_fast_set
      );
  begin
    Cpu_Fast_Set (Source, Dest, Config);
  end;


  procedure Wait_For_Interrupt (Wait_For : Interrupt_Flags) is
  begin
    Wait_For_Interrupt (True, Wait_For);
  end;


  --
  -- Affine set
  --

  procedure Affine_Set
    ( Parameters : Affine_Parameters;
      Transform  : out Affine_Transform_Matrix ) is
  begin
    Affine_Set
      ( Parameters'Address
      , Transform'Address
      , Count  => 1
      , Stride => 2
      );
  end;

  procedure Affine_Set
    ( Parameters : Affine_Parameters;
      Transform  : OBJ_Affine_Transform_Index ) is
  begin
    Affine_Set
      ( Parameters'Address
      , Affine_Transform_Address (Transform)
      , Count  => 1
      , Stride => 8
      );
  end;

  procedure Affine_Set_Ext
    ( Parameters : Affine_Parameters_Ext;
      Transform  : out BG_Transform_Info ) is
  begin
    Affine_Set_Ext (Parameters'Address, Transform'Address, 1);
  end;

  procedure Affine_Set (Parameters : OBJ_Affine_Parameter_Array) is
    Begin_Address : constant Address := Affine_Transform_Address (Parameters'First);
  begin
    Affine_Set
      ( Parameters'Address
      , Begin_Address
      , Count  => Parameters'Length
      , Stride => 8
      );
  end;

  procedure Affine_Set_Ext (Parameters : BG_Affine_Parameter_Ext_Array) is
    Begin_Address : constant Address := Affine_Transform_Address (Parameters'First);
  begin
    Affine_Set_Ext
      ( Parameters'Address
      , Begin_Address
      , Count => Parameters'Length
      );
  end;

  procedure Affine_Set
    ( Parameters : Affine_Parameter_Array;
      Transforms : out Affine_Transform_Array ) is
    pragma Assert (Parameters'Length = Transforms'Length);
  begin
    Affine_Set
      ( Parameters'Address
      , Transforms'Address
      , Count  => Parameters'Length
      , Stride => 2
      );
  end;

  procedure Affine_Set_Ext
    ( Parameters : Affine_Parameter_Ext_Array;
      Transforms : out BG_Transform_Info_Array ) is
    pragma Assert (Parameters'Length = Transforms'Length);
  begin
    Affine_Set_Ext
      ( Parameters'Address
      , Transforms'Address
      , Count => Parameters'Length
      );
  end;

end GBA.BIOS.Extended_Interface;