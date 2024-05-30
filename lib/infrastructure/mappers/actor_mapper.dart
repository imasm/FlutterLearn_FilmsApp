import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/moviedb_credits_response.dart';

class ActorMapper {
    static String imageNotFound =
      'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg';

  static String theMovieDbImageUrl ='http://image.tmdb.org/t/p/';
  static String theMovieDbBackdropSize ='w500';
  static String theMovieDbPosterSize ='w500';

   static Actor fromMovieDb(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath != null ? 
    '$theMovieDbImageUrl$theMovieDbBackdropSize${cast.profilePath}' : 
    imageNotFound,
    character: cast.character,
   );

}