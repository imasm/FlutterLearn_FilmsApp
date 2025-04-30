import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_movies/domain/domain.dart';

class IsarFavoritesDatasource extends FavoritesDatasource {
  static const String dbName = "my_moviesdb";
  late Future<Isar> isarDb;

  IsarFavoritesDatasource() {
    isarDb = _openDB();
  }

  Future<Isar> _openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [FavoriteMovieSchema],
        name: dbName,
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance(dbName));
  }

  @override
  Future<List<FavoriteMovie>> getFavorites({int page = 1, int pageSize = 20}) async {
    final offset = (page - 1) * pageSize;
    final isar = await isarDb;
    final movies =
        isar.favoriteMovies.where().sortByCreatedAtDesc().offset(offset).limit(pageSize).findAll();
    return movies;
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    final isar = await isarDb;
    final cnt = await isar.favoriteMovies.filter().movieIdEqualTo(movieId).count();
    return cnt > 0;
  }

  @override
  Future<bool> toogleFavorite(FavoriteMovie favoriteMovie) async {
    final isar = await isarDb;
    final FavoriteMovie? current =
        await isar.favoriteMovies.filter().movieIdEqualTo(favoriteMovie.movieId).findFirst();

    // If the movie is already in the favorites, remove it
    if (current != null) {
      await isar.writeTxn(() => isar.favoriteMovies.delete(current.id!));
      return false;
    }
    // Add new favorite movie
    await isar.writeTxn(() => isar.favoriteMovies.put(favoriteMovie));
    return true;
  }
}
