// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rates.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetRatesResponse _$GetRatesResponseFromJson(Map<String, dynamic> json) {
  return _GetRatesResponse.fromJson(json);
}

/// @nodoc
mixin _$GetRatesResponse {
  bool get success => throw _privateConstructorUsedError;
  String get base => throw _privateConstructorUsedError;
  List<Rate> get rates => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetRatesResponseCopyWith<GetRatesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetRatesResponseCopyWith<$Res> {
  factory $GetRatesResponseCopyWith(
          GetRatesResponse value, $Res Function(GetRatesResponse) then) =
      _$GetRatesResponseCopyWithImpl<$Res, GetRatesResponse>;
  @useResult
  $Res call({bool success, String base, List<Rate> rates});
}

/// @nodoc
class _$GetRatesResponseCopyWithImpl<$Res, $Val extends GetRatesResponse>
    implements $GetRatesResponseCopyWith<$Res> {
  _$GetRatesResponseCopyWithImpl(this._value, this._then);

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
              as List<Rate>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetRatesResponseImplCopyWith<$Res>
    implements $GetRatesResponseCopyWith<$Res> {
  factory _$$GetRatesResponseImplCopyWith(_$GetRatesResponseImpl value,
          $Res Function(_$GetRatesResponseImpl) then) =
      __$$GetRatesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String base, List<Rate> rates});
}

/// @nodoc
class __$$GetRatesResponseImplCopyWithImpl<$Res>
    extends _$GetRatesResponseCopyWithImpl<$Res, _$GetRatesResponseImpl>
    implements _$$GetRatesResponseImplCopyWith<$Res> {
  __$$GetRatesResponseImplCopyWithImpl(_$GetRatesResponseImpl _value,
      $Res Function(_$GetRatesResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? base = null,
    Object? rates = null,
  }) {
    return _then(_$GetRatesResponseImpl(
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
              as List<Rate>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetRatesResponseImpl implements _GetRatesResponse {
  _$GetRatesResponseImpl(
      {required this.success,
      required this.base,
      required final List<Rate> rates})
      : _rates = rates;

  factory _$GetRatesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetRatesResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String base;
  final List<Rate> _rates;
  @override
  List<Rate> get rates {
    if (_rates is EqualUnmodifiableListView) return _rates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rates);
  }

  @override
  String toString() {
    return 'GetRatesResponse(success: $success, base: $base, rates: $rates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRatesResponseImpl &&
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
  _$$GetRatesResponseImplCopyWith<_$GetRatesResponseImpl> get copyWith =>
      __$$GetRatesResponseImplCopyWithImpl<_$GetRatesResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetRatesResponseImplToJson(
      this,
    );
  }
}

abstract class _GetRatesResponse implements GetRatesResponse {
  factory _GetRatesResponse(
      {required final bool success,
      required final String base,
      required final List<Rate> rates}) = _$GetRatesResponseImpl;

  factory _GetRatesResponse.fromJson(Map<String, dynamic> json) =
      _$GetRatesResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get base;
  @override
  List<Rate> get rates;
  @override
  @JsonKey(ignore: true)
  _$$GetRatesResponseImplCopyWith<_$GetRatesResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
