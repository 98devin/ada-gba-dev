------------------------------------------------------------------------------
--                                                                          --
--                        GNAT RUN-TIME COMPONENTS                          --
--                                                                          --
--                               S Y S T E M                                --
--                                                                          --
--                                 S p e c                                  --
--                              (ARM Version)                               --
--                                                                          --
--          Copyright (C) 1992-2018, Free Software Foundation, Inc.         --
--                                                                          --
-- This specification is derived from the Ada Reference Manual for use with --
-- GNAT. The copyright notice above, and the license provisions that follow --
-- apply solely to the  contents of the part following the private keyword. --
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

pragma Restrictions (No_Anonymous_Allocators);
pragma Restrictions (No_Dependence => Ada.Asynchronous_Task_Control);
pragma Restrictions (No_Dependence => Ada.Calendar);
pragma Restrictions (No_Dependence => Ada.Execution_Time.Group_Budget);
pragma Restrictions (No_Dependence => Ada.Execution_Time.Timers);
pragma Restrictions (No_Dependence => Ada.Task_Attributes);
pragma Restrictions (No_Dynamic_Attachment);
pragma Restrictions (No_Dynamic_Priorities);
pragma Restrictions (No_Exception_Propagation);
pragma Restrictions (No_Exception_Registration);
pragma Restrictions (No_Finalization);
pragma Restrictions (No_Floating_Point);
pragma Restrictions (No_Implicit_Heap_Allocations);
pragma Restrictions (No_IO);
pragma Restrictions (No_Local_Protected_Objects);
pragma Restrictions (No_Local_Timing_Events);
pragma Restrictions (No_Multiple_Elaboration);
pragma Restrictions (No_Protected_Type_Allocators);
pragma Restrictions (No_Relative_Delay);
pragma Restrictions (No_Requeue_Statements);
pragma Restrictions (No_Select_Statements);
pragma Restrictions (No_Specific_Termination_Handlers);
--  pragma Restrictions (No_Standard_Allocators_After_Elaboration);
pragma Restrictions (No_Task_Allocators);
pragma Restrictions (No_Task_Hierarchy);
pragma Restrictions (No_Task_Termination);
pragma Restrictions (No_Tasking);
pragma Restrictions (Simple_Barriers);

pragma Discard_Names;
--  Disable explicitly the generation of names associated with entities in
--  order to reduce the amount of storage used. These names are not used anyway
--  (attributes such as 'Image and 'Value are not supported in this run time).

package System is
   pragma Pure;
   pragma Preelaborate;
   --  Note that we take advantage of the implementation permission to make
   --  this unit Pure instead of Preelaborable; see RM 13.7.1(15). In Ada
   --  2005, this is Pure in any case (AI-362).

   pragma No_Elaboration_Code_All;
   --  Allow the use of that restriction in units that WITH this unit

   type Name is (SYSTEM_NAME_GNAT);
   System_Name : constant Name := SYSTEM_NAME_GNAT;

   Run_Time_Name : constant String := "GBA Runtime";

   --  System-Dependent Named Numbers

   Min_Int               : constant := Long_Long_Integer'First;
   Max_Int               : constant := Long_Long_Integer'Last;

   Max_Binary_Modulus    : constant := 2 ** Long_Long_Integer'Size;
   Max_Nonbinary_Modulus : constant := 2 ** Integer'Size - 1;

   Max_Base_Digits       : constant := Long_Long_Float'Digits;
   Max_Digits            : constant := Long_Long_Float'Digits;

   Max_Mantissa          : constant := 63;
   Fine_Delta            : constant := 2.0 ** (-Max_Mantissa);

   Tick                  : constant := 0.0;

   --  Storage-related Declarations

   Storage_Unit : constant := 8;
   Word_Size    : constant := Standard'Word_Size;
   Memory_Size  : constant := 2 ** Word_Size;

   type Word is mod 2 ** Word_Size;
   type Byte is mod 2 ** Storage_Unit;

   type Address is mod Memory_Size;

   pragma Provide_Shift_Operators (Address);

   Null_Address : constant Address := 0;

   --  Address comparison

   function "<"  (Left, Right : Address) return Boolean;
   function "<=" (Left, Right : Address) return Boolean;
   function ">"  (Left, Right : Address) return Boolean;
   function ">=" (Left, Right : Address) return Boolean;
   function "="  (Left, Right : Address) return Boolean;

   pragma Import (Intrinsic, "<");
   pragma Import (Intrinsic, "<=");
   pragma Import (Intrinsic, ">");
   pragma Import (Intrinsic, ">=");
   pragma Import (Intrinsic, "=");

   --  Other System-Dependent Declarations

   type Bit_Order is (High_Order_First, Low_Order_First);
   Default_Bit_Order : constant Bit_Order :=
                         Bit_Order'Val (Standard'Default_Bit_Order);
   pragma Warnings (Off, Default_Bit_Order); -- kill constant condition warning

   --  Priority-related Declarations (RM D.1)

   Max_Priority           : constant Positive := 30;
   Max_Interrupt_Priority : constant Positive := 31;

   subtype Any_Priority       is Integer      range  0 .. 31;
   subtype Priority           is Any_Priority range  0 .. 30;
   subtype Interrupt_Priority is Any_Priority range 31 .. 31;

   Default_Priority : constant Priority := 15;

private

   --------------------------------------
   -- System Implementation Parameters --
   --------------------------------------

   --  These parameters provide information about the target that is used
   --  by the compiler. They are in the private part of System, where they
   --  can be accessed using the special circuitry in the Targparm unit
   --  whose source should be consulted for more detailed descriptions
   --  of the individual switch values.

   Atomic_Sync_Default       : constant Boolean := False;

   Backend_Divide_Checks     : constant Boolean := False;
   Backend_Overflow_Checks   : constant Boolean := True;

   Always_Compatible_Rep     : constant Boolean := False;
   Command_Line_Args         : constant Boolean := False;
   Configurable_Run_Time     : constant Boolean := True;
   Denorm                    : constant Boolean := True;
   Duration_32_Bits          : constant Boolean := True;
   Exit_Status_Supported     : constant Boolean := False;
   Fractional_Fixed_Ops      : constant Boolean := True;
   Frontend_Exceptions       : constant Boolean := False;
   Frontend_Layout           : constant Boolean := False;
   Functions_Return_By_DSP   : constant Boolean := True;
   Machine_Overflows         : constant Boolean := False;
   Machine_Rounds            : constant Boolean := True;
   Preallocated_Stacks       : constant Boolean := True;
   Signed_Zeros              : constant Boolean := False;
   Stack_Check_Default       : constant Boolean := False;
   Stack_Check_Limits        : constant Boolean := False;
   Stack_Check_Probes        : constant Boolean := False;
   Support_Aggregates        : constant Boolean := True;
   Support_Composite_Assign  : constant Boolean := True;
   Support_Composite_Compare : constant Boolean := True;
   Support_Long_Shifts       : constant Boolean := True;
   Suppress_Standard_Library : constant Boolean := True;
   Use_Ada_Main_Program_Name : constant Boolean := False;
   ZCX_By_Default            : constant Boolean := True;

end System;
