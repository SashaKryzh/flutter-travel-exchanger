// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rates.dart';

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
