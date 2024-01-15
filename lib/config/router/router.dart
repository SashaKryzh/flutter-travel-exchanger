import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/pages/custom_amount_page/custom_amount_page.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_page.dart';
import 'package:travel_exchanger/pages/select_currency_page/select_currency_page.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) => _router;

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'select',
          redirect: (context, state) =>
              state.uri.queryParameters['currencyCode'] == null ? '/' : null,
          builder: (context, state) {
            final currencyCode = state.uri.queryParameters['currencyCode']!;

            return SelectCurrencyPage(currencyCode: currencyCode);
          },
        ),
        GoRoute(
          path: ':currency',
          redirect: (context, state) => state.pathParameters['currency'] == null ? '/' : null,
          pageBuilder: (context, state) {
            final currency = state.pathParameters['currency']!;

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
                code: currency,
              ),
            );
          },
        ),
      ],
    ),
  ],
);
