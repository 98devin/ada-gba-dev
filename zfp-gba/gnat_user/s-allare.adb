
package body System.Allocation.Arenas is

   use SSE;

   procedure Allocate
      (Pool            : in out Heap_Arena;
       Storage_Address : out System.Address;
       Storage_Size    : Storage_Count;
       Alignment       : Storage_Count) is

      Align_Mask      : constant Address := Address (Alignment - 1);
      Aligned_Address : constant Address :=
         (Pool.Top_Address + Align_Mask) and not Align_Mask;
   begin
      Storage_Address  := Aligned_Address;
      Pool.Top_Address := Aligned_Address + Storage_Size;

      if Pool.Top_Address > Pool.End_Address then
         raise Storage_Error;
      end if;
   end Allocate;

   function Storage_Size (Pool : Heap_Arena) return Storage_Count is
      (Storage_Count'(Pool.End_Address - Pool.Start_Address));

   function Mark (Pool : Heap_Arena) return Marker is
      (Marker (Pool.Top_Address));

   procedure Release (Pool : in out Heap_Arena; Mark : Marker) is
   begin
      Pool.Top_Address := Address (Mark);
   end Release;

   procedure Allocate
      (Pool            : in out Local_Arena;
       Storage_Address : out System.Address;
       Storage_Size    : Storage_Count;
       Alignment       : Storage_Count) is
   begin
      Allocate (Pool.Heap, Storage_Address, Storage_Size, Alignment);
   end Allocate;

   function Storage_Size (Pool : Local_Arena) return Storage_Count is
      (Storage_Size (Pool.Heap));

   function Mark (Pool : Local_Arena) return Marker is
      (Mark (Pool.Heap));

   procedure Release (Pool : in out Local_Arena; Mark : Marker) is
   begin
      Release (Pool.Heap, Mark);
   end Release;

   function Create_Arena (Start_Address, End_Address : Address)
      return Heap_Arena
   is
      pragma Assert (End_Address >= Start_Address);
   begin
      return Heap_Arena'
         (Top_Address | Start_Address => Start_Address,
          End_Address => End_Address);
   end Create_Arena;

   function Create_Arena (Local_Size : Storage_Count) return Local_Arena is
   begin
      return A : Local_Arena (Local_Size) do
         Init_Arena (A);
      end return;
   end Create_Arena;

   procedure Init_Arena (Pool : in out Local_Arena) is
   begin
      Pool.Heap.Top_Address   := Pool.Storage'Address;
      Pool.Heap.Start_Address := Pool.Storage'Address;
      Pool.Heap.End_Address   := Pool.Storage'Address + Pool.Size;
   end Init_Arena;

end System.Allocation.Arenas;