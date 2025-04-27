import 'package:flutter/material.dart';

class GasStationLogoMarker extends StatelessWidget {
  final String logoPath; // Ruta del logo de la gasolinera
  final double size; // Tamaño de la burbuja
  final Color backgroundColor; // Color de fondo de la burbuja

  const GasStationLogoMarker({
    Key? key,
    required this.logoPath,
    this.size = 40.0,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size / 2), // Esto crea la forma redonda
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          logoPath, // Ruta del logo de la gasolinera
          fit: BoxFit.cover, // Ajuste para que la imagen ocupe todo el espacio sin distorsionarse
        ),
      ),
    );
  }
}
