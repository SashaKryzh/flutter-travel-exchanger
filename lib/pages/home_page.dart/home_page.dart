import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/domain/onboarding.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table_providers.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_app_bar.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_bottom_bar.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> checkOnboarding() async {
      final isOnboardingComplete =
          await ref.read(onboardingNotifierProvider.notifier).isOnboardingComplete();
      if (!isOnboardingComplete) {
        ref.read(onboardingNotifierProvider.notifier).start();
      }
    }

    useEffect(() {
      checkOnboarding();
      return null;
    }, []);

    Future<bool> onBackButtonPressed() async {
      if (ref.read(exchangeTableExpandedRowsProvider).rows.isNotEmpty) {
        ref.read(exchangeTableExpandedRowsProvider.notifier).collapse();
        return true;
      }

      return false;
    }

    return BackButtonListener(
      onBackButtonPressed: onBackButtonPressed,
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            HomeAppBar(),
            Expanded(
              child: ExchangeTable(),
            ),
            HomeBottomBar(),
          ],
        ),
      ),
    );
  }
}
