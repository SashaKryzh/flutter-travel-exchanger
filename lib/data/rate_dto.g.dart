// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
