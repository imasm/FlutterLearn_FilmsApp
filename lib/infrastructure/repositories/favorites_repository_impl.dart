import 'package:my_movies/domain/domain.dart';

class FavoritesRepositoryImpl extends FavoritesRepository {
  final FavoritesDatasource favoritesDatasource;
  FavoritesRepositoryImpl({required this.favoritesDatasource});

  @override
  Future<List<FavoriteMovie>> getFavorites({int page = 1, int pageSize = 20}) {
    return favoritesDatasource.getFavorites(page: page, pageSize: pageSize);
  }

  @override
  Future<bool> isFavorite(int movieId) {
    return favoritesDatasource.isFavorite(movieId);
  }

  @override
  Future<bool> toogleFavorite(FavoriteMovie favoriteMovie) {
    return favoritesDatasource.toogleFavorite(favoriteMovie);
  }
}
