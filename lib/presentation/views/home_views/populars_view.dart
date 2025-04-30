import 'package:my_movies/domain/domain.dart';
import 'package:my_movies/presentation/providers/providers.dart';
import 'package:my_movies/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularsView extends ConsumerStatefulWidget {
  const PopularsView({super.key});

  @override
  ConsumerState<PopularsView> createState() => _PopularsViewState();
}

class _PopularsViewState extends ConsumerState<PopularsView> {
  @override
  void initState() {
    super.initState();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> popularMovies = ref.watch(popularMoviesProvider);

    if (popularMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return Scaffold(
      body: MoviesMasonry(
        favorites: popularMovies,
        loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
      ),
    );
  }
}
