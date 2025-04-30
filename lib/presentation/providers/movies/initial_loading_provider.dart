import 'package:my_movies/presentation/providers/movies/movies_providers.dart';
import 'package:my_movies/presentation/providers/movies/movies_slide_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  final upcomingMovies = ref.watch(upcomingMoviesProvider);
  final topRatedMovies = ref.watch(topRatedMoviesProvider);
  final slideMovies = ref.watch(moviesSlideshowProvider);

  return nowPlayingMovies.isEmpty ||
      topRatedMovies.isEmpty ||
      upcomingMovies.isEmpty ||
      slideMovies.isEmpty;
});
