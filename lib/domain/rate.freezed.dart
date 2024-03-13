// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Rate _$RateFromJson(Map<String, dynamic> json) {
  return _Rate.fromJson(json);
}

/// @nodoc
mixin _$Rate {
  Currency get from => throw _privateConstructorUsedError;
  Currency get to => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  RateSource get source => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RateCopyWith<Rate> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RateCopyWith<$Res> {
  factory $RateCopyWith(Rate value, $Res Function(Rate) then) =
      _$RateCopyWithImpl<$Res, Rate>;
  @useResult
  $Res call({Currency from, Currency to, double rate, RateSource source});
}

/// @nodoc
class _$RateCopyWithImpl<$Res, $Val extends Rate>
    implements $RateCopyWith<$Res> {
  _$RateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? rate = null,
    Object? source = null,
  }) {
    return _then(_value.copyWith(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as Currency,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as Currency,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as RateSource,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RateImplCopyWith<$Res> implements $RateCopyWith<$Res> {
  factory _$$RateImplCopyWith(
          _$RateImpl value, $Res Function(_$RateImpl) then) =
      __$$RateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Currency from, Currency to, double rate, RateSource source});
}

/// @nodoc
class __$$RateImplCopyWithImpl<$Res>
    extends _$RateCopyWithImpl<$Res, _$RateImpl>
    implements _$$RateImplCopyWith<$Res> {
  __$$RateImplCopyWithImpl(_$RateImpl _value, $Res Function(_$RateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = null,
    Object? to = null,
    Object? rate = null,
    Object? source = null,
  }) {
    return _then(_$RateImpl(
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as Currency,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as Currency,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as RateSource,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RateImpl extends _Rate {
  _$RateImpl(
      {required this.from,
      required this.to,
      required this.rate,
      required this.source})
      : super._();

  factory _$RateImpl.fromJson(Map<String, dynamic> json) =>
      _$$RateImplFromJson(json);

  @override
  final Currency from;
  @override
  final Currency to;
  @override
  final double rate;
  @override
  final RateSource source;

  @override
  String toString() {
    return 'Rate(from: $from, to: $to, rate: $rate, source: $source)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RateImplCopyWith<_$RateImpl> get copyWith =>
      __$$RateImplCopyWithImpl<_$RateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RateImplToJson(
      this,
    );
  }
}

abstract class _Rate extends Rate {
  factory _Rate(
      {required final Currency from,
      required final Currency to,
      required final double rate,
      required final RateSource source}) = _$RateImpl;
  _Rate._() : super._();

  factory _Rate.fromJson(Map<String, dynamic> json) = _$RateImpl.fromJson;

  @override
  Currency get from;
  @override
  Currency get to;
  @override
  double get rate;
  @override
  RateSource get source;
  @override
  @JsonKey(ignore: true)
  _$$RateImplCopyWith<_$RateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RatesData _$RatesDataFromJson(Map<String, dynamic> json) {
  return _RatesData.fromJson(json);
}

/// @nodoc
mixin _$RatesData {
  DateTime get updatedAt => throw _privateConstructorUsedError;
  Currency get base => throw _privateConstructorUsedError;
  List<Rate> get rates => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RatesDataCopyWith<RatesData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatesDataCopyWith<$Res> {
  factory $RatesDataCopyWith(RatesData value, $Res Function(RatesData) then) =
      _$RatesDataCopyWithImpl<$Res, RatesData>;
  @useResult
  $Res call({DateTime updatedAt, Currency base, List<Rate> rates});
}

/// @nodoc
class _$RatesDataCopyWithImpl<$Res, $Val extends RatesData>
    implements $RatesDataCopyWith<$Res> {
  _$RatesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedAt = null,
    Object? base = null,
    Object? rates = null,
  }) {
    return _then(_value.copyWith(
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      base: null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as Currency,
      rates: null == rates
          ? _value.rates
          : rates // ignore: cast_nullable_to_non_nullable
              as List<Rate>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RatesDataImplCopyWith<$Res>
    implements $RatesDataCopyWith<$Res> {
  factory _$$RatesDataImplCopyWith(
          _$RatesDataImpl value, $Res Function(_$RatesDataImpl) then) =
      __$$RatesDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime updatedAt, Currency base, List<Rate> rates});
}

/// @nodoc
class __$$RatesDataImplCopyWithImpl<$Res>
    extends _$RatesDataCopyWithImpl<$Res, _$RatesDataImpl>
    implements _$$RatesDataImplCopyWith<$Res> {
  __$$RatesDataImplCopyWithImpl(
      _$RatesDataImpl _value, $Res Function(_$RatesDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedAt = null,
    Object? base = null,
    Object? rates = null,
  }) {
    return _then(_$RatesDataImpl(
      null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == base
          ? _value.base
          : base // ignore: cast_nullable_to_non_nullable
              as Currency,
      null == rates
          ? _value._rates
          : rates // ignore: cast_nullable_to_non_nullable
              as List<Rate>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RatesDataImpl extends _RatesData {
  _$RatesDataImpl(this.updatedAt, this.base, final List<Rate> rates)
      : _rates = rates,
        super._();

  factory _$RatesDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatesDataImplFromJson(json);

  @override
  final DateTime updatedAt;
  @override
  final Currency base;
  final List<Rate> _rates;
  @override
  List<Rate> get rates {
    if (_rates is EqualUnmodifiableListView) return _rates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rates);
  }

  @override
  String toString() {
    return 'RatesData(updatedAt: $updatedAt, base: $base, rates: $rates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatesDataImpl &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.base, base) || other.base == base) &&
            const DeepCollectionEquality().equals(other._rates, _rates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, updatedAt, base,
      const DeepCollectionEquality().hash(_rates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RatesDataImplCopyWith<_$RatesDataImpl> get copyWith =>
      __$$RatesDataImplCopyWithImpl<_$RatesDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatesDataImplToJson(
      this,
    );
  }
}

abstract class _RatesData extends RatesData {
  factory _RatesData(final DateTime updatedAt, final Currency base,
      final List<Rate> rates) = _$RatesDataImpl;
  _RatesData._() : super._();

  factory _RatesData.fromJson(Map<String, dynamic> json) =
      _$RatesDataImpl.fromJson;

  @override
  DateTime get updatedAt;
  @override
  Currency get base;
  @override
  List<Rate> get rates;
  @override
  @JsonKey(ignore: true)
  _$$RatesDataImplCopyWith<_$RatesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
