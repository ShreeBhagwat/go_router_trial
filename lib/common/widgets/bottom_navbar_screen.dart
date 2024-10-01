import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_trial/home_screen.dart';
import 'package:go_router_trial/profile_screen.dart';
import 'package:go_router_trial/search_screen.dart';
import 'package:go_router_trial/settings_screen.dart';

class InitialScreen extends ConsumerWidget {
  const InitialScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  final List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedIndex = ref.watch(bottomNavBarProvider);
    return Scaffold(
      body: IndexedStack(
        index: navigationShell.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: items,
        currentIndex:navigationShell.currentIndex,
        onTap: _switchBranch,
        // (int index) {
        //   ref.read(bottomNavBarProvider.notifier).updateIndex(index);
        // },
      ),
    );
  }

  void _switchBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
