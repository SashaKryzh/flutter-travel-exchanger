import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_exchanger/app.dart';
import 'package:travel_exchanger/config/env.dart';
import 'package:travel_exchanger/config/i18n/strings.g.dart';
import 'package:travel_exchanger/data/exchange_between_repository.dart';
import 'package:travel_exchanger/data/rates_repository.dart';
import 'package:travel_exchanger/data/recently_used_currency_repository.dart';
import 'package:travel_exchanger/data/shared_preferences.dart';
import 'package:travel_exchanger/data/time_rate_repository.dart';
import 'package:travel_exchanger/firebase_options.dart';
import 'package:travel_exchanger/utils/general_provider_observer.dart';
import 'package:travel_exchanger/utils/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  await setSystemOverlayStyle();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await Env.init();
  initLoggerListeners();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  final ratesRepository = RatesRepository(Supabase.instance.client, sharedPreferences);
  await ratesRepository.init();
  unawaited(ratesRepository.updateRatesIfExpired());

  final timeRateRepository = TimeRateRepository(sharedPreferences);
  await timeRateRepository.init();

  final exchangeBetweenRepository = ExchangeBetweenRepository(sharedPreferences);
  await exchangeBetweenRepository.init();

  final recentlyUsedCurrencyRepository = RecentlyUsedCurrencyRepository(sharedPreferences);
  await recentlyUsedCurrencyRepository.init();

  runApp(
    ProviderScope(
      observers: const [
        GeneralProviderObserver(),
      ],
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ratesRepositoryProvider.overrideWithValue(ratesRepository),
        timeRateRepositoryProvider.overrideWithValue(timeRateRepository),
        exchangeBetweenRepositoryProvider.overrideWithValue(exchangeBetweenRepository),
        recentlyUsedCurrencyRepositoryProvider.overrideWithValue(recentlyUsedCurrencyRepository),
      ],
      child: TranslationProvider(
        child: const App(),
      ),
    ),
  );
}

Future<void> setSystemOverlayStyle() async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
}
