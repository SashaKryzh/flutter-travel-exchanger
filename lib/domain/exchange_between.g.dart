// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_between.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BetweenImpl _$$BetweenImplFromJson(Map<String, dynamic> json) =>
    _$BetweenImpl(
      Currency.fromJson(json['from'] as Map<String, dynamic>),
      Currency.fromJson(json['to1'] as Map<String, dynamic>),
      json['to2_'] == null
          ? null
          : Currency.fromJson(json['to2_'] as Map<String, dynamic>),
      showTo2: json['showTo2'] as bool,
    );

Map<String, dynamic> _$$BetweenImplToJson(_$BetweenImpl instance) =>
    <String, dynamic>{
      'from': instance.from.toJson(),
      'to1': instance.to1.toJson(),
      'to2_': instance.to2_?.toJson(),
      'showTo2': instance.showTo2,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$exchangeBetweenHash() => r'259f0e425fd37aaf230c37194802d19909df6969';

/// See also [ExchangeBetween].
@ProviderFor(ExchangeBetween)
final exchangeBetweenProvider =
    AutoDisposeNotifierProvider<ExchangeBetween, Between>.internal(
  ExchangeBetween.new,
  name: r'exchangeBetweenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exchangeBetweenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExchangeBetween = AutoDisposeNotifier<Between>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
