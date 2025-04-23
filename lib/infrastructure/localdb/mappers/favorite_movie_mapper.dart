import 'package:cinemapedia/domain/domain.dart';

class FavoriteMovieMapper {
  static FavoriteMovie fromMap(Map<String, Object?> favMap) => FavoriteMovie(
        id: favMap['id'] as int?,
        movieId: favMap['movieId'] as int,
        title: favMap['title'] as String,
        backdropPath: favMap['backdropPath'] as String,
        posterPath: favMap['posterPath'] as String,
      );

  static Map<String, Object?> toMap(FavoriteMovie src) => {
        'id': src.id,
        'movieId': src.movieId,
        'title': src.title,
        'backdropPath': src.backdropPath,
        'posterPath': src.posterPath,
      };
}
