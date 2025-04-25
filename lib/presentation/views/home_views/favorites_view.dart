import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/favorite_movies_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    // Load favorite movies or any other initialization if needed
    _loadNextPage();
  }

  void _loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    int favorites = await ref.read(favoritesProvider.notifier).loadNextPage();
    isLastPage = favorites == 0;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoritesProvider);
    final moviesList = favoriteMovies.values.toList();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Favorites'),
      // ),
      body: MoviesMasonry(favorites: moviesList, loadNextPage: _loadNextPage),
    );
  }
}
