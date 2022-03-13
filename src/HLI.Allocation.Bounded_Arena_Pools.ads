-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

with System;
with System.Parameters;
with System.Storage_Elements;
with System.Unsigned_Types;

generic
  Block_Size_In_Bytes : System.Storage_Elements.Storage_Count;

package HLI.Allocation.Bounded_Arena_Pools is

  use System;
  use System.Storage_Elements;
  use System.Unsigned_Types;

  type Arena_Pool (<>) is limited
    new Storage_Pool with private;

  function Create_With_Capacity (Capacity : Unsigned)
    return Arena_Pool'Class with Inline;

  overriding
  procedure Allocate
    ( Pool                     : in out Arena_Pool;
      Storage_Address          : out Address;
      Size_In_Storage_Elements : Storage_Count;
      Alignment                : Storage_Count)
    with Inline;

  overriding
  procedure Deallocate
    ( Pool                     : in out Arena_Pool;
      Storage_Address          : Address;
      Size_In_Storage_Elements : Storage_Count;
      Alignment                : Storage_Count)
    with Inline;

  overriding
  function Storage_Size (Pool : Arena_Pool)
    return System.Storage_Elements.Storage_Count
    with Inline;

private

  type Block_Data_Array is
    array (Storage_Count range 1 .. Block_Size_In_Bytes) of aliased Storage_Element
      with Alignment => Standard'Maximum_Alignment;

  type Arena_Block (Occupied : Boolean := False) is limited
    record
      case Occupied is
      when False =>
        Next_Block : access Arena_Block := null;
      when True =>
        Block_Data : Block_Data_Array;
      end case;
    end record
      with Unchecked_Union;

  type Arena_Storage is
    array (Unsigned range <>) of Arena_Block;

  type Arena_Pool (Capacity : Unsigned) is limited
    new Storage_Pool with
      record
        Head_Block : access Arena_Block;
        Storage    : Arena_Storage (1 .. Capacity);
      end record;

end HLI.Allocation.Bounded_Arena_Pools;