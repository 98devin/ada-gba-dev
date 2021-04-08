
package body GBA.Display is
  
  procedure Set_Display_Mode (Mode : Video_Mode; Forced_Blank : Boolean := False) is
  begin
    Display_Control := Display_Control'Update
      ( Mode         => Mode
      , Forced_Blank => Forced_Blank
      );
  end;
    
  procedure Enable_Display_Element
    (Element : Toggleable_Display_Element; Enable : Boolean := True) is
  begin
    Display_Control.Displayed_Elements(Element) := Enable;
  end;
    
  procedure Request_VBlank_Interrupt (Request : Boolean := True) is
  begin
    Display_Status.Request_VBlank_Interrupt := Request;
  end;

  procedure Request_HBlank_Interrupt (Request : Boolean := True) is
  begin
    Display_Status.Request_HBlank_Interrupt := Request;
  end;

end GBA.Display;