
with GBA.BIOS.Raw.Thumb;
with GBA.BIOS.Extended_Interface;

package GBA.BIOS.Thumb is
  new GBA.BIOS.Extended_Interface (GBA.BIOS.Raw.Thumb.Generic_Interface);
