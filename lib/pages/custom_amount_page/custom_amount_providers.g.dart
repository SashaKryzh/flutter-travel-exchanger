// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_amount_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customAmountConverterHash() =>
    r'8220ae527c239dcb12e0afbb1f80d35480b69cea';

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

abstract class _$CustomAmountConverter
    extends BuildlessAutoDisposeNotifier<CustomAmountState> {
  late final String fromCode;

  CustomAmountState build(
    String fromCode,
  );
}

/// See also [CustomAmountConverter].
@ProviderFor(CustomAmountConverter)
const customAmountConverterProvider = CustomAmountConverterFamily();

/// See also [CustomAmountConverter].
class CustomAmountConverterFamily extends Family<CustomAmountState> {
  /// See also [CustomAmountConverter].
  const CustomAmountConverterFamily();

  /// See also [CustomAmountConverter].
  CustomAmountConverterProvider call(
    String fromCode,
  ) {
    return CustomAmountConverterProvider(
      fromCode,
    );
  }

  @override
  CustomAmountConverterProvider getProviderOverride(
    covariant CustomAmountConverterProvider provider,
  ) {
    return call(
      provider.fromCode,
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
  String? get name => r'customAmountConverterProvider';
}

/// See also [CustomAmountConverter].
class CustomAmountConverterProvider extends AutoDisposeNotifierProviderImpl<
    CustomAmountConverter, CustomAmountState> {
  /// See also [CustomAmountConverter].
  CustomAmountConverterProvider(
    String fromCode,
  ) : this._internal(
          () => CustomAmountConverter()..fromCode = fromCode,
          from: customAmountConverterProvider,
          name: r'customAmountConverterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customAmountConverterHash,
          dependencies: CustomAmountConverterFamily._dependencies,
          allTransitiveDependencies:
              CustomAmountConverterFamily._allTransitiveDependencies,
          fromCode: fromCode,
        );

  CustomAmountConverterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.fromCode,
  }) : super.internal();

  final String fromCode;

  @override
  CustomAmountState runNotifierBuild(
    covariant CustomAmountConverter notifier,
  ) {
    return notifier.build(
      fromCode,
    );
  }

  @override
  Override overrideWith(CustomAmountConverter Function() create) {
    return ProviderOverride(
      origin: this,
      override: CustomAmountConverterProvider._internal(
        () => create()..fromCode = fromCode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        fromCode: fromCode,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CustomAmountConverter, CustomAmountState>
      createElement() {
    return _CustomAmountConverterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomAmountConverterProvider && other.fromCode == fromCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, fromCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CustomAmountConverterRef
    on AutoDisposeNotifierProviderRef<CustomAmountState> {
  /// The parameter `fromCode` of this provider.
  String get fromCode;
}

class _CustomAmountConverterProviderElement
    extends AutoDisposeNotifierProviderElement<CustomAmountConverter,
        CustomAmountState> with CustomAmountConverterRef {
  _CustomAmountConverterProviderElement(super.provider);

  @override
  String get fromCode => (origin as CustomAmountConverterProvider).fromCode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
