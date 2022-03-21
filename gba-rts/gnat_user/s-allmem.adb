
--  Copyright (c) 2022 Devin Hill
--  zlib License -- see LICENSE for details.

package body System.Allocation.Memory is

   function Alloc (Size : size_t) return System.Address is
      Result : System.Address;
   begin
      Heap.Allocate (Result, Size, Standard'Maximum_Alignment);
      return Result;
   end Alloc;

end System.Allocation.Memory;