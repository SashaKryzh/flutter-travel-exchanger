import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/pages/custom_amount_page/custom_amount_page.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_page.dart';
import 'package:travel_exchanger/pages/select_currency_page/select_currency_page.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) => _router;

final _router = GoRouter(routes: $appRoutes);

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<SelectCurrencyRoute>(path: 'select-currency/:currencyCode'),
    TypedGoRoute<CustomAmountRoute>(path: 'custom-amount/:currencyCode'),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class SelectCurrencyRoute extends GoRouteData {
  const SelectCurrencyRoute({
    required this.currencyCode,
  });

  final String currencyCode;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SelectCurrencyPage(currencyCode: currencyCode);
  }
}

class CustomAmountRoute extends GoRouteData {
  const CustomAmountRoute({
    required this.currencyCode,
  });

  final String currencyCode;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 100),
      reverseTransitionDuration: const Duration(milliseconds: 100),
      opaque: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: CustomAmountPage(
        code: currencyCode,
      ),
    );
  }
}
