import 'package:cinemapedia/domain/repositories/actors_repository.dart';
import 'package:cinemapedia/infrastructure/the_movie_db/themoviedb_datasources.dart';
import 'package:cinemapedia/infrastructure/repositories/actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider<ActorsRepository>((ref) {
  return ActorsRepositoryImpl(actorsDataSource: TheMovieDbActorsDatasource());
});