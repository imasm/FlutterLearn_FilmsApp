import 'package:my_movies/domain/domain.dart';
import 'package:my_movies/infrastructure/the_movie_db/themoviedb_datasources.dart';
import 'package:my_movies/infrastructure/repositories/actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider<ActorsRepository>((ref) {
  return ActorsRepositoryImpl(actorsDataSource: TheMovieDbActorsDatasource());
});
