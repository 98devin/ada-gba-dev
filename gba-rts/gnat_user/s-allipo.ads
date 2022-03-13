--  Copyright (c) 2021 Devin Hill
--  zlib License -- see LICENSE for details.

with System.Storage_Pools;
with System.Storage_Elements;

--
--  Linear allocators which manage a particular address space.
--  Memory can be recovered only in blocks.
--

package System.Allocation.Linear_Pools is

   package SSP renames System.Storage_Pools;
   package SSE renames System.Storage_Elements;

   --  Represents a watermark within the allocated memory.
   --  Memory in the arena before this marker can remain allocated,
   --  while memory following it will be reused.
   --
   subtype Marker is SSP.Marker;

   --
   --  Arena which controls a range of arbitrary addresses in memory.
   --
   type Linear_Pool (Start_Address, End_Address : Address) is limited
      new SSP.Mark_Release_Storage_Pool with private;

   overriding
   procedure Allocate
     (Pool                     : in out Linear_Pool;
      Storage_Address          : out Address;
      Size_In_Storage_Elements : SSE.Storage_Count;
      Alignment                : SSE.Storage_Count)
      with Inline;

   overriding
   function Storage_Size (Pool : Linear_Pool) return SSE.Storage_Count
      with Inline;

   overriding
   function Mark (Pool : Linear_Pool) return Marker
      with Inline;

   overriding
   procedure Release (Pool : in out Linear_Pool; Mark : Marker)
      with Inline;

   procedure Reset (Pool : in out Linear_Pool)
      with Inline;

   --
   --  Arena which controls a region of the stack,
   --  Or which manages a sub-region of heap memory of a specified size.
   --
   type Owning_Linear_Pool (Size : SSE.Storage_Count) is limited
      new SSP.Mark_Release_Storage_Pool with private;

   overriding
   procedure Allocate
     (Pool                     : in out Owning_Linear_Pool;
      Storage_Address          : out Address;
      Size_In_Storage_Elements : SSE.Storage_Count;
      Alignment                : SSE.Storage_Count)
       with Inline;

   overriding
   function Storage_Size (Pool : Owning_Linear_Pool) return SSE.Storage_Count
      with Inline;

   overriding
   function Mark (Pool : Owning_Linear_Pool) return Marker
      with Inline;

   overriding
   procedure Release (Pool : in out Owning_Linear_Pool; Mark : Marker)
      with Inline;

   procedure Reset (Pool : in out Owning_Linear_Pool)
      with Inline;

private

   type Linear_Pool (Start_Address, End_Address : Address) is limited
      new SSP.Mark_Release_Storage_Pool with
         record
            Top_Address : Address := Start_Address;
         end record;

   function Init_Top_Address (Pool : access Owning_Linear_Pool'Class)
      return Address with Inline_Always;

   type Aligned_Storage_Array is
      new SSE.Storage_Array with Alignment => Standard'Maximum_Alignment;
   type Owning_Linear_Pool (Size : SSE.Storage_Count) is limited
      new SSP.Mark_Release_Storage_Pool with
         record
            Top_Address : Address
               := Init_Top_Address (Owning_Linear_Pool'Access);
            Storage     : aliased Aligned_Storage_Array (1 .. Size);
         end record;

end System.Allocation.Linear_Pools;
