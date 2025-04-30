import 'package:my_movies/config/constants/environment.dart';
import 'package:my_movies/domain/domain.dart';
import 'package:my_movies/infrastructure/localdb/datasources/isar_favorites_datasource.dart';
import 'package:my_movies/infrastructure/localdb/datasources/sqlite_favorites_datasource.dart';
import 'package:my_movies/infrastructure/repositories/favorites_repository_impl.dart';
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
