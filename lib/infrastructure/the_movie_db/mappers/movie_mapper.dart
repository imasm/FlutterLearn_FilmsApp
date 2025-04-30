import 'package:my_movies/domain/domain.dart';
import '../themoviedb_models.dart';

class MovieMapper {
  static String imageNotFound =
      'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg';

  static String theMovieDbImageUrl = 'http://image.tmdb.org/t/p/';
  static String theMovieDbBackdropSize = 'w500';
  static String theMovieDbPosterSize = 'w500';

  static Movie fromMovieDb(TheMovieDbMovie movieDbMovie) => Movie(
    id: movieDbMovie.id,
    title: movieDbMovie.title,
    originalTitle: movieDbMovie.originalTitle,
    releaseDate: movieDbMovie.releaseDate,
    popularity: movieDbMovie.popularity,
    voteCount: movieDbMovie.voteCount,
    voteAverage: movieDbMovie.voteAverage,
    video: movieDbMovie.video,
    overview: movieDbMovie.overview,
    adult: movieDbMovie.adult,
    genreIds: movieDbMovie.genreIds.map((e) => e.toString()).toList(),
    originalLanguage: movieDbMovie.originalLanguage,

    backdropPath:
        movieDbMovie.backdropPath != ''
            ? '$theMovieDbImageUrl$theMovieDbBackdropSize${movieDbMovie.backdropPath}'
            : imageNotFound,

    posterPath:
        movieDbMovie.posterPath != ''
            ? '$theMovieDbImageUrl$theMovieDbPosterSize${movieDbMovie.posterPath}'
            : imageNotFound,
  );

  static Movie fromMovieDbDetails(TheMovieDbMovieDetails src) => Movie(
    id: src.id,
    title: src.title,
    originalTitle: src.originalTitle,
    releaseDate: src.releaseDate,
    popularity: src.popularity,
    voteCount: src.voteCount,
    voteAverage: src.voteAverage,
    video: src.video,
    overview: src.overview,
    adult: src.adult,
    genreIds: src.genres.map((e) => e.name.toString()).toList(),
    originalLanguage: src.originalLanguage,
    backdropPath:
        src.backdropPath != ''
            ? '$theMovieDbImageUrl$theMovieDbBackdropSize${src.backdropPath}'
            : imageNotFound,

    posterPath:
        src.posterPath != ''
            ? '$theMovieDbImageUrl$theMovieDbPosterSize${src.posterPath}'
            : imageNotFound,
  );
}
