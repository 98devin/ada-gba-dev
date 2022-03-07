-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

package body HLI.Allocation.Bounded_Arena_Pools is

  use all type System.Parameters.Size_Type;

  function Create_With_Capacity (Capacity : Unsigned)
    return Arena_Pool'Class is
  begin
    return Pool : Arena_Pool (Capacity) do

      if Pool.Storage'Length /= 0 then
        Pool.Head_Block := Pool.Storage (Pool.Storage'First)'Unrestricted_Access;
      end if;

      for I in Pool.Storage'First .. Pool.Storage'Last - 1 loop
        Pool.Storage (I).Next_Block := Pool.Storage (I + 1)'Unrestricted_Access;
      end loop;

    end return;
  end Create_With_Capacity;


  overriding
  procedure Allocate
    ( Pool                     : in out Arena_Pool;
      Storage_Address          : out Address;
      Size_In_Storage_Elements : Storage_Count;
      Alignment                : Storage_Count) is
      pragma Unreferenced (Alignment);
  begin

    if Size_In_Storage_Elements > Block_Size_In_Bytes then
      raise Storage_Error;
    end if;

    if Pool.Head_Block = null then
      raise Storage_Error;
    end if;

    declare
      Free_Block : Arena_Block renames Pool.Head_Block.all;
    begin
      Storage_Address := Free_Block'Address;
      Pool.Head_Block := Free_Block.Next_Block;
    end;

  end Allocate;

  overriding
  procedure Deallocate
    ( Pool                     : in out Arena_Pool;
      Storage_Address          : Address;
      Size_In_Storage_Elements : Storage_Count;
      Alignment                : Storage_Count) is

      pragma Unreferenced (Size_In_Storage_Elements);
      pragma Unreferenced (Alignment);
  begin

    declare
      Used_Block : Arena_Block
        with Import, Address => Storage_Address;
    begin
      Used_Block.Next_Block := Pool.Head_Block;
      Pool.Head_Block       := Used_Block'Unrestricted_Access;
    end;

  end Deallocate;

  overriding
  function Storage_Size (Pool : Arena_Pool)
    return System.Storage_Elements.Storage_Count is
    ( Storage_Count (Pool.Capacity) * Block_Size_In_Bytes * Storage_Count (Storage_Element'Size) );


end HLI.Allocation.Bounded_Arena_Pools;