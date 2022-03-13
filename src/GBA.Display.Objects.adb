-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with Ada.Unchecked_Conversion;

with System;
use type System.Address;

package body GBA.Display.Objects is

  type Shape_Scale is
    record
      Scale : OBJ_Scale;
      Shape : OBJ_Shape;
    end record
      with Size => 4;

  for Shape_Scale use
    record
      Scale at 0 range 0 .. 1;
      Shape at 0 range 2 .. 3;
    end record;

  function Cast is new Ada.Unchecked_Conversion (Shape_Scale, OBJ_Size);
  function Cast is new Ada.Unchecked_Conversion (OBJ_Size, Shape_Scale);


  function As_Size (Shape : OBJ_Shape; Scale : OBJ_Scale) return OBJ_Size is
    Shape_And_Scale : Shape_Scale := (Shape => Shape, Scale => Scale);
  begin
    return Cast (Shape_And_Scale);
  end;

  procedure As_Shape_And_Scale (Size : OBJ_Size; Shape : out OBJ_Shape; Scale : out OBJ_Scale) is
    Shape_And_Scale : Shape_Scale := Cast (Size);
  begin
    Shape := Shape_And_Scale.Shape;
    Scale := Shape_And_Scale.Scale;
  end;

  function Affine_Transform_Address (Ix : OBJ_Affine_Transform_Index) return Address is
    ( OAM_Address'First + 6 + 32 * Address (Ix) );

end GBA.Display.Objects;