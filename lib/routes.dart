import 'package:flixnator/pages/home_page.dart';
import 'package:flixnator/pages/initial_page.dart';
import 'package:flixnator/pages/landing_page.dart';
import 'package:flixnator/pages/search_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LandingPage(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        final index = state.extra as int?;

        return HomePage(index: index ?? 0, child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, _) => const InitialPage(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const InitialPage(),
        ),
        GoRoute(
          path: '/config',
          builder: (context, state) => const InitialPage(),
        ),
      ],
    ),
  ],
);
