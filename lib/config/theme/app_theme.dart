import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

@riverpod
Raw<AppTheme> appTheme(AppThemeRef ref) => AppTheme();

class AppTheme extends ChangeNotifier {
  ThemeMode get themeMode => ThemeMode.system;

  ThemeData theme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }

  ThemeData darkTheme() => theme();
}
