--  Copyright (c) 2021 Devin Hill
--  zlib License -- see LICENSE for details.

with System.Parameters;
with System.Storage_Elements;
with System.Allocation.Arenas;

package System.Secondary_Stack is

   package SP renames System.Parameters;
   package SSE renames System.Storage_Elements;
   package SAA renames System.Allocation.Arenas;

   --  This package provides the interface GNAT requires
   --  to allocate items on the secondary stack. GNAT will allocate
   --  the stack for us, but we re-use the local arena allocator
   --  interface which other memory pools use.

   subtype SS_Stack is SAA.Local_Arena;

   type SS_Stack_Ptr is access all SS_Stack;

   procedure SS_Allocate
     (Addr         : out System.Address;
      Storage_Size : SSE.Storage_Count) with Inline;
   --  Allocate enough space for a Storage_Size bytes object with Maximum
   --  alignment. The address of the allocated space is returned in Addr.

   subtype Mark_Id is SAA.Marker;
   --  Type used to mark the stack for mark/release processing.

   function SS_Mark return SAA.Marker with Inline;
   --  Return the Mark corresponding to the current state of the stack

   procedure SS_Release (M : SAA.Marker) with Inline;
   --  Restore the state of the stack corresponding to the mark M

   function Get_Sec_Stack return SS_Stack_Ptr
      with Pure_Function, Inline;
   --  Get the pointer to the secondary stack data.
   --  Even though we know where it is statically, for some reason
   --  GNAT requires us to define this function by name.

private

   --  GNATbind will allocate an array of SS_Stack for us.
   --  Here, we export the values which it writes to so we can access
   --  the stacks at runtime to initialize them. We can see how to do
   --  so based on the generated b__<program>.adb files.

   Binder_Sec_Stacks_Count : Natural
      with Export, External_Name => "__gnat_binder_ss_count";
   --  The number of default sized secondary stacks allocated by the binder.

   Default_Secondary_Stack_Size : SP.Size_Type
      with Export, External_Name => "__gnat_default_ss_size";
   --  The size of the secondary stack (used for the discriminant)

   Default_Sized_SS_Pool : System.Address
      with Export, External_Name => "__gnat_default_ss_pool";
   --  The address of the array of stacks which GNAT generates.
   --  If secondary stacks are used at all, it will properly
   --  initialize this variable and everything will work out.

   SS_Pool : Integer;
   --  Empirically GNAT requires this variable for some reason.
   --  It must be present or else it won't allow secondary stack use.

end System.Secondary_Stack;
