-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.

package GBA.Audio is

  type Sweep_Shift_Type is range 0 .. 7;

  type Frequency_Direction is
    ( Increasing
    , Decreasing
    );

  for Frequency_Direction use
    ( Increasing => 0
    , Decreasing => 1
    );

  type Sweep_Duration_Type is range 0 .. 7;


  type Sweep_Control_Info is
    record
      Shift            : Sweep_Shift_Type;
      Frequency_Change : Frequency_Direction;
      Duration         : Sweep_Duration_Type;
    end record
      with Size => 16;

  for Sweep_Control_Info use
    record
      Shift            at 0 range 0 .. 2;
      Frequency_Change at 0 range 3 .. 3;
      Duration         at 0 range 4 .. 6;
    end record;


  type Sound_Duration_Type is range 0 .. 63;

  type Wave_Pattern_Duty_Type is range 0 .. 3;

  type Envelope_Step_Type is range 0 .. 7;

  type Envelope_Direction is
    ( Increasing
    , Decreasing
    );

  for Envelope_Direction use
    ( Increasing => 1
    , Decreasing => 0
    );

  type Initial_Volume_Type is range 0 .. 15;

  type Duty_Length_Info is
    record
      Duration           : Sound_Duration_Type;
      Wave_Pattern_Duty  : Wave_Pattern_Duty_Type;
      Envelope_Step_Time : Envelope_Step_Type;
      Envelope_Change    : Envelope_Direction;
      Initial_Volume     : Initial_Volume_Type;
    end record
      with Size => 16;

  for Duty_Length_Info use
    record
      Duration           at 0 range 0  .. 5;
      Wave_Pattern_Duty  at 0 range 6  .. 7;
      Envelope_Step_Time at 0 range 8  .. 10;
      Envelope_Direction at 0 range 11 .. 11;
      Initial_Volume     at 0 range 12 .. 15;
    end record;


  type Frequency_Type is range 0 .. 2047;

  type Frequency_Control_Info is
    record
      Frequency    : Frequency_Type;
      Use_Duration : Boolean;
      Initial      : Boolean;
    end record
      with Size => 16;

  for Frequency_Control_Info use
    record
      Frequency    at 0 range 0  .. 10;
      Use_Duration at 0 range 14 .. 14;
      Initial      at 0 range 15 .. 15;
    end record;


end GBA.Audio;