import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'theme_mode_state.mapper.dart';

@MappableClass(includeCustomMappers: [ThemeModeMapper()])
class ThemeModeState with ThemeModeStateMappable {
  const ThemeModeState(this.themeMode);

  final ThemeMode themeMode;
}

class ThemeModeMapper extends SimpleMapper<ThemeMode> {
  const ThemeModeMapper();

  @override
  ThemeMode decode(dynamic value) {
    return ThemeMode.values.firstWhere((e) => e.name == value);
  }

  @override
  dynamic encode(ThemeMode self) {
    return self.name;
  }
}
