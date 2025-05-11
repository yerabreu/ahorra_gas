import 'package:ahorra_gas/components/station/gas_station.dart';

class GasStationCache {
  static final GasStationCache _instance = GasStationCache._internal();

  factory GasStationCache() => _instance;

  GasStationCache._internal();

  List<GasStation>? cachedStations;
  int? cachedMunicipioId;
  double? lastLatitude;
  double? lastLongitude;
  DateTime? cacheTimestamp; // Fecha en la que se actualizó la caché.

  // Umbral para validar la caché, por defecto 0.01 (aproximadamente 10m)
  double cacheThreshold = 0.01;

  // Puedes actualizar el umbral de validación de la caché, si es necesario.
  void updateCacheThreshold(double newThreshold) {
    cacheThreshold = newThreshold;
  }

  // Determinar si la caché es válida para las coordenadas dadas
  bool isCacheValid(double lat, double lon) {
    if (cachedStations == null || cachedStations!.isEmpty) {
      print("Cache está vacío.");
      return false;
    }

    if (lastLatitude == null || lastLongitude == null) {
      print("Coordenadas no válidas en la caché.");
      return false;
    }

    // Verificamos si la diferencia entre las coordenadas actuales y las de la caché es aceptable
    bool validLat = (lat - lastLatitude!).abs() < cacheThreshold;
    bool validLon = (lon - lastLongitude!).abs() < cacheThreshold;

    if (!validLat || !validLon) {
      print("Las coordenadas no son suficientemente cercanas para considerar la caché válida.");
    }

    return validLat && validLon;
  }

  // Método para verificar si la caché está caducada (opcional)
  bool isCacheExpired({int expirationMinutes = 30}) {
    if (cacheTimestamp == null) return true;
    final expirationDuration = Duration(minutes: expirationMinutes);
    return DateTime.now().isAfter(cacheTimestamp!.add(expirationDuration));
  }

  // Método para "resetear" la caché, útil cuando necesitamos limpiar los datos guardados
  void clearCache() {
    cachedStations = null;
    cachedMunicipioId = null;
    lastLatitude = null;
    lastLongitude = null;
    cacheTimestamp = null;
    print("Cache limpiada.");
  }

  // Método para actualizar la caché con los nuevos datos
  void updateCache(
      List<GasStation> newStations, double lat, double lon, int municipioId) {
    cachedStations = newStations;
    lastLatitude = lat;
    lastLongitude = lon;
    cachedMunicipioId = municipioId;
    cacheTimestamp = DateTime.now();
    print("Cache actualizada.");
  }

  // Método para obtener la caché de las estaciones de gasolina, si es válida.
  List<GasStation>? getStationsIfValid(double lat, double lon) {
    if (isCacheValid(lat, lon) && !isCacheExpired()) {
      return cachedStations;
    }
    return null;
  }
}
