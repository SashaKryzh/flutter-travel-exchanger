// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_rate_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeRateDataImpl _$$TimeRateDataImplFromJson(Map<String, dynamic> json) =>
    _$TimeRateDataImpl(
      to: Currency.fromJson(json['to'] as Map<String, dynamic>),
      rate: (json['rate'] as num).toDouble(),
    );

Map<String, dynamic> _$$TimeRateDataImplToJson(_$TimeRateDataImpl instance) =>
    <String, dynamic>{
      'to': instance.to.toJson(),
      'rate': instance.rate,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timeRateRepositoryHash() =>
    r'6da2517ae5970833726f0e151f0cda2152576b14';

/// See also [timeRateRepository].
@ProviderFor(timeRateRepository)
final timeRateRepositoryProvider =
    AutoDisposeProvider<TimeRateRepository>.internal(
  timeRateRepository,
  name: r'timeRateRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timeRateRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TimeRateRepositoryRef = AutoDisposeProviderRef<TimeRateRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
