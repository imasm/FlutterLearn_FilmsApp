import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-screen';

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
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(initialLoadingProvider);
    if (isLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
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
              movies: upcomingMovies,
              title: 'Proximament',
              subtitle: "Aquest mes",
              onNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage()),

          MoviesHorizontalListview(
              movies: popularMovies,
              title: 'Populars',
              //subtitle: "",
              onNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()),

          MoviesHorizontalListview(
              movies: topRatedMovies,
              title: 'Més valorades',
              subtitle: "De sempre",
              onNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage()),

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
