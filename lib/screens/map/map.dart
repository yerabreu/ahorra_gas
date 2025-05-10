import 'package:flutter/material.dart';
import 'package:ahorra_gas/components/station/gas_station.dart';
import 'package:ahorra_gas/components/station/gas_station_api.dart';
import 'package:ahorra_gas/components/ubication/my_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ahorra_gas/components/station/gas_station_cache.dart';

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
      desiredAccuracy: LocationAccuracy.high,
    );

    if (!mounted) return;

    final lat = position.latitude;
    final lon = position.longitude;

    _currentPosition = LatLng(lat, lon);
    setState(() {});

    final cache = GasStationCache();

    if (cache.isCacheValid(lat, lon)) {
      _stations = cache.cachedStations!;
      setState(() {});
      return;
    }

    int? municipioId = await getMunicipioId(lat, lon);
    if (municipioId != null) {
      List<GasStation> estaciones = await getGasStations(municipioId);
      if (!mounted) return;
      _stations = estaciones;
      cache.cachedStations = estaciones;
      cache.cachedMunicipioId = municipioId;
      cache.lastLatitude = lat;
      cache.lastLongitude = lon;
      setState(() {});
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
    if (!mounted || _selectedStation == null) return;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(_selectedStation!.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Gasolina 95: ${_selectedStation!.fuelPrice95} €/L"),
              Text("Gasolina 98: ${_selectedStation!.fuelPrice98} €/L"),
              Text("Diésel: ${_selectedStation!.fuelPriceDiesel} €/L"),
              const SizedBox(height: 10),
              Text("Dirección: ${_selectedStation!.direction}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cerrar", style: TextStyle(color: Colors.red)),
            ),
          ],
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
                            if (!mounted) return;
                            setState(() {
                              _selectedStation = station;
                            });
                            _showStationInfo(context);
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
                    }).toList(),
                  ],
                ),
              ],
            ),
    );
  }
}
