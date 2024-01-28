// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_currency_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
