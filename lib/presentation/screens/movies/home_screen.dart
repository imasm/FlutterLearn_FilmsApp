import 'package:cinemapedia/presentation/screens/views/views.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

// This is the home screen of the app.
// It shows a list of movies in a slideshow and several horizontal lists of movies.
class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  
  final int pageIndex;
  const HomeScreen({super.key , required this.pageIndex});

  final views = const<Widget>[
    HomeView(),
    CategoriesView(),
    FavoritesView(),    
  ];
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack(
        index: pageIndex % views.length,
        children: views,        
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}
