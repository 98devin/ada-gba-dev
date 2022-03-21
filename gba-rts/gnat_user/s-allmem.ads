--  Copyright (c) 2021 Devin Hill
--  zlib License -- see LICENSE for details.

with System.Parameters;
with System.Allocation.Linear_Pools;
with System.Storage_Elements;

package System.Allocation.Memory is

   package SP renames System.Parameters;
   package SAL renames System.Allocation.Linear_Pools;
   package SSE renames System.Storage_Elements;

   Heap_Start : constant Character
      with Alignment => Standard'Maximum_Alignment;
   pragma Import (C, Heap_Start, "__eheap_start");
   --  The address of the variable is the start of the heap

   Heap_End : constant Character
      with Alignment => Standard'Maximum_Alignment;
   pragma Import (C, Heap_End, "__eheap_end");
   --  The address of the variable is the end of the heap

   Heap : SAL.Linear_Pool (Heap_Start'Address, Heap_End'Address);

   subtype size_t is SSE.Storage_Count;
   --  Note: the reason we redefine this here instead of using the
   --  definition in Interfaces.C is that we do not want to drag in
   --  all of Interfaces.C just because System.Memory is used.

   function Alloc (Size : size_t) return System.Address
      with Convention => C, Export, External_Name => "__gnat_malloc";

end System.Allocation.Memory;