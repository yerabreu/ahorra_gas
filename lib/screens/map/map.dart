import 'package:flutter/material.dart';
import 'package:ahorra_gas/components/station/gas_station.dart';
import 'package:ahorra_gas/components/station/gas_station_api.dart';
import 'package:ahorra_gas/components/ubication/my_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentPosition;
  List<GasStation> _stations = [];
  GasStation? _selectedStation;

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
      // ignore: deprecated_member_use
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

  String _getLogoPath(String stationName) {
    String firstWord = stationName.split(' ').first.toLowerCase().trim();
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
    return logoMapping[firstWord] ?? 'lib/assets/gaslogo/default.png';
  }

  void _showStationInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Ajusta el tamaño al contenido
      backgroundColor: Colors.transparent, // Fondo transparente para el contenedor
      builder: (BuildContext context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0), // Padding más pequeño
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ajustar al contenido
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedStation!.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text("Gasolina 95: ${_selectedStation!.fuelPrice95} €/L"),
                Text("Gasolina 98: ${_selectedStation!.fuelPrice98} €/L"),
                Text("Diésel: ${_selectedStation!.fuelPriceDiesel} €/L"),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cerrar el bottomSheet
                  },
                  child: const Text("Cerrar", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        );
      },
    );
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
                        width: 40,
                        height: 40,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedStation = station;
                            });
                            _showStationInfo(context); // Mostrar el modal
                          },
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.asset(
                                _getLogoPath(station.name),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
    );
  }
}
