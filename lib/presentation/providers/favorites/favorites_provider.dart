import 'package:cinemapedia/domain/domain.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Map<int, FavoriteMovie>>((ref) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return FavoritesNotifier(favoritesRepository: repository);
});

class FavoritesNotifier extends StateNotifier<Map<int, FavoriteMovie>> {
  final FavoritesRepository favoritesRepository;
  int page = 1;

  FavoritesNotifier({required this.favoritesRepository}) : super({});

  Future<int> loadNextPage() async {
    final favorites = await favoritesRepository.getFavorites(page: page);
    if (favorites.isEmpty) {
      return 0;
    }

    Map<int, FavoriteMovie> favMap = {};
    for (var favorite in favorites) {
      favMap[favorite.movieId] = favorite;
    }

    page++;
    state = {...state, ...favMap};
    return favorites.length;
  }

  Future<void> toggleFavorite(FavoriteMovie movie) async {
    bool isFavorite = await favoritesRepository.toogleFavorite(movie);
    bool isInState = state.containsKey(movie.movieId);

    if (isInState & !isFavorite) {
      // Treure
      state.remove(movie.movieId);
      state = {...state};
      return;
    }

    if (isFavorite) {
      state[movie.movieId] = movie;
      state = {...state};
    }
  }
}
