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
String _$recentlyUsedHash() => r'd17b61a12c643ca7ea507da3cd1b2c457504892d';

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

/// See also [recentlyUsed].
@ProviderFor(recentlyUsed)
const recentlyUsedProvider = RecentlyUsedFamily();

/// See also [recentlyUsed].
class RecentlyUsedFamily extends Family<List<Currency>> {
  /// See also [recentlyUsed].
  const RecentlyUsedFamily();

  /// See also [recentlyUsed].
  RecentlyUsedProvider call({
    int limit = 5,
  }) {
    return RecentlyUsedProvider(
      limit: limit,
    );
  }

  @override
  RecentlyUsedProvider getProviderOverride(
    covariant RecentlyUsedProvider provider,
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
  String? get name => r'recentlyUsedProvider';
}

/// See also [recentlyUsed].
class RecentlyUsedProvider extends AutoDisposeProvider<List<Currency>> {
  /// See also [recentlyUsed].
  RecentlyUsedProvider({
    int limit = 5,
  }) : this._internal(
          (ref) => recentlyUsed(
            ref as RecentlyUsedRef,
            limit: limit,
          ),
          from: recentlyUsedProvider,
          name: r'recentlyUsedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recentlyUsedHash,
          dependencies: RecentlyUsedFamily._dependencies,
          allTransitiveDependencies:
              RecentlyUsedFamily._allTransitiveDependencies,
          limit: limit,
        );

  RecentlyUsedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
  }) : super.internal();

  final int limit;

  @override
  Override overrideWith(
    List<Currency> Function(RecentlyUsedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecentlyUsedProvider._internal(
        (ref) => create(ref as RecentlyUsedRef),
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
    return _RecentlyUsedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecentlyUsedProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RecentlyUsedRef on AutoDisposeProviderRef<List<Currency>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _RecentlyUsedProviderElement
    extends AutoDisposeProviderElement<List<Currency>> with RecentlyUsedRef {
  _RecentlyUsedProviderElement(super.provider);

  @override
  int get limit => (origin as RecentlyUsedProvider).limit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
