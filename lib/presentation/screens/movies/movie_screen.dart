import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: currentMovie),
          childCount: 1)
        )
      ],
    ));
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final Size  deviceSize = MediaQuery.of(context).size;
    

    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MovieDetailsPoster(posterPath: movie.posterPath, posterWitdh: deviceSize.width * 0.3),
              const SizedBox(width: 10),
              _MovieDetailsText( movie: movie, width: (deviceSize.width - 40) * 0.7)
            ],
          ),
        ),

        // Generes de la pel·lícula
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,
            children: movie.genreIds.map((genre) => 
              Chip(label: Text(genre), shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
            ).toList(),
          ),
        ),
        // TODO: Afegir actors
        
        // Deixa un espai en blanc al final
        const SizedBox(height: 100),
      ],
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
          Text(movie.overview, textAlign: TextAlign.justify,),
        ],
      ),
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
