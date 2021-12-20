-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


procedure Hello
  with Linker_Section => ".iwram";

pragma Machine_Attribute (Hello, "target", "arm");