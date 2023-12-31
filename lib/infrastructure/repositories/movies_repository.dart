import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDatasource moviesDataSource;

  MoviesRepositoryImpl({required this.moviesDataSource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return await moviesDataSource.getNowPlaying(page: page);
  }
}

