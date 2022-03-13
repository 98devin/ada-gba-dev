------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                         I N T E R F A C E S . C                          --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 1992-2020, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
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
-- SweetAda SFP cutted-down version                                         --
------------------------------------------------------------------------------

package body Interfaces.C is

   -----------------------
   -- Is_Nul_Terminated --
   -----------------------

   --  Case of char_array

   function Is_Nul_Terminated (Item : char_array) return Boolean is
   begin
      for J in Item'Range loop
         if Item (J) = nul then
            return True;
         end if;
      end loop;

      return False;
   end Is_Nul_Terminated;

   --  Case of wchar_array

   function Is_Nul_Terminated (Item : wchar_array) return Boolean is
   begin
      for J in Item'Range loop
         if Item (J) = wide_nul then
            return True;
         end if;
      end loop;

      return False;
   end Is_Nul_Terminated;

   --  Case of char16_array

   function Is_Nul_Terminated (Item : char16_array) return Boolean is
   begin
      for J in Item'Range loop
         if Item (J) = char16_nul then
            return True;
         end if;
      end loop;

      return False;
   end Is_Nul_Terminated;

   --  Case of char32_array

   function Is_Nul_Terminated (Item : char32_array) return Boolean is
   begin
      for J in Item'Range loop
         if Item (J) = char32_nul then
            return True;
         end if;
      end loop;

      return False;
   end Is_Nul_Terminated;

   ------------
   -- To_Ada --
   ------------

   --  Convert char to Character

   function To_Ada (Item : char) return Character is
   begin
      return Character'Val (char'Pos (Item));
   end To_Ada;

   --  Convert wchar_t to Wide_Character

   function To_Ada (Item : wchar_t) return Wide_Character is
   begin
      return Wide_Character (Item);
   end To_Ada;

   --  Convert char16_t to Wide_Character

   function To_Ada (Item : char16_t) return Wide_Character is
   begin
      return Wide_Character'Val (char16_t'Pos (Item));
   end To_Ada;

   --  Convert char32_t to Wide_Wide_Character

   function To_Ada (Item : char32_t) return Wide_Wide_Character is
   begin
      return Wide_Wide_Character'Val (char32_t'Pos (Item));
   end To_Ada;

   ----------
   -- To_C --
   ----------

   --  Convert Character to char

   function To_C (Item : Character) return char is
   begin
      return char'Val (Character'Pos (Item));
   end To_C;

   --  Convert Wide_Character to wchar_t

   function To_C (Item : Wide_Character) return wchar_t is
   begin
      return wchar_t (Item);
   end To_C;

   --  Convert Wide_Character to char16_t

   function To_C (Item : Wide_Character) return char16_t is
   begin
      return char16_t'Val (Wide_Character'Pos (Item));
   end To_C;

   --  Convert Wide_Character to char32_t

   function To_C (Item : Wide_Wide_Character) return char32_t is
   begin
      return char32_t'Val (Wide_Wide_Character'Pos (Item));
   end To_C;

end Interfaces.C;
