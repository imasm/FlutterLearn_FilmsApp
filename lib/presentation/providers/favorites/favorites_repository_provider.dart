import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/infrastructure/localdb/datasources/isar_favorites_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/favorites_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesRepositoryProvider = StateProvider<FavoritesRepository>((ref) {
  return FavoritesRepositoryImpl(favoritesDatasource: IsarFavoritesDatasource());
});


final isFavoriteProvider = FutureProvider.family.autoDispose<bool, int>((ref, int movieId) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return repository.isFavorite(movieId);
});