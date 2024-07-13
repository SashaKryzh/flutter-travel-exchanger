// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'feature_flags.dart';

class FeatureFlagsMapper extends ClassMapperBase<FeatureFlags> {
  FeatureFlagsMapper._();

  static FeatureFlagsMapper? _instance;
  static FeatureFlagsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeatureFlagsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FeatureFlags';

  static bool _$enableRecentlyUsed(FeatureFlags v) => v.enableRecentlyUsed;
  static const Field<FeatureFlags, bool> _f$enableRecentlyUsed =
      Field('enableRecentlyUsed', _$enableRecentlyUsed);

  @override
  final MappableFields<FeatureFlags> fields = const {
    #enableRecentlyUsed: _f$enableRecentlyUsed,
  };

  static FeatureFlags _instantiate(DecodingData data) {
    return FeatureFlags(data.dec(_f$enableRecentlyUsed));
  }

  @override
  final Function instantiate = _instantiate;

  static FeatureFlags fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FeatureFlags>(map);
  }

  static FeatureFlags fromJson(String json) {
    return ensureInitialized().decodeJson<FeatureFlags>(json);
  }
}

mixin FeatureFlagsMappable {
  String toJson() {
    return FeatureFlagsMapper.ensureInitialized()
        .encodeJson<FeatureFlags>(this as FeatureFlags);
  }

  Map<String, dynamic> toMap() {
    return FeatureFlagsMapper.ensureInitialized()
        .encodeMap<FeatureFlags>(this as FeatureFlags);
  }

  FeatureFlagsCopyWith<FeatureFlags, FeatureFlags, FeatureFlags> get copyWith =>
      _FeatureFlagsCopyWithImpl(this as FeatureFlags, $identity, $identity);
  @override
  String toString() {
    return FeatureFlagsMapper.ensureInitialized()
        .stringifyValue(this as FeatureFlags);
  }

  @override
  bool operator ==(Object other) {
    return FeatureFlagsMapper.ensureInitialized()
        .equalsValue(this as FeatureFlags, other);
  }

  @override
  int get hashCode {
    return FeatureFlagsMapper.ensureInitialized()
        .hashValue(this as FeatureFlags);
  }
}

extension FeatureFlagsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FeatureFlags, $Out> {
  FeatureFlagsCopyWith<$R, FeatureFlags, $Out> get $asFeatureFlags =>
      $base.as((v, t, t2) => _FeatureFlagsCopyWithImpl(v, t, t2));
}

abstract class FeatureFlagsCopyWith<$R, $In extends FeatureFlags, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? enableRecentlyUsed});
  FeatureFlagsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FeatureFlagsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FeatureFlags, $Out>
    implements FeatureFlagsCopyWith<$R, FeatureFlags, $Out> {
  _FeatureFlagsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FeatureFlags> $mapper =
      FeatureFlagsMapper.ensureInitialized();
  @override
  $R call({bool? enableRecentlyUsed}) => $apply(FieldCopyWithData({
        if (enableRecentlyUsed != null) #enableRecentlyUsed: enableRecentlyUsed
      }));
  @override
  FeatureFlags $make(CopyWithData data) => FeatureFlags(
      data.get(#enableRecentlyUsed, or: $value.enableRecentlyUsed));

  @override
  FeatureFlagsCopyWith<$R2, FeatureFlags, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FeatureFlagsCopyWithImpl($value, $cast, t);
}
