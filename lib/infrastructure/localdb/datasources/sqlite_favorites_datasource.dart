import 'dart:io';
import 'package:my_movies/domain/domain.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../mappers/favorite_movie_mapper.dart';

class SqliteFavoritesDatasource extends FavoritesDatasource {
  late Future<Database> database;

  SqliteFavoritesDatasource() {
    database = _openDB();
  }

  Future<String> _getDatabasePath() {
    if (Platform.isIOS || Platform.isMacOS) {
      return getLibraryDirectory().then((dir) {
        return dir.path;
      });
    } else if (Platform.isAndroid) {
      return getDatabasesPath();
    } else if (Platform.isWindows) {
      return getDatabasesPath();
    } else if (Platform.isLinux) {
      return getDatabasesPath();
    } else {
      throw Exception('Unsupported platform');
    }
  }

  Future<Database> _openDB() async {
    // Open the database and store the reference.

    final dir = await _getDatabasePath();
    final db = await openDatabase(
      join(dir, 'my_movies.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute('''CREATE TABLE favorites(
              id INTEGER PRIMARY KEY, 
              movieId INTEGER, 
              title TEXT, 
              backdropPath TEXT, 
              posterPath TEXT,
              createdAt TEXT,
              UNIQUE(movieId) ON CONFLICT REPLACE,
              INDEX idx_createdAt (createdAt)
        ''');
      },
      version: 1,
    );
    return db;
  }

  @override
  Future<List<FavoriteMovie>> getFavorites({int page = 1, int pageSize = 20}) async {
    final offset = (page - 1) * pageSize;
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      limit: pageSize,
      offset: offset,
    );
    if (maps.isEmpty) return [];
    // Convert the List<Map<String, dynamic> into a List<FavoriteMovie>.
    return List.generate(maps.length, (i) => FavoriteMovieMapper.fromMap(maps[i]));
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'select count(*) from favorites where movieId = ?',
      [movieId],
    );
    final count = Sqflite.firstIntValue(maps) ?? 0;
    return count > 0;
  }

  @override
  Future<bool> toogleFavorite(FavoriteMovie favoriteMovie) async {
    final db = await database;
    final current = await db.query(
      'favorites',
      where: 'movieId = ?',
      whereArgs: [favoriteMovie.movieId],
    );
    if (current.isNotEmpty) {
      await db.delete('favorites', where: 'movieId = ?', whereArgs: [favoriteMovie.movieId]);
      return false;
    } else {
      await db.insert('favorites', FavoriteMovieMapper.toMap(favoriteMovie));
      return true;
    }
  }
}
