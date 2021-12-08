-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.Display.Backgrounds;
use  GBA.Display.Backgrounds;

with Interfaces;
use  Interfaces;


package GBA.Handles.Backgrounds is

  type BG_Ref is interface;

  function Kind (BG : BG_Ref) return BG_Kind is abstract;

  function Vertical_Offset (BG : BG_Ref) return

  procedure Set_Vertical_Offset   (BG : BG_Ref; Offset : BG_Scroll_Offset) is abstract;
  procedure Set_Horizontal_Offset (BG : BG_Ref; Offset : BG_Scroll_Offset) is abstract;

  procedure Set_Offsets (BG : BG_Ref; Offsets : BG_Offset_Info) is abstract;
  procedure Set_Offsets (BG : BG_Ref; Horizontal, Vertical : BG_Scroll_Offset) is abstract;

  procedure Shift_Vertical   (BG : BG_Ref; Offset : Integer_16) is abstract;
  procedure Shift_Horizontal (BG : BG_Ref; Offset : Integer_16) is abstract;
  procedure Shift (BG : BG_Ref; Vertical, Horizontal : Integer_16 := 0) is abstract;

end GBA.Handles.Backgrounds;