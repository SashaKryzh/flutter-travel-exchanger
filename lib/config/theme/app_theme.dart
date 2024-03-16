import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/config/theme/exchange_table_theme.dart';
import 'package:travel_exchanger/utils/extensions.dart';

part 'app_theme.g.dart';

class AppTheme {
  ThemeData theme() => _theme(false);

  ThemeData darkTheme() => _theme(true);

  ThemeData _theme(bool isDark) {
    final colorScheme = ColorScheme.fromSeed(
      brightness: isDark ? Brightness.dark : Brightness.light,
      seedColor: Colors.red,
    );

    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
      ),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.juraTextTheme(baseTheme.textTheme),
      appBarTheme: baseTheme.appBarTheme.copyWith(
        systemOverlayStyle:
            (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark).copyWith(
          systemNavigationBarColor: Colors.transparent,
          statusBarColor: Colors.transparent,
        ),
      ),
      extensions: [
        ExchangeTableTheme(
          borderColor: Colors.black,
          fromColor: colorScheme.secondaryContainer,
          toColor: colorScheme.background,
        ),
      ],
    );
  }
}

extension ThemeDataX on ThemeData {
  Color get customRateColor => Colors.orange[300]!;
}

extension ThemeContextX on BuildContext {
  ExchangeTableTheme get tableTheme => theme.extension<ExchangeTableTheme>()!;
}

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  set themeMode(ThemeMode themeMode) {
    state = themeMode;
  }
}
