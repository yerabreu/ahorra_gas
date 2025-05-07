import 'package:ahorra_gas/components/station/gas_station.dart';

class GasStationCache {
  static final GasStationCache _instance = GasStationCache._internal();

  factory GasStationCache() => _instance;

  GasStationCache._internal();

  List<GasStation>? cachedStations;
  int? cachedMunicipioId;
  double? lastLatitude;
  double? lastLongitude;

  bool isCacheValid(double lat, double lon) {
    const double threshold = 0.01; // Rango de diferencia aceptable para evitar recarga
    if (cachedStations == null) return false;
    if (lastLatitude == null || lastLongitude == null) return false;
    return (lat - lastLatitude!).abs() < threshold && (lon - lastLongitude!).abs() < threshold;
  }
}