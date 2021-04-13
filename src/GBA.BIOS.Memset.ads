
with System;
use  System;

with Interfaces;
use  Interfaces;

procedure GBA.BIOS.Memset
  ( Dest : in Address; Value : Integer; Num_Bytes : Unsigned_32 )
  with Export, External_Name => "memset", Linker_Section => ".iwram";

pragma Machine_Attribute (Memset, "target", "arm");