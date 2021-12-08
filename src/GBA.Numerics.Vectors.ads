-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


generic
  type Element is delta <>;
package GBA.Numerics.Vectors is

  subtype Dim is Integer range 0 .. 1;

  type Vec is array (Dim) of Element;

  generic
    with function Operator (X, Y : Element) return Element;
  function Pointwise (V, W : Vec) return Vec;

  generic
    with function Operator (X, Y : Element) return Element;
  function Scalar (V : Vec; E : Element) return Vec;


  function "+" (V, W : Vec) return Vec
    with Pure_Function, Inline;

  function "-" (V, W : Vec) return Vec
    with Pure_Function, Inline;

  function "*" (V, W : Vec) return Vec
    with Pure_Function, Inline;

  function "/" (V, W : Vec) return Vec
    with Pure_Function, Inline;

  function "+" (V : Vec;  E : Element) return Vec
    with Pure_Function, Inline;

  function "-" (V : Vec;  E : Element) return Vec
    with Pure_Function, Inline;

  function "*" (V : Vec;  E : Element) return Vec
    with Pure_Function, Inline;

  function "/" (V : Vec;  E : Element) return Vec
    with Pure_Function, Inline;

  function Dot (V, W : Vec) return Element
    with Pure_Function, Inline;

end GBA.Numerics.Vectors;