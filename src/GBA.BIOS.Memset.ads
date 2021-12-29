-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with System;
use  System;

with Interfaces.C;
use  Interfaces;


function GBA.BIOS.Memset
  ( Dest : in Address; Value : Integer; Num_Bytes : C.size_t ) return Address
  with Linker_Section => ".iwram";

pragma Machine_Attribute (Memset, "target", "arm");