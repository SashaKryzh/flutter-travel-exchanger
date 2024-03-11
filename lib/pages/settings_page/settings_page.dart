import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/theme/app_theme.dart';
import 'package:travel_exchanger/data/shared_preferences.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/shortcut_widgets.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          ThemeModeIconButton(),
        ],
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () => ref.read(sharedPreferencesProvider).clear(),
            child: const Text('Clear All Data'),
          ),
        ],
      ),
    );
  }
}

class ThemeModeIconButton extends HookConsumerWidget {
  const ThemeModeIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final isDark = context.theme.brightness == Brightness.dark;

    final order = useMemoized(
      () => switch (themeMode) {
        ThemeMode.system => isDark ? [ThemeMode.light] : [ThemeMode.dark],
        ThemeMode.light => [ThemeMode.dark, ThemeMode.system],
        ThemeMode.dark => [ThemeMode.light, ThemeMode.system],
      },
      [themeMode == ThemeMode.system],
    );

    final nextIndex = useRef(0);
    final nextMode = order[nextIndex.value % order.length];

    void onTap() {
      nextIndex.value = nextMode == ThemeMode.system
          ? 0
          : themeMode == ThemeMode.system
              ? 0
              : nextIndex.value + 1;
      ref.read(themeModeNotifierProvider.notifier).themeMode = nextMode;
    }

    return TextButton(
      onPressed: onTap,
      child: HStack(
        children: [
          Text(
            switch (themeMode) {
              ThemeMode.system => 'System',
              ThemeMode.light => 'Light',
              ThemeMode.dark => 'Dark',
            },
          ),
          const SizedSpacer(8),
          Icon(
            switch (themeMode) {
              ThemeMode.system => Icons.brightness_auto,
              ThemeMode.light => Icons.brightness_high,
              ThemeMode.dark => Icons.brightness_3,
            },
          ),
        ],
      ),
    );
  }
}
