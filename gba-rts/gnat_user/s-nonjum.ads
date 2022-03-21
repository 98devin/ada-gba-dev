
--  Copyright (c) 2022 Devin Hill
--  zlib License -- see LICENSE for details.

package System.Nonlocal_Jumps is

   type Jump_Buffer is private
      with Preelaborable_Initialization;

   function Set_Jump (Buf : not null access Jump_Buffer) return Integer
      with Import, Convention => Intrinsic,
         External_Name => "__builtin_setjmp";

   procedure Jump (Buf : not null access Jump_Buffer; Val : Integer := 1)
      with Import, Convention => Intrinsic,
         External_Name => "__builtin_longjmp";

private

   type Jump_Buffer is array (1 .. 5) of Address;

end System.Nonlocal_Jumps;
