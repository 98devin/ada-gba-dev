-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

with System.Unsigned_Types;
with HLI.Collections.Bounded_Vectors;

package Integer_Vectors is

  subtype Index is System.Unsigned_Types.Unsigned;

  type Element_Array is
    array (Index range <>) of aliased Integer;

  package Bounded_Integer_Vectors is
    new HLI.Collections.Bounded_Vectors (Integer, Index, Element_Array);

  subtype Vector is Bounded_Integer_Vectors.Vector;


end Integer_Vectors;
