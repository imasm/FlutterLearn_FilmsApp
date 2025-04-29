import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularsView extends ConsumerStatefulWidget {
  const PopularsView({super.key});

  @override
  ConsumerState<PopularsView> createState() => _PopularsViewState();
}

class _PopularsViewState extends ConsumerState<PopularsView> {
  @override
  Widget build(BuildContext context) {
    final List<Movie> popularMovies = ref.watch(popularMoviesProvider);

    if (popularMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return Scaffold(
      body: MoviesMasonry(
          favorites: popularMovies,
          loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()),
    );
  }
}
