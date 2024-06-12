import 'package:cinemapedia/domain/entities/favorite_movie.dart';

abstract class FavoritesDatasource {
  Future<void> toogleFavorite(FavoriteMovie favoriteMovie);
  Future<bool> isFavorite(int movieId);
  Future<List<FavoriteMovie>> getFavorites({int page =1, int pageSize = 20});
}