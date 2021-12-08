-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


package body GBA.DMA.Generic_Interfaces is

  Use_Full_Word : constant Boolean :=
    (Element_Type'Size >= 32 and then Element_Type'Size mod 32 = 0);

  function Memset_Info ( Count : Transfer_Count_Type ) return Transfer_Info is
    (( Dest_Adjustment   => Increment
     , Source_Adjustment => Fixed
     , Repeat            => False
     , Copy_Unit_Size    => (if Use_Full_Word then Word else Half_Word)
     , Timing            => Start_Immediately
     , Enable_Interrupt  => False
     , Enabled           => True
     , Transfer_Count    => Count * (if Use_Full_Word then Element_Type'Size / 32 else Element_Type'Size / 16)
    ));

  function Memcopy_Info ( Length : Transfer_Count_Type ) return Transfer_Info is
    (( Dest_Adjustment   => Increment
     , Source_Adjustment => Increment
     , Repeat            => False
     , Copy_Unit_Size    => (if Use_Full_Word then Word else Half_Word)
     , Timing            => Start_Immediately
     , Enable_Interrupt  => False
     , Enabled           => True
     , Transfer_Count    => Length * (if Use_Full_Word then Element_Type'Size / 32 else Element_Type'Size / 16)
    ));

  procedure Memset ( Channel : Channel_ID; Source, Dest : Address; Count : Transfer_Count_Type ) is
    Info : constant Transfer_Info := Memset_Info(Count);
  begin
    Setup_DMA_Transfer (Channel, Source, Dest, Info);
  end;

  procedure Memcopy ( Channel : Channel_ID; Source, Dest : Address; Length : Transfer_Count_Type ) is
    Info : constant Transfer_Info := Memcopy_Info(Length);
  begin
    Setup_DMA_Transfer (Channel, Source, Dest, Info);
  end;

end GBA.DMA.Generic_Interfaces;