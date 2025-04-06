import 'package:ahorra_gas/color/color_app.dart';
import 'package:flutter/material.dart';

class WidgetFuelType extends StatefulWidget {
  const WidgetFuelType({
    super.key,
    required this.title,
    required this.iconPath,
  });
  final String title;
  final String iconPath;

  @override
  State<WidgetFuelType> createState() => _WidgetFuelTypeState();
}

class _WidgetFuelTypeState extends State<WidgetFuelType> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: ColorApp.principalColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),
          child: Center(
            child: Image.asset(
              widget.iconPath,
              width: 80, // Tamaño ajustado de la imagen (más pequeña)
              height: 80, // Tamaño ajustado de la imagen (más pequeña)
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          width: 120,
          decoration: BoxDecoration(
            color: ColorApp.colorButton,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
          ),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: ColorApp.letterColorMenu,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
