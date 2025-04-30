import 'package:my_movies/domain/domain.dart';
import 'package:my_movies/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MoviesMasonry extends StatefulWidget {
  final List<Movie> favorites;
  final VoidCallback loadNextPage;

  const MoviesMasonry({super.key, required this.favorites, required this.loadNextPage});

  @override
  State<MoviesMasonry> createState() => _MoviesMasonryState();
}

class _MoviesMasonryState extends State<MoviesMasonry> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 300) {
        widget.loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favs = widget.favorites;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        itemCount: favs.length,
        itemBuilder: (context, index) {
          var favoriteMovie = favs[index];
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 20),
                MoviePosterLink(movieId: favoriteMovie.id, posterPath: favoriteMovie.posterPath),
              ],
            );
          }

          return MoviePosterLink(movieId: favoriteMovie.id, posterPath: favoriteMovie.posterPath);
        },
      ),
    );
  }
}
