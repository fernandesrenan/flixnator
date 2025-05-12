import 'package:flixnator/models/movie.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({required this.movie, super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final path = 'https://image.tmdb.org/t/p/original${movie.imagePath}';

    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        path,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey,
        ),
        fit: BoxFit.cover,
        height: 180,
        width: 120,
      ),
    );
  }
}
