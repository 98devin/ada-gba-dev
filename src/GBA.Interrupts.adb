
with GBA.Memory.IO_Registers;
use  GBA.Memory.IO_Registers;

with Ada.Unchecked_Conversion;

with Interfaces;
use  Interfaces;


package body GBA.Interrupts is

  -- IO Register Definitions --

  Enabled_Master : Boolean
    with Import, Address => IME;

  Enabled_Flags : Interrupt_Flags
    with Import, Address => IE;

  Acknowledge_Flags : Interrupt_Flags
    with Import, Address => IRF;

  Acknowledge_BIOS_Flags : Interrupt_Flags
    with Import, Address => 16#3007FF8#;


  -- ID to Flags conversions --

  function As_Flags (ID : Interrupt_ID) return Interrupt_Flags
    with Pure_Function, Inline_Always is
    function Cast is new Ada.Unchecked_Conversion(Unsigned_16, Interrupt_Flags);
  begin
    return Cast( Shift_Left(1, Interrupt_ID'Enum_Rep(ID)) );
  end;

  function "or" (I1, I2 : Interrupt_ID) return Interrupt_Flags is
    ( As_Flags(I1) or As_Flags(I2) );

  function "or" (F : Interrupt_Flags; I : Interrupt_ID) return Interrupt_Flags is
    ( F or As_Flags(I) );


  -- Currently Registered Handlers --

  Handlers : array (Interrupt_ID) of Interrupt_Handler := (others => null)
    with Export, External_Name => "interrupt_handler_array";


  procedure Default_Interrupt_Dispatcher is separate;

  Interrupt_Dispatcher : access procedure
    with Import, Address => 16#3007FFC#;


  -- Master Interrupt Enable/Disable --

  procedure Enable_Receiving_Interrupts (Enabled : Boolean) is
  begin
    Enabled_Master := Enabled;
  end;

  procedure Enable_Receiving_Interrupts is
  begin
    Enabled_Master := True;
  end;

  procedure Disable_Receiving_Interrupts (Enabled : out Boolean) is
  begin
    Enabled := Enabled_Master;
    Enabled_Master := False;
  end;

  procedure Disable_Receiving_Interrupts is
  begin
    Enabled_Master := False;
  end;


  -- Individual Interrupt Enable/Disable --

  procedure Enable_Interrupt (ID : Interrupt_ID) is
  begin
    Enabled_Flags := Enabled_Flags or ID;
  end;

  procedure Enable_Interrupt (Flags : Interrupt_Flags) is
  begin
    Enabled_Flags := Enabled_Flags or Flags;
  end;

  procedure Disable_Interrupt (ID : Interrupt_ID) is
  begin
    Enabled_Flags := Enabled_Flags and not As_Flags(ID);
  end;

  procedure Disable_Interrupt (Flags : Interrupt_Flags) is
  begin
    Enabled_Flags := Enabled_Flags and not Flags;
  end;

  procedure Disable_Interrupts_And_Save (Flags : out Interrupt_Flags) is
  begin
    Flags := Enabled_Flags;
    Enabled_Flags := 0;
  end;

  procedure Acknowledge_Interrupt (ID : Interrupt_ID) is
    Flags : Interrupt_Flags := As_Flags(ID);
  begin
    Acknowledge_Flags := Flags;
    Acknowledge_BIOS_Flags := Flags;
  end;

  procedure Acknowledge_Interrupt (Flags : Interrupt_Flags) is
  begin
    Acknowledge_Flags := Flags;
    Acknowledge_BIOS_Flags := Flags;
  end;


  -- Interrupt Handler Settings --

  procedure Attach_Interrupt_Handler
    (ID : Interrupt_ID; Handler : not null Interrupt_Handler) is
  begin
    Handlers(ID) := Handler;
  end;

  procedure Attach_Interrupt_Handler_And_Save
    (ID : Interrupt_ID; Handler : not null Interrupt_Handler; Old_Handler : out Interrupt_Handler) is
  begin
    Old_Handler  := Handlers(ID);
    Handlers(ID) := Handler;
  end;

  procedure Detach_Interrupt_Handler (ID : Interrupt_ID) is
  begin
    Handlers(ID) := null;
  end;

  procedure Detach_Interrupt_Handler_And_Save
    (ID : Interrupt_ID; Old_Handler : out Interrupt_Handler) is
  begin
    Old_Handler  := Handlers(ID);
    Handlers(ID) := null;
  end;

begin

  -- Register default handler.
  -- Ensures safety of enabling interrupts.

  Interrupt_Dispatcher := Default_Interrupt_Dispatcher'Access;

end GBA.Interrupts;