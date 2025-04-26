import 'package:ahorra_gas/components/nav/drawer_nav.dart';
import 'package:ahorra_gas/components/nav/up_nav.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_diesel.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_ninty_eight.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_ninty_five.dart';
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

  // Lista de pantallas que cambiarán en el body
  final List<Widget> _screens = const [
    PrincipalScreen(),  // Pantalla de inicio
    MapScreen(),        // Pantalla de mapa
    FuelNintyFive(),    // Pantalla de gasolina 95
    FuelNintyEight(),   // Pantalla de gasolina 98
    FuelDiesel(),       // Pantalla de Diesel
    Center(child: Text("Pantalla de información (próximamente)", style: TextStyle(fontSize: 18))),
  ];

  // Cuando se hace clic en un ítem del BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  // Cambiar el índice seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            drawer: DrawerNav(),

      // AppBar constante
      appBar: UpNav(),
      
      // Body que cambia dependiendo de la opción seleccionada
      body: _screens[_selectedIndex],
      
      // BottomNavigationBar constante
      bottomNavigationBar: BottomNavMenu(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
