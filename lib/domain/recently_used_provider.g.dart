// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recently_used_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recentlyUsedStreamHash() =>
    r'960dd7838a9054127bdb2aa96b91bd3500624cf1';

/// See also [recentlyUsedStream].
@ProviderFor(recentlyUsedStream)
final recentlyUsedStreamProvider =
    AutoDisposeStreamProvider<List<Currency>>.internal(
  recentlyUsedStream,
  name: r'recentlyUsedStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentlyUsedStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecentlyUsedStreamRef = AutoDisposeStreamProviderRef<List<Currency>>;
String _$recentlyUsedHash() => r'4bc614eaf1c77e645d9d7da59a9095ece9565be7';

/// See also [recentlyUsed].
@ProviderFor(recentlyUsed)
final recentlyUsedProvider = AutoDisposeProvider<List<Currency>>.internal(
  recentlyUsed,
  name: r'recentlyUsedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$recentlyUsedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecentlyUsedRef = AutoDisposeProviderRef<List<Currency>>;
String _$filteredRecentlyUsedHash() =>
    r'cdf88aae702e4259fb0bb9ae31a740cb0e834e94';

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

/// Returns recently used currencies that are not in [exchangeBetweenProvider]
///
/// Copied from [filteredRecentlyUsed].
@ProviderFor(filteredRecentlyUsed)
const filteredRecentlyUsedProvider = FilteredRecentlyUsedFamily();

/// Returns recently used currencies that are not in [exchangeBetweenProvider]
///
/// Copied from [filteredRecentlyUsed].
class FilteredRecentlyUsedFamily extends Family<List<Currency>> {
  /// Returns recently used currencies that are not in [exchangeBetweenProvider]
  ///
  /// Copied from [filteredRecentlyUsed].
  const FilteredRecentlyUsedFamily();

  /// Returns recently used currencies that are not in [exchangeBetweenProvider]
  ///
  /// Copied from [filteredRecentlyUsed].
  FilteredRecentlyUsedProvider call({
    int? limit,
  }) {
    return FilteredRecentlyUsedProvider(
      limit: limit,
    );
  }

  @override
  FilteredRecentlyUsedProvider getProviderOverride(
    covariant FilteredRecentlyUsedProvider provider,
  ) {
    return call(
      limit: provider.limit,
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
  String? get name => r'filteredRecentlyUsedProvider';
}

/// Returns recently used currencies that are not in [exchangeBetweenProvider]
///
/// Copied from [filteredRecentlyUsed].
class FilteredRecentlyUsedProvider extends AutoDisposeProvider<List<Currency>> {
  /// Returns recently used currencies that are not in [exchangeBetweenProvider]
  ///
  /// Copied from [filteredRecentlyUsed].
  FilteredRecentlyUsedProvider({
    int? limit,
  }) : this._internal(
          (ref) => filteredRecentlyUsed(
            ref as FilteredRecentlyUsedRef,
            limit: limit,
          ),
          from: filteredRecentlyUsedProvider,
          name: r'filteredRecentlyUsedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredRecentlyUsedHash,
          dependencies: FilteredRecentlyUsedFamily._dependencies,
          allTransitiveDependencies:
              FilteredRecentlyUsedFamily._allTransitiveDependencies,
          limit: limit,
        );

  FilteredRecentlyUsedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
  }) : super.internal();

  final int? limit;

  @override
  Override overrideWith(
    List<Currency> Function(FilteredRecentlyUsedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredRecentlyUsedProvider._internal(
        (ref) => create(ref as FilteredRecentlyUsedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<Currency>> createElement() {
    return _FilteredRecentlyUsedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredRecentlyUsedProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilteredRecentlyUsedRef on AutoDisposeProviderRef<List<Currency>> {
  /// The parameter `limit` of this provider.
  int? get limit;
}

class _FilteredRecentlyUsedProviderElement
    extends AutoDisposeProviderElement<List<Currency>>
    with FilteredRecentlyUsedRef {
  _FilteredRecentlyUsedProviderElement(super.provider);

  @override
  int? get limit => (origin as FilteredRecentlyUsedProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
