
with GBA.Numerics;
use  GBA.Numerics;

separate (GBA.Interrupts)
procedure Default_Interrupt_Dispatcher is

  Enabled         : Boolean;
  Triggered_Flags : Interrupt_Flags;
  Priority_Bit    : Natural;
  Priority_ID     : Interrupt_ID;

  Handler         : Interrupt_Handler;

  procedure Run_In_System_Mode (Handler : not null Interrupt_Handler)
    with Import, External_Name => "gba_run_handler_in_system_mode";

begin
  Disable_Receiving_Interrupts(Enabled);

  Triggered_Flags := Acknowledge_Flags;

  Priority_Bit := Count_Trailing_Zeros(Integer_16(Triggered_Flags));
  Priority_ID  := Interrupt_ID'Enum_Val(Priority_Bit);
  Acknowledge_Interrupt(Priority_ID);

  Handler := Handlers(Priority_ID);
  if Handler /= null then
    Run_In_System_Mode(Handler);
  end if;

  Enable_Receiving_Interrupts(Enabled);
end;