// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RateImpl _$$RateImplFromJson(Map<String, dynamic> json) => _$RateImpl(
      from: Currency.fromJson(json['from'] as Map<String, dynamic>),
      to: Currency.fromJson(json['to'] as Map<String, dynamic>),
      rate: (json['rate'] as num).toDouble(),
      source: $enumDecode(_$RateSourceEnumMap, json['source']),
    );

Map<String, dynamic> _$$RateImplToJson(_$RateImpl instance) =>
    <String, dynamic>{
      'from': instance.from.toJson(),
      'to': instance.to.toJson(),
      'rate': instance.rate,
      'source': _$RateSourceEnumMap[instance.source]!,
    };

const _$RateSourceEnumMap = {
  RateSource.api: 'api',
  RateSource.custom: 'custom',
};

_$RatesDataImpl _$$RatesDataImplFromJson(Map<String, dynamic> json) =>
    _$RatesDataImpl(
      Currency.fromJson(json['base'] as Map<String, dynamic>),
      (json['rates'] as List<dynamic>)
          .map((e) => Rate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RatesDataImplToJson(_$RatesDataImpl instance) =>
    <String, dynamic>{
      'base': instance.base.toJson(),
      'rates': instance.rates.map((e) => e.toJson()).toList(),
    };
