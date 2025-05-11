import 'package:flutter/material.dart';
import 'package:ahorra_gas/components/ubication/my_location.dart';
import 'package:ahorra_gas/components/nav/main_nav.dart';
import 'package:ahorra_gas/color/color_app.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = false;

  Future<void> _handleStart() async {
    setState(() {
      _isLoading = true;
    });

    bool permiso = await checkAndRequestLocationPermission();

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (permiso) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavScreen()),
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            color: const Color.fromARGB(101, 131, 133, 134),
            child: Lottie.asset(
              'lib/assets/img/fuel_level_indicator.json',
              fit: BoxFit.cover,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.colorButton,
                  foregroundColor: ColorApp.letterColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : const Text(
                        '¡Empieza ahorrar!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
                    const Spacer(),

        ],
      ),
    );
  }
}
