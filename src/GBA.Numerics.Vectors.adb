-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


package body GBA.Numerics.Vectors is

  function Pointwise (V, W : Vec) return Vec is
  begin
    return
      ( 0 => Operator (V (0), W (0))
      , 1 => Operator (V (1), W (1))
      );
  end;

  function Scalar (V : Vec; E : Element) return Vec is
  begin
    return
      ( 0 => Operator (V (0), E)
      , 1 => Operator (V (1), E)
      );
  end;


  function EMul (X, Y : Element) return Element is
    ( X * Y ) with Inline_Always;

  function EDiv (X, Y : Element) return Element is
    ( X / Y ) with Inline_Always;

  function VAdd is new Pointwise ("+");
  function VSub is new Pointwise ("-");
  function VMul is new Pointwise (EMul);
  function VDiv is new Pointwise (EDiv);

  function VAdd is new Scalar ("+");
  function VSub is new Scalar ("-");
  function VMul is new Scalar (EMul);
  function VDiv is new Scalar (EDiv);

  function "+" (V, W : Vec) return Vec
    renames VAdd;
  function "-" (V, W : Vec) return Vec
    renames VSub;
  function "*" (V, W : Vec) return Vec
    renames VMul;
  function "/" (V, W : Vec) return Vec
    renames VDiv;

  function "+" (V : Vec;  E : Element) return Vec
    renames VAdd;
  function "-" (V : Vec;  E : Element) return Vec
    renames VSub;
  function "*" (V : Vec;  E : Element) return Vec
    renames VMul;
  function "/" (V : Vec;  E : Element) return Vec
    renames VDiv;

  function Dot (V, W : Vec) return Element is
  begin
    return Vec'(V * W)'Reduce ("+", 0.0);
  end;

end GBA.Numerics.Vectors;