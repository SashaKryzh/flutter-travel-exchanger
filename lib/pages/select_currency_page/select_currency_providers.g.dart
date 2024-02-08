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
String _$selectCurrencyNotifierHash() =>
    r'ed984832faa157f8402f261a7292d4f02923507a';

abstract class _$SelectCurrencyNotifier
    extends BuildlessAutoDisposeNotifier<SelectCurrencyState> {
  late final Currency selectingFor;

  SelectCurrencyState build(
    Currency selectingFor,
  );
}

/// See also [SelectCurrencyNotifier].
@ProviderFor(SelectCurrencyNotifier)
const selectCurrencyNotifierProvider = SelectCurrencyNotifierFamily();

/// See also [SelectCurrencyNotifier].
class SelectCurrencyNotifierFamily extends Family<SelectCurrencyState> {
  /// See also [SelectCurrencyNotifier].
  const SelectCurrencyNotifierFamily();

  /// See also [SelectCurrencyNotifier].
  SelectCurrencyNotifierProvider call(
    Currency selectingFor,
  ) {
    return SelectCurrencyNotifierProvider(
      selectingFor,
    );
  }

  @override
  SelectCurrencyNotifierProvider getProviderOverride(
    covariant SelectCurrencyNotifierProvider provider,
  ) {
    return call(
      provider.selectingFor,
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
  String? get name => r'selectCurrencyNotifierProvider';
}

/// See also [SelectCurrencyNotifier].
class SelectCurrencyNotifierProvider extends AutoDisposeNotifierProviderImpl<
    SelectCurrencyNotifier, SelectCurrencyState> {
  /// See also [SelectCurrencyNotifier].
  SelectCurrencyNotifierProvider(
    Currency selectingFor,
  ) : this._internal(
          () => SelectCurrencyNotifier()..selectingFor = selectingFor,
          from: selectCurrencyNotifierProvider,
          name: r'selectCurrencyNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectCurrencyNotifierHash,
          dependencies: SelectCurrencyNotifierFamily._dependencies,
          allTransitiveDependencies:
              SelectCurrencyNotifierFamily._allTransitiveDependencies,
          selectingFor: selectingFor,
        );

  SelectCurrencyNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.selectingFor,
  }) : super.internal();

  final Currency selectingFor;

  @override
  SelectCurrencyState runNotifierBuild(
    covariant SelectCurrencyNotifier notifier,
  ) {
    return notifier.build(
      selectingFor,
    );
  }

  @override
  Override overrideWith(SelectCurrencyNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectCurrencyNotifierProvider._internal(
        () => create()..selectingFor = selectingFor,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        selectingFor: selectingFor,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SelectCurrencyNotifier,
      SelectCurrencyState> createElement() {
    return _SelectCurrencyNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectCurrencyNotifierProvider &&
        other.selectingFor == selectingFor;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, selectingFor.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectCurrencyNotifierRef
    on AutoDisposeNotifierProviderRef<SelectCurrencyState> {
  /// The parameter `selectingFor` of this provider.
  Currency get selectingFor;
}

class _SelectCurrencyNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<SelectCurrencyNotifier,
        SelectCurrencyState> with SelectCurrencyNotifierRef {
  _SelectCurrencyNotifierProviderElement(super.provider);

  @override
  Currency get selectingFor =>
      (origin as SelectCurrencyNotifierProvider).selectingFor;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
