// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
      $searchCurrencyRoute,
      $debugRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'settings',
          factory: $SettingsRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'select-currency/:currencyCode',
          factory: $SelectCurrencyRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'custom-amount/:currencyCode',
          factory: $CustomAmountRouteExtension._fromState,
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SelectCurrencyRouteExtension on SelectCurrencyRoute {
  static SelectCurrencyRoute _fromState(GoRouterState state) =>
      SelectCurrencyRoute(
        currencyCode: state.pathParameters['currencyCode']!,
      );

  String get location => GoRouteData.$location(
        '/select-currency/${Uri.encodeComponent(currencyCode)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CustomAmountRouteExtension on CustomAmountRoute {
  static CustomAmountRoute _fromState(GoRouterState state) => CustomAmountRoute(
        currencyCode: state.pathParameters['currencyCode']!,
      );

  String get location => GoRouteData.$location(
        '/custom-amount/${Uri.encodeComponent(currencyCode)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $searchCurrencyRoute => GoRouteData.$route(
      path: '/search-currency',
      factory: $SearchCurrencyRouteExtension._fromState,
    );

extension $SearchCurrencyRouteExtension on SearchCurrencyRoute {
  static SearchCurrencyRoute _fromState(GoRouterState state) =>
      SearchCurrencyRoute(
        state.extra as SearchCurrencyRouteExtra,
      );

  String get location => GoRouteData.$location(
        '/search-currency',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $debugRoute => GoRouteData.$route(
      path: '/debug',
      factory: $DebugRouteExtension._fromState,
    );

extension $DebugRouteExtension on DebugRoute {
  static DebugRoute _fromState(GoRouterState state) => const DebugRoute();

  String get location => GoRouteData.$location(
        '/debug',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerHash() => r'accb1de1724a292ac279804227f828c81feb1daa';

/// See also [router].
@ProviderFor(router)
final routerProvider = AutoDisposeProvider<GoRouter>.internal(
  router,
  name: r'routerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RouterRef = AutoDisposeProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
