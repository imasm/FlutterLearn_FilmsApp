import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;

  final VoidCallback? onNextPage;

  const MoviesHorizontalListview({super.key, required this.movies, this.title, this.subtitle, this.onNextPage});

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
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null) _Title(title: widget.title, subtitle: widget.subtitle),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) => FadeInRight(child: _MovieSlide(movie: widget.movies[index])),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieSlide extends StatelessWidget {
  final Movie movie;

  const _MovieSlide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.titleMedium;
    final infoStyle = theme.textTheme.bodyMedium;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 150, child: _ImagePoster(movie: movie)),
          SizedBox(
              width: 150,
              child: Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: titleStyle,
              )),
          //const Spacer(),
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half, color: Colors.yellow.shade800),
                const SizedBox(width: 5),
                Text('${movie.voteAverage}',
                    style: infoStyle?.copyWith(color: Colors.yellow.shade800, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(HumanFormats.humanReadableNumber(movie.popularity), style: infoStyle),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ImagePoster extends StatelessWidget {
  const _ImagePoster({
    required this.movie,
  });

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

            return GestureDetector(onTap: () => context.push('/movie/${movie.id}'), child: FadeIn(child: image));
          },
        ));
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
    required this.subtitle,
  });

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
                child: Text(subtitle!))
        ],
      ),
    );
  }
}
