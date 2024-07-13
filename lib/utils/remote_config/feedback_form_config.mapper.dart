// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'feedback_form_config.dart';

class FeedbackFormConfigMapper extends ClassMapperBase<FeedbackFormConfig> {
  FeedbackFormConfigMapper._();

  static FeedbackFormConfigMapper? _instance;
  static FeedbackFormConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FeedbackFormConfigMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'FeedbackFormConfig';

  static String _$url(FeedbackFormConfig v) => v.url;
  static const Field<FeedbackFormConfig, String> _f$url = Field('url', _$url);

  @override
  final MappableFields<FeedbackFormConfig> fields = const {
    #url: _f$url,
  };

  static FeedbackFormConfig _instantiate(DecodingData data) {
    return FeedbackFormConfig(url: data.dec(_f$url));
  }

  @override
  final Function instantiate = _instantiate;

  static FeedbackFormConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FeedbackFormConfig>(map);
  }

  static FeedbackFormConfig fromJson(String json) {
    return ensureInitialized().decodeJson<FeedbackFormConfig>(json);
  }
}

mixin FeedbackFormConfigMappable {
  String toJson() {
    return FeedbackFormConfigMapper.ensureInitialized()
        .encodeJson<FeedbackFormConfig>(this as FeedbackFormConfig);
  }

  Map<String, dynamic> toMap() {
    return FeedbackFormConfigMapper.ensureInitialized()
        .encodeMap<FeedbackFormConfig>(this as FeedbackFormConfig);
  }

  FeedbackFormConfigCopyWith<FeedbackFormConfig, FeedbackFormConfig,
          FeedbackFormConfig>
      get copyWith => _FeedbackFormConfigCopyWithImpl(
          this as FeedbackFormConfig, $identity, $identity);
  @override
  String toString() {
    return FeedbackFormConfigMapper.ensureInitialized()
        .stringifyValue(this as FeedbackFormConfig);
  }

  @override
  bool operator ==(Object other) {
    return FeedbackFormConfigMapper.ensureInitialized()
        .equalsValue(this as FeedbackFormConfig, other);
  }

  @override
  int get hashCode {
    return FeedbackFormConfigMapper.ensureInitialized()
        .hashValue(this as FeedbackFormConfig);
  }
}

extension FeedbackFormConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FeedbackFormConfig, $Out> {
  FeedbackFormConfigCopyWith<$R, FeedbackFormConfig, $Out>
      get $asFeedbackFormConfig =>
          $base.as((v, t, t2) => _FeedbackFormConfigCopyWithImpl(v, t, t2));
}

abstract class FeedbackFormConfigCopyWith<$R, $In extends FeedbackFormConfig,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? url});
  FeedbackFormConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FeedbackFormConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FeedbackFormConfig, $Out>
    implements FeedbackFormConfigCopyWith<$R, FeedbackFormConfig, $Out> {
  _FeedbackFormConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FeedbackFormConfig> $mapper =
      FeedbackFormConfigMapper.ensureInitialized();
  @override
  $R call({String? url}) =>
      $apply(FieldCopyWithData({if (url != null) #url: url}));
  @override
  FeedbackFormConfig $make(CopyWithData data) =>
      FeedbackFormConfig(url: data.get(#url, or: $value.url));

  @override
  FeedbackFormConfigCopyWith<$R2, FeedbackFormConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _FeedbackFormConfigCopyWithImpl($value, $cast, t);
}
