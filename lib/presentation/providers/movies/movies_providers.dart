import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final moviesRepository = ref.watch(moviesRepositoryProvider);
  return MoviesNotifier(moviesCallback: moviesRepository.getNowPlaying);
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final moviesRepository = ref.watch(moviesRepositoryProvider);
  return MoviesNotifier(moviesCallback: moviesRepository.getPopular);
});

typedef GetMoviesCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  GetMoviesCallback moviesCallback;
  MoviesNotifier({required this.moviesCallback}) : super([]);

  int currentPage = 0;
  bool isLoading = false;

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final movies = await moviesCallback(page: currentPage);
    addMovies(movies);
    isLoading = false;
  }

  void addMovies(List<Movie> movies) {
    state = [...state, ...movies];
  }
}
