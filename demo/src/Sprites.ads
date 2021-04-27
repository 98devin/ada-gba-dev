
procedure Sprites
  with Linker_Section => ".iwram";

pragma Machine_Attribute (Sprites, "target", "arm");