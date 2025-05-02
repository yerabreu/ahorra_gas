import 'package:ahorra_gas/color/color_app.dart';
import 'package:ahorra_gas/components/ubication/my_location.dart';
import 'package:flutter/material.dart';
import 'package:ahorra_gas/components/station/gas_station.dart';
import 'package:ahorra_gas/components/station/gas_station_api.dart';
import 'package:geolocator/geolocator.dart';

class FuelNintyFive extends StatefulWidget {
  const FuelNintyFive({super.key});

  @override
  _FuelNintyFiveState createState() => _FuelNintyFiveState();
}

class _FuelNintyFiveState extends State<FuelNintyFive> {
  List<GasStation> _stations = [];
  bool _isLoading = true;
  double? _latitude;
  double? _longitude;

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
      _latitude = position.latitude;
      _longitude = position.longitude;
      _isLoading = true; 
    });

    await _loadGasStations();
  }

  Future<void> _loadGasStations() async {
    if (_latitude == null || _longitude == null) return;

    try {
      int? municipioId = await getMunicipioId(_latitude!, _longitude!);

      if (municipioId != null) {
        List<GasStation> estaciones = await getGasStations(municipioId);

        estaciones.sort((a, b) => a.fuelPrice95.compareTo(b.fuelPrice95));

        setState(() {
          _stations = estaciones;
          _isLoading = false; 
        });
      } else {
        setState(() {
          _isLoading = false; 
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar las estaciones: $e')),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorApp.principalColor,
        foregroundColor: ColorApp.letterColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: Text("Gasolina 95", style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) 
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _stations.length,
                itemBuilder: (context, index) {
                  final station = _stations[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      leading: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage(
                          _getLogoPath(station.name),
                        ),
                      ),
                      title: Text(station.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Precio Gasolina 95: ${station.fuelPrice95} €/L',
                          ),
                          Text('Dirección: ${station.direction}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
