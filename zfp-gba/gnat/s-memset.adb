------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--                     S Y S T E M .  M E M O R Y _ S E T                   --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--            Copyright (C) 2006-2020, Free Software Foundation, Inc.       --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

with System;       use System;
with Interfaces;   use Interfaces;
with Interfaces.C; use Interfaces.C;

package body System.Memory_Set is

   function Shift_Left (V : Word; Amount : Natural) return Word;
   pragma Import (Intrinsic, Shift_Left);

   ------------
   -- memset --
   ------------

   function memset (M : Address; C : Integer; Size : size_t) return Address is
      B  : constant Byte := Byte (C mod 256);
      D  : Address := M;
      N  : size_t  := Size;
      CW : Word;

      Word_Bytes : constant := Word_Size / 8;
      Half_Bytes : constant := Word_Bytes / 2;

   begin
      CW := Word (B);
      CW := Shift_Left (CW, 8) or CW;
      CW := Shift_Left (CW, 16) or CW;

      --  Try to set per word, if alignment constraints are respected

      if (M and (Word'Alignment - 1)) = 0 then
         while N >= Word_Bytes loop
            Word'Deref (M) := CW;
            N := N - Word_Bytes;
            D := D + Word_Bytes;
         end loop;
      end if;

      if (D and (Unsigned_16'Alignment - 1)) = 0
         and then N >= Half_Bytes
      then
         Unsigned_16'Deref (D) := Unsigned_16'Mod (CW);
         N := N - Half_Bytes;
         D := D + Half_Bytes;
      end if;

      --  Set the remaining byte per byte

      while N > 0 loop
         Byte'Deref (D) := B;
         N := N - 1;
         D := D + 1;
      end loop;

      return M;
   end memset;

end System.Memory_Set;
