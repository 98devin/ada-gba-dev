------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                   S Y S T E M . P O O L _ G L O B A L                    --
--                                                                          --
--                                 S p e c                                  --
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

--  Storage pool corresponding to default global storage pool used for types
--  for which no storage pool is specified.

with System;
with System.Storage_Elements;
with System.Allocation.Arenas;

with System.Memory;
pragma Elaborate (System.Memory);
--  Needed to ensure that library routines can execute allocators

package System.Pool_Global is

   --  Allocation strategy:

   --    Call to malloc/free for each Allocate/Deallocate
   --    No user specifiable size
   --    No automatic reclaim
   --    Minimal overhead

   --  Pool simulating the allocation/deallocation strategy used by the
   --  compiler for access types globally declared.

   package SAA renames System.Allocation.Arenas;
   package SSE renames System.Storage_Elements;

   --  Pool object used by the compiler when implicit Storage Pool objects are
   --  explicitly referred to. For instance when writing something like:
   --     for T'Storage_Pool use Q'Storage_Pool;
   --  and Q'Storage_Pool hasn't been defined explicitly.
   Global_Pool_Object : SAA.Heap_Arena
      renames System.Memory.Heap;

   function Storage_Size
      (Pool : SAA.Heap_Arena) return System.Storage_Elements.Storage_Count
      renames SAA.Storage_Size;

   procedure Allocate
     (Pool         : in out SAA.Heap_Arena;
      Address      : out System.Address;
      Storage_Size : SSE.Storage_Count;
      Alignment    : SSE.Storage_Count)
      renames SAA.Allocate;

   procedure Deallocate
     (Pool         : in out SAA.Heap_Arena;
      Address      : System.Address;
      Storage_Size : SSE.Storage_Count;
      Alignment    : SSE.Storage_Count)
         is null;

end System.Pool_Global;
