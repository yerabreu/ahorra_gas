import 'package:flutter/material.dart';

class GasStationLogoMarker extends StatelessWidget {
  final String logoPath; 
  final double size; 
  final Color backgroundColor; 
  const GasStationLogoMarker({
    super.key,
    required this.logoPath,
    this.size = 40.0,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size / 2), 
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          logoPath, 
          fit: BoxFit.cover, 
        ),
      ),
    );
  }
}
