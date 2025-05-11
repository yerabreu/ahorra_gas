import 'package:ahorra_gas/components/nav/drawer_nav.dart';
import 'package:ahorra_gas/components/nav/up_nav.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_diesel.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_ninty_eight.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_ninty_five.dart';
import 'package:ahorra_gas/screens/info/info.dart';
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
    InfoScreen(),     
    FuelNintyFive(),    
    FuelNintyEight(),   
    FuelDiesel(),      
  ];

  // Cuando se hace clic en un ítem del BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            drawer: DrawerNav(),

      appBar: UpNav(),
      
      body: _screens[_selectedIndex],
      
      bottomNavigationBar: BottomNavMenu(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
