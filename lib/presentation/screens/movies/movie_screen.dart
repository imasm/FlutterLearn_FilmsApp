import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_provider.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This screen shows the details of a movie.
// It shows the title, the poster, the overview, the genres and the actors of the movie.
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
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
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
        _MoviePosterAppBar(movie: currentMovie),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) => _MovieContent(movie: currentMovie), childCount: 1))
      ],
    ));
  }
}

// Screen AppBar
// Shows the movie poster and title in a flexible space bar.
// Starts with a height of 70% of the screen and shrinks to 10% when scrolling.
class _MoviePosterAppBar extends StatelessWidget {
  final Movie movie;
  const _MoviePosterAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shadowColor: Colors.red,
      expandedHeight: deviceSize.height * 0.7, // 70% of the screen

      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: _MoviePosterAppBarTitle(movieTitle: movie.title),
        background: Stack(children: [
          _MoviePosterAppBarImage(movie: movie),
          const _MoviePosterAppBarTitleGradient(),
          const _MoviePosterAppBarGoBackGradient()
        ]),
      ),
    );
  }
}

// Shows the movie poster for the app bar.
class _MoviePosterAppBarImage extends StatelessWidget {
  const _MoviePosterAppBarImage({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Image.network(
      movie.posterPath,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return FadeIn(child: child);
        return const SizedBox();
      },
    ));
  }
}

class _MoviePosterAppBarTitle extends StatelessWidget {
  const _MoviePosterAppBarTitle({required this.movieTitle});

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

// Create a gradient to make the title more readable
class _MoviePosterAppBarTitleGradient extends StatelessWidget {
  const _MoviePosterAppBarTitleGradient();

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

// Create a gradient to make the go back button more readable
class _MoviePosterAppBarGoBackGradient extends StatelessWidget {
  const _MoviePosterAppBarGoBackGradient();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
        child: DecoratedBox(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(begin: Alignment.topLeft, stops: [0, 0.3], colors: [Colors.black87, Colors.transparent])),
    ));
  }
}

// Shows the details of the movie.
class _MovieContent extends StatelessWidget {
  final Movie movie;
  const _MovieContent({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Details
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _MovieDetails(movie: movie),
        ),

        // Genres
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _MovieGenres(movie: movie),
        ),

        _MovieActors(movieId: movie.id),

        // Deixa un espai en blanc al final
        const SizedBox(height: 50),
      ],
    );
  }
}

// Shows the movie poster and details.
class _MovieDetails extends StatelessWidget {
  const _MovieDetails({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MovieDetailsPoster(posterPath: movie.posterPath, posterWitdh: deviceSize.width * 0.3),
        const SizedBox(width: 10),
        _MovieDetailsText(movie: movie, width: (deviceSize.width - 40) * 0.7)
      ],
    );
  }
}

class _MovieDetailsPoster extends StatelessWidget {
  const _MovieDetailsPoster({
    required this.posterPath,
    required this.posterWitdh,
  });

  final String posterPath;
  final double posterWitdh;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(posterPath, width: posterWitdh),
    );
  }
}

class _MovieDetailsText extends StatelessWidget {
  const _MovieDetailsText({
    required this.movie,
    required this.width,
  });

  final double width;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(movie.title, style: textStyles.titleLarge),
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

// Shows the genres of the movie.
class _MovieGenres extends StatelessWidget {
  const _MovieGenres({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: movie.genreIds
          .map((genre) =>
              Chip(label: Text(genre), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))))
          .toList(),
    );
  }
}

// Shows the actors of the movie.
class _MovieActors extends ConsumerWidget {
  final int movieId;
  const _MovieActors({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actors = ref.watch(actorsByMovieProvider);

    return SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            final actor = actors[index];
            return Container(
              padding: const EdgeInsets.all(8),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ActorPhoto(actor: actor),
                  Text(actor.name, maxLines: 2),
                  Text(
                    actor.character ?? "",
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class _ActorPhoto extends StatelessWidget {
  const _ActorPhoto({required this.actor});

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(actor.profilePath, height: 180, width: 135, fit: BoxFit.cover),
      ),
    );
  }
}

class _ActorAvatar extends StatelessWidget {
  const _ActorAvatar({required this.actor});

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: 50, backgroundImage: NetworkImage(actor.profilePath));
  }
}
