------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                         I N T E R F A C E S . C                          --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
-- This specification is derived from the Ada Reference Manual for use with --
-- GNAT.  In accordance with the copyright of that document, you can freely --
-- copy and modify this specification,  provided that if you redistribute a --
-- modified version,  any changes that you have made are clearly indicated. --
--                                                                          --
------------------------------------------------------------------------------
-- SweetAda SFP cutted-down version                                         --
------------------------------------------------------------------------------
-- GBADA C conversion functions removed                                     --
------------------------------------------------------------------------------

with System.Parameters;

package Interfaces.C is
   pragma Pure;

   --  Declaration's based on C's <limits.h>

   CHAR_BIT  : constant := 8;
   SCHAR_MIN : constant := -128;
   SCHAR_MAX : constant := 127;
   UCHAR_MAX : constant := 255;

   --  Signed and Unsigned Integers. Note that in GNAT, we have ensured that
   --  the standard predefined Ada types correspond to the standard C types

   --  Note: the Integer qualifications used in the declaration of type long
   --  avoid ambiguities when compiling in the presence of s-auxdec.ads and
   --  a non-private system.address type.

   type int   is new Integer;
   type short is new Short_Integer;
   type long  is range -(2 ** (System.Parameters.long_bits - Integer'(1)))
     .. +(2 ** (System.Parameters.long_bits - Integer'(1))) - 1;
   type long_long is new Long_Long_Integer;

   type signed_char is range SCHAR_MIN .. SCHAR_MAX;
   for signed_char'Size use CHAR_BIT;

   type unsigned           is mod 2 ** int'Size;
   type unsigned_short     is mod 2 ** short'Size;
   type unsigned_long      is mod 2 ** long'Size;
   type unsigned_long_long is mod 2 ** long_long'Size;

   type unsigned_char is mod (UCHAR_MAX + 1);
   for unsigned_char'Size use CHAR_BIT;

   --  Note: the Integer qualifications used in the declaration of ptrdiff_t
   --  avoid ambiguities when compiling in the presence of s-auxdec.ads and
   --  a non-private system.address type.

   type ptrdiff_t is
     range -(2 ** (System.Parameters.ptr_bits - Integer'(1))) ..
           +(2 ** (System.Parameters.ptr_bits - Integer'(1)) - 1);

   type size_t is mod 2 ** System.Parameters.ptr_bits;

   ----------------------------
   -- Characters and Strings --
   ----------------------------

   type char is new Character;

   nul : constant char := char'First;

   function To_C   (Item : Character) return char
      with Inline_Always;
   function To_Ada (Item : char)      return Character
      with Inline_Always;

   type char_array is array (size_t range <>) of aliased char;
   for char_array'Component_Size use CHAR_BIT;

   function Is_Nul_Terminated (Item : char_array) return Boolean;

   ------------------------------------
   -- Wide Character and Wide String --
   ------------------------------------

   type wchar_t is new Wide_Character;
   for wchar_t'Size use Standard'Wchar_T_Size;

   wide_nul : constant wchar_t := wchar_t'First;

   function To_C   (Item : Wide_Character) return wchar_t
      with Inline_Always;
   function To_Ada (Item : wchar_t)        return Wide_Character
      with Inline_Always;

   type wchar_array is array (size_t range <>) of aliased wchar_t;

   function Is_Nul_Terminated (Item : wchar_array) return Boolean;

   type char16_t is new Wide_Character;

   char16_nul : constant char16_t := char16_t'Val (0);

   function To_C   (Item : Wide_Character) return char16_t;
   function To_Ada (Item : char16_t)       return Wide_Character;

   type char16_array is array (size_t range <>) of aliased char16_t;

   function Is_Nul_Terminated (Item : char16_array) return Boolean;

   type char32_t is new Wide_Wide_Character;

   char32_nul : constant char32_t := char32_t'Val (0);

   function To_C   (Item : Wide_Wide_Character) return char32_t
      with Inline_Always;
   function To_Ada (Item : char32_t)            return Wide_Wide_Character
      with Inline_Always;

   type char32_array is array (size_t range <>) of aliased char32_t;

   function Is_Nul_Terminated (Item : char32_array) return Boolean;

end Interfaces.C;
