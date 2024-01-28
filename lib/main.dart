import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_exchanger/app.dart';
import 'package:travel_exchanger/config/env.dart';
import 'package:travel_exchanger/data/exchange_between_repository.dart';
import 'package:travel_exchanger/data/rates_repository.dart';
import 'package:travel_exchanger/data/shared_preferences.dart';
import 'package:travel_exchanger/data/time_rate_repository.dart';
import 'package:travel_exchanger/utils/provider_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();

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

  runApp(
    ProviderScope(
      observers: const [
        MyProviderObserver(),
      ],
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ratesRepositoryProvider.overrideWithValue(ratesRepository),
        timeRateRepositoryProvider.overrideWithValue(timeRateRepository),
        exchangeBetweenRepositoryProvider.overrideWithValue(exchangeBetweenRepository),
      ],
      child: const App(),
    ),
  );
}
