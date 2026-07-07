import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xff0C9E6E),
      height: 75,

      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: "Home",
        ),

        NavigationDestination(
          icon: Icon(Icons.directions_run_outlined),
          selectedIcon: Icon(Icons.directions_run),
          label: "Activity",
        ),

        NavigationDestination(
          icon: Icon(Icons.water_drop_outlined),
          selectedIcon: Icon(Icons.water_drop),
          label: "Water",
        ),

        NavigationDestination(
          icon: Icon(Icons.sentiment_satisfied_outlined),
          selectedIcon: Icon(Icons.sentiment_satisfied),
          label: "Mood",
        ),

        NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon: Icon(Icons.bar_chart),
          label: "Stats",
        ),
      ],
    );
  }
}
