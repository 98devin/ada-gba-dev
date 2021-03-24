
package body GBA.Input.Unbuffered is

  function Is_Key_Pressed(K : Key) return Boolean is
    ( Key_Set'(Read_Key_State)(K) );

  function Are_Any_Pressed(F : Key_Flags) return Boolean is
    ( (F and Read_Key_State) /= 0 );

  function Are_All_Pressed(F : Key_Flags) return Boolean is
    ( (F and Read_Key_State) = F );

end GBA.Input.Unbuffered;