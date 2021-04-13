
with System.Parameters;

with System.Secondary_Stack;
use  System.Secondary_Stack;

use type System.Address;

generic
  Location : Address := External_WRAM_Address'Last + 1;
  Size     : System.Parameters.Size_Type := System.Parameters.Unspecified_Size;
package GBA.Memory.Secondary_Stack is

  pragma Warnings (Off);

  function Get_Sec_Stack return SS_Stack_Ptr
    with Pure_Function
       , Inline
       , Export
       , External_Name => "__gnat_get_secondary_stack";

  pragma Warnings (On);

end GBA.Memory.Secondary_Stack;