// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'terms_of_use_config.dart';

class TermsOfUseConfigMapper extends ClassMapperBase<TermsOfUseConfig> {
  TermsOfUseConfigMapper._();

  static TermsOfUseConfigMapper? _instance;
  static TermsOfUseConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TermsOfUseConfigMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TermsOfUseConfig';

  static String _$url(TermsOfUseConfig v) => v.url;
  static const Field<TermsOfUseConfig, String> _f$url = Field('url', _$url);

  @override
  final MappableFields<TermsOfUseConfig> fields = const {
    #url: _f$url,
  };

  static TermsOfUseConfig _instantiate(DecodingData data) {
    return TermsOfUseConfig(url: data.dec(_f$url));
  }

  @override
  final Function instantiate = _instantiate;

  static TermsOfUseConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TermsOfUseConfig>(map);
  }

  static TermsOfUseConfig fromJson(String json) {
    return ensureInitialized().decodeJson<TermsOfUseConfig>(json);
  }
}

mixin TermsOfUseConfigMappable {
  String toJson() {
    return TermsOfUseConfigMapper.ensureInitialized()
        .encodeJson<TermsOfUseConfig>(this as TermsOfUseConfig);
  }

  Map<String, dynamic> toMap() {
    return TermsOfUseConfigMapper.ensureInitialized()
        .encodeMap<TermsOfUseConfig>(this as TermsOfUseConfig);
  }

  TermsOfUseConfigCopyWith<TermsOfUseConfig, TermsOfUseConfig, TermsOfUseConfig>
      get copyWith => _TermsOfUseConfigCopyWithImpl(
          this as TermsOfUseConfig, $identity, $identity);
  @override
  String toString() {
    return TermsOfUseConfigMapper.ensureInitialized()
        .stringifyValue(this as TermsOfUseConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TermsOfUseConfigMapper.ensureInitialized()
                .isValueEqual(this as TermsOfUseConfig, other));
  }

  @override
  int get hashCode {
    return TermsOfUseConfigMapper.ensureInitialized()
        .hashValue(this as TermsOfUseConfig);
  }
}

extension TermsOfUseConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TermsOfUseConfig, $Out> {
  TermsOfUseConfigCopyWith<$R, TermsOfUseConfig, $Out>
      get $asTermsOfUseConfig =>
          $base.as((v, t, t2) => _TermsOfUseConfigCopyWithImpl(v, t, t2));
}

abstract class TermsOfUseConfigCopyWith<$R, $In extends TermsOfUseConfig, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? url});
  TermsOfUseConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TermsOfUseConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TermsOfUseConfig, $Out>
    implements TermsOfUseConfigCopyWith<$R, TermsOfUseConfig, $Out> {
  _TermsOfUseConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TermsOfUseConfig> $mapper =
      TermsOfUseConfigMapper.ensureInitialized();
  @override
  $R call({String? url}) =>
      $apply(FieldCopyWithData({if (url != null) #url: url}));
  @override
  TermsOfUseConfig $make(CopyWithData data) =>
      TermsOfUseConfig(url: data.get(#url, or: $value.url));

  @override
  TermsOfUseConfigCopyWith<$R2, TermsOfUseConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TermsOfUseConfigCopyWithImpl($value, $cast, t);
}
