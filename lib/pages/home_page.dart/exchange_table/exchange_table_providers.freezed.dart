// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exchange_table_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;


final _privateConstructorUsedError = UnsupportedError('It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExchangeTableExpandedRowsState {

 Set<ExpandableRowState> get rows => throw _privateConstructorUsedError;







@JsonKey(ignore: true)
$ExchangeTableExpandedRowsStateCopyWith<ExchangeTableExpandedRowsState> get copyWith => throw _privateConstructorUsedError;

}

/// @nodoc
abstract class $ExchangeTableExpandedRowsStateCopyWith<$Res>  {
  factory $ExchangeTableExpandedRowsStateCopyWith(ExchangeTableExpandedRowsState value, $Res Function(ExchangeTableExpandedRowsState) then) = _$ExchangeTableExpandedRowsStateCopyWithImpl<$Res, ExchangeTableExpandedRowsState>;
@useResult
$Res call({
 Set<ExpandableRowState> rows
});



}

/// @nodoc
class _$ExchangeTableExpandedRowsStateCopyWithImpl<$Res,$Val extends ExchangeTableExpandedRowsState> implements $ExchangeTableExpandedRowsStateCopyWith<$Res> {
  _$ExchangeTableExpandedRowsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

@pragma('vm:prefer-inline') @override $Res call({Object? rows = null,}) {
  return _then(_value.copyWith(
rows: null == rows ? _value.rows : rows // ignore: cast_nullable_to_non_nullable
as Set<ExpandableRowState>,
  )as $Val);
}

}


/// @nodoc
abstract class _$$ExchangeTableExpandedRowsStateImplCopyWith<$Res> implements $ExchangeTableExpandedRowsStateCopyWith<$Res> {
  factory _$$ExchangeTableExpandedRowsStateImplCopyWith(_$ExchangeTableExpandedRowsStateImpl value, $Res Function(_$ExchangeTableExpandedRowsStateImpl) then) = __$$ExchangeTableExpandedRowsStateImplCopyWithImpl<$Res>;
@override @useResult
$Res call({
 Set<ExpandableRowState> rows
});



}

/// @nodoc
class __$$ExchangeTableExpandedRowsStateImplCopyWithImpl<$Res> extends _$ExchangeTableExpandedRowsStateCopyWithImpl<$Res, _$ExchangeTableExpandedRowsStateImpl> implements _$$ExchangeTableExpandedRowsStateImplCopyWith<$Res> {
  __$$ExchangeTableExpandedRowsStateImplCopyWithImpl(_$ExchangeTableExpandedRowsStateImpl _value, $Res Function(_$ExchangeTableExpandedRowsStateImpl) _then)
      : super(_value, _then);


@pragma('vm:prefer-inline') @override $Res call({Object? rows = null,}) {
  return _then(_$ExchangeTableExpandedRowsStateImpl(
null == rows ? _value._rows : rows // ignore: cast_nullable_to_non_nullable
as Set<ExpandableRowState>,
  ));
}


}

/// @nodoc


class _$ExchangeTableExpandedRowsStateImpl extends _ExchangeTableExpandedRowsState  {
   _$ExchangeTableExpandedRowsStateImpl(final  Set<ExpandableRowState> rows): _rows = rows,super._();

  

 final  Set<ExpandableRowState> _rows;
@override Set<ExpandableRowState> get rows {
  if (_rows is EqualUnmodifiableSetView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_rows);
}


@override
String toString() {
  return 'ExchangeTableExpandedRowsState(rows: $rows)';
}


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _$ExchangeTableExpandedRowsStateImpl&&const DeepCollectionEquality().equals(other._rows, _rows));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rows));

@JsonKey(ignore: true)
@override
@pragma('vm:prefer-inline')
_$$ExchangeTableExpandedRowsStateImplCopyWith<_$ExchangeTableExpandedRowsStateImpl> get copyWith => __$$ExchangeTableExpandedRowsStateImplCopyWithImpl<_$ExchangeTableExpandedRowsStateImpl>(this, _$identity);








}


abstract class _ExchangeTableExpandedRowsState extends ExchangeTableExpandedRowsState {
   factory _ExchangeTableExpandedRowsState(final  Set<ExpandableRowState> rows) = _$ExchangeTableExpandedRowsStateImpl;
   _ExchangeTableExpandedRowsState._(): super._();

  

@override  Set<ExpandableRowState> get rows;
@override @JsonKey(ignore: true)
_$$ExchangeTableExpandedRowsStateImplCopyWith<_$ExchangeTableExpandedRowsStateImpl> get copyWith => throw _privateConstructorUsedError;

}
