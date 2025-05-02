import 'package:flutter/material.dart';
import 'package:ahorra_gas/components/station/gas_station.dart';
import 'package:ahorra_gas/components/station/gas_station_api.dart';
import 'package:ahorra_gas/components/ubication/my_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ahorra_gas/components/station/gas_station_logo_maker.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentPosition;
  List<GasStation> _stations = [];

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  Future<void> _loadCurrentLocation() async {
    bool permiso = await checkAndRequestLocationPermission();

    if (!permiso) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permiso de ubicación denegado')),
        );
      }
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    await _loadGasStations();
  }

  Future<void> _loadGasStations() async {
    if (_currentPosition == null) return;

    final lat = _currentPosition!.latitude;
    final lon = _currentPosition!.longitude;

    int? municipioId = await getMunicipioId(lat, lon);
    if (municipioId != null) {
      List<GasStation> estaciones = await getGasStations(municipioId);
      setState(() {
        _stations = estaciones;
      });
    }
  }

  // Mejorado para buscar el logo según la primera palabra del nombre de la estación
  String _getLogoPath(String stationName) {
    // Extraemos la primera palabra del nombre
    String firstWord = stationName.split(' ').first.toLowerCase().trim();

    // Mapa de gasolineras con la primera palabra como clave
    Map<String, String> logoMapping = {
      'bp': 'lib/assets/gaslogo/bp.png',
      'cepsa': 'lib/assets/gaslogo/cepsa.jpg',
      'disa': 'lib/assets/gaslogo/disa.jpeg',
      'pcan': 'lib/assets/gaslogo/pcan.jpeg',
      'repsol': 'lib/assets/gaslogo/repsol.jpeg',
      'shell': 'lib/assets/gaslogo/shell.png',
      'canary': 'lib/assets/gaslogo/canaryoil.png',
      'tgas': 'lib/assets/gaslogo/tgas.jpg',
    };

    // Devolvemos el logo correspondiente o un logo por defecto
    return logoMapping[firstWord] ?? 'lib/assets/gaslogo/default.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter: _currentPosition!,
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentPosition!,
                      width: 60,
                      height: 60,
                      child: const Icon(Icons.location_on, size: 40, color: Colors.red),
                    ),
                    ..._stations.map((station) {
                      return Marker(
                        point: LatLng(station.latitude, station.longitude),
                        width: 40, // Tamaño ajustado del marcador
                        height: 40, // Tamaño ajustado del marcador
                        child: Tooltip(
                          message: '${station.name}\n${station.fuelPrice} €/L',
                          child: CircleAvatar(
                            radius: 25.0, // Radio ajustado para el círculo
                            backgroundColor: Colors.white, // Fondo blanco del círculo
                            child: ClipOval(
                              child: Image.asset(
                                _getLogoPath(station.name),
                                fit: BoxFit.contain, // Ajuste para mantener la imagen sin distorsión
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
    );
  }
}
