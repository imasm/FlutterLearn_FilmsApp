import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
final int currentIndex;
const CustomBottomNavigation({ super.key, required this.currentIndex});



  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
      onTap: (index) =>  context.go('/home/$index'),
      elevation: 0,
      currentIndex: currentIndex,
      items: const [
       BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inici'),
       BottomNavigationBarItem(icon: Icon(Icons.label_outline), label: 'Categories'),
       BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Preferits'),
    ]);
  }
}