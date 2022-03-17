
-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

with System, System.Unsigned_Types;
use  System, System.Unsigned_Types;

private
package Test.Font is

  subtype Font_Character is
    Character range Character'Val(16#00#) .. Character'Val(16#7F#);

  type Font_String is
    array (Positive range <>) of Font_Character;

  function Font_Data_Address
    return Address with Inline;

  function Font_Data_Length
    return Unsigned with Inline;

end Test.Font;