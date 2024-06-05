import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");

final searchMoviesProvider = StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
  final moviesRepository = ref.watch(moviesRepositoryProvider);
  return SearchMoviesNotifier(searchMovies: moviesRepository.searchMovies, ref: ref);
} );

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {

  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchMoviesNotifier({required this.searchMovies, required this.ref}) : super([]);

  Future<List<Movie>> searchMovieByQuery(String query) async {
    ref.read(searchQueryProvider.notifier).update((state) => query);
    final movies = await searchMovies(query);
    state = movies;
    return movies;
  }
 
}