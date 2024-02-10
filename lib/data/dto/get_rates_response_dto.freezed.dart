// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_rates_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetRatesResponseDto _$GetRatesResponseDtoFromJson(Map<String, dynamic> json) {
  return _GetRatesResponseDto.fromJson(json);
}

/// @nodoc
mixin _$GetRatesResponseDto {
  bool get success => throw _privateConstructorUsedError;
  String get base => throw _privateConstructorUsedError;
  List<RateDto> get rates => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetRatesResponseDtoCopyWith<GetRatesResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetRatesResponseDtoCopyWith<$Res> {
  factory $GetRatesResponseDtoCopyWith(
          GetRatesResponseDto value, $Res Function(GetRatesResponseDto) then) =
      _$GetRatesResponseDtoCopyWithImpl<$Res, GetRatesResponseDto>;
  @useResult
  $Res call({bool success, String base, List<RateDto> rates});
}

/// @nodoc
class _$GetRatesResponseDtoCopyWithImpl<$Res, $Val extends GetRatesResponseDto>
    implements $GetRatesResponseDtoCopyWith<$Res> {
  _$GetRatesResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? base = null,
    Object? rates = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      rates: null == rates
          ? _value.rates
          : rates // ignore: cast_nullable_to_non_nullable
              as List<RateDto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetRatesResponseDtoImplCopyWith<$Res>
    implements $GetRatesResponseDtoCopyWith<$Res> {
  factory _$$GetRatesResponseDtoImplCopyWith(_$GetRatesResponseDtoImpl value,
          $Res Function(_$GetRatesResponseDtoImpl) then) =
      __$$GetRatesResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String base, List<RateDto> rates});
}

/// @nodoc
class __$$GetRatesResponseDtoImplCopyWithImpl<$Res>
    extends _$GetRatesResponseDtoCopyWithImpl<$Res, _$GetRatesResponseDtoImpl>
    implements _$$GetRatesResponseDtoImplCopyWith<$Res> {
  __$$GetRatesResponseDtoImplCopyWithImpl(_$GetRatesResponseDtoImpl _value,
      $Res Function(_$GetRatesResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? base = null,
    Object? rates = null,
  }) {
    return _then(_$GetRatesResponseDtoImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as String,
      rates: null == rates
          ? _value._rates
          : rates // ignore: cast_nullable_to_non_nullable
              as List<RateDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetRatesResponseDtoImpl implements _GetRatesResponseDto {
  _$GetRatesResponseDtoImpl(
      {required this.success,
      required this.base,
      required final List<RateDto> rates})
      : _rates = rates;

  factory _$GetRatesResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetRatesResponseDtoImplFromJson(json);

  @override
  final bool success;
  @override
  final String base;
  final List<RateDto> _rates;
  @override
  List<RateDto> get rates {
    if (_rates is EqualUnmodifiableListView) return _rates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rates);
  }

  @override
  String toString() {
    return 'GetRatesResponseDto(success: $success, base: $base, rates: $rates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRatesResponseDtoImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.base, base) || other.base == base) &&
            const DeepCollectionEquality().equals(other._rates, _rates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, base, const DeepCollectionEquality().hash(_rates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetRatesResponseDtoImplCopyWith<_$GetRatesResponseDtoImpl> get copyWith =>
      __$$GetRatesResponseDtoImplCopyWithImpl<_$GetRatesResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetRatesResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _GetRatesResponseDto implements GetRatesResponseDto {
  factory _GetRatesResponseDto(
      {required final bool success,
      required final String base,
      required final List<RateDto> rates}) = _$GetRatesResponseDtoImpl;

  factory _GetRatesResponseDto.fromJson(Map<String, dynamic> json) =
      _$GetRatesResponseDtoImpl.fromJson;

  @override
  bool get success;
  @override
  String get base;
  @override
  List<RateDto> get rates;
  @override
  @JsonKey(ignore: true)
  _$$GetRatesResponseDtoImplCopyWith<_$GetRatesResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
