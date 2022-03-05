-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

package body HLI.Collections.Bounded_Vectors is

  -- Cursor Functions --

  function Has_Element (Self : Cursor) return Boolean is
  begin
    return Self.Position in First (Self.Container.all) .. Last (Self.Container.all);
  end Has_Element;

  function Index (Self : Cursor) return Index_Type is
  begin
    return Self.Position;
  end Index;


  -- Iterator Functions --

  type Iterator is new Iterators.Reversible_Iterator with
    record
      Container : Vector_Ptr;
    end record;

  overriding
  function First (Object : Iterator) return Cursor is
    ( (Container => Object.Container, Position => <>) );

  overriding
  function Next (Object : Iterator; Position : Cursor) return Cursor is
    ( (Position with delta Position => Position.Position + 1) );

  overriding
  function Last (Object : Iterator) return Cursor is
    ( (Container => Object.Container, Position => Index_Type'Pred(Object.Container.Top) ) );

  overriding
  function Previous (Object : Iterator; Position : Cursor) return Cursor is
    ( (Position with delta Position => Position.Position - 1) );

  function Iterate (Self : Vector'Class) return Iterators.Reversible_Iterator'Class is
    ( Iterator'(Container => Self'Unrestricted_Access) );


  -- Vector Functions --

  overriding
  function "=" (Self, Other : Vector) return Boolean is
    ( Self.Lower = Other.Lower and then
      Self.Upper = Other.Upper and then
      (for all I in Self.Lower .. Self.Upper => Self.Data (I) = Other.Data (I))
    );

  procedure Push (Self : in out Vector'Class; Value : Element_Type) is
  begin
    Self.Data (Self.Top) := Value;
    Self.Top := Self.Top + 1;
  end Push;

  procedure Push (Self : in out Vector'Class; Value : Element_Type; Pos : out Index_Type) is
  begin
    Self.Data (Self.Top) := Value;
    Pos := Self.Top;
    Self.Top := Self.Top + 1;
  end Push;

  function Push (Self : in out Vector'Class) return Element_Ref is
  begin
    return R : Element_Ref (Self.Data (Self.Top)'Unrestricted_Access) do
      Self.Top := Self.Top + 1;
    end return;
  end Push;

  function Push (Self : in out Vector'Class) return Index_Type is
  begin
    return I : Index_Type := Self.Top do
      Self.Top := Self.Top + 1;
    end return;
  end Push;

  procedure Pop (Self : in out Vector'Class) is
  begin
    Self.Top := Self.Top - 1;
  end Pop;

  function Pop (Self : in out Vector'Class) return Element_Type is
  begin
    return E : Element_Type := Self.Data (Self.Top) do
      Self.Top := Self.Top - 1;
    end return;
  end Pop;

  function Try_Push (Self : in out Vector'Class; Value : Element_Type) return Boolean is
  begin
    if Self.Top > Self.Upper then
      return False;
    else
      Push (Self, Value);
      return True;
    end if;
  end Try_Push;

  function Try_Push (Self : in out Vector'Class; Value : Element_Type; Pos : out Index_Type) return Boolean is
  begin
    if Self.Top > Self.Upper then
      return False;
    else
      Push (Self, Value, Pos);
      return True;
    end if;
  end Try_Push;

  function Try_Pop (Self : in out Vector'Class) return Boolean is
  begin
    if Self.Top = Self.Lower then
      return False;
    else
      Pop (Self);
      return True;
    end if;
  end Try_Pop;

  function Try_Pop (Self : in out Vector'Class; Value : out Element_Type) return Boolean is
  begin
    if Self.Top = Self.Lower then
      return False;
    else
      Value := Pop (Self);
      return True;
    end if;
  end Try_Pop;


  function First (Self : Vector'Class) return Index_Type is ( Self.Lower );
  function First (Self : in out Vector'Class) return Element_Ref is
  begin
    return R : Element_Ref (Self.Data (First (Self))'Unrestricted_Access);
  end First;

  function Last (Self :        Vector'Class) return Index_Type is ( Self.Top - 1 );
  function Last (Self : in out Vector'Class) return Element_Ref is
  begin
    return R : Element_Ref (Self.Data (Last (Self))'Unrestricted_Access);
  end Last;

  function Element_Mut (Self : in out Vector'Class; Pos : Index_Type) return Element_Ref is
  begin
    return R : Element_Ref (Self.Data (Pos)'Unrestricted_Access);
  end Element_Mut;

  function Element_Mut (Self : in out Vector'Class; Pos : Cursor) return Element_Ref is
  begin
    return Element_Mut (Self, Pos.Position);
  end Element_Mut;


  function Element (Self : Vector'Class; Pos : Index_Type) return Constant_Element_Ref is
  begin
    return R : Constant_Element_Ref (Self.Data (Pos)'Unrestricted_Access);
  end Element;

  function Element (Self : Vector'Class; Pos : Cursor) return Constant_Element_Ref is
  begin
    return Element (Self, Pos.Position);
  end Element;


  function Try_Index (Self : Vector'Class; Pos : Index_Type; Value : out Element_Type) return Boolean is
  begin
    if Pos >= Self.Lower and then Pos < Self.Top then
      Value := Self.Data (Pos);
      return True;
    else
      return False;
    end if;
  end Try_Index;


end HLI.Collections.Bounded_Vectors;