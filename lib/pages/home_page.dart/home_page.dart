import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/domain/app_events.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/onboarding.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_app_bar.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_bottom_bar.dart';
import 'package:travel_exchanger/widgets/back_button_handler.dart';
import 'package:travel_exchanger/widgets/toast.dart';

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
          positionedToastBuilder: topCenterToastBuilder,
          child: const ToastContainer(
            child: Text("Time can't be the first currency"),
          ),
        );
      }
    });

    return const BackButtonHandler(
      child: Scaffold(
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
