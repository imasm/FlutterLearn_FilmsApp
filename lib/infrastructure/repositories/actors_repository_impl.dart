import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actorsDataSource;

  ActorsRepositoryImpl({required this.actorsDataSource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return await actorsDataSource.getActorsByMovie(movieId);
  }

}