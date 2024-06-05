import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';


// This is the home screen of the app.
// It shows a list of movies in a slideshow and several horizontal lists of movies.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.childView});

  static const name = 'home-screen';
  final Widget childView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  childView,
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
