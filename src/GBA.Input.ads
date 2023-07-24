-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.Memory.IO_Registers;

package GBA.Input is

  type Key is
    ( A_Button
    , B_Button
    , Select_Button
    , Start_Button
    , Right_Direction
    , Left_Direction
    , Up_Direction
    , Down_Direction
    , Left_Shoulder
    , Right_Shoulder
    )
    with Size => 16;

  for Key use
    ( A_Button        => 0
    , B_Button        => 1
    , Select_Button   => 2
    , Start_Button    => 3
    , Right_Direction => 4
    , Left_Direction  => 5
    , Up_Direction    => 6
    , Down_Direction  => 7
    , Left_Shoulder   => 8
    , Right_Shoulder  => 9
    );


  type Key_Flags is mod 2**10
    with Size => 16;

  type Key_Set is array (Key) of Boolean
    with Pack, Size => 16;

  function To_Flags (S : Key_Set) return Key_Flags
    with Inline_Always;

  function To_Flags (K : Key) return Key_Flags
    with Inline_Always;


  function "or" (K1, K2 : Key) return Key_Flags
    with Pure_Function, Inline_Always;

  function "or" (F : Key_Flags; K : Key) return Key_Flags
    with Pure_Function, Inline_Always;

  function Read_Key_State return Key_Flags
    with Inline_Always;

  function Read_Key_State return Key_Set
    with Inline_Always;

  procedure Disable_Input_Interrupt_Request;
  procedure Request_Interrupt_If_Key_Pressed(K : Key);
  procedure Request_Interrupt_If_Any_Pressed(F : Key_Flags);
  procedure Request_Interrupt_If_All_Pressed(F : Key_Flags);

  -- Unsafe Interface --

  type Key_Control_Op is
    ( Disjunction, Conjunction );

  for Key_Control_Op use
    ( Disjunction => 0, Conjunction => 1 );

  type Key_Control_Info is
    record
      Flags               : Key_Flags;
      Interrupt_Requested : Boolean;
      Interrupt_Op        : Key_Control_Op;
    end record
    with Size => 16;

  for Key_Control_Info use
    record
      Flags               at 0 range 0  .. 9;
      Interrupt_Requested at 0 range 14 .. 14;
      Interrupt_Op        at 0 range 15 .. 15;
    end record;

  use GBA.Memory.IO_Registers;

  Key_Input : Key_Flags
    with Import, Address => KEYINPUT;

  Key_Control : Key_Control_Info
    with Import, Address => KEYCNT;

end GBA.Input;