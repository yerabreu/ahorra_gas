import 'package:ahorra_gas/components/nav/drawer_nav.dart';
import 'package:ahorra_gas/components/nav/up_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Asegúrate de importar latlong2

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerNav(),
      appBar: UpNav(),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(40.7128, -74.0060), // Coordenadas iniciales
          initialZoom: 13.0, // Nivel de zoom inicial
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", // URL para los tiles de OpenStreetMap
            subdomains: ['a', 'b', 'c'], // Subdominios para las tiles
          ),
        ],
      ),
    );
  }
}
