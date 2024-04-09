import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:travel_exchanger/config/theme/app_icons.dart';
import 'package:travel_exchanger/config/theme/app_theme.dart';
import 'package:travel_exchanger/data/shared_preferences.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/shortcut_widgets.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

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
          const Gap(12),
          const AppearanceSection(),
          const Gap(48),
          const Divider().padding(x: 16),
          const Gap(48),
          const RatesDataTimestampsWidget().padding(x: 16),
          const Gap(48),
          OutlinedButton(
            // TODO: Improve clear method.
            onPressed: () => ref.read(sharedPreferencesProvider).clear(),
            child: const Text('Clear All Data'),
          ).padding(x: 16),
          if (kDebugMode) ...[
            const Gap(24),
            TextButton(
              onPressed: () => throw Exception(),
              child: const Text('Throw Test Exception'),
            ),
          ],
        ],
      ),
    );
  }
}

class ThemeModeIconButton extends HookConsumerWidget {
  const ThemeModeIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider).themeMode;
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
              ThemeMode.system => 'Automatic',
              ThemeMode.light => 'Light',
              ThemeMode.dark => 'Dark',
            },
          ),
          const SizedSpacer(8),
          Icon(
            switch (themeMode) {
              ThemeMode.system => AppIcons.systemMode,
              ThemeMode.light => AppIcons.lightMode,
              ThemeMode.dark => AppIcons.darkMode,
            },
          ),
        ],
      ),
    );
  }
}

class AppearanceSection extends ConsumerWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedColor = ref.watch(seedColorNotifierProvider);

    void changeColor(Color color) {
      ref.read(seedColorNotifierProvider.notifier).setSeedColor(color);
    }

    Widget buildColorPicker(Color color) {
      final isSelected = seedColor == color;

      return GestureDetector(
        onTap: () => changeColor(color),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? context.colorScheme.onBackground : Colors.transparent,
              width: 2,
            ),
          ),
        ),
      );
    }

    return VStack(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Appearance',
          style: context.textTheme.titleLarge,
        ),
        const Gap(16),
        Wrap(
          spacing: 12,
          children: seedColors.map(buildColorPicker).toList(),
        ),
      ],
    ).padding(x: 16);
  }
}

class RatesDataTimestampsWidget extends ConsumerWidget {
  const RatesDataTimestampsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timestampsAsync = ref.watch(ratesDataTimestampsProvider);
    final timestamps = timestampsAsync.valueOrNull;

    String format(DateTime? dateTime) {
      final formatter = DateFormat.Hm().add_MMMEd();
      return dateTime == null ? '' : formatter.format(dateTime);
    }

    return AnimatedOpacity(
      opacity: timestamps == null ? 0 : 1,
      duration: const Duration(milliseconds: 100),
      child: VStack(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rates updated at ${format(timestamps?.updatedAt)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Gap(8),
          Text('Last fetched at ${format(timestamps?.lastFetchedAt)}'),
        ],
      ),
    );
  }
}
