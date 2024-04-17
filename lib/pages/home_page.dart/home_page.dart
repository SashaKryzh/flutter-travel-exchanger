import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/domain/app_events.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/onboarding.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table_providers.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_app_bar.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_bottom_bar.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> checkOnboarding() async {
      final isOnboardingComplete =
          await ref.read(onboardingNotifierProvider.notifier).isOnboardingComplete();
      if (!isOnboardingComplete) {
        Future.delayed(const Duration(seconds: 1), () {
          ref.read(onboardingNotifierProvider.notifier).start();
        });
      }
    }

    useEffect(() {
      checkOnboarding();
      return null;
    }, []);

    final fToast = useMemoized(() {
      final fToast = FToast();
      fToast.init(context);
      return fToast;
    });

    ref.listen(appEventProvider, (previous, next) {
      final event = next.unwrapPrevious().valueOrNull;
      if (event is TriedToSetFromToTimeCurrencyEvent) {
        fToast.showToast(
          positionedToastBuilder: (context, child) => Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SafeArea(
                child: child,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: context.colorScheme.tertiaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(9999)),
            ),
            child: const Text("Time can't be the first currency")
                .textStyle(TextStyle(color: context.colorScheme.onTertiaryContainer)),
          ),
        );
      }
    });

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
