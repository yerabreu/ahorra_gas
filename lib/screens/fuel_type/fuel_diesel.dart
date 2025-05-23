import 'package:ahorra_gas/color/color_app.dart';
import 'package:ahorra_gas/components/station/gas_station.dart';
import 'package:ahorra_gas/components/station/gas_station_api.dart';
import 'package:ahorra_gas/components/ubication/my_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ahorra_gas/components/station/gas_station_cache.dart'; // Importa la clase de caché

class FuelDiesel extends StatefulWidget {
  const FuelDiesel({super.key});

  @override
  State<FuelDiesel> createState() => _FuelDieselState();
}

class _FuelDieselState extends State<FuelDiesel> {
  List<GasStation> _stations = [];
  bool _isLoading = true;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _loadStations();  // Llama a _loadStations() al iniciar
  }

  // Carga las estaciones desde el caché o API
  Future<void> _loadStations() async {
    final cache = GasStationCache();

    // Si las estaciones están guardadas en caché, las carga directamente
    if (cache.cachedStations != null && cache.cachedStations!.isNotEmpty) {
      setState(() {
        _stations = cache.cachedStations!;
        _isLoading = false;
      });
      return; // Si tienes datos en caché, no es necesario hacer otra solicitud
    }

    // Si no hay caché, obtiene la ubicación actual y luego las estaciones
    await _loadCurrentLocation();
  }

  // Obtiene la ubicación actual del usuario
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

    // Actualiza el estado solo si el widget está montado
    if (mounted) {
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _isLoading = true;
      });
    }

    await _loadGasStations();
  }

  // Carga las estaciones de gasolina desde la API
  Future<void> _loadGasStations() async {
    if (_latitude == null || _longitude == null) return;

    try {
      int? municipioId = await getMunicipioId(_latitude!, _longitude!);

      if (municipioId != null) {
        List<GasStation> estaciones = await getGasStations(municipioId);

        // Ordena las estaciones por el precio del diésel
        estaciones.sort((a, b) => a.fuelPriceDiesel.compareTo(b.fuelPriceDiesel));

        final cache = GasStationCache();
        cache.cachedStations = estaciones; // Guarda las estaciones en caché
        cache.cachedMunicipioId = municipioId;
        cache.lastLatitude = _latitude;
        cache.lastLongitude = _longitude;

        if (mounted) {
          setState(() {
            _stations = estaciones;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar las estaciones: $e')),
      );
    }
  }

  // Obtiene la ruta del logo según el nombre de la estación
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
            child: Text("Diésel", style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())  // Muestra el indicador de carga
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
                            'Precio Diésel: ${station.fuelPriceDiesel} €/L',
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
