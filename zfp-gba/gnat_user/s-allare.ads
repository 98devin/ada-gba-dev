
with System.Storage_Elements;

--
--  Linear allocators which manage a particular address space.
--  Memory can be recovered only in blocks.
--

package System.Allocation.Arenas is

   pragma Elaborate_Body;

   package SSE renames System.Storage_Elements;

   --  Represents a watermark within the allocated memory.
   --  Memory in the arena before this marker can remain allocated,
   --  while memory following it will be reused.
   --
   type Marker is private;

   --
   --  Arena which controls a range of arbitrary addresses in memory.
   --
   type Heap_Arena (<>) is limited private;

   pragma Simple_Storage_Pool_Type (Heap_Arena);

   procedure Allocate
      (Pool            : in out Heap_Arena;
       Storage_Address : out System.Address;
       Storage_Size    : SSE.Storage_Count;
       Alignment       : SSE.Storage_Count)
      with Inline;

   function Storage_Size (Pool : Heap_Arena) return SSE.Storage_Count
      with Inline;

   function Mark (Pool : Heap_Arena) return Marker
      with Inline;

   procedure Release (Pool : in out Heap_Arena; Mark : Marker)
      with Inline;

   function Create_Arena (Start_Address, End_Address : Address)
      return Heap_Arena
         with Inline_Always;

   --
   --  Arena which controls a region of the stack,
   --  Or which manages a sub-region of heap memory of a specified size.
   --
   type Local_Arena (Size : SSE.Storage_Count) is limited private;

   pragma Simple_Storage_Pool_Type (Local_Arena);

   procedure Allocate
      (Pool            : in out Local_Arena;
       Storage_Address : out System.Address;
       Storage_Size    : SSE.Storage_Count;
       Alignment       : SSE.Storage_Count)
       with Inline;

   function Storage_Size (Pool : Local_Arena) return SSE.Storage_Count
      with Inline;

   function Mark (Pool : Local_Arena) return Marker
      with Inline;

   procedure Release (Pool : in out Local_Arena; Mark : Marker)
      with Inline;

   function Create_Arena (Local_Size : SSE.Storage_Count) return Local_Arena
      with Inline_Always;

   procedure Init_Arena (Pool : in out Local_Arena)
      with Inline_Always;

private

   type Marker is new Address;

   type Heap_Arena is limited
      record
         Start_Address, End_Address, Top_Address : Address;
      end record;

   type Aligned_Storage_Array is
      new SSE.Storage_Array with Alignment => Standard'Maximum_Alignment;

   type Local_Arena (Size : SSE.Storage_Count) is limited
      record
         Heap    : Heap_Arena;
         Storage : aliased Aligned_Storage_Array (1 .. Size);
      end record
         with Alignment => Standard'Maximum_Alignment;

end System.Allocation.Arenas;
