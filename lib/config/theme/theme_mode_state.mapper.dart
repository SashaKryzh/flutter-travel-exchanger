// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'theme_mode_state.dart';

class ThemeModeStateMapper extends ClassMapperBase<ThemeModeState> {
  ThemeModeStateMapper._();

  static ThemeModeStateMapper? _instance;
  static ThemeModeStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ThemeModeStateMapper._());
      MapperContainer.globals.useAll([ThemeModeMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ThemeModeState';

  static ThemeMode _$themeMode(ThemeModeState v) => v.themeMode;
  static const Field<ThemeModeState, ThemeMode> _f$themeMode =
      Field('themeMode', _$themeMode);

  @override
  final MappableFields<ThemeModeState> fields = const {
    #themeMode: _f$themeMode,
  };

  static ThemeModeState _instantiate(DecodingData data) {
    return ThemeModeState(data.dec(_f$themeMode));
  }

  @override
  final Function instantiate = _instantiate;

  static ThemeModeState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ThemeModeState>(map);
  }

  static ThemeModeState fromJson(String json) {
    return ensureInitialized().decodeJson<ThemeModeState>(json);
  }
}

mixin ThemeModeStateMappable {
  String toJson() {
    return ThemeModeStateMapper.ensureInitialized()
        .encodeJson<ThemeModeState>(this as ThemeModeState);
  }

  Map<String, dynamic> toMap() {
    return ThemeModeStateMapper.ensureInitialized()
        .encodeMap<ThemeModeState>(this as ThemeModeState);
  }

  ThemeModeStateCopyWith<ThemeModeState, ThemeModeState, ThemeModeState>
      get copyWith => _ThemeModeStateCopyWithImpl(
          this as ThemeModeState, $identity, $identity);
  @override
  String toString() {
    return ThemeModeStateMapper.ensureInitialized()
        .stringifyValue(this as ThemeModeState);
  }

  @override
  bool operator ==(Object other) {
    return ThemeModeStateMapper.ensureInitialized()
        .equalsValue(this as ThemeModeState, other);
  }

  @override
  int get hashCode {
    return ThemeModeStateMapper.ensureInitialized()
        .hashValue(this as ThemeModeState);
  }
}

extension ThemeModeStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ThemeModeState, $Out> {
  ThemeModeStateCopyWith<$R, ThemeModeState, $Out> get $asThemeModeState =>
      $base.as((v, t, t2) => _ThemeModeStateCopyWithImpl(v, t, t2));
}

abstract class ThemeModeStateCopyWith<$R, $In extends ThemeModeState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({ThemeMode? themeMode});
  ThemeModeStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ThemeModeStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ThemeModeState, $Out>
    implements ThemeModeStateCopyWith<$R, ThemeModeState, $Out> {
  _ThemeModeStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ThemeModeState> $mapper =
      ThemeModeStateMapper.ensureInitialized();
  @override
  $R call({ThemeMode? themeMode}) =>
      $apply(FieldCopyWithData({if (themeMode != null) #themeMode: themeMode}));
  @override
  ThemeModeState $make(CopyWithData data) =>
      ThemeModeState(data.get(#themeMode, or: $value.themeMode));

  @override
  ThemeModeStateCopyWith<$R2, ThemeModeState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ThemeModeStateCopyWithImpl($value, $cast, t);
}
