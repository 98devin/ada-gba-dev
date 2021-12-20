--  Copyright (c) 2021 Devin Hill
--  zlib License -- see LICENSE for details.

package body System.Allocation.Memory is

   function Alloc (Size : size_t) return System.Address
   is
      use all type SAA.Heap_Arena;

      Max_Align : constant := Standard'Maximum_Alignment;
      Res       : Address;
   begin
      Allocate (Heap, Res, SSE.Storage_Count (Size), Max_Align);
      return Res;
   end Alloc;

end System.Allocation.Memory;