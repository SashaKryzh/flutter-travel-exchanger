// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_amount_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomAmountState {
  Exchangeable get from => throw _privateConstructorUsedError;
  ((Exchangeable, double), (Exchangeable, double), (Exchangeable, double)?)
      get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomAmountStateCopyWith<CustomAmountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomAmountStateCopyWith<$Res> {
  factory $CustomAmountStateCopyWith(
          CustomAmountState value, $Res Function(CustomAmountState) then) =
      _$CustomAmountStateCopyWithImpl<$Res, CustomAmountState>;
  @useResult
  $Res call(
      {Exchangeable from,
      (
        (Exchangeable, double),
        (Exchangeable, double),
        (Exchangeable, double)?
      ) values});
}

/// @nodoc
class _$CustomAmountStateCopyWithImpl<$Res, $Val extends CustomAmountState>
    implements $CustomAmountStateCopyWith<$Res> {
  _$CustomAmountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? values = null,
  }) {
    return _then(_value.copyWith(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as Exchangeable,
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as (
              (Exchangeable, double),
              (Exchangeable, double),
              (Exchangeable, double)?
            ),
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomAmountStateImplCopyWith<$Res>
    implements $CustomAmountStateCopyWith<$Res> {
  factory _$$CustomAmountStateImplCopyWith(_$CustomAmountStateImpl value,
          $Res Function(_$CustomAmountStateImpl) then) =
      __$$CustomAmountStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Exchangeable from,
      (
        (Exchangeable, double),
        (Exchangeable, double),
        (Exchangeable, double)?
      ) values});
}

/// @nodoc
class __$$CustomAmountStateImplCopyWithImpl<$Res>
    extends _$CustomAmountStateCopyWithImpl<$Res, _$CustomAmountStateImpl>
    implements _$$CustomAmountStateImplCopyWith<$Res> {
  __$$CustomAmountStateImplCopyWithImpl(_$CustomAmountStateImpl _value,
      $Res Function(_$CustomAmountStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? values = null,
  }) {
    return _then(_$CustomAmountStateImpl(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as Exchangeable,
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as (
              (Exchangeable, double),
              (Exchangeable, double),
              (Exchangeable, double)?
            ),
    ));
  }
}

/// @nodoc

class _$CustomAmountStateImpl extends _CustomAmountState {
  _$CustomAmountStateImpl({required this.from, required this.values})
      : super._();

  @override
  final Exchangeable from;
  @override
  final (
    (Exchangeable, double),
    (Exchangeable, double),
    (Exchangeable, double)?
  ) values;

  @override
  String toString() {
    return 'CustomAmountState(from: $from, values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomAmountStateImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.values, values) || other.values == values));
  }

  @override
  int get hashCode => Object.hash(runtimeType, from, values);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomAmountStateImplCopyWith<_$CustomAmountStateImpl> get copyWith =>
      __$$CustomAmountStateImplCopyWithImpl<_$CustomAmountStateImpl>(
          this, _$identity);
}

abstract class _CustomAmountState extends CustomAmountState {
  factory _CustomAmountState(
      {required final Exchangeable from,
      required final (
        (Exchangeable, double),
        (Exchangeable, double),
        (Exchangeable, double)?
      ) values}) = _$CustomAmountStateImpl;
  _CustomAmountState._() : super._();

  @override
  Exchangeable get from;
  @override
  ((Exchangeable, double), (Exchangeable, double), (Exchangeable, double)?)
      get values;
  @override
  @JsonKey(ignore: true)
  _$$CustomAmountStateImplCopyWith<_$CustomAmountStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
