import 'package:flutter/material.dart';
import 'package:flutter_quick_starter/app.dart';
import 'package:flutter_quick_starter/config/env.dart';
import 'package:flutter_quick_starter/utils/provider_observer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.init();

  runApp(
    const ProviderScope(
      observers: [
        MyProviderObserver(),
      ],
      child: App(),
    ),
  );
}
