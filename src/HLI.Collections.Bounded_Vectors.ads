-- Copyright (c) 2022 Devin Hill
-- zlib License -- see LICENSE for details.

with Ada.Iterator_Interfaces;

with System.Unsigned_Types;
use  System.Unsigned_Types;

generic
  type Element_Type is private;
  type Index_Type is new Unsigned;
  type Element_Array is
    array (Index_Type range <>) of aliased Element_Type;

package HLI.Collections.Bounded_Vectors is


  type Element_Ref (Ref : not null access Element_Type) is limited private
    with Implicit_Dereference => Ref;

  type Constant_Element_Ref (Ref : not null access constant Element_Type) is limited private
    with Implicit_Dereference => Ref;


  type Cursor (<>) is private;

  function Has_Element (Self : Cursor) return Boolean;
  function Index (Self : Cursor) return Index_Type;

  package Iterators is
    new Ada.Iterator_Interfaces (Cursor, Has_Element);


  type Vector (Lower, Upper : Index_Type) is tagged private
    with Variable_Indexing => Element_Mut
       , Constant_Indexing => Element
       , Default_Iterator  => Iterate
       , Iterator_Element  => Element_Type;


  overriding
  function "=" (Self, Other : Vector) return Boolean;


  function Iterate (Self : Vector'Class) return Iterators.Reversible_Iterator'Class;


  procedure Push (Self : in out Vector'Class; Value : Element_Type);
  procedure Push (Self : in out Vector'Class; Value : Element_Type; Pos : out Index_Type);
  function  Push (Self : in out Vector'Class) return Element_Ref;
  function  Push (Self : in out Vector'Class) return Index_Type;

  procedure Pop (Self : in out Vector'Class);
  function  Pop (Self : in out Vector'Class) return Element_Type;

  function Try_Push (Self : in out Vector'Class; Value : Element_Type) return Boolean;
  function Try_Push (Self : in out Vector'Class; Value : Element_Type; Pos : out Index_Type) return Boolean;

  function Try_Pop (Self : in out Vector'Class) return Boolean;
  function Try_Pop (Self : in out Vector'Class; Value : out Element_Type) return Boolean;

  function First (Self :        Vector'Class) return Index_Type;
  function First (Self : in out Vector'Class) return Element_Ref;

  function Last (Self :        Vector'Class) return Index_Type;
  function Last (Self : in out Vector'Class) return Element_Ref;

  function Top (Self :        Vector'Class) return Index_Type renames Last;
  function Top (Self : in out Vector'Class) return Element_Ref renames Last;

  function Bottom (Self :        Vector'Class) return Index_Type renames First;
  function Bottom (Self : in out Vector'Class) return Element_Ref renames First;

  function Element_Mut (Self : in out Vector'Class; Pos : Index_Type) return Element_Ref;
  function Element_Mut (Self : in out Vector'Class; Pos : Cursor) return Element_Ref;

  function Element (Self : Vector'Class; Pos : Index_Type) return Constant_Element_Ref;
  function Element (Self : Vector'Class; Pos : Cursor) return Constant_Element_Ref;


  function Try_Index (Self : Vector'Class; Pos : Index_Type; Value : out Element_Type) return Boolean;

private

  type Element_Ref (Ref : not null access Element_Type) is
    null record;

  type Constant_Element_Ref (Ref : not null access constant Element_Type) is
    null record;

  type Vector (Lower, Upper : Index_Type) is tagged
    record
      Top  : Index_Type := Lower;
      Data : Element_Array (Lower .. Upper);
    end record;

  type Vector_Ptr is not null access all Vector'Class;

  type Cursor is
    record
      Container : Vector_Ptr;
      Position  : Index_Type := Index_Type'First;
    end record;

end HLI.Collections.Bounded_Vectors;