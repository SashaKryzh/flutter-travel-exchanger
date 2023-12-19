import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_page.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) => _router;

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
