import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailsProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final moviesRepository = ref.watch(moviesRepositoryProvider);
  return MovieMapNotifier(getMovieDetails: moviesRepository.getMovieDetails);
});

typedef GetMovieDetailsCallback = Future<Movie> Function(String id);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieDetailsCallback getMovieDetails;

  MovieMapNotifier({required this.getMovieDetails}) : super({});

  bool isLoading = false;

  Future<void> loadMovie(String movieId) async {
    if (isLoading) return;

    if (state[movieId] != null) return;
    isLoading = true;

    final details = await getMovieDetails(movieId);   
    state = {...state, movieId: details};

    isLoading = false;
    return;
  }
}

class MovieDetailsNotifier extends StateNotifier<Movie?> {
  final MoviesRepository repository;
  MovieDetailsNotifier(this.repository) : super(null);

  bool isLoading = false;

  Future<void> loadMovie(String movieId) async {
    if (isLoading) return;
    isLoading = true;

    final details = await repository.getMovieDetails(movieId);
    state = details;
    isLoading = false;
  }
}
