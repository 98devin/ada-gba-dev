--  Copyright (c) 2021 Devin Hill
--  zlib License -- see LICENSE for details.

with System.Parameters;

package body System.Allocation.Linear_Pools is

   use SSE;
   use all type System.Parameters.Size_Type;

   overriding
   procedure Allocate
     (Pool                     : in out Linear_Pool;
      Storage_Address          : out Address;
      Size_In_Storage_Elements : SSE.Storage_Count;
      Alignment                : SSE.Storage_Count) is

      Align_Mask      : constant Address := Address (Alignment - 1);
      Aligned_Address : constant Address :=
         (Pool.Top_Address + Align_Mask) and not Align_Mask;
   begin
      Storage_Address  := Aligned_Address;
      Pool.Top_Address := Aligned_Address + Size_In_Storage_Elements;

      if Pool.Top_Address > Pool.End_Address then
         raise Storage_Error;
      end if;
   end Allocate;

   overriding
   function Storage_Size (Pool : Linear_Pool) return Storage_Count is
      (Storage_Count'(Pool.End_Address - Pool.Top_Address));

   function Mark (Pool : Linear_Pool) return Marker is
      (Marker (Pool.Top_Address));

   overriding
   procedure Release (Pool : in out Linear_Pool; Mark : Marker) is
   begin
      Pool.Top_Address := Address (Mark);
   end Release;

   procedure Reset (Pool : in out Linear_Pool) is
   begin
      Pool.Top_Address := Pool.Start_Address;
   end Reset;

   function Init_Top_Address (Pool : access Owning_Linear_Pool'Class)
      return Address is (Pool.Storage'Address);

   overriding
   procedure Allocate
     (Pool                     : in out Owning_Linear_Pool;
      Storage_Address          : out Address;
      Size_In_Storage_Elements : SSE.Storage_Count;
      Alignment                : SSE.Storage_Count) is

      Align_Mask      : constant Address := Address (Alignment - 1);
      Aligned_Address : constant Address :=
         (Pool.Top_Address + Align_Mask) and not Align_Mask;
   begin
      Storage_Address  := Aligned_Address;
      Pool.Top_Address := Aligned_Address + Size_In_Storage_Elements;

      if Pool.Top_Address > Pool.Storage'Address + Pool.Size then
         raise Storage_Error;
      end if;
   end Allocate;

   overriding
   function Storage_Size (Pool : Owning_Linear_Pool) return Storage_Count is
      (Storage_Count'(Pool.Storage'Address + Pool.Size - Pool.Top_Address));

   overriding
   function Mark (Pool : Owning_Linear_Pool) return Marker is
      (Marker (Pool.Top_Address));

   overriding
   procedure Release (Pool : in out Owning_Linear_Pool; Mark : Marker) is
   begin
      Pool.Top_Address := Address (Mark);
   end Release;

   procedure Reset (Pool : in out Owning_Linear_Pool) is
   begin
      Pool.Top_Address := Init_Top_Address (Pool'Access);
   end Reset;

end System.Allocation.Linear_Pools;