// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_rate_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TimeRateData _$TimeRateDataFromJson(Map<String, dynamic> json) {
  return _TimeRateData.fromJson(json);
}

/// @nodoc
mixin _$TimeRateData {
  Currency get to => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeRateDataCopyWith<TimeRateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeRateDataCopyWith<$Res> {
  factory $TimeRateDataCopyWith(
          TimeRateData value, $Res Function(TimeRateData) then) =
      _$TimeRateDataCopyWithImpl<$Res, TimeRateData>;
  @useResult
  $Res call({Currency to, double rate});
}

/// @nodoc
class _$TimeRateDataCopyWithImpl<$Res, $Val extends TimeRateData>
    implements $TimeRateDataCopyWith<$Res> {
  _$TimeRateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = null,
    Object? rate = null,
  }) {
    return _then(_value.copyWith(
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as Currency,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeRateDataImplCopyWith<$Res>
    implements $TimeRateDataCopyWith<$Res> {
  factory _$$TimeRateDataImplCopyWith(
          _$TimeRateDataImpl value, $Res Function(_$TimeRateDataImpl) then) =
      __$$TimeRateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Currency to, double rate});
}

/// @nodoc
class __$$TimeRateDataImplCopyWithImpl<$Res>
    extends _$TimeRateDataCopyWithImpl<$Res, _$TimeRateDataImpl>
    implements _$$TimeRateDataImplCopyWith<$Res> {
  __$$TimeRateDataImplCopyWithImpl(
      _$TimeRateDataImpl _value, $Res Function(_$TimeRateDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = null,
    Object? rate = null,
  }) {
    return _then(_$TimeRateDataImpl(
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as Currency,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeRateDataImpl with DiagnosticableTreeMixin implements _TimeRateData {
  _$TimeRateDataImpl({required this.to, required this.rate});

  factory _$TimeRateDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeRateDataImplFromJson(json);

  @override
  final Currency to;
  @override
  final double rate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TimeRateData(to: $to, rate: $rate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TimeRateData'))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('rate', rate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeRateDataImpl &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.rate, rate) || other.rate == rate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, to, rate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeRateDataImplCopyWith<_$TimeRateDataImpl> get copyWith =>
      __$$TimeRateDataImplCopyWithImpl<_$TimeRateDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeRateDataImplToJson(
      this,
    );
  }
}

abstract class _TimeRateData implements TimeRateData {
  factory _TimeRateData(
      {required final Currency to,
      required final double rate}) = _$TimeRateDataImpl;

  factory _TimeRateData.fromJson(Map<String, dynamic> json) =
      _$TimeRateDataImpl.fromJson;

  @override
  Currency get to;
  @override
  double get rate;
  @override
  @JsonKey(ignore: true)
  _$$TimeRateDataImplCopyWith<_$TimeRateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}