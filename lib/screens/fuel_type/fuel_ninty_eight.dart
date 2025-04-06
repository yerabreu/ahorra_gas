import 'package:ahorra_gas/components/nav/bottom_nav.dart';
import 'package:ahorra_gas/components/nav/up_nav.dart';
import 'package:flutter/material.dart';

class FuelNintyEight extends StatefulWidget {
  const FuelNintyEight({super.key});

  @override
  State<FuelNintyEight> createState() => _FuelNintyFiveState();
}

class _FuelNintyFiveState extends State<FuelNintyEight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: UpNav(),
      body: Center(child: Text("Hola 98")),
      bottomNavigationBar: BottomNavMenu(),
    );
  }
}
