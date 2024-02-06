// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currencies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currenciesHash() => r'9c73b5bdfa7c418200e5c2a814c953000cee26e6';

/// Provides a list of all currencies.
///
/// Copied from [currencies].
@ProviderFor(currencies)
final currenciesProvider = AutoDisposeProvider<List<Currency>>.internal(
  currencies,
  name: r'currenciesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currenciesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrenciesRef = AutoDisposeProviderRef<List<Currency>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
