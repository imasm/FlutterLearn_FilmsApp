import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-screen';
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Screen'),
      // ),
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    if (nowPlayingMovies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        const CustomAppbar(),
        Expanded(
          child: NowPlayingList(nowPlayingMovies: nowPlayingMovies),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
          },
          child: const Text('Load more'),
        ),
        const SizedBox(height: 16),
      ]);
  }
}

class NowPlayingList extends StatelessWidget {
  const NowPlayingList({
    super.key,
    required this.nowPlayingMovies,
  });

  final List<Movie> nowPlayingMovies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nowPlayingMovies.length,
      itemBuilder: (context, index) {
        final movie = nowPlayingMovies[index];
        return ListTile(
          title: Text(movie.title),
          subtitle: Text(movie.overview),
        );
      },
    );
  }
}
