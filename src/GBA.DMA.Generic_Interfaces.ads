
generic
  type Element_Type is private;
    
package GBA.DMA.Generic_Interfaces is

  pragma Compile_Time_Error ( Element_Type'Size mod 16 /= 0,  "Cannot trivially DMA copy types with alignment less than 2 bytes." );

  function Memset_Info ( Count : Transfer_Count_Type ) return Transfer_Info
    with Inline, Pure_Function;

  function Memcopy_Info ( Length : Transfer_Count_Type ) return Transfer_Info
    with Inline, Pure_Function;

  procedure Memset  ( Channel : Channel_ID; Source, Dest : Address; Count : Transfer_Count_Type )
    with Inline_Always;

  procedure Memcopy ( Channel : Channel_ID; Source, Dest : Address; Length : Transfer_Count_Type )
    with Inline_Always; 

end GBA.DMA.Generic_Interfaces;
