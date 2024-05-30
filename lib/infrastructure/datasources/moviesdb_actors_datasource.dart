import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/moviedb_credits_response.dart';
import 'package:dio/dio.dart';

class TheMovieDbActorsDatasource implements ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.theMovieDbKey, 'language': 'es-ES', 'region': 'ES'}));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final httpResponse = await dio.get('/movie/$movieId/credits');

    if (httpResponse.statusCode == 200 && httpResponse.data != null) {
      final TheMovieDbCreditsResponse creditsResponse = TheMovieDbCreditsResponse.fromJson(httpResponse.data!);
      final actors = creditsResponse.cast.map((e) => ActorMapper.fromMovieDb(e)).toList();
      return actors;
    }

    return [];
  }
}
