import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate(this.searchMovies);
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
    return IconButton(onPressed: () => close(context, null), icon: const Icon(Icons.arrow_back));
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
              final movie = movies[index];
              return _MovieItem(movie: movie);
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('build Suggestions...');
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
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
          SizedBox(width: size.width *.7,
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
                Text(movie.title, style: textStyles.titleMedium),
                Text(movie.overview, style: textStyles.bodySmall, maxLines: 5, overflow: TextOverflow.ellipsis),

            ],),)
          

        ],
      ),
    );
  }
}
