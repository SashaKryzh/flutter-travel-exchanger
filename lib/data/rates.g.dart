// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetRatesResponseImpl _$$GetRatesResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetRatesResponseImpl(
      success: json['success'] as bool,
      base: json['base'] as String,
      rates: (json['rates'] as List<dynamic>)
          .map((e) => Rate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GetRatesResponseImplToJson(
        _$GetRatesResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'base': instance.base,
      'rates': instance.rates.map((e) => e.toJson()).toList(),
    };
