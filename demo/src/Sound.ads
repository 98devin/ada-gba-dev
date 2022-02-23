-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

procedure Sound
  with Linker_Section => ".iwram", No_Inline;

pragma Machine_Attribute (Sound, "target", "arm");