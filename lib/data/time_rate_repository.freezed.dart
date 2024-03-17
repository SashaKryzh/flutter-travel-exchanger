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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeRateData _$TimeRateDataFromJson(Map<String, dynamic> json) {
  return _TimeRateData.fromJson(json);
}

/// @nodoc
mixin _$TimeRateData {
// TODO: Change to MoneyCurrency, this is temporary fix for freezed generation.
  Currency get to => throw _privateConstructorUsedError;
  double get perHour => throw _privateConstructorUsedError;

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
  $Res call({Currency to, double perHour});
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
    Object? perHour = null,
  }) {
    return _then(_value.copyWith(
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as Currency,
      perHour: null == perHour
          ? _value.perHour
          : perHour // ignore: cast_nullable_to_non_nullable
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
  $Res call({Currency to, double perHour});
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
    Object? perHour = null,
  }) {
    return _then(_$TimeRateDataImpl(
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as Currency,
      perHour: null == perHour
          ? _value.perHour
          : perHour // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeRateDataImpl with DiagnosticableTreeMixin implements _TimeRateData {
  _$TimeRateDataImpl({required this.to, required this.perHour});

  factory _$TimeRateDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeRateDataImplFromJson(json);

// TODO: Change to MoneyCurrency, this is temporary fix for freezed generation.
  @override
  final Currency to;
  @override
  final double perHour;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TimeRateData(to: $to, perHour: $perHour)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TimeRateData'))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('perHour', perHour));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeRateDataImpl &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.perHour, perHour) || other.perHour == perHour));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, to, perHour);

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
      required final double perHour}) = _$TimeRateDataImpl;

  factory _TimeRateData.fromJson(Map<String, dynamic> json) =
      _$TimeRateDataImpl.fromJson;

  @override // TODO: Change to MoneyCurrency, this is temporary fix for freezed generation.
  Currency get to;
  @override
  double get perHour;
  @override
  @JsonKey(ignore: true)
  _$$TimeRateDataImplCopyWith<_$TimeRateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
