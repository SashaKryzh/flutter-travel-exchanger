// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetRatesResponseDtoImpl _$$GetRatesResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$GetRatesResponseDtoImpl(
      success: json['success'] as bool,
      base: json['base'] as String,
      rates: (json['rates'] as List<dynamic>)
          .map((e) => RateDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GetRatesResponseDtoImplToJson(
        _$GetRatesResponseDtoImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'base': instance.base,
      'rates': instance.rates.map((e) => e.toJson()).toList(),
    };

_$RateDtoImpl _$$RateDtoImplFromJson(Map<String, dynamic> json) =>
    _$RateDtoImpl(
      base: json['base'] as String,
      target: json['target'] as String,
      rate: (json['rate'] as num).toDouble(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$RateDtoImplToJson(_$RateDtoImpl instance) =>
    <String, dynamic>{
      'base': instance.base,
      'target': instance.target,
      'rate': instance.rate,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
