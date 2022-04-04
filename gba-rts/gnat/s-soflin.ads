------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                    S Y S T E M . S O F T _ L I N K S                     --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 1992-2022, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
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
-- GBADA: Some exception-related code removed.                              --
------------------------------------------------------------------------------

--  This package contains a set of subprogram access variables that access
--  some low-level primitives that are different depending whether tasking is
--  involved or not (e.g. the Get/Set_Jmpbuf_Address that needs to provide a
--  different value for each task). To avoid dragging in the tasking runtimes
--  all the time, we use a system of soft links where the links are
--  initialized to non-tasking versions, and then if the tasking support is
--  initialized, they are set to the real tasking versions.

with Ada.Exceptions;
with System.Parameters;
with System.Secondary_Stack;

package System.Soft_Links is

   package SST renames System.Secondary_Stack;

   --  First we have the access subprogram types used to establish the links.
   --  The approach is to establish variables containing access subprogram
   --  values, which by default point to dummy no tasking versions of routines.

   type No_Param_Proc     is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);
   pragma Suppress_Initialization (No_Param_Proc);
   --  Some uninitialized objects of that type are initialized by the Binder
   --  so it is important that such objects are not reset to null during
   --  elaboration.

   type Addr_Param_Proc   is access procedure (Addr : Address);
   pragma Favor_Top_Level (Addr_Param_Proc);

   type Get_Address_Call  is access function return Address;
   pragma Favor_Top_Level (Get_Address_Call);
   type Set_Address_Call  is access procedure (Addr : Address);
   pragma Favor_Top_Level (Set_Address_Call);
   type Set_Address_Call2 is access procedure
     (Self_ID : Address; Addr : Address);
   pragma Favor_Top_Level (Set_Address_Call2);

   type Get_Integer_Call  is access function return Integer;
   pragma Favor_Top_Level (Get_Integer_Call);
   type Set_Integer_Call  is access procedure (Len : Integer);
   pragma Favor_Top_Level (Set_Integer_Call);

   type Get_Stack_Call    is access function return SST.SS_Stack_Ptr;
   pragma Favor_Top_Level (Get_Stack_Call);
   type Set_Stack_Call    is access procedure (Stack : SST.SS_Stack_Ptr);
   pragma Favor_Top_Level (Set_Stack_Call);

   type Task_Name_Call is access
     function return String;
   pragma Favor_Top_Level (Task_Name_Call);

   --  Suppress checks on all these types, since we know the corresponding
   --  values can never be null (the soft links are always initialized).

   pragma Suppress (Access_Check, No_Param_Proc);
   pragma Suppress (Access_Check, Addr_Param_Proc);
   pragma Suppress (Access_Check, Get_Address_Call);
   pragma Suppress (Access_Check, Set_Address_Call);
   pragma Suppress (Access_Check, Set_Address_Call2);
   pragma Suppress (Access_Check, Get_Integer_Call);
   pragma Suppress (Access_Check, Set_Integer_Call);
   pragma Suppress (Access_Check, Get_Stack_Call);
   pragma Suppress (Access_Check, Set_Stack_Call);
   pragma Suppress (Access_Check, Task_Name_Call);

   --  The following one is not related to tasking/no-tasking but to the
   --  traceback decorators for exceptions.

   type Traceback_Decorator_Wrapper_Call is access
     function (Traceback : System.Address;
               Len       : Natural)
               return      String;
   pragma Favor_Top_Level (Traceback_Decorator_Wrapper_Call);

   --  Declarations for the no tasking versions of the required routines

   procedure Abort_Defer_NT;
   --  Defer task abort (non-tasking case, does nothing)

   procedure Abort_Undefer_NT;
   --  Undefer task abort (non-tasking case, does nothing)

   procedure Abort_Handler_NT;
   --  Handle task abort (non-tasking case, does nothing). Currently, no port
   --  makes use of this, but we retain the interface for possible future use.

   function Check_Abort_Status_NT return Integer;
   --  Returns Boolean'Pos (True) iff abort signal should raise
   --  Standard'Abort_Signal.

   procedure Task_Lock_NT;
   --  Lock out other tasks (non-tasking case, does nothing)

   procedure Task_Unlock_NT;
   --  Release lock set by Task_Lock (non-tasking case, does nothing)

   procedure Adafinal_NT;
   --  Shuts down the runtime system (non-tasking case)

   Abort_Defer : No_Param_Proc := Abort_Defer_NT'Access;
   pragma Suppress (Access_Check, Abort_Defer);
   --  Defer task abort (task/non-task case as appropriate)

   Abort_Undefer : No_Param_Proc := Abort_Undefer_NT'Access;
   pragma Suppress (Access_Check, Abort_Undefer);
   --  Undefer task abort (task/non-task case as appropriate)

   Abort_Handler : No_Param_Proc := Abort_Handler_NT'Access;
   --  Handle task abort (task/non-task case as appropriate)

   Check_Abort_Status : Get_Integer_Call := Check_Abort_Status_NT'Access;
   --  Called when Abort_Signal is delivered to the process.  Checks to
   --  see if signal should result in raising Standard'Abort_Signal.

   Lock_Task : No_Param_Proc := Task_Lock_NT'Access;
   --  Locks out other tasks. Preceding a section of code by Task_Lock and
   --  following it by Task_Unlock creates a critical region. This is used
   --  for ensuring that a region of non-tasking code (such as code used to
   --  allocate memory) is tasking safe. Note that it is valid for calls to
   --  Task_Lock/Task_Unlock to be nested, and this must work properly, i.e.
   --  only the corresponding outer level Task_Unlock will actually unlock.
   --  This routine also prevents against asynchronous aborts (abort is
   --  deferred).

   Unlock_Task : No_Param_Proc := Task_Unlock_NT'Access;
   --  Releases lock previously set by call to Lock_Task. In the nested case,
   --  all nested locks must be released before other tasks competing for the
   --  tasking lock are released.
   --
   --  In the non nested case, this routine terminates the protection against
   --  asynchronous aborts introduced by Lock_Task (unless abort was already
   --  deferred before the call to Lock_Task (e.g in a protected procedures).
   --
   --  Note: the recommended protocol for using Lock_Task and Unlock_Task
   --  is as follows:
   --
   --    Locked_Processing : begin
   --       System.Soft_Links.Lock_Task.all;
   --       ...
   --       System.Soft_Links.Unlock_Task.all;
   --
   --    exception
   --       when others =>
   --          System.Soft_Links.Unlock_Task.all;
   --          raise;
   --    end Locked_Processing;
   --
   --  This ensures that the lock is not left set if an exception is raised
   --  explicitly or implicitly during the critical locked region.

   Finalize_Library_Objects : No_Param_Proc;
   pragma Export (C, Finalize_Library_Objects,
                  "__gnat_finalize_library_objects");
   --  Will be initialized by the binder

   Adafinal : No_Param_Proc := Adafinal_NT'Access;
   --  Performs the finalization of the Ada Runtime

   function  Get_Jmpbuf_Address_NT return  Address;
   procedure Set_Jmpbuf_Address_NT (Addr : Address);

   Get_Jmpbuf_Address : Get_Address_Call := Get_Jmpbuf_Address_NT'Access;
   Set_Jmpbuf_Address : Set_Address_Call := Set_Jmpbuf_Address_NT'Access;

   function  Get_Sec_Stack_NT return  SST.SS_Stack_Ptr;
   procedure Set_Sec_Stack_NT (Stack : SST.SS_Stack_Ptr);

   Get_Sec_Stack : Get_Stack_Call := Get_Sec_Stack_NT'Access;
   Set_Sec_Stack : Set_Stack_Call := Set_Sec_Stack_NT'Access;

   --------------------------
   -- Master_Id Soft-Links --
   --------------------------

   --  Soft-Links are used for procedures that manipulate Master_Ids because
   --  a Master_Id must be generated for access to limited class-wide types,
   --  whose root may be extended with task components.

   function Current_Master_NT return Integer;
   procedure Enter_Master_NT;
   procedure Complete_Master_NT;

   Current_Master  : Get_Integer_Call := Current_Master_NT'Access;
   Enter_Master    : No_Param_Proc    := Enter_Master_NT'Access;
   Complete_Master : No_Param_Proc    := Complete_Master_NT'Access;

   --------------------------
   -- Task Name Soft-Links --
   --------------------------

   function Task_Name_NT return String;

   Task_Name : Task_Name_Call := Task_Name_NT'Access;

   ------------------------
   -- Task Specific Data --
   ------------------------

   --  Here we define a single type that encapsulates the various task
   --  specific data. This type is used to store the necessary data into the
   --  Task_Control_Block or into a global variable in the non tasking case.

   type TSD is record
      Jmpbuf_Address : System.Address;
      --  Address of jump buffer used to store the address of the current
      --  longjmp/setjmp buffer for exception management. These buffers are
      --  threaded into a stack, and the address here is the top of the stack.
      --  A null address means that no exception handler is currently active.

      Sec_Stack_Ptr : SST.SS_Stack_Ptr;
      --  Pointer of the allocated secondary stack
   end record;

   procedure Create_TSD
     (New_TSD        : in out TSD;
      Sec_Stack      : SST.SS_Stack_Ptr;
      Sec_Stack_Size : System.Parameters.Size_Type);
   pragma Inline (Create_TSD);
   --  Called from s-tassta when a new thread is created to perform
   --  any required initialization of the TSD.

   procedure Destroy_TSD (Old_TSD : in out TSD);
   pragma Inline (Destroy_TSD);
   --  Called from s-tassta just before a thread is destroyed to perform
   --  any required finalization.

   function Get_GNAT_Exception return Ada.Exceptions.Exception_Id;
   pragma Inline (Get_GNAT_Exception);
   --  This function obtains the Exception_Id from the Exception_Occurrence
   --  referenced by the Current_Excep field of the task specific data, i.e.
   --  the call is equivalent to
   --  Exception_Identity (Get_Current_Exception.all)

   --  Export the Get/Set routines for the various Task Specific Data (TSD)
   --  elements as callable subprograms instead of objects of access to
   --  subprogram types.

   function  Get_Jmpbuf_Address_Soft return  Address;
   procedure Set_Jmpbuf_Address_Soft (Addr : Address);
   pragma Inline (Get_Jmpbuf_Address_Soft);
   pragma Inline (Set_Jmpbuf_Address_Soft);

   function  Get_Sec_Stack_Soft return  SST.SS_Stack_Ptr;
   procedure Set_Sec_Stack_Soft (Stack : SST.SS_Stack_Ptr);
   pragma Inline (Get_Sec_Stack_Soft);
   pragma Inline (Set_Sec_Stack_Soft);

   --  The following is a dummy record designed to mimic Communication_Block as
   --  defined in s-tpobop.ads:

   --     type Communication_Block is record
   --        Self      : Task_Id;  --  An access type
   --        Enqueued  : Boolean := True;
   --        Cancelled : Boolean := False;
   --     end record;

   --  The record is used in the construction of the predefined dispatching
   --  primitive _disp_asynchronous_select in order to avoid the import of
   --  System.Tasking.Protected_Objects.Operations. Note that this package
   --  is always imported in the presence of interfaces since the dispatch
   --  table uses entities from here.

   type Dummy_Communication_Block is record
      Comp_1 : Address;  --  Address and access have the same size
      Comp_2 : Boolean;
      Comp_3 : Boolean;
   end record;

private
   NT_TSD : TSD;
   --  The task specific data for the main task when the Ada tasking run-time
   --  is not used. It relies on the default initialization of NT_TSD. It is
   --  placed here and not the body to ensure the default initialization does
   --  not clobber the secondary stack initialization that occurs as part of
   --  System.Soft_Links.Initialization.
end System.Soft_Links;