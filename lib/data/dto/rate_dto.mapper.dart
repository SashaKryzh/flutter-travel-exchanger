// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'rate_dto.dart';

class RateDtoMapper extends ClassMapperBase<RateDto> {
  RateDtoMapper._();

  static RateDtoMapper? _instance;
  static RateDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RateDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'RateDto';

  static String _$base(RateDto v) => v.base;
  static const Field<RateDto, String> _f$base = Field('base', _$base);
  static String _$target(RateDto v) => v.target;
  static const Field<RateDto, String> _f$target = Field('target', _$target);
  static double _$rate(RateDto v) => v.rate;
  static const Field<RateDto, double> _f$rate = Field('rate', _$rate);

  @override
  final MappableFields<RateDto> fields = const {
    #base: _f$base,
    #target: _f$target,
    #rate: _f$rate,
  };

  static RateDto _instantiate(DecodingData data) {
    return RateDto(
        base: data.dec(_f$base),
        target: data.dec(_f$target),
        rate: data.dec(_f$rate));
  }

  @override
  final Function instantiate = _instantiate;

  static RateDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RateDto>(map);
  }

  static RateDto fromJson(String json) {
    return ensureInitialized().decodeJson<RateDto>(json);
  }
}

mixin RateDtoMappable {
  String toJson() {
    return RateDtoMapper.ensureInitialized()
        .encodeJson<RateDto>(this as RateDto);
  }

  Map<String, dynamic> toMap() {
    return RateDtoMapper.ensureInitialized()
        .encodeMap<RateDto>(this as RateDto);
  }

  RateDtoCopyWith<RateDto, RateDto, RateDto> get copyWith =>
      _RateDtoCopyWithImpl(this as RateDto, $identity, $identity);
  @override
  String toString() {
    return RateDtoMapper.ensureInitialized().stringifyValue(this as RateDto);
  }

  @override
  bool operator ==(Object other) {
    return RateDtoMapper.ensureInitialized()
        .equalsValue(this as RateDto, other);
  }

  @override
  int get hashCode {
    return RateDtoMapper.ensureInitialized().hashValue(this as RateDto);
  }
}

extension RateDtoValueCopy<$R, $Out> on ObjectCopyWith<$R, RateDto, $Out> {
  RateDtoCopyWith<$R, RateDto, $Out> get $asRateDto =>
      $base.as((v, t, t2) => _RateDtoCopyWithImpl(v, t, t2));
}

abstract class RateDtoCopyWith<$R, $In extends RateDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? base, String? target, double? rate});
  RateDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RateDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RateDto, $Out>
    implements RateDtoCopyWith<$R, RateDto, $Out> {
  _RateDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RateDto> $mapper =
      RateDtoMapper.ensureInitialized();
  @override
  $R call({String? base, String? target, double? rate}) =>
      $apply(FieldCopyWithData({
        if (base != null) #base: base,
        if (target != null) #target: target,
        if (rate != null) #rate: rate
      }));
  @override
  RateDto $make(CopyWithData data) => RateDto(
      base: data.get(#base, or: $value.base),
      target: data.get(#target, or: $value.target),
      rate: data.get(#rate, or: $value.rate));

  @override
  RateDtoCopyWith<$R2, RateDto, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _RateDtoCopyWithImpl($value, $cast, t);
}
