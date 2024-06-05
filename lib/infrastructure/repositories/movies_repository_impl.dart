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

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return await moviesDataSource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return await moviesDataSource.getUpcoming(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return await moviesDataSource.getTopRated(page: page);
  }

  @override
  Future<Movie> getMovieDetails(String movieId) async {
    return await moviesDataSource.getMovieDetails(movieId);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    return await moviesDataSource.searchMovies(query);
  }
}
