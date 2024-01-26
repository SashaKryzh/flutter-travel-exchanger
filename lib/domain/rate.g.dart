// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RateImpl _$$RateImplFromJson(Map<String, dynamic> json) => _$RateImpl(
      base: Currency.fromJson(json['base'] as Map<String, dynamic>),
      target: Currency.fromJson(json['target'] as Map<String, dynamic>),
      rate: (json['rate'] as num).toDouble(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      source: $enumDecode(_$RateSourceEnumMap, json['source']),
    );

Map<String, dynamic> _$$RateImplToJson(_$RateImpl instance) =>
    <String, dynamic>{
      'base': instance.base.toJson(),
      'target': instance.target.toJson(),
      'rate': instance.rate,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'source': _$RateSourceEnumMap[instance.source]!,
    };

const _$RateSourceEnumMap = {
  RateSource.api: 'api',
  RateSource.custom: 'custom',
};
