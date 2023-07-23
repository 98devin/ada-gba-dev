-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.Numerics.Vectors;

generic
  with package V is new GBA.Numerics.Vectors(<>);

package GBA.Numerics.Matrices is

  subtype Dim     is V.Dim;
  subtype Vec     is V.Vec;
  subtype Element is V.Element;

  type Mat is array (Dim, Dim) of Element;

  function From_Cols (C0, C1 : Vec) return Mat
    with Pure_Function, Inline;

  function From_Rows (R0, R1 : Vec) return Mat
    with Pure_Function, Inline;

  function Col (M : Mat; C : Dim) return Vec
    with Pure_Function, Inline;

  function Row (M : Mat; R : Dim) return Vec
    with Pure_Function, Inline;

  function To_Affine_Transform (M : Mat)
    return Affine_Transform_Matrix
      with Pure_Function, Inline;


  generic
    with function Operator (X, Y : Element) return Element;
  function Pointwise (N, M : Mat) return Mat;

  generic
    with function Operator (X, Y : Element) return Element;
  function Scalar (M : Mat; E : Element) return Mat;


  function "+" (M, N : Mat) return Mat
    with Pure_Function, Inline;

  function "-" (M, N : Mat) return Mat
    with Pure_Function, Inline;

  function "*" (M, N : Mat) return Mat
    with Pure_Function, Inline;

  function "/" (M, N : Mat) return Mat
    with Pure_Function, Inline;

  function "+" (M : Mat;  E : Element) return Mat
    with Pure_Function, Inline;

  function "-" (M : Mat;  E : Element) return Mat
    with Pure_Function, Inline;

  function "*" (M : Mat;  E : Element) return Mat
    with Pure_Function, Inline;

  function "/" (M : Mat;  E : Element) return Mat
    with Pure_Function, Inline;

  function Mul (M, N : Mat) return Mat
    with Pure_Function, Inline;

  function Mul (M : Mat; V : Vec) return Vec
    with Pure_Function, Inline;

  function Determinant (M : Mat) return Element
    with Pure_Function, Inline;

  function Inverse (M : Mat) return Mat
    with Pure_Function, Inline;

end GBA.Numerics.Matrices;
