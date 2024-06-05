import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';


// This is the home screen of the app.
// It shows a list of movies in a slideshow and several horizontal lists of movies.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.navigationShell});

  static const name = 'home-screen';
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  navigationShell,
      bottomNavigationBar:  CustomBottomNavigation(navigationShell: navigationShell),
    );
  }
}
