import 'package:my_movies/domain/entities/movie.dart';
import 'package:my_movies/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayngMovies = ref.watch(nowPlayingMoviesProvider);
  if (nowPlayngMovies.isEmpty) {
    return [];
  }
  return nowPlayngMovies.getRange(0, 6).toList();
});
