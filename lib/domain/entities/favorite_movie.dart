import 'package:isar/isar.dart';
import 'movie.dart';

part 'favorite_movie.g.dart';

@collection
class FavoriteMovie {
  Id? id;
  final int movieId;
  final String title;
  final String backdropPath;
  final String posterPath;
  final DateTime createdAt;

  FavoriteMovie({
    this.id,
    required this.movieId,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.createdAt,
  });

  static FavoriteMovie empty() {
    return FavoriteMovie(
        movieId: 0, title: '', backdropPath: '', posterPath: '', createdAt: DateTime.now().toUtc());
  }

  static FavoriteMovie fromMovie(Movie movie) {
    return FavoriteMovie(
      movieId: movie.id,
      title: movie.title,
      backdropPath: movie.backdropPath,
      posterPath: movie.posterPath,
      createdAt: DateTime.now().toUtc(),
    );
  }
}
