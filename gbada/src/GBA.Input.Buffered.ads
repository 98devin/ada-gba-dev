
with GBA.Input;
use  GBA.Input;

package GBA.Input.Buffered is
  
  procedure Update_Key_State;

  function Is_Key_Pressed (K : Key) return Boolean with Inline_Always;
  function Are_Any_Pressed (F : Key_Flags) return Boolean with Inline_Always;
  function Are_All_Pressed (F : Key_Flags) return Boolean with Inline_Always;

  function Was_Key_Pressed  (K : Key) return Boolean with Inline_Always;
  function Were_Any_Pressed (F : Key_Flags) return Boolean with Inline_Always;
  function Were_All_Pressed (F : Key_Flags) return Boolean with Inline_Always;

  function Was_Key_Released  (K : Key) return Boolean with Inline_Always;
  function Were_Any_Released (F : Key_Flags) return Boolean with Inline_Always;
  function Were_All_Released (F : Key_Flags) return Boolean with Inline_Always;

  function Was_Key_Held  (K : Key) return Boolean with Inline_Always;
  function Were_Any_Held (F : Key_Flags) return Boolean with Inline_Always;
  function Were_All_Held (F : Key_Flags) return Boolean with Inline_Always;
  
  function Was_Key_Untouched  (K : Key) return Boolean with Inline_Always;
  function Were_Any_Untouched (F : Key_Flags) return Boolean with Inline_Always;
  function Were_All_Untouched (F : Key_Flags) return Boolean with Inline_Always;

private

  Last_Key_State    : Key_Flags := 0;
  Current_Key_State : Key_Flags := 0;

end GBA.Input.Buffered;