-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.Memory;
use  GBA.Memory;

with GBA.Memory.IO_Registers;


package GBA.DMA is

  type Dest_Address_Adjustment is
    ( Increment
    , Decrement
    , Fixed
    , Increment_And_Reset
    );

  for Dest_Address_Adjustment use
    ( Increment           => 0
    , Decrement           => 1
    , Fixed               => 2
    , Increment_And_Reset => 3
    );


  type Source_Address_Adjustment is
    ( Increment
    , Decrement
    , Fixed
    );

  for Source_Address_Adjustment use
    ( Increment => 0
    , Decrement => 1
    , Fixed     => 2
    );


  type Unit_Size is
    ( Half_Word -- 16 bits
    , Word      -- 32 bits
    );

  for Unit_Size use
    ( Half_Word => 0
    , Word      => 1
    );


  type Timing_Mode is
    ( Start_Immediately
    , Start_At_VBlank
    , Start_At_HBlank
    , Start_At_Timer
    );

  for Timing_Mode use
    ( Start_Immediately => 0
    , Start_At_VBlank   => 1
    , Start_At_HBlank   => 2
    , Start_At_Timer    => 3
    );


  type Transfer_Count_Type is mod 2**15;

  type Transfer_Info is
    record
      Transfer_Count    : Transfer_Count_Type;
      Dest_Adjustment   : Dest_Address_Adjustment;
      Source_Adjustment : Source_Address_Adjustment;
      Repeat            : Boolean;
      Copy_Unit_Size    : Unit_Size;
      Timing            : Timing_Mode;
      Enable_Interrupt  : Boolean;
      Enabled           : Boolean;
    end record
    with Size => 32;

  for Transfer_Info use
    record
      Transfer_Count    at 0 range 16#00# .. 16#0F#;
      Dest_Adjustment   at 0 range 16#15# .. 16#16#;
      Source_Adjustment at 0 range 16#17# .. 16#18#;
      Repeat            at 0 range 16#19# .. 16#19#;
      Copy_Unit_Size    at 0 range 16#1A# .. 16#1A#;
      Timing            at 0 range 16#1C# .. 16#1D#;
      Enable_Interrupt  at 0 range 16#1E# .. 16#1E#;
      Enabled           at 0 range 16#1F# .. 16#1F#;
    end record;

  type Channel_Info is limited
    record
      Source   : Address       with Volatile;
      Dest     : Address       with Volatile;
      DMA_Info : Transfer_Info with Volatile;
    end record
    with Size => 96;

  for Channel_Info use
    record
      Source   at 0 range 0  .. 31;
      Dest     at 4 range 0  .. 31;
      DMA_Info at 8 range 0  .. 31;
    end record;


  type Channel_ID is range 0 .. 3;


  -- Basic access to structured DMA info --

  use GBA.Memory.IO_Registers;

  Channel_Addresses : constant array (Channel_ID) of Address :=
    ( 0 => DMA0SAD
    , 1 => DMA1SAD
    , 2 => DMA2SAD
    , 3 => DMA3SAD
    );

  DMA_Channel_0 : Channel_Info
    with Import, Address => Channel_Addresses (0);

  DMA_Channel_1 : Channel_Info
    with Import, Address => Channel_Addresses (1);

  DMA_Channel_2 : Channel_Info
    with Import, Address => Channel_Addresses (2);

  DMA_Channel_3 : Channel_Info
    with Import, Address => Channel_Addresses (3);

  Channel_Array_View : array (Channel_ID) of Channel_Info
    with Import, Address => DMA0SAD;


  -- Most basic DMA interface routines --

  procedure Setup_DMA_Transfer
    ( Channel      : Channel_ID;
      Source, Dest : Address;
      Info         : Transfer_Info )
    with Inline_Always;

  function Is_Transfer_Ongoing
    ( Channel : Channel_ID ) return Boolean
    with Inline_Always;

  procedure Stop_Ongoing_Transfer
    ( Channel : Channel_ID )
    with Inline_Always;

end GBA.DMA;