import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  static const route = '/favorites';

  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
