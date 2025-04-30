import 'package:my_movies/presentation/screens/screens.dart';
import 'package:my_movies/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _moviesNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'tab-movies',
);

final GlobalKey<NavigatorState> _popularsNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'tab-populars',
);

final GlobalKey<NavigatorState> _favoritesNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'tab-favorites',
);

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/movies',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(navigatorKey: _moviesNavigatorKey, routes: [homeViewRoute()]),
        StatefulShellBranch(navigatorKey: _popularsNavigatorKey, routes: [popularsViewRoute()]),
        StatefulShellBranch(navigatorKey: _favoritesNavigatorKey, routes: [favoritesViewRoute()]),
      ],
    ),
  ],
  redirect: (context, state) {
    if (state.uri.path == "/") {
      return "/movies";
    }
    return null;
  },
);

GoRoute homeViewRoute() {
  return GoRoute(
    path: "/movies",
    builder: (context, state) {
      return const HomeView();
    },
    routes: <RouteBase>[
      GoRoute(
        path: ":id",
        builder: (context, state) {
          final movieId = state.pathParameters['id'] ?? "no-id";
          return MovieScreen(movieId: movieId);
        },
      ),
    ],
  );
}

GoRoute homeViewOldRoute() {
  return GoRoute(
    path: "/movies",
    builder: (context, state) => const HomeView(),
    routes: [
      GoRoute(
        path: ":id",
        builder: (context, state) {
          final movieId = state.pathParameters['id'] ?? "no-id";
          return MovieScreen(movieId: movieId);
        },
      ),
    ],
  );
}

GoRoute popularsViewRoute() {
  return GoRoute(path: "/populars", builder: (context, state) => const PopularsView());
}

GoRoute favoritesViewRoute() {
  return GoRoute(path: "/favorites", builder: (context, state) => const FavoritesView());
}
