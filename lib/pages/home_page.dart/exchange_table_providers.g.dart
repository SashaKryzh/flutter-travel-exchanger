// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_table_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$exchangeValuesHash() => r'2ef3c540dcdc3d5ea210ec6df3d49fb894b5a429';

/// See also [exchangeValues].
@ProviderFor(exchangeValues)
final exchangeValuesProvider = AutoDisposeProvider<List<double>>.internal(
  exchangeValues,
  name: r'exchangeValuesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exchangeValuesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ExchangeValuesRef = AutoDisposeProviderRef<List<double>>;
String _$exchangeValuesFromNotifierHash() =>
    r'4042b4b72ab1a423e3c7456326f944ff7047860e';

/// See also [ExchangeValuesFromNotifier].
@ProviderFor(ExchangeValuesFromNotifier)
final exchangeValuesFromNotifierProvider = AutoDisposeNotifierProvider<
    ExchangeValuesFromNotifier, ExchangeValuesFrom>.internal(
  ExchangeValuesFromNotifier.new,
  name: r'exchangeValuesFromNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exchangeValuesFromNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExchangeValuesFromNotifier = AutoDisposeNotifier<ExchangeValuesFrom>;
String _$exchangeTableExpandedRowsNotifierHash() =>
    r'aa3019cd525ba18b47ae2807230d3b1c4404832d';

/// See also [ExchangeTableExpandedRowsNotifier].
@ProviderFor(ExchangeTableExpandedRowsNotifier)
final exchangeTableExpandedRowsNotifierProvider = AutoDisposeNotifierProvider<
    ExchangeTableExpandedRowsNotifier,
    Set<ExchangeTableExpandedRowId>>.internal(
  ExchangeTableExpandedRowsNotifier.new,
  name: r'exchangeTableExpandedRowsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exchangeTableExpandedRowsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExchangeTableExpandedRowsNotifier
    = AutoDisposeNotifier<Set<ExchangeTableExpandedRowId>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
