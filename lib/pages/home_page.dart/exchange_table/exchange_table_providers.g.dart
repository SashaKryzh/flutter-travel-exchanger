// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_table_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$exchangeValuesHash() => r'8b52bf18cf211d647179167e8fd2503cb21ee593';

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
String _$betweenValuesHash() => r'e88073c236f161d094971155e444097a2b9bcfac';

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

/// See also [betweenValues].
@ProviderFor(betweenValues)
const betweenValuesProvider = BetweenValuesFamily();

/// See also [betweenValues].
class BetweenValuesFamily extends Family<List<double>?> {
  /// See also [betweenValues].
  const BetweenValuesFamily();

  /// See also [betweenValues].
  BetweenValuesProvider call({
    required ExchangeValuesFrom from1,
    required double value,
    required int level,
  }) {
    return BetweenValuesProvider(
      from1: from1,
      value: value,
      level: level,
    );
  }

  @override
  BetweenValuesProvider getProviderOverride(
    covariant BetweenValuesProvider provider,
  ) {
    return call(
      from1: provider.from1,
      value: provider.value,
      level: provider.level,
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
  String? get name => r'betweenValuesProvider';
}

/// See also [betweenValues].
class BetweenValuesProvider extends AutoDisposeProvider<List<double>?> {
  /// See also [betweenValues].
  BetweenValuesProvider({
    required ExchangeValuesFrom from1,
    required double value,
    required int level,
  }) : this._internal(
          (ref) => betweenValues(
            ref as BetweenValuesRef,
            from1: from1,
            value: value,
            level: level,
          ),
          from: betweenValuesProvider,
          name: r'betweenValuesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$betweenValuesHash,
          dependencies: BetweenValuesFamily._dependencies,
          allTransitiveDependencies:
              BetweenValuesFamily._allTransitiveDependencies,
          from1: from1,
          value: value,
          level: level,
        );

  BetweenValuesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.from1,
    required this.value,
    required this.level,
  }) : super.internal();

  final ExchangeValuesFrom from1;
  final double value;
  final int level;

  @override
  Override overrideWith(
    List<double>? Function(BetweenValuesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BetweenValuesProvider._internal(
        (ref) => create(ref as BetweenValuesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        from1: from1,
        value: value,
        level: level,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<double>?> createElement() {
    return _BetweenValuesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BetweenValuesProvider &&
        other.from1 == from1 &&
        other.value == value &&
        other.level == level;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, from1.hashCode);
    hash = _SystemHash.combine(hash, value.hashCode);
    hash = _SystemHash.combine(hash, level.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BetweenValuesRef on AutoDisposeProviderRef<List<double>?> {
  /// The parameter `from1` of this provider.
  ExchangeValuesFrom get from1;

  /// The parameter `value` of this provider.
  double get value;

  /// The parameter `level` of this provider.
  int get level;
}

class _BetweenValuesProviderElement
    extends AutoDisposeProviderElement<List<double>?> with BetweenValuesRef {
  _BetweenValuesProviderElement(super.provider);

  @override
  ExchangeValuesFrom get from1 => (origin as BetweenValuesProvider).from1;
  @override
  double get value => (origin as BetweenValuesProvider).value;
  @override
  int get level => (origin as BetweenValuesProvider).level;
}

String _$convertedValuesHash() => r'7c785ac76773d88d79e93a18608641b6d63b7e64';

/// See also [convertedValues].
@ProviderFor(convertedValues)
const convertedValuesProvider = ConvertedValuesFamily();

/// See also [convertedValues].
class ConvertedValuesFamily extends Family<(Value, Value?)> {
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
class ConvertedValuesProvider extends AutoDisposeProvider<(Value, Value?)> {
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
    (Value, Value?) Function(ConvertedValuesRef provider) create,
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
  AutoDisposeProviderElement<(Value, Value?)> createElement() {
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

mixin ConvertedValuesRef on AutoDisposeProviderRef<(Value, Value?)> {
  /// The parameter `value` of this provider.
  double get value;
}

class _ConvertedValuesProviderElement
    extends AutoDisposeProviderElement<(Value, Value?)>
    with ConvertedValuesRef {
  _ConvertedValuesProviderElement(super.provider);

  @override
  double get value => (origin as ConvertedValuesProvider).value;
}

String _$autoSizeGroupHash() => r'f3f10cb05b06b86004d72b23a3556506f004dbe1';

/// See also [autoSizeGroup].
@ProviderFor(autoSizeGroup)
const autoSizeGroupProvider = AutoSizeGroupFamily();

/// See also [autoSizeGroup].
class AutoSizeGroupFamily extends Family<AutoSizeGroup> {
  /// See also [autoSizeGroup].
  const AutoSizeGroupFamily();

  /// See also [autoSizeGroup].
  AutoSizeGroupProvider call(
    int level,
  ) {
    return AutoSizeGroupProvider(
      level,
    );
  }

  @override
  AutoSizeGroupProvider getProviderOverride(
    covariant AutoSizeGroupProvider provider,
  ) {
    return call(
      provider.level,
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
  String? get name => r'autoSizeGroupProvider';
}

/// See also [autoSizeGroup].
class AutoSizeGroupProvider extends AutoDisposeProvider<AutoSizeGroup> {
  /// See also [autoSizeGroup].
  AutoSizeGroupProvider(
    int level,
  ) : this._internal(
          (ref) => autoSizeGroup(
            ref as AutoSizeGroupRef,
            level,
          ),
          from: autoSizeGroupProvider,
          name: r'autoSizeGroupProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$autoSizeGroupHash,
          dependencies: AutoSizeGroupFamily._dependencies,
          allTransitiveDependencies:
              AutoSizeGroupFamily._allTransitiveDependencies,
          level: level,
        );

  AutoSizeGroupProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.level,
  }) : super.internal();

  final int level;

  @override
  Override overrideWith(
    AutoSizeGroup Function(AutoSizeGroupRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AutoSizeGroupProvider._internal(
        (ref) => create(ref as AutoSizeGroupRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        level: level,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<AutoSizeGroup> createElement() {
    return _AutoSizeGroupProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AutoSizeGroupProvider && other.level == level;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, level.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AutoSizeGroupRef on AutoDisposeProviderRef<AutoSizeGroup> {
  /// The parameter `level` of this provider.
  int get level;
}

class _AutoSizeGroupProviderElement
    extends AutoDisposeProviderElement<AutoSizeGroup> with AutoSizeGroupRef {
  _AutoSizeGroupProviderElement(super.provider);

  @override
  int get level => (origin as AutoSizeGroupProvider).level;
}

String _$exchangeTableExpandedRowsHash() =>
    r'20cb383e4f71c5e28fd71c4797eca82f043dc3c8';

/// See also [ExchangeTableExpandedRows].
@ProviderFor(ExchangeTableExpandedRows)
final exchangeTableExpandedRowsProvider = AutoDisposeNotifierProvider<
    ExchangeTableExpandedRows, ExchangeTableExpandedRowsState>.internal(
  ExchangeTableExpandedRows.new,
  name: r'exchangeTableExpandedRowsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$exchangeTableExpandedRowsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExchangeTableExpandedRows
    = AutoDisposeNotifier<ExchangeTableExpandedRowsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
