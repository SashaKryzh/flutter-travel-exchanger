import 'package:flutter/material.dart';
import 'package:flutter_quick_starter/config/theme/app_theme.dart';
import 'package:flutter_quick_starter/home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Quick Starter',
      themeMode: appTheme.themeMode,
      theme: appTheme.theme(),
      darkTheme: appTheme.darkTheme(),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
