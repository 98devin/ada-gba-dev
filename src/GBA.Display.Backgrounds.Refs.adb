-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


package body GBA.Display.Backgrounds.Refs is

  function ID (This : BG_Ref'Class) return BG_ID is
    ( This.ID );

  function Priority (This : BG_Ref'Class) return Display_Priority is
    ( This.Control.Priority );

  function Mosaic_Enabled (This : BG_Ref'Class) return Boolean is
    ( This.Control.Enable_Mosaic );

  procedure Set_Priority
    (This : in out BG_Ref'Class; Priority : Display_Priority) is
  begin
    This.Control.Priority := Priority;
  end;

  procedure Enable_Mosaic
    (This : in out BG_Ref'Class; Enable : Boolean := True) is
  begin
    This.Control.Enable_Mosaic := Enable;
  end;

  procedure Update_Control_Info (This : in out BG_Ref'Class) is
  begin
    Update (BG_Control_Info (This.Control.all));
  end;



  procedure Refresh_Offset_Register (This : in out Reg_BG_Ref'Class)
    with Inline_Always is
  begin
    Set_Offset (This.ID, This.Offset);
  end;

  function Offset (This : Reg_BG_Ref'Class) return BG_Offset_Info is
    ( This.Offset );

  procedure Set_Offset
    ( This : in out Reg_BG_Ref'Class; Offset : BG_Offset_Info ) is
  begin
    This.Offset := Offset;
    Refresh_Offset_Register (This);
  end;

  procedure Set_Offset
    ( This : in out Reg_BG_Ref'Class; X, Y : BG_Scroll_Offset ) is
  begin
    This.Offset := (X => X, Y => Y);
    Refresh_Offset_Register (This);
  end;

  procedure Set_Offset_X
    (This : in out Reg_BG_Ref'Class; Value : BG_Scroll_Offset) is
  begin
    This.Offset.X := Value;
    Refresh_Offset_Register (This);
  end;

  procedure Set_Offset_Y
    (This : in out Reg_BG_Ref'Class; Value : BG_Scroll_Offset) is
  begin
    This.Offset.Y := Value;
    Refresh_Offset_Register (This);
  end;


  procedure Move_Offset
    (This : in out Reg_BG_Ref'Class; DX, DY : BG_Scroll_Offset := 0) is
  begin
    This.Offset :=
      ( X => This.Offset.X + DX
      , Y => This.Offset.Y + DY
      );
    Refresh_Offset_Register (This);
  end;

  procedure Update_Offset (This : in out Reg_BG_Ref'Class) is
  begin
    Update (This.Offset);
    Refresh_Offset_Register (This);
  end;


  procedure Refresh_Transform_Info (This : Aff_BG_Ref'Class)
    with Inline_Always is
  begin
    Set_Transform (This.ID, This.Transform_Info);
  end;

  procedure Refresh_Affine_Matrix (This : Aff_BG_Ref'Class)
    with Inline_Always is
  begin
    Set_Affine_Matrix (This.ID, This.Transform_Info.Affine_Matrix);
  end;

  procedure Refresh_Reference_Point (This : Aff_BG_Ref'Class)
    with Inline_Always is
  begin
    Set_Reference_Point (This.ID, This.Transform_Info.Reference_Point);
  end;

  function Transform (This : Aff_BG_Ref'Class)
    return Affine_Transform_Matrix is
  begin
    return This.Transform_Info.Affine_Matrix;
  end;

  function Reference_Point (This : Aff_BG_Ref'Class)
    return BG_Reference_Point is
  begin
    return This.Transform_Info.Reference_Point;
  end;

  procedure Set_Reference_Point
    (This            : in out Aff_BG_Ref'Class;
     Reference_Point : BG_Reference_Point) is
  begin
    This.Transform_Info.Reference_Point := Reference_Point;
    Refresh_Reference_Point (This);
  end;

  procedure Set_Reference_Point
    (This : in out Aff_BG_Ref'Class; X, Y : BG_Reference_Point_Coordinate) is
  begin
    This.Transform_Info.Reference_Point := (X => X, Y => Y);
    Refresh_Reference_Point (This);
  end;

  procedure Set_Reference_X
    (This : in out Aff_BG_Ref'Class; Value : BG_Reference_Point_Coordinate) is
  begin
    This.Transform_Info.Reference_Point.X := Value;
    Set_Reference_X (This.ID, Value);
  end;

  procedure Set_Reference_Y
    (This : in out Aff_BG_Ref'Class; Value : BG_Reference_Point_Coordinate) is
  begin
    This.Transform_Info.Reference_Point.Y := Value;
    Set_Reference_Y (This.ID, Value);
  end;

  procedure Move_Reference_Point
    (This : in out Aff_BG_Ref'Class; DX, DY : BG_Reference_Point_Coordinate := 0.0) is
    RP : BG_Reference_Point renames This.Transform_Info.Reference_Point;
  begin
    RP := (X => RP.X + DX, Y => RP.Y + DY);
    Refresh_Reference_Point (This);
  end;

  procedure Update_Transform (This : in out Aff_BG_Ref'Class) is
  begin
    Update (This.Transform_Info);
    Refresh_Transform_Info (This);
  end;


end GBA.Display.Backgrounds.Refs;