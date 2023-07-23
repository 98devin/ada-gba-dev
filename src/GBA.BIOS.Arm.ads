-- Copyright (c) 2023 Devin Hill
-- zlib License -- see LICENSE for details.


with GBA.BIOS.Raw.Arm;
with GBA.BIOS.Extended_Interface;

package GBA.BIOS.Arm is
  new GBA.BIOS.Extended_Interface (GBA.BIOS.Raw.Arm.Generic_Interface);
