
with GBA.Memory;
with GBA.Interrupts;
with GBA.Input.Buffered;
with GBA.DMA;

with GBA.BIOS;
use  GBA.BIOS;

with GBA.BIOS.Thumb;
use  GBA.BIOS.Thumb;

with Interfaces;
use  Interfaces;

with GBA.BIOS.Memset;

procedure Hello is

  Display_Control : Unsigned_32
    with Import, Volatile, Address => 16#4000000#;

  Display_Stats : Unsigned_16
    with Import, Volatile, Address => 16#4000004#;

  Mode_3 : constant := 16#0003#;
  BG_2   : constant := 16#0400#;
  VBlank_Enable : constant := 2#1000#;

  type Unsigned_5 is mod 2 ** 5;

  type Color is 
    record
      R, G, B : Unsigned_5;
    end record
    with Size => 16;

  for Color use
    record
      R at 0 range 0  .. 4;
      G at 0 range 5  .. 9;
      B at 0 range 10 .. 14;
    end record;


  VRAM : array (1 .. 160, 1 .. 240) of Color
    with Import, Volatile, Address => 16#6000000#;


  Color_BGS : array (1 .. 2) of Color with Export;

  procedure Adjust_Color(Y : Positive) is
    Color_Palette : constant array (0 .. 3) of Color :=
      ( (19, 23, 19) 
      , (31, 25, 21) 
      , (31, 16, 15)
      , (29,  9, 11)
      );
  begin
    Color_BGS := (1..2 => Color_Palette(((Y-1) mod 128) / 32));
  end;

  Y_Offset : Natural := 0;

  use GBA.Input;
  use GBA.Input.Buffered;

  use GBA.DMA;

  Block_Transfer_Info : constant Transfer_Info :=
    ( Copy_Unit_Size    => Half_Word
    , Transfer_Count    => 60
    , Dest_Adjustment   => Increment
    , Source_Adjustment => Fixed
    , Repeat            => False
    , Timing            => Start_Immediately
    , Enable_Interrupt  => False
    , Enabled           => True
    );

begin

  Display_Control := Mode_3 + BG_2;
  Display_Stats   := @ or VBlank_Enable;

  GBA.Interrupts.Enable_Receiving_Interrupts;
  GBA.Interrupts.Enable_Interrupt(GBA.Interrupts.VBlank);

  loop
    Update_Key_State;
  
    for Y in VRAM'Range(1) loop
      for X in 1 .. 4 loop
        Adjust_Color(Y + Y_Offset * X);
--        Perform_Transfer
--          ( Channel     => 0
--          , Source      => Color_BG'Address
--          , Destination => VRAM(Y, 1 + (X-1) * 60)'Address
--          , Info        => Block_Transfer_Info       
--          );
        Cpu_Set(
          Source     => Color_BGS'Address,
          Dest       => VRAM(Y, 1 + (X-1) * 60)'Address,
          Unit_Count => 30,
          Unit_Size  => Word,
          Mode       => Fill
        );
      end loop;
    end loop;

    if Are_Any_Pressed( A_Button or B_Button ) then
      Y_Offset := @ + 5;
    else
      Y_Offset := @ + 1;
    end if;

    Wait_For_VBlank;

  end loop;
end;
