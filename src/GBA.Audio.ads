-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

with GBA.Memory.IO_Registers;
with GBA.Timers;
with System.Unsigned_Types;


package GBA.Audio is

  use GBA.Memory.IO_Registers;
  use GBA.Timers;
  use System.Unsigned_Types;

  ----------------------------------
  -- Master Volume/Enable Control --
  ----------------------------------

  type Channel_Enable_Array is
    array (1 .. 4) of Boolean
      with Pack;

  type Master_Control_Info is
    record
      Volume_Right : Unsigned range 0 .. 7;
      Volume_Left  : Unsigned range 0 .. 7;
      Enable_Right : Channel_Enable_Array;
      Enable_Left  : Channel_Enable_Array;
    end record
      with Size => 16;

  for Master_Control_Info use
    record
      Volume_Right at 0 range  0 ..  2;
      Volume_Left  at 0 range  4 ..  6;
      Enable_Right at 0 range  8 .. 11;
      Enable_Left  at 0 range 12 .. 15;
    end record;

  type Master_Status_Info is
    record
      Sound_Playing : Channel_Enable_Array; -- Read-only
      Master_Enable : Boolean;
    end record
      with Size => 16;

  for Master_Status_Info use
    record
      Sound_Playing at 0 range 0 .. 3;
      Master_Enable at 0 range 7 .. 7;
    end record;

  type Master_Channel_Mixing_Volume is
    ( Vol_25
    , Vol_50
    , Vol_100
    , Muted
    ) with Size => 2;

  for Master_Channel_Mixing_Volume use
    ( Vol_25  => 0
    , Vol_50  => 1
    , Vol_100 => 2
    , Muted   => 3
    );

  type Master_DMA_Mixing_Volume is
    ( Vol_50
    , Vol_100
    ) with Size => 1;

  for Master_DMA_Mixing_Volume use
    ( Vol_50  => 0
    , Vol_100 => 1
    );


  ---------------------------
  -- Master Mixing Control --
  ---------------------------

  type DMA_Mixing_Info is
    record
      Enable_Right : Boolean;
      Enable_Left  : Boolean;
      Timer        : Timer_ID range 0 .. 1;
      Reset        : Boolean;
    end record
      with Size => 4;

  for DMA_Mixing_Info use
    record
      Enable_Right at 0 range 0 .. 0;
      Enable_Left  at 0 range 1 .. 1;
      Timer        at 0 range 2 .. 2;
      Reset        at 0 range 3 .. 3;
    end record;

  type Master_Mixing_Info is
    record
      Channel_Volume : Master_Channel_Mixing_Volume;
      DMA_A_Volume   : Master_DMA_Mixing_Volume;
      DMA_B_Volume   : Master_DMA_Mixing_Volume;

      DMA_A          : DMA_Mixing_Info;
      DMA_B          : DMA_Mixing_Info;
    end record;

  for Master_Mixing_Info use
    record
      Channel_Volume at 0 range  0 ..  1;
      DMA_A_Volume   at 0 range  2 ..  2;
      DMA_B_Volume   at 0 range  3 ..  3;

      DMA_A          at 0 range  8 .. 11;
      DMA_B          at 0 range 12 .. 15;
    end record;


  --------------------------
  -- Bitrate/Bias Control --
  --------------------------

  type Sample_Bias_Type is
    new Unsigned range 0 .. 2**9 - 1;

  type Sample_Rate_Type is
    ( HZ_32768
    , HZ_65536
    , HZ_131072
    , HZ_262144
    ) with Size => 2;

  for Sample_Rate_Type use
    ( HZ_32768  => 0
    , HZ_65536  => 1
    , HZ_131072 => 2
    , HZ_262144 => 3
    );

  type Bias_Sampling_Control_Info is
    record
      Bias : Sample_Bias_Type;
      Rate : Sample_Rate_Type;
    end record
      with Size => 16;

  for Bias_Sampling_Control_Info use
    record
      Bias at 0 range  1 ..  9;
      Rate at 0 range 14 .. 15;
    end record;


  ----------------------
  -- Master Registers --
  ----------------------

  Channel_Enable_Control : Master_Control_Info
    with Address => SOUNDCNT_L, Volatile_Full_Access;

  Channel_Mixing_Control : Master_Mixing_Info
    with Address => SOUNDCNT_H, Volatile_Full_Access;

  Channel_Status_Control : Master_Status_Info
    with Address => SOUNDCNT_X, Volatile_Full_Access;

  Bias_Sampling_Control : Bias_Sampling_Control_Info
    with Address => SOUNDBIAS, Volatile_Full_Access;


  DMA_A : DMA_Mixing_Info
    renames Channel_Mixing_Control.DMA_A;

  DMA_B : DMA_Mixing_Info
    renames Channel_Mixing_Control.DMA_B;

end GBA.Audio;