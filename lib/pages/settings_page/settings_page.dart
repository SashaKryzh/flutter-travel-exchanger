import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:travel_exchanger/config/theme/app_icons.dart';
import 'package:travel_exchanger/config/theme/app_theme.dart';
import 'package:travel_exchanger/data/shared_preferences.dart';
import 'package:travel_exchanger/domain/onboarding.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/utils/analytics/analytics.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/utils/remote_config/remote_config.dart';
import 'package:travel_exchanger/widgets/shortcut_widgets.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
          const Gap(24),
          const _Menu(),
          const Gap(32),
          const Divider().padding(x: 16),
          const Gap(48),
          const _ThankYouSection(),
          const Gap(24),
          const _FeedbackSection(),
          const Gap(40),
          const Divider().padding(x: 16),
          const Gap(48),
          const RatesDataTimestampsWidget().padding(x: 16),
          if (kDebugMode) ...[
            const Gap(48),
            const Divider().padding(x: 16),
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

class _Menu extends ConsumerWidget {
  const _Menu();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showOnboarding() {
      final onboardingNotifier = ref.read(onboardingNotifierProvider.notifier);
      context.pop();
      Future.delayed(const Duration(milliseconds: 200), () {
        onboardingNotifier.start();
      });
    }

    return VStack(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: showOnboarding,
          child: const Text('Show Onboarding'),
        ),
      ],
    ).padding(x: 4);
  }
}

class RatesDataTimestampsWidget extends ConsumerWidget {
  const RatesDataTimestampsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timestampsAsync = ref.watch(ratesDataTimestampsProvider);
    final timestamps = timestampsAsync.valueOrNull;

    void clear() {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return HookBuilder(
            builder: (context) {
              final cleared = useState(false);

              void clear() async {
                await ref.read(sharedPreferencesProvider).clear();
                cleared.value = true;
              }

              final Widget content;
              if (!cleared.value) {
                content = VStack(children: [
                  const Gap(8),
                  const Text('Clear All Data').textStyle(context.textTheme.titleLarge),
                  const Gap(8),
                  const Text(
                    'If you clear all data, you will lose custom rates and you will need to restart the app.',
                  ).textStyle(context.textTheme.titleSmall, align: TextAlign.center),
                  const Gap(8),
                  HStack(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: clear,
                          child: const Text('Clear'),
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: context.pop,
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ]);
              } else {
                content = VStack(children: [
                  const Gap(8),
                  const Text('Data is Cleared').textStyle(context.textTheme.titleLarge),
                  const Gap(8),
                  const Text('Please restart the app').textStyle(context.textTheme.titleLarge),
                ]);
              }

              return PopScope(
                canPop: !cleared.value,
                child: Center(
                  widthFactor: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: VStack(
                        children: [
                          const Icon(
                            AppIcons.warning,
                            size: 32,
                          ),
                          content,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }

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
          const Gap(48),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: clear,
              child: const Text('Clear All Data'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThankYouSection extends HookWidget {
  const _ThankYouSection();

  void openXProfile() {
    analyticsVar.logOpenXProfile();
    final xProfile = remoteConfig.getXProfileConfig();
    canLaunchUrlString(xProfile.url).then((canLaunch) {
      if (canLaunch) {
        launchUrlString(
          xProfile.url,
          mode: LaunchMode.externalApplication,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final xProfile = remoteConfig.getXProfileConfig();

    final recognizer = useRef<TapGestureRecognizer?>(null);
    useEffect(() {
      recognizer.value = TapGestureRecognizer()..onTap = openXProfile;
      return recognizer.value?.dispose;
    }, []);

    return VStack(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thank you for using TIM Converter!',
          style: context.textTheme.titleLarge,
        ),
        Text.rich(
          TextSpan(
            text: 'Made by ',
            children: [
              TextSpan(
                text: xProfile.username,
                style: TextStyle(
                  color: context.colorScheme.primary,
                ),
                recognizer: recognizer.value,
              ),
            ],
          ),
          style: context.textTheme.bodyLarge,
        ),
      ],
    ).padding(x: 16);
  }
}

class _FeedbackSection extends StatelessWidget {
  const _FeedbackSection();

  void openFeedbackForm() {
    analyticsVar.logOpenFeedbackForm();
    final feedbackForm = remoteConfig.getFeedbackFormConfig();
    canLaunchUrlString(feedbackForm.url).then((canLaunch) {
      if (canLaunch) {
        launchUrlString(
          feedbackForm.url,
          mode: LaunchMode.externalApplication,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return VStack(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: openFeedbackForm,
          child: const Text('Report a bug or write feedback'),
        ),
      ],
    ).padding(x: 4);
  }
}
