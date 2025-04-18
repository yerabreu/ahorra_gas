import 'package:ahorra_gas/components/nav/up_nav.dart';
import 'package:flutter/material.dart';

class FuelNintyFive extends StatefulWidget {
  const FuelNintyFive({super.key});

  @override
  State<FuelNintyFive> createState() => _FuelNintyFiveState();
}

class _FuelNintyFiveState extends State<FuelNintyFive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UpNav(),
      body: Center(child: Text("Hola 95")),
    );
  }
}
