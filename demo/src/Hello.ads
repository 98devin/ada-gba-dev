-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.

procedure Hello
  with Linker_Section => ".iwram", No_Inline;

pragma Machine_Attribute (Hello, "target", "arm");