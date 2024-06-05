import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _tabANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'tabANav');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/', 
  routes: [
  StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(navigatorKey: _tabANavigatorKey, routes: [homeViewRoute()]),
        StatefulShellBranch(routes: [favoritesViewRoute()]),
        StatefulShellBranch(routes: [categoriesViewRoute()])

        //GoRoute(path: "/favorites", builder: (context, state) => const FavoritesView()),
        //GoRoute(path: "/categories",  builder: (context, state) => const CategoriesView()),
      ])
]);


GoRoute homeViewRoute() {
  return GoRoute(path: "/", builder: (context, state) => const HomeView(), routes: [
            GoRoute(
              path: "movie/:id",
              name: MovieScreen.name,
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? "no-id";
                return MovieScreen(movieId: movieId);
              },
            ),
          ]);
}

GoRoute favoritesViewRoute() {
  return GoRoute(path: "/categories", builder: (context, state) => const CategoriesView());
}

GoRoute categoriesViewRoute() {
  return GoRoute(path: "/favorites", builder: (context, state) => const FavoritesView());
}