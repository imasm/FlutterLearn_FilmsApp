import 'package:dio/dio.dart';
import 'package:my_movies/config/constants/environment.dart';
import 'package:my_movies/domain/domain.dart';
import '../themoviedb_models.dart';
import '../themoviedb_mappers.dart';

class TheMovieDbActorsDatasource implements ActorsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.theMovieDbKey, 'language': 'es-ES', 'region': 'ES'},
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final httpResponse = await dio.get('/movie/$movieId/credits');

    if (httpResponse.statusCode == 200 && httpResponse.data != null) {
      final TheMovieDbCreditsResponse creditsResponse = TheMovieDbCreditsResponse.fromJson(
        httpResponse.data!,
      );
      final actors = creditsResponse.cast.map((e) => ActorMapper.fromMovieDb(e)).toList();
      return actors;
    }

    return [];
  }
}
