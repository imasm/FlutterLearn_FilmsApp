import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, List<Actor>>((ref) {
  final repository = ref.watch(actorsRepositoryProvider);
  return ActorsByMovieNotifier(getActorsByMovieCallback: repository.getActorsByMovie);
});

typedef GetActorsByMovieCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<List<Actor>> {
  final GetActorsByMovieCallback getActorsByMovieCallback;
  ActorsByMovieNotifier({required this.getActorsByMovieCallback}) : super([]);

  bool isLoading = false;

  Future<void> loadActors(String movieId) async {
    if (isLoading) return;
    isLoading = true;

    final actors = await getActorsByMovieCallback(movieId);
    state = actors;
    isLoading = false;
  }
}