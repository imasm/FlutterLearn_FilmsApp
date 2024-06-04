import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);
typedef MovieSelectedCallback = void Function(Movie movie);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  Timer? _debouceTimer;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();

  final SearchMoviesCallback searchMovies;
  SearchMovieDelegate(this.searchMovies);

  // cada cop que es canvia el text del search bar, es crida aquest mètode
  // però no volem fer una crida a la API per cada lletra que s'escriu
  // per això, es fa servir un timer per esperar 500ms abans de fer la crida
  // a la API
  void _onQueryChanged(String query) {
    // si el timer està actiu (la query ha canviat abans de 500ms), es cancela
    if (_debouceTimer?.isActive ?? false) {
      _debouceTimer?.cancel();
    }

    _debouceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty || query.length < 3) {
        debouncedMovies.add([]);
        return;
      }

      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
    });
  }

  // Tanquem el stream quan es tanca el delegate
  clearStreams() {
    debouncedMovies.close();
  }

  @override
  String get searchFieldLabel => 'Buscar pelicul·les';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(animate: query.isNotEmpty, child: IconButton(onPressed: () => {query = ''}, icon: const Icon(Icons.clear)))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: searchMovies(query),
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return _MovieItem(
                movie: movies[index], 
                onMovieSelected: (movie) {
                  clearStreams();
                  close(context, movie);
              });
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return StreamBuilder(
        initialData: const [],
        stream: debouncedMovies.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return _MovieItem(movie: movies[index], onMovieSelected: (movie) => close(context, movie));
            },
          );
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final MovieSelectedCallback onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * .7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  Text(movie.overview, style: textStyles.bodySmall, maxLines: 5, overflow: TextOverflow.ellipsis),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(HumanFormats.humanReadableNumber(movie.voteAverage, 1),
                          style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade900))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
