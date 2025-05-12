import 'package:flixnator/pages/favorites_page.dart';
import 'package:flixnator/pages/search_page.dart';
import 'package:flixnator/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  static const route = '/home';

  const HomePage({required this.child, required this.index, super.key});

  final Widget child;
  final int index;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tabs = [
    HomePage.route,
    SearchPage.route,
    FavoritesPage.route,
    SettingsPage.route,
  ];

  void changePage(int index) {
    final route = tabs[index];

    context.go(route, extra: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.index,
        onTap: changePage,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        fixedColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
