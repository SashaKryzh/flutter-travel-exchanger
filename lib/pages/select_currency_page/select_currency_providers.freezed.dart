// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_currency_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;


final _privateConstructorUsedError = UnsupportedError('It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectCurrencyState {

 Currency get selectingFor => throw _privateConstructorUsedError;







@JsonKey(ignore: true)
$SelectCurrencyStateCopyWith<SelectCurrencyState> get copyWith => throw _privateConstructorUsedError;

}

/// @nodoc
abstract class $SelectCurrencyStateCopyWith<$Res>  {
  factory $SelectCurrencyStateCopyWith(SelectCurrencyState value, $Res Function(SelectCurrencyState) then) = _$SelectCurrencyStateCopyWithImpl<$Res, SelectCurrencyState>;
@useResult
$Res call({
 Currency selectingFor
});



}

/// @nodoc
class _$SelectCurrencyStateCopyWithImpl<$Res,$Val extends SelectCurrencyState> implements $SelectCurrencyStateCopyWith<$Res> {
  _$SelectCurrencyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

@pragma('vm:prefer-inline') @override $Res call({Object? selectingFor = null,}) {
  return _then(_value.copyWith(
selectingFor: null == selectingFor ? _value.selectingFor : selectingFor // ignore: cast_nullable_to_non_nullable
as Currency,
  )as $Val);
}

}


/// @nodoc
abstract class _$$SelectCurrencyStateImplCopyWith<$Res> implements $SelectCurrencyStateCopyWith<$Res> {
  factory _$$SelectCurrencyStateImplCopyWith(_$SelectCurrencyStateImpl value, $Res Function(_$SelectCurrencyStateImpl) then) = __$$SelectCurrencyStateImplCopyWithImpl<$Res>;
@override @useResult
$Res call({
 Currency selectingFor
});



}

/// @nodoc
class __$$SelectCurrencyStateImplCopyWithImpl<$Res> extends _$SelectCurrencyStateCopyWithImpl<$Res, _$SelectCurrencyStateImpl> implements _$$SelectCurrencyStateImplCopyWith<$Res> {
  __$$SelectCurrencyStateImplCopyWithImpl(_$SelectCurrencyStateImpl _value, $Res Function(_$SelectCurrencyStateImpl) _then)
      : super(_value, _then);


@pragma('vm:prefer-inline') @override $Res call({Object? selectingFor = null,}) {
  return _then(_$SelectCurrencyStateImpl(
selectingFor: null == selectingFor ? _value.selectingFor : selectingFor // ignore: cast_nullable_to_non_nullable
as Currency,
  ));
}


}

/// @nodoc


class _$SelectCurrencyStateImpl  implements _SelectCurrencyState {
   _$SelectCurrencyStateImpl({required this.selectingFor});

  

@override final  Currency selectingFor;

@override
String toString() {
  return 'SelectCurrencyState(selectingFor: $selectingFor)';
}


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _$SelectCurrencyStateImpl&&(identical(other.selectingFor, selectingFor) || other.selectingFor == selectingFor));
}


@override
int get hashCode => Object.hash(runtimeType,selectingFor);

@JsonKey(ignore: true)
@override
@pragma('vm:prefer-inline')
_$$SelectCurrencyStateImplCopyWith<_$SelectCurrencyStateImpl> get copyWith => __$$SelectCurrencyStateImplCopyWithImpl<_$SelectCurrencyStateImpl>(this, _$identity);








}


abstract class _SelectCurrencyState implements SelectCurrencyState {
   factory _SelectCurrencyState({required final  Currency selectingFor}) = _$SelectCurrencyStateImpl;
  

  

@override  Currency get selectingFor;
@override @JsonKey(ignore: true)
_$$SelectCurrencyStateImplCopyWith<_$SelectCurrencyStateImpl> get copyWith => throw _privateConstructorUsedError;

}
