// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rate_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RateDto _$RateDtoFromJson(Map<String, dynamic> json) {
  return _RateDto.fromJson(json);
}

/// @nodoc
mixin _$RateDto {
  String get base => throw _privateConstructorUsedError;
  String get target => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RateDtoCopyWith<RateDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RateDtoCopyWith<$Res> {
  factory $RateDtoCopyWith(RateDto value, $Res Function(RateDto) then) =
      _$RateDtoCopyWithImpl<$Res, RateDto>;
  @useResult
  $Res call({String base, String target, double rate, DateTime updatedAt});
}

/// @nodoc
class _$RateDtoCopyWithImpl<$Res, $Val extends RateDto>
    implements $RateDtoCopyWith<$Res> {
  _$RateDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base = null,
    Object? target = null,
    Object? rate = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RateDtoImplCopyWith<$Res> implements $RateDtoCopyWith<$Res> {
  factory _$$RateDtoImplCopyWith(
          _$RateDtoImpl value, $Res Function(_$RateDtoImpl) then) =
      __$$RateDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String base, String target, double rate, DateTime updatedAt});
}

/// @nodoc
class __$$RateDtoImplCopyWithImpl<$Res>
    extends _$RateDtoCopyWithImpl<$Res, _$RateDtoImpl>
    implements _$$RateDtoImplCopyWith<$Res> {
  __$$RateDtoImplCopyWithImpl(
      _$RateDtoImpl _value, $Res Function(_$RateDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? base = null,
    Object? target = null,
    Object? rate = null,
    Object? updatedAt = null,
  }) {
    return _then(_$RateDtoImpl(
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RateDtoImpl extends _RateDto {
  _$RateDtoImpl(
      {required this.base,
      required this.target,
      required this.rate,
      required this.updatedAt})
      : super._();

  factory _$RateDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RateDtoImplFromJson(json);

  @override
  final String base;
  @override
  final String target;
  @override
  final double rate;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'RateDto(base: $base, target: $target, rate: $rate, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateDtoImpl &&
            (identical(other.base, base) || other.base == base) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, base, target, rate, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RateDtoImplCopyWith<_$RateDtoImpl> get copyWith =>
      __$$RateDtoImplCopyWithImpl<_$RateDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RateDtoImplToJson(
      this,
    );
  }
}

abstract class _RateDto extends RateDto {
  factory _RateDto(
      {required final String base,
      required final String target,
      required final double rate,
      required final DateTime updatedAt}) = _$RateDtoImpl;
  _RateDto._() : super._();

  factory _RateDto.fromJson(Map<String, dynamic> json) = _$RateDtoImpl.fromJson;

  @override
  String get base;
  @override
  String get target;
  @override
  double get rate;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$RateDtoImplCopyWith<_$RateDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
