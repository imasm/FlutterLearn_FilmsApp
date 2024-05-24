import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slide_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {

  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  final popularMovies = ref.watch(popularMoviesProvider);
  final upcomingMovies = ref.watch(upcomingMoviesProvider);
  final topRatedMovies = ref.watch(topRatedMoviesProvider);
  final slideMovies = ref.watch(moviesSlideshowProvider);

  return nowPlayingMovies.isEmpty ||
      popularMovies.isEmpty ||
      upcomingMovies.isEmpty ||
      topRatedMovies.isEmpty ||
      slideMovies.isEmpty;
});
