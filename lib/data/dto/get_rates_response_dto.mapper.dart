// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'get_rates_response_dto.dart';

class GetRatesResponseDtoMapper extends ClassMapperBase<GetRatesResponseDto> {
  GetRatesResponseDtoMapper._();

  static GetRatesResponseDtoMapper? _instance;
  static GetRatesResponseDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetRatesResponseDtoMapper._());
      RateDtoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GetRatesResponseDto';

  static bool _$success(GetRatesResponseDto v) => v.success;
  static const Field<GetRatesResponseDto, bool> _f$success =
      Field('success', _$success);
  static DateTime _$updatedAt(GetRatesResponseDto v) => v.updatedAt;
  static const Field<GetRatesResponseDto, DateTime> _f$updatedAt =
      Field('updatedAt', _$updatedAt);
  static String _$base(GetRatesResponseDto v) => v.base;
  static const Field<GetRatesResponseDto, String> _f$base =
      Field('base', _$base);
  static List<RateDto> _$rates(GetRatesResponseDto v) => v.rates;
  static const Field<GetRatesResponseDto, List<RateDto>> _f$rates =
      Field('rates', _$rates);

  @override
  final MappableFields<GetRatesResponseDto> fields = const {
    #success: _f$success,
    #updatedAt: _f$updatedAt,
    #base: _f$base,
    #rates: _f$rates,
  };

  static GetRatesResponseDto _instantiate(DecodingData data) {
    return GetRatesResponseDto(
        success: data.dec(_f$success),
        updatedAt: data.dec(_f$updatedAt),
        base: data.dec(_f$base),
        rates: data.dec(_f$rates));
  }

  @override
  final Function instantiate = _instantiate;

  static GetRatesResponseDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GetRatesResponseDto>(map);
  }

  static GetRatesResponseDto fromJson(String json) {
    return ensureInitialized().decodeJson<GetRatesResponseDto>(json);
  }
}

mixin GetRatesResponseDtoMappable {
  String toJson() {
    return GetRatesResponseDtoMapper.ensureInitialized()
        .encodeJson<GetRatesResponseDto>(this as GetRatesResponseDto);
  }

  Map<String, dynamic> toMap() {
    return GetRatesResponseDtoMapper.ensureInitialized()
        .encodeMap<GetRatesResponseDto>(this as GetRatesResponseDto);
  }

  GetRatesResponseDtoCopyWith<GetRatesResponseDto, GetRatesResponseDto,
          GetRatesResponseDto>
      get copyWith => _GetRatesResponseDtoCopyWithImpl(
          this as GetRatesResponseDto, $identity, $identity);
  @override
  String toString() {
    return GetRatesResponseDtoMapper.ensureInitialized()
        .stringifyValue(this as GetRatesResponseDto);
  }

  @override
  bool operator ==(Object other) {
    return GetRatesResponseDtoMapper.ensureInitialized()
        .equalsValue(this as GetRatesResponseDto, other);
  }

  @override
  int get hashCode {
    return GetRatesResponseDtoMapper.ensureInitialized()
        .hashValue(this as GetRatesResponseDto);
  }
}

extension GetRatesResponseDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetRatesResponseDto, $Out> {
  GetRatesResponseDtoCopyWith<$R, GetRatesResponseDto, $Out>
      get $asGetRatesResponseDto =>
          $base.as((v, t, t2) => _GetRatesResponseDtoCopyWithImpl(v, t, t2));
}

abstract class GetRatesResponseDtoCopyWith<$R, $In extends GetRatesResponseDto,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, RateDto, RateDtoCopyWith<$R, RateDto, RateDto>> get rates;
  $R call(
      {bool? success, DateTime? updatedAt, String? base, List<RateDto>? rates});
  GetRatesResponseDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GetRatesResponseDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetRatesResponseDto, $Out>
    implements GetRatesResponseDtoCopyWith<$R, GetRatesResponseDto, $Out> {
  _GetRatesResponseDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetRatesResponseDto> $mapper =
      GetRatesResponseDtoMapper.ensureInitialized();
  @override
  ListCopyWith<$R, RateDto, RateDtoCopyWith<$R, RateDto, RateDto>> get rates =>
      ListCopyWith(
          $value.rates, (v, t) => v.copyWith.$chain(t), (v) => call(rates: v));
  @override
  $R call(
          {bool? success,
          DateTime? updatedAt,
          String? base,
          List<RateDto>? rates}) =>
      $apply(FieldCopyWithData({
        if (success != null) #success: success,
        if (updatedAt != null) #updatedAt: updatedAt,
        if (base != null) #base: base,
        if (rates != null) #rates: rates
      }));
  @override
  GetRatesResponseDto $make(CopyWithData data) => GetRatesResponseDto(
      success: data.get(#success, or: $value.success),
      updatedAt: data.get(#updatedAt, or: $value.updatedAt),
      base: data.get(#base, or: $value.base),
      rates: data.get(#rates, or: $value.rates));

  @override
  GetRatesResponseDtoCopyWith<$R2, GetRatesResponseDto, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _GetRatesResponseDtoCopyWithImpl($value, $cast, t);
}
