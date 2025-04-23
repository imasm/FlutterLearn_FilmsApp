import 'package:isar/isar.dart';
part 'favorite_movie.g.dart';

@collection
class FavoriteMovie {
  Id? id;
  final int movieId;
  final String title;
  final String backdropPath;
  final String posterPath;

  FavoriteMovie({
    this.id,
    required this.movieId,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
  });
}
