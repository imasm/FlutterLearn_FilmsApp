import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const CustomBottomNavigation({super.key, required this.navigationShell});

  int getCurrentIndex(BuildContext context) {
   return navigationShell.currentIndex;
  }

  void onItemSelected(BuildContext context, int index) {
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(onTap: (value) => onItemSelected(context, value), 
    elevation: 0,
    currentIndex: getCurrentIndex(context),
     items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inici'),      
      BottomNavigationBarItem(icon: Icon(Icons.label_outline), label: 'categories'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Preferits'),
    ]);
  }
}
