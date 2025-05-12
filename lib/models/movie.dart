import 'dart:convert';

class Movie {
  Movie({required this.id, this.title, this.imagePath, this.releaseDate});

  final int id;
  final String? title;
  final String? imagePath;
  final DateTime? releaseDate;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      imagePath: json['poster_path'],
      releaseDate: DateTime.tryParse(json['release_date']),
    );
  }

  String get toJson => jsonEncode({
        'id': id,
        'title': title,
        'poster_path': imagePath,
        'release_date': releaseDate?.toIso8601String(),
      });
}
