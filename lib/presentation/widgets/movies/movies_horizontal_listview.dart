import 'package:animate_do/animate_do.dart';
import 'package:my_movies/config/helpers/human_formats.dart';
import 'package:my_movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
  This widget is a horizontal listview that shows a list of movies.
  It has a title and a subtitle, and it can be scrolled horizontally.
  
  It also has a callback that is called when the user reaches the end of the list to load more movies.

  The movies are shown in a card with the movie poster, title, rating, and popularity.
  The movie poster is clickable and it will navigate to the movie details page.
*/

class MoviesHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? sectionTitle;
  final String? sectionSubtitle;

  final VoidCallback? onNextPage;

  const MoviesHorizontalListview({
    super.key,
    required this.movies,
    this.sectionTitle,
    this.sectionSubtitle,
    this.onNextPage,
  });

  @override
  State<MoviesHorizontalListview> createState() => _MoviesHorizontalListviewState();
}

class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      var onNextPage = widget.onNextPage;
      if (onNextPage == null) return;
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 500) {
        onNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Column(
        children: [
          // setion title
          if (widget.sectionTitle != null || widget.sectionSubtitle != null)
            _SectionTitle(title: widget.sectionTitle, subtitle: widget.sectionSubtitle),

          // list of movies (horizontal scrollable listview)
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: widget.movies.length,
              itemBuilder:
                  (_, int index) => FadeInRight(child: _MovieSlide(movie: widget.movies[index])),
            ),
          ),
        ],
      ),
    );
  }
}

// Show the title of the section and an optional subtitle.
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Text(title ?? '', style: theme.textTheme.titleLarge),
          const Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}

// Each movie is shown in a card with the movie poster, title, rating, and popularity.
class _MovieSlide extends StatelessWidget {
  final Movie movie;

  const _MovieSlide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 150, child: _MoviePoster(movie: movie)),
          SizedBox(width: 150, child: _MovieTitle(movie: movie)),
          SizedBox(width: 150, child: _MovieRating(movie: movie)),
        ],
      ),
    );
  }
}

// Poster of the movie. Network image with a rounded border.
// Until the image is loaded, a circular progress indicator is shown.
// The poster is clickable and it will navigate to the movie details page.
class _MoviePoster extends StatelessWidget {
  const _MoviePoster({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    if (movie.posterPath == '') {
      return const Center(child: Text('No image'));
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        movie.posterPath,
        width: 150,
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
    );
  }
}

class _MovieTitle extends StatelessWidget {
  const _MovieTitle({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.titleMedium;

    return Text(movie.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: titleStyle);
  }
}

// Show the rating and popularity of the movie.
class _MovieRating extends StatelessWidget {
  const _MovieRating({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final infoStyle = theme.textTheme.bodyMedium;
    return Row(
      children: [
        Icon(Icons.star_half, color: Colors.yellow.shade800),
        const SizedBox(width: 5),
        Text(
          '${movie.voteAverage}',
          style: infoStyle?.copyWith(color: Colors.yellow.shade800, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(HumanFormats.humanReadableNumber(movie.popularity), style: infoStyle),
      ],
    );
  }
}
