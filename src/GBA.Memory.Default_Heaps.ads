-- Copyright (c) 2021 Devin Hill
-- zlib License -- see LICENSE for details.


with System.Allocation.Memory;

with System.Allocation.Arenas;
use  System.Allocation.Arenas;

package GBA.Memory.Default_Heaps is

  IWRAM_Heap_Start : constant Character
    with Import, External_Name => "__iheap_start";

  IWRAM_Heap : Heap_Arena
    := Create_Arena (IWRAM_Heap_Start'Address, Internal_WRAM_Address'Last);

  EWRAM_Heap : Heap_Arena renames System.Allocation.Memory.Heap;

end GBA.Memory.Default_Heaps;