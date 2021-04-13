
with System;
use  System;

with Interfaces;
use  Interfaces;

with GBA.BIOS.Arm;
use  GBA.BIOS.Arm;

with Ada.Unchecked_Conversion;


procedure GBA.BIOS.Memset
  ( Dest : in Address; Value : Integer; Num_Bytes : Unsigned_32 ) is

  function Conv is new Ada.Unchecked_Conversion (Integer, Unsigned_32);
  function Conv is new Ada.Unchecked_Conversion (Unsigned_32, Cpu_Set_Unit_Count);
  function Conv is new Ada.Unchecked_Conversion (Unsigned_32, Address);

  Value_U32 : Unsigned_32 := Conv (Value);

  Num_Bytes_32 : Unsigned_32 := Num_Bytes and not 2#1111#;
  Num_Bytes_2  : Unsigned_32 := Num_Bytes and     2#1110#;
  Num_Bytes_1  : Unsigned_32 := Num_Bytes and     2#0001#;

  Copy_Dest : Address := Dest;

begin
  Value_U32 := @ and 16#FF#;
  Value_U32 := @ or Shift_Left (Value_U32, 8);
  Value_U32 := @ or Shift_Left (Value_U32, 16);

  if Num_Bytes_32 /= 0 then
    Cpu_Fast_Set
      ( Value_U32'Address
      , Copy_Dest
      , Conv (Num_Bytes_32 / 4)
      , Mode => Fill );
    Copy_Dest := @ + Conv (Num_Bytes_32);
  end if;

  if Num_Bytes_2 /= 0 then
    Cpu_Set
      ( Value_U32'Address
      , Copy_Dest
      , Conv (Num_Bytes_2 / 2)
      , Mode      => Fill
      , Unit_Size => Half_Word );
    Copy_Dest := @ + Conv (Num_Bytes_2);
  end if;

  if Num_Bytes_1 /= 0 then
    Unsigned_8'Deref (Copy_Dest) := Unsigned_8'Mod (Value_U32);
  end if;
end;