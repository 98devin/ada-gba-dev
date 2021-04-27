
with System;
use  System;

with System.Storage_Elements;
use  System.Storage_Elements;

with System.Allocation.Arenas;
use  System.Allocation.Arenas;

package GBA.Allocation is
  pragma Elaborate_Body;

  generic
    Size : Storage_Count;
  package Stack_Arena is

    Storage : Local_Arena (Size);

  end Stack_Arena;

  subtype Marker      is System.Allocation.Arenas.Marker;
  subtype Heap_Arena  is System.Allocation.Arenas.Heap_Arena;
  subtype Local_Arena is System.Allocation.Arenas.Local_Arena;


  function Storage_Size (Pool : Heap_Arena) return Storage_Count
    renames System.Allocation.Arenas.Storage_Size;

  function Storage_Size (Pool : Local_Arena) return Storage_Count
    renames System.Allocation.Arenas.Storage_Size;


  function Mark (Pool : Heap_Arena) return Marker
    renames System.Allocation.Arenas.Mark;

  function Mark (Pool : Local_Arena) return Marker
    renames System.Allocation.Arenas.Mark;


  procedure Release (Pool : in out Heap_Arena; Mark : Marker)
    renames System.Allocation.Arenas.Release;

  procedure Release (Pool : in out Local_Arena; Mark : Marker)
    renames System.Allocation.Arenas.Release;


  function Create_Arena (Start_Address, End_Address : Address)
    return Heap_Arena renames System.Allocation.Arenas.Create_Arena;

  function Create_Arena (Local_Size : SSE.Storage_Count)
    return Local_Arena renames System.Allocation.Arenas.Create_Arena;

  procedure Init_Arena (Pool : in out Local_Arena)
    renames System.Allocation.Arenas.Init_Arena;

end GBA.Allocation;