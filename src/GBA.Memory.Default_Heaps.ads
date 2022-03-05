-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with System.Allocation.Memory;

with System.Allocation.Linear_Pools;
use  System.Allocation.Linear_Pools;

package GBA.Memory.Default_Heaps is

  IWRAM_Heap_Start : constant Character
    with Import, External_Name => "__iheap_start";

  IWRAM_Heap : Linear_Pool (IWRAM_Heap_Start'Address, Internal_WRAM_Address'Last);

  EWRAM_Heap : Linear_Pool renames System.Allocation.Memory.Heap;

end GBA.Memory.Default_Heaps;