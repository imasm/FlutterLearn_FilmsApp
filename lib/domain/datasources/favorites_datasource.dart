import 'package:my_movies/domain/entities/favorite_movie.dart';

abstract class FavoritesDatasource {
  Future<bool> toogleFavorite(FavoriteMovie favoriteMovie);
  Future<bool> isFavorite(int movieId);
  Future<List<FavoriteMovie>> getFavorites({int page = 1, int pageSize = 20});
}
