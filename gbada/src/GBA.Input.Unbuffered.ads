
with GBA.Input;
use  GBA.Input;

package GBA.Input.Unbuffered is

  function Is_Key_Pressed(K : Key) return Boolean with Inline_Always;
  function Are_Any_Pressed(F : Key_Flags) return Boolean with Inline_Always;
  function Are_All_Pressed(F : Key_Flags) return Boolean with Inline_Always;  

end GBA.Input.Unbuffered;