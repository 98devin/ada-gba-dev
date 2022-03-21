
-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

with GBA.Memory;
use  GBA.Memory;

private
package Test.Font is

  function Font_Data_Address
    return Address with Inline;

  function Font_Data_Length
    return Unsigned with Inline;

end Test.Font;