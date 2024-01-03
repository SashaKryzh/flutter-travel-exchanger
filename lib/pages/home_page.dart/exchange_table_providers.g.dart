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
String _$convertedValuesHash() => r'f2823e1f7735e9804d375ac04775fff85d52c6d9';

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

/// See also [convertedValues].
@ProviderFor(convertedValues)
const convertedValuesProvider = ConvertedValuesFamily();

/// See also [convertedValues].
class ConvertedValuesFamily extends Family<(double, double?)> {
  /// See also [convertedValues].
  const ConvertedValuesFamily();

  /// See also [convertedValues].
  ConvertedValuesProvider call(
    double value,
  ) {
    return ConvertedValuesProvider(
      value,
    );
  }

  @override
  ConvertedValuesProvider getProviderOverride(
    covariant ConvertedValuesProvider provider,
  ) {
    return call(
      provider.value,
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
  String? get name => r'convertedValuesProvider';
}

/// See also [convertedValues].
class ConvertedValuesProvider extends AutoDisposeProvider<(double, double?)> {
  /// See also [convertedValues].
  ConvertedValuesProvider(
    double value,
  ) : this._internal(
          (ref) => convertedValues(
            ref as ConvertedValuesRef,
            value,
          ),
          from: convertedValuesProvider,
          name: r'convertedValuesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$convertedValuesHash,
          dependencies: ConvertedValuesFamily._dependencies,
          allTransitiveDependencies:
              ConvertedValuesFamily._allTransitiveDependencies,
          value: value,
        );

  ConvertedValuesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.value,
  }) : super.internal();

  final double value;

  @override
  Override overrideWith(
    (double, double?) Function(ConvertedValuesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ConvertedValuesProvider._internal(
        (ref) => create(ref as ConvertedValuesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        value: value,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<(double, double?)> createElement() {
    return _ConvertedValuesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConvertedValuesProvider && other.value == value;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, value.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ConvertedValuesRef on AutoDisposeProviderRef<(double, double?)> {
  /// The parameter `value` of this provider.
  double get value;
}

class _ConvertedValuesProviderElement
    extends AutoDisposeProviderElement<(double, double?)>
    with ConvertedValuesRef {
  _ConvertedValuesProviderElement(super.provider);

  @override
  double get value => (origin as ConvertedValuesProvider).value;
}

String _$exchangeValuesFromNotifierHash() =>
    r'a734b8659ccc2196255a75573350cd7246cda9c7';

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
    r'55a8f0fa76d6bd1ee68b0058d6befb531b39a5a5';

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
