
with Interfaces;
use  Interfaces;

with Ada.Unchecked_Conversion;


package body GBA.Numerics is

  function Count_Trailing_Zeros (I : Integer) return Natural is
    function To_Unsigned is new Ada.Unchecked_Conversion(Integer, Unsigned_32);
    U : Unsigned_32 := To_Unsigned(I);
    C : Natural     := 32;
  begin
    U := U and To_Unsigned(-I);
    if (U /= 0)                    then C := C - 1;  end if;
    if ((U and 16#0000FFFF#) /= 0) then C := C - 16; end if;
    if ((U and 16#00FF00FF#) /= 0) then C := C - 8;  end if;
    if ((U and 16#0F0F0F0F#) /= 0) then C := C - 4;  end if;
    if ((U and 16#33333333#) /= 0) then C := C - 2;  end if;
    if ((U and 16#55555555#) /= 0) then C := C - 1;  end if;
    return C;
  end;


  function Count_Trailing_Zeros (I : Integer_16) return Natural is
    function To_Unsigned is new Ada.Unchecked_Conversion(Integer_16, Unsigned_16);
    U : Unsigned_16 := To_Unsigned(I);
    C : Natural     := 16;
  begin
    U := U and To_Unsigned(-I);
    if (U /= 0)                then C := C - 1; end if;
    if ((U and 16#00FF#) /= 0) then C := C - 8; end if;
    if ((U and 16#0F0F#) /= 0) then C := C - 4; end if;
    if ((U and 16#3333#) /= 0) then C := C - 2; end if;
    if ((U and 16#5555#) /= 0) then C := C - 1; end if;
    return C;
  end;

end GBA.Numerics;