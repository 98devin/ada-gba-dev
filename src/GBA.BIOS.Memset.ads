
with System;
use  System;

with Interfaces.C;
use  Interfaces;


function GBA.BIOS.Memset
  ( Dest : in Address; Value : Integer; Num_Bytes : C.size_t ) return Address
  with Export, External_Name => "memset", Linker_Section => ".iwram";

pragma Machine_Attribute (Memset, "target", "arm");