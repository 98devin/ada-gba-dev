-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


with Interfaces;
use  Interfaces;


package GBA.Display.Windows is

  subtype Toggleable_Window_Element is
    Toggleable_Display_Element range Background_0 .. Object_Sprites;

  type Window_Horizontal_Dimensions is
    record
      Left_Bound, Right_Bound : Unsigned_8 range 0 .. 240;
    end record
      with Size => 16;

  for Window_Horizontal_Dimensions use
    record
      Right_Bound at 0 range 0 .. 7;
      Left_Bound  at 1 range 0 .. 7;
    end record;


  type Window_Vertical_Dimensions is
    record
      Upper_Bound, Lower_Bound : Unsigned_8 range 0 .. 160;
    end record
      with Size => 16;

  for Window_Vertical_Dimensions use
    record
      Lower_Bound at 0 range 0 .. 7;
      Upper_Bound at 1 range 0 .. 7;
    end record;


  type Window_Display_Control_Info is
    record
      Displayed_Elements  : Displayed_Element_Flags (Toggleable_Window_Element);
      Enable_Color_Effect : Boolean;
    end record
      with Size => 8;

  for Window_Display_Control_Info use
    record
      Displayed_Elements  at 0 range 0 .. 4;
      Enable_Color_Effect at 0 range 5 .. 5;
    end record;


  type Window_Region is
    ( Window_0
    , Window_1
    , Outside_Windows
    , Object_Window
    );

  subtype Rectangular_Window_Region is
    Window_Region range Window_0 .. Window_1;

  subtype Irregular_Window_Region is
    Window_Region range Outside_Windows .. Object_Window;


  Horizontal_Dimensions : array (Rectangular_Window_Region) of Window_Horizontal_Dimensions
    with Import, Volatile_Components, Address => WIN0H;

  Vertical_Dimensions   : array (Rectangular_Window_Region) of Window_Vertical_Dimensions
    with Import, Volatile_Components, Address => WIN0V;

  Window_Control : array (Window_Region) of Window_Display_Control_Info
    with Import, Volatile, Address => WININ;

end GBA.Display.Windows;