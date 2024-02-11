// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_currency_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectCurrencyPageInitialCurrencyHash() =>
    r'b3f1031924fcad884dcfe9014bc0698068a6bbc3';

/// See also [selectCurrencyPageInitialCurrency].
@ProviderFor(selectCurrencyPageInitialCurrency)
final selectCurrencyPageInitialCurrencyProvider =
    AutoDisposeProvider<Currency>.internal(
  selectCurrencyPageInitialCurrency,
  name: r'selectCurrencyPageInitialCurrencyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectCurrencyPageInitialCurrencyHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef SelectCurrencyPageInitialCurrencyRef = AutoDisposeProviderRef<Currency>;
String _$searchCurrenciesHash() => r'f550e325b7a154879dbefbaa2c0e7fa39e15873f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [searchCurrencies].
@ProviderFor(searchCurrencies)
const searchCurrenciesProvider = SearchCurrenciesFamily();

/// See also [searchCurrencies].
class SearchCurrenciesFamily extends Family<List<Currency>> {
  /// See also [searchCurrencies].
  const SearchCurrenciesFamily();

  /// See also [searchCurrencies].
  SearchCurrenciesProvider call(
    String query, {
    bool Function(Currency)? filter,
  }) {
    return SearchCurrenciesProvider(
      query,
      filter: filter,
    );
  }

  @override
  SearchCurrenciesProvider getProviderOverride(
    covariant SearchCurrenciesProvider provider,
  ) {
    return call(
      provider.query,
      filter: provider.filter,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchCurrenciesProvider';
}

/// See also [searchCurrencies].
class SearchCurrenciesProvider extends AutoDisposeProvider<List<Currency>> {
  /// See also [searchCurrencies].
  SearchCurrenciesProvider(
    String query, {
    bool Function(Currency)? filter,
  }) : this._internal(
          (ref) => searchCurrencies(
            ref as SearchCurrenciesRef,
            query,
            filter: filter,
          ),
          from: searchCurrenciesProvider,
          name: r'searchCurrenciesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchCurrenciesHash,
          dependencies: SearchCurrenciesFamily._dependencies,
          allTransitiveDependencies:
              SearchCurrenciesFamily._allTransitiveDependencies,
          query: query,
          filter: filter,
        );

  SearchCurrenciesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.filter,
  }) : super.internal();

  final String query;
  final bool Function(Currency)? filter;

  @override
  Override overrideWith(
    List<Currency> Function(SearchCurrenciesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchCurrenciesProvider._internal(
        (ref) => create(ref as SearchCurrenciesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        filter: filter,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<Currency>> createElement() {
    return _SearchCurrenciesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchCurrenciesProvider &&
        other.query == query &&
        other.filter == filter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchCurrenciesRef on AutoDisposeProviderRef<List<Currency>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `filter` of this provider.
  bool Function(Currency)? get filter;
}

class _SearchCurrenciesProviderElement
    extends AutoDisposeProviderElement<List<Currency>>
    with SearchCurrenciesRef {
  _SearchCurrenciesProviderElement(super.provider);

  @override
  String get query => (origin as SearchCurrenciesProvider).query;
  @override
  bool Function(Currency)? get filter =>
      (origin as SearchCurrenciesProvider).filter;
}

String _$selectCurrencyAllCurrenciesHash() =>
    r'1f2fcfe1602b258a132b71334297eacf8637af43';

/// See also [selectCurrencyAllCurrencies].
@ProviderFor(selectCurrencyAllCurrencies)
final selectCurrencyAllCurrenciesProvider =
    AutoDisposeProvider<List<Currency>>.internal(
  selectCurrencyAllCurrencies,
  name: r'selectCurrencyAllCurrenciesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectCurrencyAllCurrenciesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectCurrencyAllCurrenciesRef = AutoDisposeProviderRef<List<Currency>>;
String _$currencyMetadataHash() => r'99e031da7e2c1315ebeb92e93e2609a4bfee89e2';

/// See also [currencyMetadata].
@ProviderFor(currencyMetadata)
const currencyMetadataProvider = CurrencyMetadataFamily();

/// See also [currencyMetadata].
class CurrencyMetadataFamily extends Family<CurrencyMetadata> {
  /// See also [currencyMetadata].
  const CurrencyMetadataFamily();

  /// See also [currencyMetadata].
  CurrencyMetadataProvider call(
    Currency currency,
  ) {
    return CurrencyMetadataProvider(
      currency,
    );
  }

  @override
  CurrencyMetadataProvider getProviderOverride(
    covariant CurrencyMetadataProvider provider,
  ) {
    return call(
      provider.currency,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    selectCurrencyNotifierProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    selectCurrencyNotifierProvider,
    ...?selectCurrencyNotifierProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'currencyMetadataProvider';
}

/// See also [currencyMetadata].
class CurrencyMetadataProvider extends AutoDisposeProvider<CurrencyMetadata> {
  /// See also [currencyMetadata].
  CurrencyMetadataProvider(
    Currency currency,
  ) : this._internal(
          (ref) => currencyMetadata(
            ref as CurrencyMetadataRef,
            currency,
          ),
          from: currencyMetadataProvider,
          name: r'currencyMetadataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currencyMetadataHash,
          dependencies: CurrencyMetadataFamily._dependencies,
          allTransitiveDependencies:
              CurrencyMetadataFamily._allTransitiveDependencies,
          currency: currency,
        );

  CurrencyMetadataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.currency,
  }) : super.internal();

  final Currency currency;

  @override
  Override overrideWith(
    CurrencyMetadata Function(CurrencyMetadataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrencyMetadataProvider._internal(
        (ref) => create(ref as CurrencyMetadataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        currency: currency,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<CurrencyMetadata> createElement() {
    return _CurrencyMetadataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrencyMetadataProvider && other.currency == currency;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currency.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CurrencyMetadataRef on AutoDisposeProviderRef<CurrencyMetadata> {
  /// The parameter `currency` of this provider.
  Currency get currency;
}

class _CurrencyMetadataProviderElement
    extends AutoDisposeProviderElement<CurrencyMetadata>
    with CurrencyMetadataRef {
  _CurrencyMetadataProviderElement(super.provider);

  @override
  Currency get currency => (origin as CurrencyMetadataProvider).currency;
}

String _$selectCurrencyNotifierHash() =>
    r'de23fab06c6d8e2507572da171a2bc88223a15b7';

/// See also [SelectCurrencyNotifier].
@ProviderFor(SelectCurrencyNotifier)
final selectCurrencyNotifierProvider = AutoDisposeNotifierProvider<
    SelectCurrencyNotifier, SelectCurrencyState>.internal(
  SelectCurrencyNotifier.new,
  name: r'selectCurrencyNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectCurrencyNotifierHash,
  dependencies: <ProviderOrFamily>[selectCurrencyPageInitialCurrencyProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    selectCurrencyPageInitialCurrencyProvider,
    ...?selectCurrencyPageInitialCurrencyProvider.allTransitiveDependencies
  },
);

typedef _$SelectCurrencyNotifier = AutoDisposeNotifier<SelectCurrencyState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
