// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'privacy_policy_config.dart';

class PrivacyPolicyConfigMapper extends ClassMapperBase<PrivacyPolicyConfig> {
  PrivacyPolicyConfigMapper._();

  static PrivacyPolicyConfigMapper? _instance;
  static PrivacyPolicyConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PrivacyPolicyConfigMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PrivacyPolicyConfig';

  static String _$url(PrivacyPolicyConfig v) => v.url;
  static const Field<PrivacyPolicyConfig, String> _f$url = Field('url', _$url);

  @override
  final MappableFields<PrivacyPolicyConfig> fields = const {
    #url: _f$url,
  };

  static PrivacyPolicyConfig _instantiate(DecodingData data) {
    return PrivacyPolicyConfig(url: data.dec(_f$url));
  }

  @override
  final Function instantiate = _instantiate;

  static PrivacyPolicyConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PrivacyPolicyConfig>(map);
  }

  static PrivacyPolicyConfig fromJson(String json) {
    return ensureInitialized().decodeJson<PrivacyPolicyConfig>(json);
  }
}

mixin PrivacyPolicyConfigMappable {
  String toJson() {
    return PrivacyPolicyConfigMapper.ensureInitialized()
        .encodeJson<PrivacyPolicyConfig>(this as PrivacyPolicyConfig);
  }

  Map<String, dynamic> toMap() {
    return PrivacyPolicyConfigMapper.ensureInitialized()
        .encodeMap<PrivacyPolicyConfig>(this as PrivacyPolicyConfig);
  }

  PrivacyPolicyConfigCopyWith<PrivacyPolicyConfig, PrivacyPolicyConfig,
          PrivacyPolicyConfig>
      get copyWith => _PrivacyPolicyConfigCopyWithImpl(
          this as PrivacyPolicyConfig, $identity, $identity);
  @override
  String toString() {
    return PrivacyPolicyConfigMapper.ensureInitialized()
        .stringifyValue(this as PrivacyPolicyConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PrivacyPolicyConfigMapper.ensureInitialized()
                .isValueEqual(this as PrivacyPolicyConfig, other));
  }

  @override
  int get hashCode {
    return PrivacyPolicyConfigMapper.ensureInitialized()
        .hashValue(this as PrivacyPolicyConfig);
  }
}

extension PrivacyPolicyConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PrivacyPolicyConfig, $Out> {
  PrivacyPolicyConfigCopyWith<$R, PrivacyPolicyConfig, $Out>
      get $asPrivacyPolicyConfig =>
          $base.as((v, t, t2) => _PrivacyPolicyConfigCopyWithImpl(v, t, t2));
}

abstract class PrivacyPolicyConfigCopyWith<$R, $In extends PrivacyPolicyConfig,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? url});
  PrivacyPolicyConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _PrivacyPolicyConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PrivacyPolicyConfig, $Out>
    implements PrivacyPolicyConfigCopyWith<$R, PrivacyPolicyConfig, $Out> {
  _PrivacyPolicyConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PrivacyPolicyConfig> $mapper =
      PrivacyPolicyConfigMapper.ensureInitialized();
  @override
  $R call({String? url}) =>
      $apply(FieldCopyWithData({if (url != null) #url: url}));
  @override
  PrivacyPolicyConfig $make(CopyWithData data) =>
      PrivacyPolicyConfig(url: data.get(#url, or: $value.url));

  @override
  PrivacyPolicyConfigCopyWith<$R2, PrivacyPolicyConfig, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _PrivacyPolicyConfigCopyWithImpl($value, $cast, t);
}
