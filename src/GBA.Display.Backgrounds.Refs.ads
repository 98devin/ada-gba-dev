-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.



limited with GBA.Refs;

package GBA.Display.Backgrounds.Refs is

  type BG_Ref (<>) is abstract tagged limited private;

  function ID (This : BG_Ref'Class) return BG_ID
    with Inline;

  function Priority (This : BG_Ref'Class) return Display_Priority
    with Inline;

  function Mosaic_Enabled (This : BG_Ref'Class) return Boolean
    with Inline;

  procedure Set_Priority
    (This : in out BG_Ref'Class; Priority : Display_Priority);

  procedure Enable_Mosaic
    (This : in out BG_Ref'Class; Enable : Boolean := True);

  generic
    with procedure Update (Control : in out BG_Control_Info);
  procedure Update_Control_Info (This : in out BG_Ref'Class);



  type Reg_BG_Ref (<>) is new BG_Ref with private;

  function Offset (This : Reg_BG_Ref'Class) return BG_Offset_Info
    with Inline;

  procedure Set_Offset
    (This : in out Reg_BG_Ref'Class; Offset : BG_Offset_Info);

  procedure Set_Offset
    (This : in out Reg_BG_Ref'Class; X, Y : BG_Scroll_Offset)
    with Inline_Always;

  procedure Set_Offset_X
    (This : in out Reg_BG_Ref'Class; Value : BG_Scroll_Offset);

  procedure Set_Offset_Y
    (This : in out Reg_BG_Ref'Class; Value : BG_Scroll_Offset);

  procedure Move_Offset
    (This : in out Reg_BG_Ref'Class; DX, DY : BG_Scroll_Offset := 0);

  generic
    with procedure Update (Offset : in out BG_Offset_Info);
  procedure Update_Offset (This : in out Reg_BG_Ref'Class);



  type Aff_BG_Ref (<>) is new BG_Ref with private;

  function Transform (This : Aff_BG_Ref'Class)
    return Affine_Transform_Matrix with Inline;

  function Reference_Point (This : Aff_BG_Ref'Class)
    return BG_Reference_Point with Inline;

  procedure Set_Reference_Point
    (This            : in out Aff_BG_Ref'Class;
     Reference_Point : BG_Reference_Point);

  procedure Set_Reference_Point
    (This : in out Aff_BG_Ref'Class; X, Y : BG_Reference_Point_Coordinate);

  procedure Set_Reference_X
    (This : in out Aff_BG_Ref'Class; Value : BG_Reference_Point_Coordinate);

  procedure Set_Reference_Y
    (This : in out Aff_BG_Ref'Class; Value : BG_Reference_Point_Coordinate);

  procedure Move_Reference_Point
    (This : in out Aff_BG_Ref'Class; DX, DY : BG_Reference_Point_Coordinate := 0.0);

  generic
    with procedure Update (Transform : in out BG_Transform_Info);
  procedure Update_Transform (This : in out Aff_BG_Ref'Class);

private

  type Volatile_BG_Control_Info is
    new BG_Control_Info with Volatile;

  type BG_Ref (Control : access Volatile_BG_Control_Info) is
    tagged limited record
      ID : BG_ID;
    end record;

  type Reg_BG_Ref is new BG_Ref with
    record
      Offset : BG_Offset_Info;
    end record;

  type Aff_BG_Ref is new BG_Ref with
    record
      Transform_Info : BG_Transform_Info;
    end record;

end GBA.Display.Backgrounds.Refs;