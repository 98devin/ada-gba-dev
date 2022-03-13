--  Copyright (c) 2022 Devin Hill
--  zlib License -- see LICENSE for details.

function System.Memcmp (M1, M2 : Address; Length : Integer) return Integer is
   pragma Unreferenced (M1, M2, Length);
begin
   return 0;
end System.Memcmp;