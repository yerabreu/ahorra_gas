import 'package:ahorra_gas/color/color_app.dart';
import 'package:flutter/material.dart';

class BottomNavMenu extends StatefulWidget {
  const BottomNavMenu({super.key});

  @override
  State<BottomNavMenu> createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: ColorApp.principalColor,
      selectedItemColor: ColorApp.colorButton,
      unselectedItemColor: Colors.grey, 
      selectedLabelStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold), 
      unselectedLabelStyle: TextStyle(color: Colors.grey), 
      items: <BottomNavigationBarItem>[
        _createBottomItem(icon: Icons.home, label: "Inicio"),
        _createBottomItem(icon: Icons.map, label: "Mapa"),
        _createBottomItem(icon: Icons.info, label: "Info"),
      ],
    );
  }

  BottomNavigationBarItem _createBottomItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon), 
      label: label,
    );
  }
}
