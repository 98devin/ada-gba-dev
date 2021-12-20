------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                   S Y S T E M . P O O L _ G L O B A L                    --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--                                                                          --
--        Copyright (C) 1992,1993,1994 Free Software Foundation, Inc.       --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT;  see file COPYING.  If not, write --
-- to  the Free Software Foundation,  59 Temple Place - Suite 330,  Boston, --
-- MA 02111-1307, USA.                                                      --
--                                                                          --
-- As a special exception,  if other files  instantiate  generics from this --
-- unit, or you link  this unit with other files  to produce an executable, --
-- this  unit  does not  by itself cause  the resulting  executable  to  be --
-- covered  by the  GNU  General  Public  License.  This exception does not --
-- however invalidate  any other reasons why  the executable file  might be --
-- covered by the  GNU Public License.                                      --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------
-- GBADA: Modified to use arena allocation.                                 --
------------------------------------------------------------------------------

--  Storage pool corresponding to default global storage pool used for types
--  for which no storage pool is specified.

with System;
with System.Storage_Elements;
with System.Allocation.Arenas;
with System.Allocation.Memory;

pragma Elaborate (System.Allocation.Memory);

package System.Pool_Global is

   package SAA renames System.Allocation.Arenas;
   package SAM renames System.Allocation.Memory;
   package SSE renames System.Storage_Elements;

   --  Pool object used by the compiler when implicit Storage Pool objects are
   --  explicitly referred to. For instance when writing something like:
   --     for T'Storage_Pool use Q'Storage_Pool;
   --  and Q'Storage_Pool hasn't been defined explicitly.
   Global_Pool_Object : SAA.Heap_Arena renames SAM.Heap;

   function Storage_Size
      (Pool : SAA.Heap_Arena) return System.Storage_Elements.Storage_Count
      renames SAA.Storage_Size;

   procedure Allocate
     (Pool         : in out SAA.Heap_Arena;
      Address      : out System.Address;
      Storage_Size : SSE.Storage_Count;
      Alignment    : SSE.Storage_Count)
      renames SAA.Allocate;

   --  Deallocation in an arena can only be done by saving and restoring
   --  a watermark in the System.Allocation.Memory.Heap object.
   procedure Deallocate
     (Pool         : in out SAA.Heap_Arena;
      Address      : System.Address;
      Storage_Size : SSE.Storage_Count;
      Alignment    : SSE.Storage_Count)
         is null;

end System.Pool_Global;
