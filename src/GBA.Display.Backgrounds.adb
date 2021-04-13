
package body GBA.Display.Backgrounds is

  procedure Set_Vertical_Offset (BG : BG_ID; Offset : BG_Scroll_Offset) is
  begin
    BG_Offsets(BG).Vertical := Offset;
  end;

  procedure Set_Horizontal_Offset (BG : BG_ID; Offset : BG_Scroll_Offset) is
  begin
    BG_Offsets(BG).Horizontal := Offset;
  end;

  procedure Set_Offsets (BG : BG_ID; Horizontal, Vertical : BG_Scroll_Offset) is
  begin
    BG_Offsets(BG) := (Horizontal => Horizontal, Vertical => Vertical);
  end;

  procedure Set_Offsets (BG : BG_ID; Offsets : BG_Offset_Info) is
  begin
    BG_Offsets(BG) := Offsets;
  end;


  procedure Set_Reference_Point (BG : Affine_BG_ID; Reference_Point : BG_Reference_Point) is
  begin
    BG_Transforms(BG).Reference_Point := Reference_Point;
  end;

  procedure Set_Affine_Matrix (BG : Affine_BG_ID; Matrix : BG_Transform_Matrix) is
  begin
    BG_Transforms(BG).Affine_Matrix := Matrix;
  end;

  procedure Set_Transform (BG : Affine_BG_ID; Transform : BG_Transform_Info) is
  begin
    BG_Transforms(BG) := Transform;
  end;

end GBA.Display.Backgrounds;