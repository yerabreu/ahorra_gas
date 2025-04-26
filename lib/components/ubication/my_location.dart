import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// Función global para verificar y solicitar permisos de ubicación
Future<bool> checkAndRequestLocationPermission() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return false;

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return false;
  }

  if (permission == LocationPermission.deniedForever) return false;

  return true;
}

class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  String _locationMessage = "";

  // Obtener ubicación solo si se tienen permisos
  Future<void> _getLocation() async {
    bool hasPermission = await checkAndRequestLocationPermission();

    if (!hasPermission) {
      setState(() {
        _locationMessage = "Permisos de ubicación no concedidos.";
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _locationMessage =
          "Latitud: ${position.latitude}, Longitud: ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Obtener Ubicación')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_locationMessage),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getLocation,
              child: const Text('Obtener Ubicación'),
            ),
          ],
        ),
      ),
    );
  }
}
