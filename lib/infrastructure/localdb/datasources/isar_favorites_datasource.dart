import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cinemapedia/domain/domain.dart';

class IsarFavoritesDatasource extends FavoritesDatasource {
  static const String dbName = "cinemapediadb";
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
    final movies = isar.favoriteMovies.where().offset(offset).limit(pageSize).findAll();
    return movies;
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    final isar = await isarDb;    
    final cnt = await isar.favoriteMovies.filter().movieIdEqualTo(movieId).count();
    return cnt > 0;
  }

  @override
  Future<void> toogleFavorite(FavoriteMovie favoriteMovie) async {
    final isar = await isarDb;
    final FavoriteMovie? current = await isar.favoriteMovies.filter()
      .movieIdEqualTo(favoriteMovie.movieId)
      .findFirst();

    if (current != null) {
      await isar.writeTxn(() =>  isar.favoriteMovies.delete(current.id!));
    } else {
        await isar.writeTxn(() =>  isar.favoriteMovies.put(favoriteMovie));
    }
  }
}
