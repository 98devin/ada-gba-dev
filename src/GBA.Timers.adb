-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


package body GBA.Timers is

  function Get_Count (ID : Timer_ID) return Timer_Value is
    ( Timers (ID).Value );

  procedure Set_Initial_Value (ID : Timer_ID; Value : Timer_Value) is
  begin
    Timers (ID).Value := Value;
  end Set_Initial_Value;

  procedure Start_Timer (ID : Timer_ID) is
    Control : Timer_Control_Info renames Timers (ID).Control_Info;
  begin
    Control.Enabled := False;
    Control.Enabled := True;
  end Start_Timer;

  procedure Set_Timer_Scale (ID : Timer_ID; Scale : Timer_Scale) is
  begin
    Timers (ID).Control_Info.Scale := Scale;
  end Set_Timer_Scale;

  procedure Set_Timer_Increment_Type (ID : Timer_ID; Increment : Timer_Increment_Type) is
  begin
    Timers (ID).Control_Info.Increment := Increment;
  end Set_Timer_Increment_Type;

end GBA.Timers;