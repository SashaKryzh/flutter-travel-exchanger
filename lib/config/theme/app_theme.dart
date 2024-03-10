import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

@riverpod
Raw<AppTheme> appTheme(AppThemeRef _) => AppTheme();

class AppTheme extends ChangeNotifier {
  ThemeMode get themeMode => ThemeMode.system;

  ThemeData theme() {
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.juraTextTheme(baseTheme.textTheme),
    );
  }

  ThemeData darkTheme() => theme();
}
