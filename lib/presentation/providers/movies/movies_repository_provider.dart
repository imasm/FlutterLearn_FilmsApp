import 'package:my_movies/domain/repositories/movies_repository.dart';
import 'package:my_movies/infrastructure/the_movie_db/themoviedb_datasources.dart';
import 'package:my_movies/infrastructure/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  return MoviesRepositoryImpl(moviesDataSource: TheMovieDbMoviesDatasource());
});
