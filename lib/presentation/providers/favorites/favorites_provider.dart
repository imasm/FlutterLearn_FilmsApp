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

  Future<void> loadNextPage() async {
    final favorites = await favoritesRepository.getFavorites(page: page);
    if (favorites.isNotEmpty) {
      page++;
      Map<int, FavoriteMovie> tempMap = {};
      for (var e in favorites) {
        tempMap[e.movieId] = e;
      }
      state = {...state, ...tempMap};
    }
  }
}
