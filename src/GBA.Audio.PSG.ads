-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

package GBA.Audio.PSG is

  ------------------
  -- Tone Control --
  ------------------

  type Tone_Duration_Type is
    range 0 .. 63;

  type Wave_Duty_Type is
    ( Duty_125
    , Duty_250
    , Duty_500
    , Duty_750
    );

  for Wave_Duty_Type use
    ( Duty_125 => 0
    , Duty_250 => 1
    , Duty_500 => 2
    , Duty_750 => 3
    );

  type Envelope_Duration_Type is
    range 0 .. 7;

  type Envelope_Direction is
    ( Decreasing
    , Increasing
    );

  for Envelope_Direction use
    ( Decreasing => 0
    , Increasing => 1
    );

  type Initial_Volume_Type is
    range 0 .. 15;

  type Channel_Tone_Info is
    record
      Duration          : Tone_Duration_Type;
      Wave_Duty         : Wave_Duty_Type;
      Envelope_Duration : Envelope_Duration_Type;
      Envelope_Change   : Envelope_Direction;
      Initial_Volume    : Initial_Volume_Type;
    end record
      with Size => 16;

  for Channel_Tone_Info use
    record
      Duration          at 0 range 0  .. 5;
      Wave_Duty         at 0 range 6  .. 7;
      Envelope_Duration at 0 range 8  .. 10;
      Envelope_Change   at 0 range 11 .. 11;
      Initial_Volume    at 0 range 12 .. 15;
    end record;

  -----------------------------
  -- Frequency Sweep Control --
  -----------------------------

  type Sweep_Shift_Amount is
    range 0 .. 7;

  type Frequency_Direction is
    ( Increasing
    , Decreasing
    );

  for Frequency_Direction use
    ( Increasing => 0
    , Decreasing => 1
    );

  type Sweep_Duration_Type is
    range 0 .. 7;

  type Channel_Sweep_Info is
    record
      Shift            : Sweep_Shift_Amount;
      Frequency_Change : Frequency_Direction;
      Duration         : Sweep_Duration_Type;
    end record
      with Size => 16;

  for Channel_Sweep_Info use
    record
      Shift            at 0 range 0 .. 2;
      Frequency_Change at 0 range 3 .. 3;
      Duration         at 0 range 4 .. 6;
    end record;

  -----------------------
  -- Frequency Control --
  -----------------------

  type Tone_Frequency_Type is
    range 0 .. 2047;

  type Channel_Frequency_Info is
    record
      Frequency    : Tone_Frequency_Type;
      Use_Duration : Boolean;
      Initial      : Boolean;
    end record
      with Size => 16;

  for Channel_Frequency_Info use
    record
      Frequency    at 0 range 0  .. 10;
      Use_Duration at 0 range 14 .. 14;
      Initial      at 0 range 15 .. 15;
    end record;


  --------------------------
  -- Wave Channel Control --
  --------------------------

  type Wave_RAM_Size_Type is
    ( Bits_32
    , Bits_64
    ) with Size => 1;

  for Wave_RAM_Size_Type use
    ( Bits_32 => 0
    , Bits_64 => 1
    );

  type Wave_RAM_Bank_ID is
    mod 2;

  type Channel_Bank_Select_Info is
    record
      Size   : Wave_RAM_Size_Type;
      Bank   : Wave_RAM_Bank_ID;
      Enable : Boolean;
    end record
      with Size => 16;

  for Channel_Bank_Select_Info use
    record
      Size   at 0 range 5 .. 5;
      Bank   at 0 range 6 .. 6;
      Enable at 0 range 7 .. 7;
    end record;

  type Wave_Volume_Type is
    ( Muted
    , Vol_100
    , Vol_50
    , Vol_25
    , Vol_75
    ) with Size => 3;

  for Wave_Volume_Type use
    ( Muted   => 2#000#
    , Vol_100 => 2#001#
    , Vol_50  => 2#010#
    , Vol_25  => 2#011#
    , Vol_75  => 2#100#
    );

  type Channel_Wave_Info is
    record
      Duration : Unsigned range 0 .. 255;
      Volume   : Wave_Volume_Type;
    end record
      with Size => 16;

  for Channel_Wave_Info use
    record
      Duration at 0 range  0 ..  7;
      Volume   at 0 range 13 .. 15;
    end record;



  -------------------------
  -- Channel 1 Registers --
  -------------------------

  Channel_1_Sweep : Channel_Sweep_Info
    with Address => SOUND1CNT_L, Volatile_Full_Access;

  Channel_1_Tone  : Channel_Tone_Info
    with Address => SOUND1CNT_H, Volatile_Full_Access;

  Channel_1_Freq  : Channel_Frequency_Info
    with Address => SOUND1CNT_X, Volatile_Full_Access;


  -------------------------
  -- Channel 2 Registers --
  -------------------------

  Channel_2_Tone : Channel_Tone_Info
    with Address => SOUND2CNT_L, Volatile_Full_Access;

  Channel_2_Freq : Channel_Frequency_Info
    with Address => SOUND2CNT_H, Volatile_Full_Access;


  -------------------------
  -- Channel 3 Registers --
  -------------------------

  Channel_3_Wave : Channel_Bank_Select_Info
    with Address => SOUND3CNT_L, Volatile_Full_Access;

  Channel_3_Duration_Volume : Channel_Wave_Info
    with Address => SOUND3CNT_H, Volatile_Full_Access;

  Channel_3_Freq : Channel_Frequency_Info
    with Address => SOUND3CNT_X, Volatile_Full_Access;


  -------------------------
  -- Channel 4 Registers --
  -------------------------

  Channel_4_Tone : Channel_Tone_Info
    with Address => SOUND4CNT_L, Volatile_Full_Access;

  Channel_4_Freq : Channel_Frequency_Info
    with Address => SOUND4CNT_H, Volatile_Full_Access;


end GBA.Audio.PSG;