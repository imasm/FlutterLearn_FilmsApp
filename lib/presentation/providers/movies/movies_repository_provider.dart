import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/infrastructure/the_movie_db/themoviedb_datasources.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  return MoviesRepositoryImpl(moviesDataSource: TheMovieDbMoviesDatasource());
});