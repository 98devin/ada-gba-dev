
with Interfaces;
use  Interfaces;

package GBA.Numerics is

  Pi : constant :=
    3.14159_26535_89793_23846_26433_83279_50288_41971_69399_37511;

  e : constant :=
    2.71828_18284_59045_23536_02874_71352_66249_77572_47093_69996;

  type Fixed_2_14 is
    delta 2.0**(-14) range -2.0 .. 2.0 - 2.0**(-14)
      with Size => 16;

  type Fixed_20_8 is
    delta 2.0**(-8) range -2.0**19 .. 2.0**19
      with Size => 32;

  type Fixed_8_8 is
    delta 2.0**(-8) range -2.0**7 .. 2.0**7 - 2.0**(-8)
      with Size => 16;

  type Fixed_2_30 is
    delta 2.0**(-30) range -2.0 .. 2.0 - 2.0**(-30)
      with Size => 32;

  type Fixed_Unorm_8 is
    delta 2.0**(-8) range 0.0 .. 1.0 - 2.0**(-8)
      with Size => 8;

  type Fixed_Unorm_16 is
    delta 2.0**(-16) range 0.0 .. 1.0 - 2.0**(-16)
      with Size => 16;

  type Fixed_Unorm_32 is
    delta 2.0**(-32) range 0.0 .. 1.0 - 2.0**(-32)
      with Size => 32;

  subtype Fixed_Snorm_16 is
    Fixed_2_14 range -1.0 .. 1.0;

  subtype Fixed_Snorm_32 is
    Fixed_2_30 range -1.0 .. 1.0;


  -- Consider this to have an implicit unit of 2*Pi.
  -- Additive operators are defined to be cyclic.
  type Radians_16 is new Fixed_Unorm_16;

  overriding
  function "+" (X, Y : Radians_16) return Radians_16
    with Pure_Function, Inline_Always;

  overriding
  function "-" (X, Y : Radians_16) return Radians_16
    with Pure_Function, Inline_Always;


  -- Consider this to have an implicit unit of 2*Pi.
  -- Additive operators are defined to be cyclic.
  type Radians_32 is new Fixed_Unorm_32;

  overriding
  function "+" (X, Y : Radians_32) return Radians_32
    with Pure_Function, Inline_Always;

  overriding
  function "-" (X, Y : Radians_32) return Radians_32
    with Pure_Function, Inline_Always;



  function Sin (Theta : Radians_32) return Fixed_Snorm_32
    with Pure_Function, Inline_Always;

  function Cos (Theta : Radians_32) return Fixed_Snorm_32
    with Pure_Function, Inline_Always;

  procedure Sin_Cos (Theta : Radians_32; Sin, Cos : out Fixed_Snorm_32)
    with Linker_Section => ".iwram.sin_cos";

  pragma Machine_Attribute (Sin_Cos, "target", "arm");


  function Sin_LUT (Theta : Radians_16) return Fixed_Snorm_16
    with Pure_Function, Linker_Section => ".iwram.sin_lut";

  function Cos_LUT (Theta : Radians_16) return Fixed_Snorm_16
    with Pure_Function, Inline_Always;

  procedure Sin_Cos_LUT (Theta : Radians_16; Sin, Cos : out Fixed_Snorm_16)
    with Inline_Always;

  pragma Machine_Attribute (Sin_LUT, "target", "arm");



  function Count_Trailing_Zeros (I : Long_Long_Integer) return Natural
    with Pure_Function, Inline_Always;

  function Count_Trailing_Zeros (I : Unsigned_64) return Natural
    with Pure_Function, Linker_Section => ".iwram.ctz64";

  pragma Machine_Attribute (Count_Trailing_Zeros, "target", "arm");


  function Count_Trailing_Zeros (I : Integer) return Natural
    with Pure_Function, Inline_Always;

  function Count_Trailing_Zeros (I : Unsigned_32) return Natural
    with Pure_Function, Linker_Section => ".iwram.ctz";

  pragma Machine_Attribute (Count_Trailing_Zeros, "target", "arm");


  function Count_Trailing_Zeros (I : Integer_16) return Natural
    with Pure_Function, Inline_Always;

  function Count_Trailing_Zeros (I : Unsigned_16) return Natural
    with Pure_Function, Linker_Section => ".iwram.ctz16";

  pragma Machine_Attribute (Count_Trailing_Zeros, "target", "arm");



  function Count_Leading_Zeros (I : Long_Long_Integer) return Natural
    with Pure_Function, Inline_Always;

  function Count_Leading_Zeros (I : Unsigned_64) return Natural
    with Pure_Function, Linker_Section => ".iwram.clz64";

  pragma Machine_Attribute (Count_Leading_Zeros, "target", "arm");


  function Count_Leading_Zeros (I : Integer) return Natural
    with Pure_Function, Inline_Always;

  function Count_Leading_Zeros (I : Unsigned_32) return Natural
    with Pure_Function, Linker_Section => ".iwram.clz";

  pragma Machine_Attribute (Count_Leading_Zeros, "target", "arm");


  function Count_Leading_Zeros (I : Integer_16) return Natural
    with Pure_Function, Inline_Always;

  function Count_Leading_Zeros (I : Unsigned_16) return Natural
    with Pure_Function, Linker_Section => ".iwram.clz16";

  pragma Machine_Attribute (Count_Leading_Zeros, "target", "arm");


private

  -- Private functions so that they will not override any other definitions
  -- (e.g. BIOS routines, if you prefer those for some reason).
  -- They are callable via standard operators, since they overwrite the defaults.

  function Div_Mod (N, D : Integer) return Long_Long_Integer
    with Pure_Function, Inline, Linker_Section => ".iwram.idivmod",
         Export, External_Name => "__aeabi_idivmod";

  pragma Machine_Attribute (Div_Mod, "target", "arm");


  function Div_Mod (N, D : Unsigned_32) return Long_Long_Integer
    with Pure_Function, Inline, Linker_Section => ".iwram.uidivmod",
         Export, External_Name => "__aeabi_uidivmod";

  pragma Machine_Attribute (Div_Mod, "target", "arm");


  function Divide (N, D : Integer) return Integer
    with Pure_Function, Inline, Linker_Section => ".iwram.idiv",
         Export, External_Name => "__aeabi_idiv";

  pragma Machine_Attribute (Divide, "target", "arm");


  function Divide (N, D : Unsigned_32) return Unsigned_32
    with Pure_Function, Inline, Linker_Section => ".iwram.uidiv",
         Export, External_Name => "__aeabi_uidiv";

  pragma Machine_Attribute (Divide, "target", "arm");

end GBA.Numerics;