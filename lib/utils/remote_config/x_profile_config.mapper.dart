// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'x_profile_config.dart';

class XProfileConfigMapper extends ClassMapperBase<XProfileConfig> {
  XProfileConfigMapper._();

  static XProfileConfigMapper? _instance;
  static XProfileConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = XProfileConfigMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'XProfileConfig';

  static String _$username(XProfileConfig v) => v.username;
  static const Field<XProfileConfig, String> _f$username =
      Field('username', _$username);
  static String _$url(XProfileConfig v) => v.url;
  static const Field<XProfileConfig, String> _f$url = Field('url', _$url);

  @override
  final MappableFields<XProfileConfig> fields = const {
    #username: _f$username,
    #url: _f$url,
  };

  static XProfileConfig _instantiate(DecodingData data) {
    return XProfileConfig(
        username: data.dec(_f$username), url: data.dec(_f$url));
  }

  @override
  final Function instantiate = _instantiate;

  static XProfileConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<XProfileConfig>(map);
  }

  static XProfileConfig fromJson(String json) {
    return ensureInitialized().decodeJson<XProfileConfig>(json);
  }
}

mixin XProfileConfigMappable {
  String toJson() {
    return XProfileConfigMapper.ensureInitialized()
        .encodeJson<XProfileConfig>(this as XProfileConfig);
  }

  Map<String, dynamic> toMap() {
    return XProfileConfigMapper.ensureInitialized()
        .encodeMap<XProfileConfig>(this as XProfileConfig);
  }

  XProfileConfigCopyWith<XProfileConfig, XProfileConfig, XProfileConfig>
      get copyWith => _XProfileConfigCopyWithImpl(
          this as XProfileConfig, $identity, $identity);
  @override
  String toString() {
    return XProfileConfigMapper.ensureInitialized()
        .stringifyValue(this as XProfileConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            XProfileConfigMapper.ensureInitialized()
                .isValueEqual(this as XProfileConfig, other));
  }

  @override
  int get hashCode {
    return XProfileConfigMapper.ensureInitialized()
        .hashValue(this as XProfileConfig);
  }
}

extension XProfileConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, XProfileConfig, $Out> {
  XProfileConfigCopyWith<$R, XProfileConfig, $Out> get $asXProfileConfig =>
      $base.as((v, t, t2) => _XProfileConfigCopyWithImpl(v, t, t2));
}

abstract class XProfileConfigCopyWith<$R, $In extends XProfileConfig, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? username, String? url});
  XProfileConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _XProfileConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, XProfileConfig, $Out>
    implements XProfileConfigCopyWith<$R, XProfileConfig, $Out> {
  _XProfileConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<XProfileConfig> $mapper =
      XProfileConfigMapper.ensureInitialized();
  @override
  $R call({String? username, String? url}) => $apply(FieldCopyWithData(
      {if (username != null) #username: username, if (url != null) #url: url}));
  @override
  XProfileConfig $make(CopyWithData data) => XProfileConfig(
      username: data.get(#username, or: $value.username),
      url: data.get(#url, or: $value.url));

  @override
  XProfileConfigCopyWith<$R2, XProfileConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _XProfileConfigCopyWithImpl($value, $cast, t);
}
