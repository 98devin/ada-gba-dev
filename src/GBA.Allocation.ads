-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.

with System;
with System.Storage_Pools;
with System.Storage_Elements;
with System.Allocation.Linear_Pools;

use  System;
use  System.Storage_Elements;
use  System.Allocation.Linear_Pools;
package GBA.Allocation is

  subtype Storage_Pool is
    System.Storage_Pools.Root_Storage_Pool;

  subtype Mark_Release_Storage_Pool is
    System.Storage_Pools.Mark_Release_Storage_Pool;

  subtype Marker is
    System.Storage_Pools.Marker;

  subtype Linear_Pool is
    System.Allocation.Linear_Pools.Linear_Pool;

  subtype Owning_Linear_Pool is
    System.Allocation.Linear_Pools.Owning_Linear_Pool;

  procedure Allocate
    (Pool                    : in out Linear_Pool;
    Storage_Address          : out Address;
    Size_In_Storage_Elements : System.Storage_Elements.Storage_Count;
    Alignment                : System.Storage_Elements.Storage_Count)
  renames System.Allocation.Linear_Pools.Allocate;

  procedure Allocate
    (Pool                    : in out Owning_Linear_Pool;
    Storage_Address          : out Address;
    Size_In_Storage_Elements : System.Storage_Elements.Storage_Count;
    Alignment                : System.Storage_Elements.Storage_Count)
  renames System.Allocation.Linear_Pools.Allocate;


  function Storage_Size (Pool : Linear_Pool) return Storage_Count
    renames System.Allocation.Linear_Pools.Storage_Size;

  function Storage_Size (Pool : Owning_Linear_Pool) return Storage_Count
    renames System.Allocation.Linear_Pools.Storage_Size;


  function Mark (Pool : Linear_Pool) return Marker
    renames System.Allocation.Linear_Pools.Mark;

  function Mark (Pool : Owning_Linear_Pool) return Marker
    renames System.Allocation.Linear_Pools.Mark;


  procedure Release (Pool : in out Linear_Pool; Mark : Marker)
    renames System.Allocation.Linear_Pools.Release;

  procedure Release (Pool : in out Owning_Linear_Pool; Mark : Marker)
    renames System.Allocation.Linear_Pools.Release;

end GBA.Allocation;