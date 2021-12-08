-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


procedure Sprites
  with Linker_Section => ".iwram";

pragma Machine_Attribute (Sprites, "target", "arm");