import 'package:cinemapedia/domain/domain.dart';
import '../themoviedb_models.dart';

class ActorMapper {
    static String imageNotFound =
      'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg';

  static String theMovieDbImageUrl ='http://image.tmdb.org/t/p/';
  static String theMovieDbBackdropSize ='w500';
  static String theMovieDbPosterSize ='w500';

   static Actor fromMovieDb(TheMovieDbCast cast) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath != null ? 
    '$theMovieDbImageUrl$theMovieDbBackdropSize${cast.profilePath}' : 
    imageNotFound,
    character: cast.character,
   );

}