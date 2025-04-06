import 'package:ahorra_gas/components/nav/bottom_nav.dart';
import 'package:ahorra_gas/components/nav/up_nav.dart';
import 'package:flutter/material.dart';

class FuelDiesel extends StatefulWidget {
  const FuelDiesel({super.key});

  @override
  State<FuelDiesel> createState() => _FuelDieselState();
}

class _FuelDieselState extends State<FuelDiesel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UpNav(),
      body: Center(child: Text("Hola diesel")),
      bottomNavigationBar: BottomNavMenu(),
    );
  }
}
