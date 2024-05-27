import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({super.key, required this.movieId});

  static const name = 'movie-screen';

  final String movieId;

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieDetailsProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Movie> movieCache = ref.watch(movieDetailsProvider);
    final Movie? currentMovie = movieCache[widget.movieId];

    // Wait for the movie to be loaded
    if (currentMovie == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
        body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(movie: currentMovie),
      ],
    ));
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: deviceSize.height * 0.7, // 70% of the screen
      foregroundColor: Colors.white,
      shadowColor: Colors.red,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: _AppBarMovieTitle(movieTitle: movie.title),
        background:
            Stack(children: [_AppBarPoster(movie: movie), const _AppBarTitleGradient(), const _AppBarGoBackGradient()]),
      ),
    );
  }
}

class _AppBarMovieTitle extends StatelessWidget {
  const _AppBarMovieTitle({
    required this.movieTitle,
  });

  final String movieTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      movieTitle,
      style: const TextStyle(fontSize: 20),
      textAlign: TextAlign.start,
    );
  }
}

// Mostra la imatge de la pel·lícula
class _AppBarPoster extends StatelessWidget {
  const _AppBarPoster({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image(
        image: NetworkImage(movie.posterPath),
        fit: BoxFit.cover,
      ),
    );
  }
}

// Fa un degradat per sobre de la imatge per a que es vegi millor el títol
class _AppBarTitleGradient extends StatelessWidget {
  const _AppBarTitleGradient();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
        child: DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 1],
              colors: [Colors.transparent, Colors.black87])),
    ));
  }
}

// Fa un degradat per sobre de la imatge per a que es vegi millor la fletxa de tornar enrere
class _AppBarGoBackGradient extends StatelessWidget {
  const _AppBarGoBackGradient();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
        child: DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              stops: [0, 0.3],
              colors: [Colors.black87, Colors.transparent])),
    ));
  }
}
