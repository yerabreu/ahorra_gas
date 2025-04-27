import 'dart:convert';
import 'package:ahorra_gas/components/station/gas_station.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart' as geo;

// Función para obtener el municipio ID usando la latitud y longitud
Future<int?> getMunicipioId(double lat, double lon) async {
  try {
    // Obtener el nombre del municipio desde las coordenadas GPS
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(lat, lon);
    String? municipioName = placemarks.first.locality;

    print("📍 Municipio detectado por geolocalización: $municipioName");

    // Realizar la petición para obtener la lista de municipios de la API
    final response = await http.get(Uri.parse("https://api.precioil.es/municipios/provincia/38"));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      
      // Mostrar los municipios obtenidos para depuración
      for (var m in data) {
        print('🗺️ Municipio en API: ${m['nombreMunicipio']}');
      }

      // Buscar el municipio usando contains para evitar problemas de coincidencias exactas
      var municipio = data.firstWhere(
        (e) => e['nombreMunicipio'].toString().toLowerCase().contains(municipioName?.toLowerCase() ?? ''),
        orElse: () => null,
      );

      if (municipio != null) {
        print("🟡 Municipio ID: ${municipio['idMunicipio']}");
        return municipio['idMunicipio'];
      } else {
        print("🔴 No se encontró municipio");
        return null;
      }
    } else {
      print("❌ Error al obtener municipio: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("❌ Error al obtener municipio: $e");
    return null;
  }
}

// Función para obtener las estaciones de gasolina por municipio
Future<List<GasStation>> getGasStations(int municipioId) async {
  try {
    final response = await http.get(Uri.parse("https://api.precioil.es/estaciones/municipio/$municipioId"));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => GasStation.fromJson(e)).toList();
    } else {
      return [];
    }
  } catch (e) {
    print("❌ Error al obtener estaciones: $e");
    return [];
  }
}
