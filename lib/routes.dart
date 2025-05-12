import 'package:flixnator/pages/favorites_page.dart';
import 'package:flixnator/pages/home_page.dart';
import 'package:flixnator/pages/initial_page.dart';
import 'package:flixnator/pages/landing_page.dart';
import 'package:flixnator/pages/search_page.dart';
import 'package:flixnator/pages/settings_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: LandingPage.route,
  routes: [
    GoRoute(
      path: LandingPage.route,
      builder: (context, state) => const LandingPage(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        final index = state.extra as int?;

        return HomePage(index: index ?? 0, child: child);
      },
      routes: [
        GoRoute(
          path: HomePage.route,
          builder: (context, _) => const InitialPage(),
        ),
        GoRoute(
          path: SearchPage.route,
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: FavoritesPage.route,
          builder: (context, state) => const FavoritesPage(),
        ),
        GoRoute(
          path: SettingsPage.route,
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
