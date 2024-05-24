import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/moviedb_response.dart';
import 'package:dio/dio.dart';

class TheMovieDbDatasource implements MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.theMovieDbKey, 'language': 'es-ES', 'region': 'ES'}));

  Future<List<Movie>> _getMoviesFromResponse(Response<dynamic> httpResponse) async {
    final List<Movie> movies = [];
    if (httpResponse.statusCode == 200 && httpResponse.data != null) {
      TheMovieDbResponse movieDbResponse = TheMovieDbResponse.fromJson(httpResponse.data!);
      for (var movie in movieDbResponse.results) {
        movies.add(MovieMapper.fromMovieDb(movie));
      }
    }

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final httpResponse = await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return await _getMoviesFromResponse(httpResponse);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final httpResponse = await dio.get('/movie/popular', queryParameters: {'page': page});
    return await _getMoviesFromResponse(httpResponse);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final httpResponse = await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return await _getMoviesFromResponse(httpResponse);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final httpResponse = await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return await _getMoviesFromResponse(httpResponse);
  }
}
