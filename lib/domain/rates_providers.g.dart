// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rates_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ratesHash() => r'c0a59ae494218f8c043f44f2587b376dfcf4a648';

/// See also [rates].
@ProviderFor(rates)
final ratesProvider = AutoDisposeProvider<List<Rate>>.internal(
  rates,
  name: r'ratesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ratesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RatesRef = AutoDisposeProviderRef<List<Rate>>;
String _$rateHash() => r'7f6d066c861de4f6afdbe2caa2586a9d26d572d7';

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

/// See also [rate].
@ProviderFor(rate)
const rateProvider = RateFamily();

/// See also [rate].
class RateFamily extends Family<double> {
  /// See also [rate].
  const RateFamily();

  /// See also [rate].
  RateProvider call(
    Currency fromm,
    Currency to,
  ) {
    return RateProvider(
      fromm,
      to,
    );
  }

  @override
  RateProvider getProviderOverride(
    covariant RateProvider provider,
  ) {
    return call(
      provider.fromm,
      provider.to,
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
  String? get name => r'rateProvider';
}

/// See also [rate].
class RateProvider extends AutoDisposeProvider<double> {
  /// See also [rate].
  RateProvider(
    Currency fromm,
    Currency to,
  ) : this._internal(
          (ref) => rate(
            ref as RateRef,
            fromm,
            to,
          ),
          from: rateProvider,
          name: r'rateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$rateHash,
          dependencies: RateFamily._dependencies,
          allTransitiveDependencies: RateFamily._allTransitiveDependencies,
          fromm: fromm,
          to: to,
        );

  RateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fromm,
    required this.to,
  }) : super.internal();

  final Currency fromm;
  final Currency to;

  @override
  Override overrideWith(
    double Function(RateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RateProvider._internal(
        (ref) => create(ref as RateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fromm: fromm,
        to: to,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<double> createElement() {
    return _RateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RateProvider && other.fromm == fromm && other.to == to;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fromm.hashCode);
    hash = _SystemHash.combine(hash, to.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RateRef on AutoDisposeProviderRef<double> {
  /// The parameter `fromm` of this provider.
  Currency get fromm;

  /// The parameter `to` of this provider.
  Currency get to;
}

class _RateProviderElement extends AutoDisposeProviderElement<double>
    with RateRef {
  _RateProviderElement(super.provider);

  @override
  Currency get fromm => (origin as RateProvider).fromm;
  @override
  Currency get to => (origin as RateProvider).to;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
