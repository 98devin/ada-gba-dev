
with GBA.Input;
use  GBA.Input;

package GBA.Input.Unbuffered is

  function Is_Key_Down(K : Key) return Boolean with Inline_Always;
  function Are_Any_Down(F : Key_Flags) return Boolean with Inline_Always;
  function Are_All_Down(F : Key_Flags) return Boolean with Inline_Always;  

end GBA.Input.Unbuffered;