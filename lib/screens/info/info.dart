import 'package:flutter/material.dart';
import 'package:ahorra_gas/color/color_app.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 20),
            Text(
              '¿Qué es AhorraGas?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorApp.letterColorMenu,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'AhorraGas es una aplicación móvil que permite a los usuarios encontrar las gasolineras más cercanas '
              'y comparar precios de combustible para ahorrar dinero y tiempo.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Proyecto Académico',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorApp.letterColorMenu,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Esta app ha sido desarrollada como parte de un proyecto de fin de curso para el Ciclo Formativo de '
              'Grado Superior en Desarrollo de Aplicaciones Multiplataforma (DAM).',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Objetivos del Proyecto',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorApp.letterColorMenu,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• Aprender a trabajar con APIs y geolocalización.\n'
              '• Aplicar conceptos de arquitectura de apps Flutter.\n'
              '• Desarrollar una aplicación funcional y útil para la sociedad.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '¡Gracias por usar AhorraGas!',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
