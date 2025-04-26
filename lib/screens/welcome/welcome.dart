import 'package:flutter/material.dart';
import 'package:ahorra_gas/components/ubication/my_location.dart';
import 'package:ahorra_gas/components/nav/main_nav.dart';
import 'package:ahorra_gas/color/color_app.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<void> _handleStart(BuildContext context) async {
    bool permiso = await checkAndRequestLocationPermission();

    if (permiso) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Se necesitan permisos de ubicación')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.principalColor,
        foregroundColor: ColorApp.letterColor,
        toolbarHeight: 230,
        flexibleSpace: Center(
          child: Image.asset(
            'lib/assets/img/logo.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  color: const Color.fromARGB(255, 73, 0, 0),
                  child: Image.asset(
                    'lib/assets/img/gasprice.gif',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Center(
                    child: Material(
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: FloatingActionButton(
                          onPressed: () => _handleStart(context),
                          heroTag: 'principal',
                          backgroundColor: ColorApp.colorButton,
                          foregroundColor: ColorApp.letterColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            '¡Empieza ahorrar!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
