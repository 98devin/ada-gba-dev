-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

with HLI.Allocation;
with GBA.Audio;
with GBA.Audio.PSG;
with GBA.BIOS;
with GBA.BIOS.Arm;
with GBA.Display;
with GBA.DMA;
with GBA.Input;
with GBA.Input.Buffered;
with GBA.Interrupts;
with GBA.Memory.IO_Registers;
with GBA.Timers;
with Interfaces;
with System.Unsigned_Types;


procedure Sound is

  use HLI.Allocation;
  use GBA.Audio;
  use GBA.Audio.PSG;
  use GBA.BIOS.Arm;
  use GBA.Display;
  use GBA.Interrupts;
  use GBA.Input;
  use GBA.Input.Buffered;
  use GBA.Memory.IO_Registers;
  use Interfaces;
  use System.Unsigned_Types;

  package DMA renames GBA.DMA;
  use all type DMA.Channel_ID;

  package Timers renames GBA.Timers;
  use all type Timers.Timer_ID;

  Music_Begin : aliased Unsigned_8
    with Import, External_Name => "track_start";

begin

  Enable_Interrupt (VBlank);
  Enable_Interrupt (Timer_0_Overflow);

  Request_VBlank_Interrupt;
  Wait_For_VBlank;

  Set_Display_Mode (Mode_3);
  Enable_Display_Element (Background_2);

  Timers.Set_Initial_Value (0, 64488);
  Timers.Set_Timer_Scale (0, Timers.x1);

  Timers.Timers (0).Control_Info.Trigger_IRQ := True;

  Channel_Status_Control.Master_Enable := True;
  Channel_Mixing_Control.DMA_A_Volume  := Vol_100;
  Channel_Mixing_Control.DMA_A         :=
    ( Enable_Right => True
    , Enable_Left  => True
    , Timer        => 0
    , Reset        => True
    );

  DMA.Setup_DMA_Transfer
    ( Channel => 1
    , Source  => Music_Begin'Address
    , Dest    => FIFO_A
    , Info    =>
      ( Transfer_Count    => 1
      , Dest_Adjustment   => DMA.Fixed
      , Source_Adjustment => DMA.Increment
      , Repeat            => True
      , Copy_Unit_Size    => DMA.Word
      , Timing            => DMA.Start_At_Timer
      , others            => <>
      )
    );

  Timers.Start_Timer (0);

  loop
    Wait_For_VBlank;
  end loop;

end;