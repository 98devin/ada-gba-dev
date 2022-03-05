--  Copyright (c) 2021 Devin Hill
--  zlib License -- see LICENSE for details.

package body System.Secondary_Stack is

   use all type SS_Stack;

   Sec_Stack : aliased SS_Stack
      (SSE.Storage_Count (Default_Secondary_Stack_Size))
      with Import, Address => Default_Sized_SS_Pool;

   -------------------
   -- Get_Sec_Stack --
   -------------------

   function Get_Sec_Stack return SS_Stack_Ptr is
   begin
      return Sec_Stack'Unrestricted_Access;
   end Get_Sec_Stack;

   -----------------
   -- SS_Allocate --
   -----------------

   procedure SS_Allocate
     (Addr         : out Address;
      Storage_Size : SSE.Storage_Count) is
   begin
      Allocate
         (Sec_Stack
         , Addr
         , Storage_Size
         , Standard'Maximum_Alignment
         );
   end SS_Allocate;

   -------------
   -- SS_Mark --
   -------------

   function SS_Mark return SAL.Marker is
   begin
      return Mark (Sec_Stack);
   end SS_Mark;

   ----------------
   -- SS_Release --
   ----------------

   procedure SS_Release (M : SAL.Marker) is
   begin
      Release (Sec_Stack, M);
   end SS_Release;

begin

   --  We need to manually initialize the secondary stack allocator
   --  since we use `Import` which will skip default initialization.
   if Binder_Sec_Stacks_Count /= 0 then
      Reset (Sec_Stack);
   end if;

end System.Secondary_Stack;
