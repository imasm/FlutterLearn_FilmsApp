import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayngMovies = ref.watch(nowPlayingMoviesProvider);
  if (nowPlayngMovies.isEmpty) {
    return [];
  }
  return nowPlayngMovies.getRange(0, 6).toList();
});
