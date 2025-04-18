import 'package:flutter/material.dart';
import 'package:ahorra_gas/screens/home/home.dart';
import 'package:ahorra_gas/screens/map/map.dart';
import 'package:ahorra_gas/components/nav/bottom_nav.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    PrincipalScreen(),
    MapScreen(),
    Center(
      child: Text("Pantalla de información (próximamente)", style: TextStyle(fontSize: 18)),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavMenu(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
