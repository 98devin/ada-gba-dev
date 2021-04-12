
package body GBA.Memory.Secondary_Stack is

  Secondary_Stack : aliased SS_Stack :=
    ( Size        => Size
    , Start | Top => Location
    );

  function Get_Sec_Stack return SS_Stack_Ptr is
    ( Secondary_Stack'Access );

end GBA.Memory.Secondary_Stack;