import 'package:flixnator/components/loading_movie_list.dart';
import 'package:flixnator/components/movie_card.dart';
import 'package:flixnator/components/movie_list_error.dart';
import 'package:flixnator/models/movie.dart';
import 'package:flixnator/repositories/movie_repository.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late final MovieRepository movieRepository;

  @override
  void initState() {
    super.initState();
    movieRepository = MovieRepository();
  }

  Future<List<Movie>> getMovies() async {
    final localMovies = await movieRepository.getMoviesDb();

    if (localMovies.isNotEmpty) {
      return localMovies;
    }

    return movieRepository.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/movie_banner.png',
          fit: BoxFit.cover,
          height: 450,
          width: double.infinity,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Popular Movie',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder(
          future: getMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingMovieList();
            }
            if (snapshot.hasError) {
              return MovieListError(onRetry: () {});
            }

            final movies = snapshot.data ?? [];

            return SizedBox(
              height: 180,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 10),
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) => MovieCard(
                  movie: movies[index],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
