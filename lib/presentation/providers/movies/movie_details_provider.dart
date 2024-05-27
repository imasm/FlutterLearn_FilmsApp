import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailsProvider = StateNotifierProvider<MovieDetailsNotifier, Movie?>((ref) {
  final moviesRepository = ref.watch(moviesRepositoryProvider);
  return MovieDetailsNotifier(moviesRepository);
});


class MovieDetailsNotifier extends StateNotifier<Movie?> {
  final MoviesRepository repository;
  MovieDetailsNotifier(this.repository) : super(null);

  bool isLoading = false;

  Future<void> loadDetails(String movieId) async {
    if (isLoading) return;
    isLoading = true;
    
    final details = await repository.getMovieDetails(movieId);
    state = details;
    isLoading = false;
  }
}