import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _moviesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'tab-movies');

    final GlobalKey<NavigatorState> _categoriesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'tab-categories');

    final GlobalKey<NavigatorState> _favoritesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'tab-favorites');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/movies', 
  routes: [    
  StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(navigatorKey: _moviesNavigatorKey, routes: [homeViewRoute()]),
        StatefulShellBranch(navigatorKey:_categoriesNavigatorKey, routes: [favoritesViewRoute()]),
        StatefulShellBranch(navigatorKey:_favoritesNavigatorKey, routes: [categoriesViewRoute()])
      ])
],
redirect: (context, state) {
  if (state.uri.path == "/") {
    return "/movies";
  }
  return null;
});


GoRoute homeViewRoute() {
  return GoRoute(path: "/movies", builder: (context, state)  { 
    
  return const HomeView(); } ,
      routes: <RouteBase>[
            GoRoute(
              path: ":id",
              builder: (context, state) {
                
                final movieId = state.pathParameters['id'] ?? "no-id";
                return MovieScreen(movieId: movieId);
              },
            ),
          ]);
}



GoRoute homeViewOldRoute() {
  return GoRoute(path: "/movies", builder: (context, state) => const HomeView(), 
      routes: [
            GoRoute(
              path: ":id",
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