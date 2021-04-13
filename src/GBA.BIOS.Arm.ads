
with GBA.BIOS.Raw.Arm;
with GBA.BIOS.Extended_Interface;

package GBA.BIOS.Arm is
  new GBA.BIOS.Extended_Interface (GBA.BIOS.Raw.Arm.Generic_Interface);
