class Movie {
  Movie({required this.id, this.title, this.imagePath});

  final int id;
  final String? title;
  final String? imagePath;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      imagePath: json['poster_path'],
    );
  }
}
