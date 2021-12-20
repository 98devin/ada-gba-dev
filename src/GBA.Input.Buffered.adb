-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with Ada.Unchecked_Conversion;


package body GBA.Input.Buffered is

  procedure Update_Key_State is
  begin
    Last_Key_State    := Current_Key_State;
    Current_Key_State := Read_Key_State;
  end;


  function Is_Key_Down (K : Key) return Boolean is
    ( (Current_Key_State and To_Flags(K)) /= 0 );

  function Was_Key_Pressed (K : Key) return Boolean is
    ( (Current_Key_State and (not Last_Key_State) and To_Flags(K)) /= 0 );

  function Was_Key_Released (K : Key) return Boolean is
    ( ((not Current_Key_State) and Last_Key_State and To_Flags(K)) /= 0 );

  function Was_Key_Held (K : Key) return Boolean is
    ( (Current_Key_State and Last_Key_State and To_Flags(K)) /= 0 );

  function Was_Key_Untouched (K : Key) return Boolean is
    ( ((not Current_Key_State) and (not Last_Key_State) and To_Flags(K)) /= 0 );


  function Are_Any_Down (F : Key_Flags) return Boolean is
    ( (Current_Key_State and F) /= 0 );

  function Were_Any_Pressed (F : Key_Flags) return Boolean is
    ( (Current_Key_State and (not Last_Key_State) and F) /= 0 );

  function Were_Any_Released (F : Key_Flags) return Boolean is
    ( ((not Current_Key_State) and Last_Key_State and F) /= 0 );

  function Were_Any_Held (F : Key_Flags) return Boolean is
    ( (Current_Key_State and Last_Key_State and F) /= 0 );

  function Were_Any_Untouched (F : Key_Flags) return Boolean is
    ( ((not Current_Key_State) and (not Last_Key_State) and F) /= 0 );


  function Are_All_Down (F : Key_Flags) return Boolean is
    ( (Current_Key_State and F) = F );

  function Were_All_Pressed (F : Key_Flags) return Boolean is
    ( (Current_Key_State and (not Last_Key_State) and F) = F );

  function Were_All_Released (F : Key_Flags) return Boolean is
    ( ((not Current_Key_State) and Last_Key_State and F) = F );

  function Were_All_Held (F : Key_Flags) return Boolean is
    ( (Current_Key_State and Last_Key_State and F) = F );

  function Were_All_Untouched (F : Key_Flags) return Boolean is
    ( ((not Current_Key_State) and (not Last_Key_State) and F) = F );

end GBA.Input.Buffered;




