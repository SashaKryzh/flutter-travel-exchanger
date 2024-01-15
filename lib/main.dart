import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_exchanger/app.dart';
import 'package:travel_exchanger/config/env.dart';
import 'package:travel_exchanger/data/rates_repository.dart';
import 'package:travel_exchanger/data/shared_preferences.dart';
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
  await ratesRepository.initRates();
  unawaited(ratesRepository.updateRatesIfExpired());

  runApp(
    ProviderScope(
      observers: const [
        MyProviderObserver(),
      ],
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ratesRepositoryProvider.overrideWithValue(ratesRepository),
      ],
      child: const App(),
    ),
  );
}
