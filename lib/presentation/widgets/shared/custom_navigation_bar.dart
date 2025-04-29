import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Bottom navigation bar for the app
// It uses the NavigationShell to manage the current index and navigation between branches
class CustomNavigationBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const CustomNavigationBar({super.key, required this.navigationShell});

  int getCurrentIndex(BuildContext context) {
    return navigationShell.currentIndex;
  }

  void onItemSelected(BuildContext context, int index) {
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return NavigationBar(
        elevation: 2,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: size.height * 0.1,
        selectedIndex: getCurrentIndex(context),
        onDestinationSelected: (value) => onItemSelected(context, value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_max_outlined), label: 'Inici'),
          NavigationDestination(icon: Icon(Icons.trending_up), label: 'Populars'),
          NavigationDestination(icon: Icon(Icons.favorite_outline), label: 'Preferits'),
        ]);
  }
}
