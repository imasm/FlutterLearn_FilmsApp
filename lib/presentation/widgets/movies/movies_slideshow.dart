import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:my_movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// This widget is a slideshow that shows a list of movies.
// It has a limited number of movies that can be scrolled horizontally.
// The movies are shown in a card with the movie poster.
class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 260,
      width: double.infinity,

      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.8,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            activeSize: 12,
            size: 8,
            color: theme.colorScheme.secondary,
            activeColor: theme.colorScheme.primary,
          ),
        ),
        itemCount: movies.length,
        itemBuilder: (_, int index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

// This widget is a slide that shows a movie.
// It's clickable and it will navigate to the movie details page.
class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 10))],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, image, loadingProgress) {
              if (loadingProgress != null) {
                return const Center(child: CircularProgressIndicator());
              }
              return GestureDetector(
                onTap: () => context.push('/movies/${movie.id}'),
                child: FadeIn(child: image),
              );
            },
          ),
        ),
      ),
    );
  }
}
