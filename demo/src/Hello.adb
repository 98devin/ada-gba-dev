
with GBA.BIOS;
with GBA.BIOS.Thumb;
with GBA.BIOS.Memset;

with GBA.Display;
with GBA.Display.Backgrounds;
with GBA.Display.Palettes;
with GBA.Display.Windows;

with GBA.Memory;
with GBA.Interrupts;

with GBA.Input;
with GBA.Input.Buffered;


with Interfaces;


procedure Hello is

  use GBA.BIOS;
  use GBA.BIOS.Thumb;

  use GBA.Display;
  use GBA.Display.Palettes;

  use GBA.Input;
  use GBA.Input.Buffered;



  VRAM : array (1 .. 160, 1 .. 240) of Color
    with Import, Volatile, Address => 16#6000000#;


  Color_BG : aliased Color with Volatile;

  procedure Adjust_Color (Y : Positive) is
    Color_Palette : constant array (0 .. 3) of Color :=
      ( (19, 23, 19) 
      , (31, 25, 21) 
      , (31, 16, 15)
      , (29,  9, 11)
      );
  begin
    Color_BG := Color_Palette(((Y-1) mod 128) / 32);
  end;

  Y_Offset : Natural := 0;

begin

  GBA.Interrupts.Enable_Receiving_Interrupts;
  GBA.Interrupts.Enable_Interrupt(GBA.Interrupts.VBlank);

  Set_Display_Mode(Mode_3);
  Enable_Display_Element(Background_2);

  Request_VBlank_Interrupt;

  loop
    Update_Key_State;
  
    for Y in VRAM'Range(1) loop
      for X in 1 .. 4 loop
        Adjust_Color(Y + Y_Offset * X);
        Cpu_Set(
          Source     => Color_BG'Address,
          Dest       => VRAM(Y, 1 + (X-1) * 60)'Address,
          Unit_Count => 60,
          Unit_Size  => Half_Word,
          Mode       => Fill
        );
      end loop;
    end loop;

    if Are_Any_Down( A_Button or B_Button ) then
      Y_Offset := @ + 5;
    else
      Y_Offset := @ + 1;
    end if;

    Wait_For_VBlank;
  end loop;

end;
