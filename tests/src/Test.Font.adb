
--  Copyright (c) 2022 Devin Hill
--  zlib License -- see LICENSE for details.

with System;

package body Test.Font is

  use all type System.Address;

  Font_Begin : Character
    with Import, External_Name => "font_begin";

  Font_End : Character
    with Import, External_Name => "font_end";

  function Font_Data_Address return Address
    is ( Font_Begin'Address );

  function Font_Data_Length return Unsigned
    is ( Unsigned (Font_End'Address - Font_Begin'Address) );

end Test.Font;