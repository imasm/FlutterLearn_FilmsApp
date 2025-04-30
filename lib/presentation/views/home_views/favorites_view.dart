import 'package:my_movies/presentation/providers/providers.dart';
import 'package:my_movies/presentation/widgets/movies/favorite_movies_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline, size: 60, color: colors.primary),
            const SizedBox(height: 10),
            Text(
              'No tens cap pel·licula preverida encara!',
              style: TextStyle(fontSize: 30, color: colors.primary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            FilledButton.tonal(
              onPressed: () => context.go('/movies'),
              child: const Text('Torna a la pàgina principal'),
            ),
          ],
        ),
      );
    }

    final moviesList = favoriteMovies.values.toList();

    // order by createdAt (added to favorites) descending
    moviesList.sort((a, b) {
      return -a.createdAt.compareTo(b.createdAt);
    });

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Favorites'),
      // ),
      body: FavoritesMoviesMasonry(favorites: moviesList, loadNextPage: _loadNextPage),
    );
  }
}
