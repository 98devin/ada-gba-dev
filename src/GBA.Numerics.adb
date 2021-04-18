
with Ada.Unchecked_Conversion;


package body GBA.Numerics is

  type LL_Parts is
    record
      Lower, Upper : Integer;
    end record
    with Size => 64;

  type ULL_Parts is
    record
      Lower, Upper : Unsigned_32;
    end record
    with Size => 64;

  function Cast is new Ada.Unchecked_Conversion (Long_Long_Integer, Unsigned_64);
  function Cast is new Ada.Unchecked_Conversion (Unsigned_64, Long_Long_Integer);
  function Cast is new Ada.Unchecked_Conversion (Integer, Unsigned_32);
  function Cast is new Ada.Unchecked_Conversion (Unsigned_32, Integer);
  function Cast is new Ada.Unchecked_Conversion (Integer_16, Unsigned_16);
  function Cast is new Ada.Unchecked_Conversion (Unsigned_16, Integer_16);

  function Cast is new Ada.Unchecked_Conversion (Long_Long_Integer, LL_Parts);
  function Cast is new Ada.Unchecked_Conversion (LL_Parts, Long_Long_Integer);
  function Cast is new Ada.Unchecked_Conversion (Long_Long_Integer, ULL_Parts);
  function Cast is new Ada.Unchecked_Conversion (ULL_Parts, Long_Long_Integer);


  Leading_Nine_Bits : constant array (Unsigned_32'(256) .. 511) of Unsigned_8 :=
    ( 254, 252, 250, 248, 246, 244, 242, 240, 238, 236, 234, 233, 231, 229, 227, 225,
      224, 222, 220, 218, 217, 215, 213, 212, 210, 208, 207, 205, 203, 202, 200, 199,
      197, 195, 194, 192, 191, 189, 188, 186, 185, 183, 182, 180, 179, 178, 176, 175,
      173, 172, 170, 169, 168, 166, 165, 164, 162, 161, 160, 158, 157, 156, 154, 153,
      152, 151, 149, 148, 147, 146, 144, 143, 142, 141, 139, 138, 137, 136, 135, 134,
      132, 131, 130, 129, 128, 127, 126, 125, 123, 122, 121, 120, 119, 118, 117, 116,
      115, 114, 113, 112, 111, 110, 109, 108, 107, 106, 105, 104, 103, 102, 101, 100,
       99,  98,  97,  96,  95,  94,  93,  92,  91,  90,  89,  88,  88,  87,  86,  85,
       84,  83,  82,  81,  80,  80,  79,  78,  77,  76,  75,  74,  74,  73,  72,  71,
       70,  70,  69,  68,  67,  66,  66,  65,  64,  63,  62,  62,  61,  60,  59,  59,
       58,  57,  56,  56,  55,  54,  53,  53,  52,  51,  50,  50,  49,  48,  48,  47,
       46,  46,  45,  44,  43,  43,  42,  41,  41,  40,  39,  39,  38,  37,  37,  36,
       35,  35,  34,  33,  33,  32,  32,  31,  30,  30,  29,  28,  28,  27,  27,  26,
       25,  25,  24,  24,  23,  22,  22,  21,  21,  20,  19,  19,  18,  18,  17,  17,
       16,  15,  15,  14,  14,  13,  13,  12,  12,  11,  10,  10,   9,   9,   8,   8,
        7,   7,   6,   6,   5,   5,   4,   4,   3,   3,   2,   2,   1,   1,   0,   0 );


  function Divide (N, D : Integer) return Integer is
    QR : Unsigned_64 := Cast (Div_Mod (N, D));
  begin
    return Cast (Unsigned_32'Mod (Shift_Right (QR, 32)));
  end;

  function Div_Mod (N, D : Integer) return Long_Long_Integer is
    N_Abs  : Unsigned_32 := Cast (abs N);
    D_Abs  : Unsigned_32 := Cast (abs D);
    QR_Abs : ULL_Parts := Cast (Div_Mod (N_Abs, D_Abs));

    Q, R : Integer;
  begin
    if N >= 0 then
      R := Cast (QR_Abs.Upper);
    else
      R := Cast (-QR_Abs.Upper);
    end if;

    if Cast (D) = D_Abs xor Cast (N) = N_Abs then
      Q := Cast (-QR_Abs.Lower);
    else
      Q := Cast (QR_Abs.Lower);
    end if;

    return Cast (LL_Parts'(Lower => Q, Upper => R));
  end;


  function Divide (N, D : Unsigned_32) return Unsigned_32 is
    function Div_Mod_Call (N, D : Unsigned_32) return Long_Long_Integer
      with No_Inline;

    function Div_Mod_Call (N, D : Unsigned_32) return Long_Long_Integer
      renames Div_Mod;

    QR : Unsigned_64 := Cast (Div_Mod_Call (N, D));
  begin
    return Unsigned_32'Mod (Shift_Right (QR, 32));
  end;


  function Div_Mod (N, D : Unsigned_32) return Long_Long_Integer is
    K  : constant Natural     := Count_Leading_Zeros (D);
    Ty : constant Unsigned_32 := Shift_Right (Shift_Left (D, K), 23);
    T  : constant Unsigned_32 := Unsigned_32 (Leading_Nine_Bits (Ty)) + 256;
    Z  : Unsigned_32 := Shift_Right (Shift_Left (T, 23), 31 - K);
    Q, R : Unsigned_32;

    function UMulH (X, Y : Unsigned_32) return Unsigned_32 is
      Long : Unsigned_64 := Unsigned_64 (X) * Unsigned_64 (Y);
    begin
      return Unsigned_32'Mod (Shift_Right (Long, 32));
    end;

  begin
    Z := Z + UMulH (Z, Z * (-D));
    Z := Z + UMulH (Z, Z * (-D));
    Q := UMulH (N, Z);
    R := N - (Q * D);

    if R >= D then
      R := R - D;
      Q := Q + 1;
      if R >= D then
        R := R - D;
        Q := Q + 1;
      end if;
    end if;

    return Cast (ULL_Parts'(Lower => Q, Upper => R));
  end Div_Mod;


  function Count_Trailing_Zeros (I : Long_Long_Integer) return Natural is
    ( Count_Trailing_Zeros (Cast (I)) );

  function Count_Trailing_Zeros (I : Unsigned_64) return Natural is
    U : Unsigned_64 := I;
    C : Natural     := 64;
  begin
    U := U and -U;
    if U /= 0                    then C := C - 1;  end if;
    if (U and 16#FFFFFFFF#) /= 0 then C := C - 32; end if;
    if (U and 16#0000FFFF#) /= 0 then C := C - 16; end if;
    if (U and 16#00FF00FF#) /= 0 then C := C - 8;  end if;
    if (U and 16#0F0F0F0F#) /= 0 then C := C - 4;  end if;
    if (U and 16#33333333#) /= 0 then C := C - 2;  end if;
    if (U and 16#55555555#) /= 0 then C := C - 1;  end if;
    return C;
  end;


  function Count_Trailing_Zeros (I : Integer) return Natural is
    ( Count_Trailing_Zeros (Cast (I)) );

  function Count_Trailing_Zeros (I : Unsigned_32) return Natural is
    U : Unsigned_32 := I;
    C : Natural     := 32;
  begin
    U := U and -U;
    if U /= 0                    then C := C - 1;  end if;
    if (U and 16#0000FFFF#) /= 0 then C := C - 16; end if;
    if (U and 16#00FF00FF#) /= 0 then C := C - 8;  end if;
    if (U and 16#0F0F0F0F#) /= 0 then C := C - 4;  end if;
    if (U and 16#33333333#) /= 0 then C := C - 2;  end if;
    if (U and 16#55555555#) /= 0 then C := C - 1;  end if;
    return C;
  end;


  function Count_Trailing_Zeros (I : Integer_16) return Natural is
    ( Count_Trailing_Zeros (Cast (I)) );

  function Count_Trailing_Zeros (I : Unsigned_16) return Natural is
    U : Unsigned_16 := I;
    C : Natural     := 16;
  begin
    U := U and -U;
    if U /= 0                then C := C - 1; end if;
    if (U and 16#00FF#) /= 0 then C := C - 8; end if;
    if (U and 16#0F0F#) /= 0 then C := C - 4; end if;
    if (U and 16#3333#) /= 0 then C := C - 2; end if;
    if (U and 16#5555#) /= 0 then C := C - 1; end if;
    return C;
  end;


  function Count_Leading_Zeros (I : Long_Long_Integer) return Natural is
    ( Count_Leading_Zeros (Cast (I)) );

  function Count_Leading_Zeros (I : Unsigned_64) return Natural is
    U : Unsigned_64 := I;
    C : Natural     := 32;
  begin
    if (U and 16#FFFFFFFF00000000#) /= 0 then
      C := 0;
      U := Shift_Right (U, 32);
    end if;
    return C + Count_Leading_Zeros (Unsigned_32'Mod (U));
  end;


  function Count_Leading_Zeros (I : Integer) return Natural is
    ( Count_Leading_Zeros (Cast (I)) );

  function Count_Leading_Zeros (I : Unsigned_32) return Natural is
    U : Unsigned_32 := I;
    C : Natural     := 16;
  begin
    if (U and 16#FFFF0000#) /= 0 then
      C := 0;
      U := Shift_Right (U, 16);
    end if;
    return C + Count_Leading_Zeros (Unsigned_16'Mod (U));
  end;


  function Count_Leading_Zeros (I : Integer_16) return Natural is
    ( Count_Leading_Zeros (Cast (I)) );

  function Count_Leading_Zeros (I : Unsigned_16) return Natural is
    U : Unsigned_16 := I;
    C : Natural     := 16;
  begin
    if (U and 16#FF00#) /= 0 then C := C - 8; U := Shift_Right(U, 8); end if;
    if (U and 16#F0#  ) /= 0 then C := C - 4; U := Shift_Right(U, 4); end if;
    if (U and 16#C#   ) /= 0 then C := C - 2; U := Shift_Right(U, 2); end if;
    if (U and 16#A#   ) /= 0 then C := C - 1; U := Shift_Right(U, 1); end if;
    if U /= 0 then C := C - 1; end if;
    return C;
  end;

end GBA.Numerics;