import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/infrastructure/localdb/datasources/isar_favorites_datasource.dart';
import 'package:cinemapedia/infrastructure/localdb/datasources/sqlite_favorites_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/favorites_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesRepositoryProvider = StateProvider<FavoritesRepository>((ref) {
  if (Environment.useIsar) {
    return FavoritesRepositoryImpl(favoritesDatasource: IsarFavoritesDatasource());
  }
  // Fallback to SQLite if Isar is not used
  return FavoritesRepositoryImpl(favoritesDatasource: SqliteFavoritesDatasource());
});

final isFavoriteProvider = FutureProvider.family.autoDispose<bool, int>((ref, int movieId) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return repository.isFavorite(movieId);
});
