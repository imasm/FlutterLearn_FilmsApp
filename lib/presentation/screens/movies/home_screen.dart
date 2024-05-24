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
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
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
    final slideMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            centerTitle: false,
            titlePadding: EdgeInsetsDirectional.only(
              start: 0.0,
              bottom: 16.0,
            ),
          )),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(children: [
          //const CustomAppbar(),
          MoviesSlideshow(movies: slideMovies),

          MoviesHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En Cartellera',
              subtitle: "Dilluns 20",
              onNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),

          MoviesHorizontalListview(
              movies: nowPlayingMovies,
              title: 'Proximament',
              subtitle: "Aquest mes",
              onNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),

          MoviesHorizontalListview(
              movies: nowPlayingMovies,
              title: 'Populars',
              //subtitle: "",
              onNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),

          MoviesHorizontalListview(
              movies: nowPlayingMovies,
              title: 'Més valorades',
              subtitle: "De sempre",
              onNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),

          const SizedBox(height: 20)
        ]);
      }, childCount: 1))
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
