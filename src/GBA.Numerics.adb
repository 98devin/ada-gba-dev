
with Ada.Unchecked_Conversion;


package body GBA.Numerics is

  --
  -- Helpers for extracting upper and lower 32 bits
  -- of signed and unsigned 64-bit integer types.
  --

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

  --
  -- Casting for bit-level optimizations, etc.
  --

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

  function Cast is new Ada.Unchecked_Conversion (Radians_32, Unsigned_32);
  function Cast is new Ada.Unchecked_Conversion (Unsigned_32, Radians_32);
  function Cast is new Ada.Unchecked_Conversion (Radians_16, Unsigned_16);
  function Cast is new Ada.Unchecked_Conversion (Unsigned_16, Radians_16);

  --
  -- Cyclic addition for angle-representing types
  --

  overriding
  function "+" (X, Y : Radians_16) return Radians_16 is
    UX : Unsigned_16 := Cast (X);
    UY : Unsigned_16 := Cast (Y);
  begin
    return Cast (UX + UY);
  end;

  overriding
  function "-" (X, Y : Radians_16) return Radians_16 is
    UX : Unsigned_16 := Cast (X);
    UY : Unsigned_16 := Cast (Y);
  begin
    return Cast (UX - UY);
  end;

  overriding
  function "+" (X, Y : Radians_32) return Radians_32 is
    UX : Unsigned_32 := Cast (X);
    UY : Unsigned_32 := Cast (Y);
  begin
    return Cast (UX + UY);
  end;

  overriding
  function "-" (X, Y : Radians_32) return Radians_32 is
    UX : Unsigned_32 := Cast (X);
    UY : Unsigned_32 := Cast (Y);
  begin
    return Cast (UX - UY);
  end;

  --
  -- Look-up table for division optimization.
  --

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
    QR : Unsigned_64 := Cast (Div_Mod (N, D));
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


  procedure Sin_Cos_Quadrant (Norm_Theta : Fixed_Snorm_32; Sin, Cos : out Fixed_Snorm_32)
    with Inline_Always is

    X  : constant Fixed_2_30 := Norm_Theta;

    A0 : constant Fixed_2_30 :=  0.707106781187;
    A2 : constant Fixed_2_30 := -0.872348075361;
    A4 : constant Fixed_2_30 :=  0.179251759526;
    A6 : constant Fixed_2_30 := -0.0142718282624;

    B1 : constant Fixed_2_30 := -1.11067032264;
    B3 : constant Fixed_2_30 :=  0.4561589075945;
    B5 : constant Fixed_2_30 := -0.0539104694791;

    X2 : constant Fixed_2_30 := X  * X;
    X3 : constant Fixed_2_30 := X2 * X;
    X4 : constant Fixed_2_30 := X2 * X2;
    X5 : constant Fixed_2_30 := X3 * X2;
    X6 : constant Fixed_2_30 := X3 * X3;

    A  : constant Fixed_2_30 := A0 + (A2 * X2) + (A4 * X4) + (A6 * X6);
    B  : constant Fixed_2_30 := (B1 * X) + (B3 * X3) + (B5 * X5);

  begin
    Sin := A - B;
    Cos := A + B;
  end;

  procedure Sin_Cos (Theta : Radians_32; Sin, Cos : out Fixed_Snorm_32) is

    type Unsigned_2 is mod 4;

    function Cast is new Ada.Unchecked_Conversion (Radians_32, Unsigned_32);

    Quadrant         : Unsigned_2 := Unsigned_2'Mod (Shift_Right (Cast (Theta), 30));
    Normalized_Theta : Fixed_2_30 := Fixed_2_30'Fixed_Value (Cast (Theta) mod 2**30);

    S, C : Fixed_Snorm_32;
  begin
    Sin_Cos_Quadrant (Normalized_Theta - 0.5, S, C);
    case Quadrant is
    when 0 =>
      Sin :=  S; Cos :=  C;
    when 1 =>
      Sin :=  C; Cos := -S;
    when 2 =>
      Sin := -S; Cos := -C;
    when 3 =>
      Sin := -C; Cos :=  S;
    end case;
  end;


  function Sin (Theta : Radians_32) return Fixed_Snorm_32 is
    S, C : Fixed_Snorm_32;
  begin
    Sin_Cos (Theta, S, C);
    return S;
  end;


  function Cos (Theta : Radians_32) return Fixed_Snorm_32 is
    S, C : Fixed_Snorm_32;
  begin
    Sin_Cos (Theta, S, C);
    return C;
  end;


  function Sin_LUT (Theta : Radians_16) return Fixed_Snorm_16 is

    type Unsigned_2 is mod 2**2;

    type Decomposition is
      record
        Index  : Unsigned_8;
        Interp : Fixed_Unorm_8;
      end record;

    for Decomposition use
      record
        Index    at 0 range 8  .. 15;
        Interp   at 0 range 0  .. 7;
      end record;

    function Cast is new Ada.Unchecked_Conversion (Radians_16, Decomposition);

    LUT_Values : constant array (Unsigned_8 range 0 .. 64) of Fixed_Snorm_16 :=
      ( 0.0,                 0.024541228522912288, 0.049067674327418015, 0.07356456359966743
      , 0.0980171403295606,  0.1224106751992162,   0.14673047445536175,  0.17096188876030122
      , 0.19509032201612825, 0.2191012401568698,   0.24298017990326387,  0.26671275747489837
      , 0.29028467725446233, 0.3136817403988915,   0.33688985339222005,  0.3598950365349881
      , 0.3826834323650898,  0.40524131400498986,  0.4275550934302821,   0.44961132965460654
      , 0.47139673682599764, 0.49289819222978404,  0.5141027441932217,   0.5349976198870972
      , 0.5555702330196022,  0.5758081914178453,   0.5956993044924334,   0.6152315905806268
      , 0.6343932841636455,  0.6531728429537768,   0.6715589548470183,   0.6895405447370668
      , 0.7071067811865475,  0.7242470829514669,   0.7409511253549591,   0.7572088465064845
      , 0.773010453362737,   0.7883464276266062,   0.8032075314806448,   0.8175848131515837
      , 0.8314696123025452,  0.844853565249707,    0.8577286100002721,   0.8700869911087113
      , 0.8819212643483549,  0.8932243011955153,   0.9039892931234433,   0.9142097557035307
      , 0.9238795325112867,  0.9329927988347388,   0.9415440651830208,   0.9495281805930367
      , 0.9569403357322089,  0.9637760657954398,   0.970031253194544,    0.9757021300385286
      , 0.9807852804032304,  0.9852776423889412,   0.989176509964781,    0.99247953459871
      , 0.9951847266721968,  0.9972904566786902,   0.9987954562051724,   0.9996988186962042
      , 1.0
      );

    function Lookup (Index : Unsigned_8) return Fixed_Snorm_16
      with Pure_Function, Inline is
      Quadrant  : Unsigned_2 := Unsigned_2'Mod (Shift_Right (Index, 6));
      LUT_Index : Unsigned_8 := Index mod 64;
    begin
      return (case Quadrant is
        when 0 =>   LUT_Values (     LUT_Index),
        when 1 =>   LUT_Values (64 - LUT_Index),
        when 2 => - LUT_Values (     LUT_Index),
        when 3 => - LUT_Values (64 - LUT_Index));
    end;

    D  : constant Decomposition  := Cast (Theta);
    V0 : constant Fixed_Snorm_16 := Lookup (D.Index);
    V1 : constant Fixed_Snorm_16 := Lookup (D.Index + 1);

  begin
    return (D.Interp * V1) - (D.Interp * V0) + V0;
  end Sin_LUT;

  function Cos_LUT (Theta : Radians_16) return Fixed_Snorm_16 is
    ( Sin_LUT (Theta + (1.0/4.0)) );

  procedure Sin_Cos_LUT (Theta : Radians_16; Sin, Cos : out Fixed_Snorm_16) is
  begin
    Sin := Sin_LUT (Theta);
    Cos := Cos_LUT (Theta);
  end;

end GBA.Numerics;