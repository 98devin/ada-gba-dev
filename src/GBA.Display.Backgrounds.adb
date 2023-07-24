-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


package body GBA.Display.Backgrounds is

  procedure Set_Offset_X (BG : BG_ID; Value : BG_Scroll_Offset) is
  begin
    BG_Offsets (BG).X := Value;
  end;

  procedure Set_Offset_Y (BG : BG_ID; Value : BG_Scroll_Offset) is
  begin
    BG_Offsets (BG).Y := Value;
  end;

  procedure Set_Offset (BG : BG_ID; X, Y : BG_Scroll_Offset) is
  begin
    BG_Offsets (BG) := (X => X, Y => Y);
  end;

  procedure Set_Offset (BG : BG_ID; Offsets : BG_Offset_Info) is
  begin
    BG_Offsets (BG) := Offsets;
  end;


  function Affine_Transform_Address (ID : Affine_BG_ID) return Address is
    ( BG_Transforms (ID)'Address );

  procedure Set_Reference_X (BG : Affine_BG_ID; Value : BG_Reference_Point_Coordinate) is
  begin
    BG_Transforms (BG).Reference_Point.X := Value;
  end;

  procedure Set_Reference_Y (BG : Affine_BG_ID; Value : BG_Reference_Point_Coordinate) is
  begin
    BG_Transforms (BG).Reference_Point.Y := Value;
  end;

  procedure Set_Reference_Point (BG : Affine_BG_ID; X, Y : BG_Reference_Point_Coordinate) is
  begin
    BG_Transforms (BG).Reference_Point := (X => X, Y => Y);
  end;

  procedure Set_Reference_Point (BG : Affine_BG_ID; Reference_Point : BG_Reference_Point) is
  begin
    BG_Transforms (BG).Reference_Point := Reference_Point;
  end;

  procedure Set_Affine_Matrix (BG : Affine_BG_ID; Matrix : Affine_Transform_Matrix) is
  begin
    BG_Transforms (BG).Affine_Matrix := Matrix;
  end;

  procedure Set_Transform (BG : Affine_BG_ID; Transform : BG_Transform_Info) is
  begin
    BG_Transforms (BG) := Transform;
  end;

end GBA.Display.Backgrounds;