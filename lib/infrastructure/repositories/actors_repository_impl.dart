import 'package:my_movies/domain/domain.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actorsDataSource;

  ActorsRepositoryImpl({required this.actorsDataSource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return await actorsDataSource.getActorsByMovie(movieId);
  }
}
