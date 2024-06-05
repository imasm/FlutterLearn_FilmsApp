import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
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
      const _HomeAppBar(),

      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(children: [

          MoviesSlideshow(movies: slideMovies),

          MoviesHorizontalListview(
              movies: nowPlayingMovies,
              sectionTitle: 'En Cartellera',
              sectionSubtitle: "Dilluns 20",
              onNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),

          MoviesHorizontalListview(
              movies: upcomingMovies,
              sectionTitle: 'Proximament',
              sectionSubtitle: "Aquest mes",
              onNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage()),

          MoviesHorizontalListview(
              movies: popularMovies,
              sectionTitle: 'Populars',
              //subtitle: "",
              onNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()),

          MoviesHorizontalListview(
              movies: topRatedMovies,
              sectionTitle: 'Més valorades',
              sectionSubtitle: "De sempre",
              onNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage()),

          const SizedBox(height: 20)
        ]);
      }, childCount: 1))
    ]);
  }
}

// The appbar of the home screen.
// It's a sliver appbar with a custom appbar.
class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
          centerTitle: false,
          titlePadding: EdgeInsetsDirectional.only(
            start: 0.0,
            bottom: 16.0,
          ),
        ));
  }
}
