// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'converter_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$exchangeListHash() => r'1447c7c0df842af763897f40dc00e66fc1160d4c';

/// See also [exchangeList].
@ProviderFor(exchangeList)
final exchangeListProvider =
    AutoDisposeFutureProvider<List<Exchangeable>>.internal(
  exchangeList,
  name: r'exchangeListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$exchangeListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExchangeListRef = AutoDisposeFutureProviderRef<List<Exchangeable>>;
String _$exchangeBetweenHash() => r'83ad84be5e83610af0db1f682fd66c840b7cb21e';

/// See also [ExchangeBetween].
@ProviderFor(ExchangeBetween)
final exchangeBetweenProvider =
    AutoDisposeNotifierProvider<ExchangeBetween, ExchangeBetweenState>.internal(
  ExchangeBetween.new,
  name: r'exchangeBetweenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exchangeBetweenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExchangeBetween = AutoDisposeNotifier<ExchangeBetweenState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
