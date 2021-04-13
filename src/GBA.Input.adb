
with Interfaces;
use  Interfaces;

with Ada.Unchecked_Conversion;


package body GBA.Input is

  function Cast is new Ada.Unchecked_Conversion(Key_Flags, Key_Set);
  function Cast is new Ada.Unchecked_Conversion(Key_Set, Key_Flags);

  function To_Flags (S : Key_Set) return Key_Flags is
    ( Cast(S) );

  function To_Flags (K : Key) return Key_Flags is
    function Cast is new Ada.Unchecked_Conversion(Unsigned_16, Key_Flags);
  begin
    return Cast(Shift_Left(1, Key'Enum_Rep(K)));
  end;


  function "or" (K1, K2 : Key) return Key_Flags is
    ( To_Flags(K1) or To_Flags(K2) );

  function "or" (F : Key_Flags; K : Key) return Key_Flags is
    ( F or To_Flags(K) );


  function Read_Key_State return Key_Flags is ( not Key_Input       );
  function Read_Key_State return Key_Set   is ( not Cast(Key_Input) );


  procedure Disable_Input_Interrupt_Request is
  begin
    Key_Control.Interrupt_Requested := False;
  end;

  procedure Request_Interrupt_If_Key_Pressed(K : Key) is
    Flags : Key_Flags := To_Flags(K);
  begin
    Key_Control :=
      ( Flags => Flags
      , Interrupt_Requested => True
      , Interrupt_Op => Disjunction
      );
  end;

  procedure Request_Interrupt_If_Any_Pressed(F : Key_Flags) is
  begin
    Key_Control :=
      ( Flags => F
      , Interrupt_Requested => True
      , Interrupt_Op => Disjunction
      );
  end;

  procedure Request_Interrupt_If_All_Pressed(F : Key_Flags) is
  begin
    Key_Control :=
      ( Flags => F
      , Interrupt_Requested => True
      , Interrupt_Op => Conjunction
      );
  end;

end GBA.Input;