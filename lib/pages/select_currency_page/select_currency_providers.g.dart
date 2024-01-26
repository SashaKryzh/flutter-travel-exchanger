// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_currency_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchCurrenciesHash() => r'970b1fbce3b3f51cd495d354010fd14822dcb3a4';

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
    String query,
  ) {
    return SearchCurrenciesProvider(
      query,
    );
  }

  @override
  SearchCurrenciesProvider getProviderOverride(
    covariant SearchCurrenciesProvider provider,
  ) {
    return call(
      provider.query,
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
    String query,
  ) : this._internal(
          (ref) => searchCurrencies(
            ref as SearchCurrenciesRef,
            query,
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
        );

  SearchCurrenciesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

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
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<Currency>> createElement() {
    return _SearchCurrenciesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchCurrenciesProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchCurrenciesRef on AutoDisposeProviderRef<List<Currency>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchCurrenciesProviderElement
    extends AutoDisposeProviderElement<List<Currency>>
    with SearchCurrenciesRef {
  _SearchCurrenciesProviderElement(super.provider);

  @override
  String get query => (origin as SearchCurrenciesProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
