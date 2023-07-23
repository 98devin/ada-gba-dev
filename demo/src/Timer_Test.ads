-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.

procedure Timer_Test
  with Linker_Section => ".iwram", No_Inline;

pragma Machine_Attribute (Timer_Test, "target", "arm");