// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appLocaleStreamHash() => r'37e42ff7d49f119c94db99566dfd54374e150c9a';

/// See also [appLocaleStream].
@ProviderFor(appLocaleStream)
final appLocaleStreamProvider = AutoDisposeStreamProvider<AppLocale>.internal(
  appLocaleStream,
  name: r'appLocaleStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appLocaleStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppLocaleStreamRef = AutoDisposeStreamProviderRef<AppLocale>;
String _$tHash() => r'26289ce7c8dd8f27764ca5bbea5d3aa1f513fec9';

/// Translation provider
///
/// Copied from [t].
@ProviderFor(t)
final tProvider = AutoDisposeProvider<Translations>.internal(
  t,
  name: r'tProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TRef = AutoDisposeProviderRef<Translations>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
