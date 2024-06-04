import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final titleStyle = theme.textTheme.titleMedium?.apply(color: colors.primary);
    final hasNotch = MediaQuery.of(context).viewPadding.top > 40;

    return SafeArea(
        child: Padding(
      padding: EdgeInsets.fromLTRB(10, hasNotch ? 0 : 15, 10, 0),
      child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 8),
              Text('Cinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    final searchProviderNotifier = ref.read(searchMoviesProvider.notifier);
                    final searchedMovies = ref.read(searchMoviesProvider);
                    final searchQuery = ref.read(searchQueryProvider);
                    showSearch<Movie?>(
                        query: searchQuery,
                        context: context,
                        delegate: SearchMovieDelegate(
                          searchMovies: searchProviderNotifier.searchMovieByQuery,
                          initialMovies: searchedMovies,
                        )).then((movie) => {
                          if (movie != null) {context.push('/movie/${movie.id}')}
                        });
                  },
                  icon: Icon(Icons.search, color: colors.primary))
            ],
          )),
    ));
  }
}
