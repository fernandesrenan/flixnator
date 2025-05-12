import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flixnator/app_config.dart';
import 'package:flixnator/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieRepository {
  final client = Dio(
    BaseOptions(
      baseUrl: AppConfig.instance.baseUrl,
      headers: {'Authorization': 'Bearer ${AppConfig.instance.token}'},
      queryParameters: {'language': 'pt-BR'},
    ),
  );

  SharedPreferencesAsync? _preferences;
  final moviesKey = 'movies';

  SharedPreferencesAsync get db {
    return _preferences ?? SharedPreferencesAsync();
  }

  Future<List<Movie>> getMovies() async {
    final response = await client.get(
      '/discover/movie',
      queryParameters: {'page': 1},
    );

    final movies = (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    await db.setStringList(
      moviesKey,
      movies.map((movie) => movie.toJson).toList(),
    );

    return movies;
  }

  Future<List<Movie>> getMoviesDb() async {
    final moviesStringList = await db.getStringList(moviesKey) ?? [];

    final movies = moviesStringList
        .map((json) => Movie.fromJson(jsonDecode(json)))
        .toList();

    return movies;
  }

  Future<List<Movie>> searchMovie(String search) async {
    final response = await client.get(
      '/search/movie',
      queryParameters: {'page': 1, 'query': search},
    );

    final movies = (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();

    return movies;
  }
}
