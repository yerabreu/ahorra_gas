import 'package:ahorra_gas/components/nav/drawer_nav.dart';
import 'package:ahorra_gas/components/nav/up_nav.dart';
import 'package:ahorra_gas/components/fuel/widget_fuel_type.dart';
import 'package:ahorra_gas/color/color_app.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_diesel.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_ninty_eight.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_ninty_five.dart';
import 'package:flutter/material.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: DrawerNav(),
      appBar: UpNav(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset("lib/assets/img/gas_station.jpg", fit: BoxFit.cover,),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '  Escoge el tipo de combustible:',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: ColorApp.letterColorMenu,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        FuelNintyFive(), // Cambia a la pantalla de inicio
                              ),
                            );
                          },
                          child: WidgetFuelType(title: "Gasolina 95", iconPath: 'lib/assets/icons/hose.png',),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        FuelNintyEight(), // Cambia a la pantalla de inicio
                              ),
                            );
                          },
                          child: WidgetFuelType(title: "Gasolina 98", iconPath:'lib/assets/icons/pump.png'),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        FuelDiesel(), // Cambia a la pantalla de inicio
                              ),
                            );
                          },
                          child: WidgetFuelType(title: "Diésel", iconPath:'lib/assets/icons/gallon.png'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    Text(
                      'Gasolineras cerda de ti :',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: ColorApp.letterColorMenu,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: ColorApp.principalColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Gasolineras cerda de ti :',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: ColorApp.letterColorMenu,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
