// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exchange_between.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Between _$BetweenFromJson(Map<String, dynamic> json) {
  return _Between.fromJson(json);
}

/// @nodoc
mixin _$Between {
  Currency get from => throw _privateConstructorUsedError;
  Currency get to1 => throw _privateConstructorUsedError;
  @protected
  Currency? get to2_ => throw _privateConstructorUsedError;
  bool get showTo2 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BetweenCopyWith<Between> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BetweenCopyWith<$Res> {
  factory $BetweenCopyWith(Between value, $Res Function(Between) then) =
      _$BetweenCopyWithImpl<$Res, Between>;
  @useResult
  $Res call(
      {Currency from, Currency to1, @protected Currency? to2_, bool showTo2});
}

/// @nodoc
class _$BetweenCopyWithImpl<$Res, $Val extends Between>
    implements $BetweenCopyWith<$Res> {
  _$BetweenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to1 = null,
    Object? to2_ = freezed,
    Object? showTo2 = null,
  }) {
    return _then(_value.copyWith(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as Currency,
      to1: null == to1
          ? _value.to1
          : to1 // ignore: cast_nullable_to_non_nullable
              as Currency,
      to2_: freezed == to2_
          ? _value.to2_
          : to2_ // ignore: cast_nullable_to_non_nullable
              as Currency?,
      showTo2: null == showTo2
          ? _value.showTo2
          : showTo2 // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BetweenImplCopyWith<$Res> implements $BetweenCopyWith<$Res> {
  factory _$$BetweenImplCopyWith(
          _$BetweenImpl value, $Res Function(_$BetweenImpl) then) =
      __$$BetweenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Currency from, Currency to1, @protected Currency? to2_, bool showTo2});
}

/// @nodoc
class __$$BetweenImplCopyWithImpl<$Res>
    extends _$BetweenCopyWithImpl<$Res, _$BetweenImpl>
    implements _$$BetweenImplCopyWith<$Res> {
  __$$BetweenImplCopyWithImpl(
      _$BetweenImpl _value, $Res Function(_$BetweenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to1 = null,
    Object? to2_ = freezed,
    Object? showTo2 = null,
  }) {
    return _then(_$BetweenImpl(
      null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as Currency,
      null == to1
          ? _value.to1
          : to1 // ignore: cast_nullable_to_non_nullable
              as Currency,
      freezed == to2_
          ? _value.to2_
          : to2_ // ignore: cast_nullable_to_non_nullable
              as Currency?,
      showTo2: null == showTo2
          ? _value.showTo2
          : showTo2 // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BetweenImpl extends _Between {
  _$BetweenImpl(this.from, this.to1, @protected this.to2_,
      {required this.showTo2})
      : super._();

  factory _$BetweenImpl.fromJson(Map<String, dynamic> json) =>
      _$$BetweenImplFromJson(json);

  @override
  final Currency from;
  @override
  final Currency to1;
  @override
  @protected
  final Currency? to2_;
  @override
  final bool showTo2;

  @override
  String toString() {
    return 'Between(from: $from, to1: $to1, to2_: $to2_, showTo2: $showTo2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BetweenImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to1, to1) || other.to1 == to1) &&
            (identical(other.to2_, to2_) || other.to2_ == to2_) &&
            (identical(other.showTo2, showTo2) || other.showTo2 == showTo2));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, from, to1, to2_, showTo2);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BetweenImplCopyWith<_$BetweenImpl> get copyWith =>
      __$$BetweenImplCopyWithImpl<_$BetweenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BetweenImplToJson(
      this,
    );
  }
}

abstract class _Between extends Between {
  factory _Between(
      final Currency from, final Currency to1, @protected final Currency? to2_,
      {required final bool showTo2}) = _$BetweenImpl;
  _Between._() : super._();

  factory _Between.fromJson(Map<String, dynamic> json) = _$BetweenImpl.fromJson;

  @override
  Currency get from;
  @override
  Currency get to1;
  @override
  @protected
  Currency? get to2_;
  @override
  bool get showTo2;
  @override
  @JsonKey(ignore: true)
  _$$BetweenImplCopyWith<_$BetweenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
