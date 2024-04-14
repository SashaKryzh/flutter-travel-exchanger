import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/i18n/strings.g.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/config/theme/app_theme.dart';
import 'package:travel_exchanger/domain/onboarding.dart';
import 'package:travel_exchanger/utils/analytics/analytics_provider.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    ref.read(analyticsProvider).logAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeNotifierProvider).themeMode;
    final router = ref.watch(routerProvider);

    // TODO: Remove
    ref.watch(onboardingNotifierProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TIM Converter',
      themeMode: themeMode,
      theme: AppTheme().theme(seedColor: ref.watch(seedColorNotifierProvider)),
      darkTheme: AppTheme().theme(seedColor: ref.watch(seedColorNotifierProvider), isDark: true),
      routerConfig: router,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      builder: FToastBuilder(),
    );
  }
}
