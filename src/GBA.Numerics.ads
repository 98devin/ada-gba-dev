
with Interfaces;
use  Interfaces;

package GBA.Numerics is

  Pi : constant :=
    3.14159_26535_89793_23846_26433_83279_50288_41971_69399_37511;

  e : constant :=
    2.71828_18284_59045_23536_02874_71352_66249_77572_47093_69996;

  type Fixed_2_14 is
    delta 2.0**(-14) range -1.0 .. 1.0
    with Size => 16;

  type Fixed_20_8 is
    delta 2.0**(-8) range -2.0**19 .. 2.0**19
    with Size => 32;

  type Fixed_8_8 is
    delta 2.0**(-8) range -2.0**7 .. 2.0**7 - 2.0**(-8)
    with Size => 16;

  type Radians_16 is
    delta (2.0*Pi) / (2.0**(-16)) range 0.0 .. 2.0*Pi
    with Size => 16;


  function Count_Trailing_Zeros (I : Integer) return Natural
    with Linker_Section => ".iwram";

  function Count_Trailing_Zeros (I : Integer_16) return Natural
    with Linker_Section => ".iwram";

  pragma Machine_Attribute (Count_Trailing_Zeros, "target", "arm");

end GBA.Numerics;