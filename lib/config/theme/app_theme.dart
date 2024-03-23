import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/config/theme/exchange_table_theme.dart';
import 'package:travel_exchanger/config/theme/theme_mode_state.dart';
import 'package:travel_exchanger/data/shared_preferences.dart';
import 'package:travel_exchanger/data/shared_storage_keys.dart';
import 'package:travel_exchanger/utils/extensions.dart';

part 'app_theme.g.dart';

class AppTheme {
  ThemeData theme({required Color seedColor, bool isDark = false}) {
    final colorScheme = ColorScheme.fromSeed(
      brightness: isDark ? Brightness.dark : Brightness.light,
      seedColor: seedColor,
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
  ThemeModeState build() {
    return _load() ?? const ThemeModeState(ThemeMode.system);
  }

  set themeMode(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
    _store();
  }

  ThemeModeState? _load() {
    try {
      return ThemeModeStateMapper.fromJson(
        ref.read(sharedPreferencesProvider).getString(SharedStorageKeys.themeMode.key) ?? '',
      );
    } catch (e) {
      return null;
    }
  }

  void _store() {
    ref.read(sharedPreferencesProvider).setString(SharedStorageKeys.themeMode.key, state.toJson());
  }
}

@riverpod
class SeedColorNotifier extends _$SeedColorNotifier {
  @override
  Color build() {
    return _readStoredState() ?? seedColors.first;
  }

  void setSeedColor(Color color) {
    state = color;
    _storeState();
  }

  void _storeState() {
    ref.read(sharedPreferencesProvider).setInt('seedColorKey', state.value);
  }

  Color? _readStoredState() {
    final value = ref.read(sharedPreferencesProvider).getInt('seedColorKey');
    if (value == null) {
      return null;
    }

    final color = Color(value);

    if (!seedColors.contains(color)) {
      ref.read(sharedPreferencesProvider).remove('seedColorKey');
      return null;
    } else {
      return color;
    }
  }
}

final seedColors = [
  Colors.red.value,
  Colors.orange.value,
  Colors.green.value,
  Colors.blue.value,
  Colors.purple.value,
].map(Color.new);
