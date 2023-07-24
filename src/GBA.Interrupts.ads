-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


package GBA.Interrupts is

  type Interrupt_ID is
    ( VBlank
    , HBlank
    , VCounter_Match
    , Timer_0_Overflow
    , Timer_1_Overflow
    , Timer_2_Overflow
    , Timer_3_Overflow
    , Serial_Communication
    , DMA_0
    , DMA_1
    , DMA_2
    , DMA_3
    , Keypad
    , Game_Pak
    )
    with Size => 16;

  for Interrupt_ID use
    ( VBlank               => 0
    , HBlank               => 1
    , VCounter_Match       => 2
    , Timer_0_Overflow     => 3
    , Timer_1_Overflow     => 4
    , Timer_2_Overflow     => 5
    , Timer_3_Overflow     => 6
    , Serial_Communication => 7
    , DMA_0                => 8
    , DMA_1                => 9
    , DMA_2                => 10
    , DMA_3                => 11
    , Keypad               => 12
    , Game_Pak             => 13
    );


  type Interrupt_Flags is mod 2**14
    with Size => 16;

  All_Interrupts : constant Interrupt_Flags := Interrupt_Flags'Mod(-1);


  function "or" (I1, I2 : Interrupt_ID) return Interrupt_Flags
    with Pure_Function, Inline_Always;

  function "or" (F : Interrupt_Flags; I : Interrupt_ID) return Interrupt_Flags
    with Pure_Function, Inline_Always;


  type Interrupt_Handler is
    access procedure;


  procedure Enable_Receiving_Interrupts (Enabled : Boolean)
    with Inline;

  procedure Enable_Receiving_Interrupts
    with Inline;

  procedure Disable_Receiving_Interrupts
    with Inline;

  procedure Disable_Receiving_Interrupts (Enabled : out Boolean)
    with Inline;


  procedure Enable_Interrupt (ID : Interrupt_ID)
    with Inline;

  procedure Enable_Interrupt (Flags : Interrupt_Flags)
    with Inline;


  procedure Disable_Interrupt (ID : Interrupt_ID)
    with Inline;

  procedure Disable_Interrupt (Flags : Interrupt_Flags)
    with Inline;

  procedure Disable_Interrupts_And_Save (Flags : out Interrupt_Flags)
    with Inline;


  procedure Acknowledge_Interrupt (ID : Interrupt_ID)
    with Inline;

  procedure Acknowledge_Interrupt (Flags : Interrupt_Flags)
    with Inline;


  procedure Attach_Interrupt_Handler
    (ID : Interrupt_ID; Handler : not null Interrupt_Handler)
    with Inline;

  procedure Attach_Interrupt_Handler_And_Save
    (ID : Interrupt_ID; Handler : not null Interrupt_Handler; Old_Handler : out Interrupt_Handler)
    with Inline;

  procedure Detach_Interrupt_Handler (ID : Interrupt_ID)
    with Inline;

  procedure Detach_Interrupt_Handler_And_Save (ID : Interrupt_ID; Old_Handler : out Interrupt_Handler)
    with Inline;


private

  procedure Default_Interrupt_Dispatcher
    with Linker_Section => ".iwram";
  pragma Machine_Attribute(Default_Interrupt_Dispatcher, "target", "arm");

end GBA.Interrupts;