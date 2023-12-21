import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/infrastructure/datasources/moviesdb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesRepositoryProvider = Provider<MoviesRepository>((ref) {
  return MoviesRepositoryImpl(moviesDataSource: TheMovieDbDatasource());
});