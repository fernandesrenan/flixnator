import 'dart:async';

import 'package:flixnator/models/movie.dart';
import 'package:flixnator/repositories/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  static const route = '/search';

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final MovieRepository movieRepository;
  List<Movie> movies = [];
  bool isLoading = false;
  final textEC = TextEditingController();
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    movieRepository = MovieRepository();
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  Future<void> searchMovie(String search) async {
    setState(() {
      isLoading = true;
    });

    final searchResult = await movieRepository.searchMovie(search);

    setState(() {
      movies = searchResult;
      isLoading = false;
    });
  }

  void handleChange() {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      searchMovie(textEC.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              onChanged: handleChange,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xff2B2930),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: TextFormField(
                  controller: textEC,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.menu),
                    prefixIconColor: Theme.of(context).colorScheme.primary,
                    suffixIcon: Icon(Icons.search),
                    suffixIconColor: Theme.of(context).colorScheme.primary,
                    hintText: 'Search for a title...',
                    hintStyle: GoogleFonts.getFont('Roboto').copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.separated(
                      itemCount: movies.length,
                      separatorBuilder: (_, __) => SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        return _SearchResultItem(movie: movies[index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  const _SearchResultItem({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final path = 'https://image.tmdb.org/t/p/original${movie.imagePath}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          path,
          height: 90,
          width: 60,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => SizedBox(
            height: 90,
            width: 60,
            child: Icon(
              Icons.image,
              color: Color(0xff969696),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                movie.releaseDate?.year.toString() ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff969696),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
