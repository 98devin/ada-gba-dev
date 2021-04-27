
package body GBA.Numerics.Matrices is

  use all type V.Element;
  use all type V.Vec;

  function Pointwise (N, M : Mat) return Mat is
  begin
    return
      ( 0 => ( 0 => Operator (N (0, 0), M (0, 0))
             , 1 => Operator (N (0, 1), M (0, 1))
             )
      , 1 => ( 0 => Operator (N (1, 0), M (1, 0))
             , 1 => Operator (N (1, 1), M (1, 1))
             )
      );
  end;

  function Scalar (M : Mat; E : Element) return Mat is
  begin
    return
      ( 0 => ( 0 => Operator (M (0, 0), E)
             , 1 => Operator (M (0, 1), E)
             )
      , 1 => ( 0 => Operator (M (1, 0), E)
             , 1 => Operator (M (1, 1), E)
             )
      );
  end;

  function To_Affine_Transform (M : Mat)
    return Affine_Transform_Matrix is
  begin
    return
      ( DX  => Affine_Transform_Parameter (M (0, 0))
      , DMX => Affine_Transform_Parameter (M (0, 1))
      , DY  => Affine_Transform_Parameter (M (1, 0))
      , DMY => Affine_Transform_Parameter (M (1, 1))
      );
  end;


  function EMul (X, Y : Element) return Element is
    ( X * Y ) with Inline_Always;

  function EDiv (X, Y : Element) return Element is
    ( X / Y ) with Inline_Always;

  function MAdd is new Pointwise ("+");
  function MSub is new Pointwise ("-");
  function MMul is new Pointwise (EMul);
  function MDiv is new Pointwise (EDiv);

  function MAdd is new Scalar ("+");
  function MSub is new Scalar ("-");
  function MMul is new Scalar (EMul);
  function MDiv is new Scalar (EDiv);

  function "+" (M, N : Mat) return Mat
    renames MAdd;
  function "-" (M, N : Mat) return Mat
    renames MSub;
  function "*" (M, N : Mat) return Mat
    renames MMul;
  function "/" (M, N : Mat) return Mat
    renames MDiv;

  function "+" (M : Mat;  E : Element) return Mat
    renames MAdd;
  function "-" (M : Mat;  E : Element) return Mat
    renames MSub;
  function "*" (M : Mat;  E : Element) return Mat
    renames MMul;
  function "/" (M : Mat;  E : Element) return Mat
    renames MDiv;


  function From_Cols (C0, C1 : Vec) return Mat is
  begin
    return
      ( 0 => (C0 (0), C1 (0))
      , 1 => (C0 (1), C1 (1))
      );
  end;

  function From_Rows (R0, R1 : Vec) return Mat is
  begin
    return
      ( 0 => (R0 (0), R0 (1))
      , 1 => (R1 (0), R1 (1))
      );
  end;

  function Col (M : Mat; C : Dim) return Vec is
  begin
    return (M (0, C), M (1, C));
  end;

  function Row (M : Mat; R : Dim) return Vec is
  begin
    return (M (R, 0), M (R, 1));
  end;

  function Mul (M : Mat; V : Vec) return Vec is
  begin
    return
      ( 0 => Dot (V, Row (M, 0))
      , 1 => Dot (V, Row (M, 1))
      );
  end;

  function Mul (M, N : Mat) return Mat is
  begin
    return From_Cols
      ( Mul (M, Col (N, 0))
      , Mul (M, Col (N, 1))
      );
  end;

  function Determinant (M : Mat) return Element is
  begin
    return (M (0, 0) * M (1, 1)) - (M (0, 1) * M (1, 0));
  end;

  function Inverse (M : Mat) return Mat is
    N : Mat :=
      ( (   M (1, 1), - M (0, 1) )
      , ( - M (1, 0),   M (0, 0) )
      );
  begin
    return N / Determinant (M);
  end;

end GBA.Numerics.Matrices;