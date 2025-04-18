import 'package:flutter/material.dart';
import 'package:ahorra_gas/color/color_app.dart';

class BottomNavMenu extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavMenu({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: ColorApp.principalColor,
      selectedItemColor: ColorApp.colorButton,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
      ],
    );
  }
}
