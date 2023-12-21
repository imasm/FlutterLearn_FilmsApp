import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/moviedb_movie.dart';

class MovieMapper {
  static String imageNotFound =
      'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg';
  static String theMovieDbImageUrl ='http://image.tmdb.org/t/p/';
  static String theMovieDbBackdropSize ='w500';
  static String theMovieDbPosterSize ='w500';

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

      backdropPath: movieDbMovie.backdropPath != '' ? 
        '$theMovieDbImageUrl$theMovieDbBackdropSize${movieDbMovie.backdropPath}' : 
        imageNotFound,

    posterPath: movieDbMovie.posterPath != '' ? 
        '$theMovieDbImageUrl$theMovieDbPosterSize${movieDbMovie.posterPath}' : 
        imageNotFound      
      );
}
