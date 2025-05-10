import 'package:ahorra_gas/components/fuel/widget_fuel_type.dart';
import 'package:ahorra_gas/components/station/gas_station.dart';
import 'package:ahorra_gas/color/color_app.dart';
import 'package:ahorra_gas/components/station/gas_station_api.dart';
import 'package:ahorra_gas/components/station/gas_station_cache.dart';
import 'package:ahorra_gas/components/ubication/my_location.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_diesel.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_ninty_eight.dart';
import 'package:ahorra_gas/screens/fuel_type/fuel_ninty_five.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  bool _isLoading = false;
  List<GasStation> _stations = [];
  double? _lat, _lon;

  @override
  void initState() {
    super.initState();
    _getLocation(); // Obtener ubicación al iniciar
  }

  Future<void> _getLocation() async {
    bool hasPermission = await checkAndRequestLocationPermission();

    if (!hasPermission) {
      if (!mounted) return;
      setState(() {
        _lat = 0.0;
        _lon = 0.0;
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (!mounted) return;
    setState(() {
      _lat = position.latitude;
      _lon = position.longitude;
    });

    await _fetchGasStations(_lat!, _lon!);
  }

  Future<void> _fetchGasStations(double lat, double lon) async {
    if (!mounted) return;

    final cache = GasStationCache();

    // Comprobamos si el cache es válido. Si lo es, usamos los datos del cache.
    if (cache.isCacheValid(lat, lon)) {
      setState(() {
        _stations = cache.cachedStations!;
        _isLoading = false;
      });
      return;
    }

    // Si no es válido, cargamos los datos de la API
    setState(() {
      _isLoading = true;
    });

    int? municipioId = await getMunicipioId(lat, lon);
    if (!mounted) return;

    if (municipioId != null) {
      List<GasStation> stations = await getGasStations(municipioId);

      // Guardar en caché solo si obtenemos estaciones
      if (stations.isNotEmpty) {
        cache.cachedStations = stations;
        cache.cachedMunicipioId = municipioId;
        cache.lastLatitude = lat;
        cache.lastLongitude = lon;
      }

      // Actualizamos la UI con las estaciones obtenidas
      if (!mounted) return;
      setState(() {
        _stations = stations;
        _isLoading = false;
      });
    } else {
      // Si no encontramos el municipio o ocurre algún error
      if (!mounted) return;
      setState(() {
        _isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Image.asset(
                    "lib/assets/img/gas_station.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Escoge el tipo de combustible:',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: ColorApp.letterColorMenu,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FuelNintyFive()),
                        );
                      },
                      child: const WidgetFuelType(
                        title: "Gasolina 95",
                        iconPath: 'lib/assets/icons/hose.png',
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FuelNintyEight()),
                        );
                      },
                      child: const WidgetFuelType(
                        title: "Gasolina 98",
                        iconPath: 'lib/assets/icons/pump.png',
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FuelDiesel()),
                        );
                      },
                      child: const WidgetFuelType(
                        title: "Diésel",
                        iconPath: 'lib/assets/icons/gallon.png',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Row(
                  children: [
                    Text(
                      'Gasolineras cerca de ti:',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: ColorApp.letterColorMenu,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _stations.isEmpty
                        ? const Text("No se encontraron gasolineras.")
                        : Column(
                            children: _stations.map((station) {
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(_getLogoPath(station.name)),
                                    radius: 24,
                                  ),
                                  title: Text(
                                    station.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(station.direction),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Marca: ${station.name}',
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
