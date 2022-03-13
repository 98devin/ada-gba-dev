--  Copyright (c) 2022 Devin Hill
--  zlib License -- see LICENSE for details.

function System.Memcmp (M1, M2 : Address; Length : Integer) return Integer
  with Linker_Section => ".iwram.memcmp"
     , Export
     , External_Name => "memcmp"
     , Convention => C;

pragma Machine_Attribute (System.Memcmp, "target", "arm");