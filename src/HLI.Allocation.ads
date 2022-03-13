-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

with System.Storage_Pools;

package HLI.Allocation is

  pragma Pure;

  subtype Storage_Pool is
    System.Storage_Pools.Root_Storage_Pool;

  subtype Mark_Release_Storage_Pool is
    System.Storage_Pools.Mark_Release_Storage_Pool;

  subtype Marker is
    System.Storage_Pools.Marker;

end HLI.Allocation;