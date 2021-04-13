
package body GBA.DMA is

  procedure Setup_DMA_Transfer
    ( Channel       : Channel_ID;
      Source, Dest  : Address;
      Info          : Transfer_Info ) is

    Selected_Channel : Channel_Info renames Channel_Array_View (Channel);
  begin
    Selected_Channel.Source   := Source;
    Selected_Channel.Dest     := Dest;
    Selected_Channel.DMA_Info := Info'Update (Enabled => True);
  end;

  procedure Stop_Ongoing_Transfer (Channel : Channel_ID) is
    Selected_Channel : Channel_Info renames Channel_Array_View (Channel);
  begin
    Selected_Channel.DMA_Info.Enabled := False;
  end;

  function Is_Transfer_Ongoing (Channel : Channel_ID) return Boolean is
    Selected_Channel : Channel_Info renames Channel_Array_View (Channel);
  begin
    return Selected_Channel.DMA_Info.Enabled;
  end;

end GBA.DMA;