-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.BIOS.Raw.Thumb;
with GBA.BIOS.Extended_Interface;

package GBA.BIOS.Thumb is
  new GBA.BIOS.Extended_Interface (GBA.BIOS.Raw.Thumb.Generic_Interface);
