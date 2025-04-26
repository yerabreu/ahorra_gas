import 'package:flutter/material.dart';

class FuelNintyFive extends StatelessWidget {
  const FuelNintyFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Gasolina 95", style: TextStyle(fontSize: 24)),
            // Aquí puedes añadir el contenido de esta pantalla, como más widgets
          ],
        ),
      ),
    );
  }
}
