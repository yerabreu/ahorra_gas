import 'package:flutter_test/flutter_test.dart';
import 'package:ahorra_gas/components/station/gas_station.dart';

void main() {
  group('GasStation', () {
    test('GasStation fromJson should create a valid instance from JSON', () {
      final json = {
        'nombreEstacion': 'Repsol',
        'latitud': '40.416775',
        'longitud': '-3.703790',
        'Gasolina95': '1.35',
        'Gasolina98': '1.45',
        'Diesel': '1.20',
        'direccion': 'Calle Falsa 123'
      };

      final station = GasStation.fromJson(json);

      expect(station.name, 'Repsol');
      expect(station.latitude, 40.416775);
      expect(station.longitude, -3.703790);
      expect(station.fuelPrice95, '1.35');
      expect(station.fuelPrice98, '1.45');
      expect(station.fuelPriceDiesel, '1.20');
      expect(station.direction, 'Calle Falsa 123');
    });

    test('GasStation fromJson should handle missing fields', () {
      final json = {
        'nombreEstacion': 'Cepsa',
        'latitud': '40.416775',
        'longitud': '-3.703790',
        'direccion': 'Calle Real 456',
      };

      final station = GasStation.fromJson(json);

      expect(station.name, 'Cepsa');
      expect(station.latitude, 40.416775);
      expect(station.longitude, -3.703790);
      expect(station.fuelPrice95, 'N/A'); 
      expect(station.fuelPrice98, 'N/A'); 
      expect(station.fuelPriceDiesel, 'N/A'); 
      expect(station.direction, 'Calle Real 456');
    });

    test('GasStation fromJson should handle invalid latitude and longitude', () {
      final json = {
        'nombreEstacion': 'Shell',
        'latitud': 'invalid_lat',
        'longitud': 'invalid_lon',
        'Gasolina95': '1.50',
        'Gasolina98': '1.60',
        'Diesel': '1.40',
        'direccion': 'Avenida Libertad 789'
      };

      final station = GasStation.fromJson(json);

      expect(station.name, 'Shell');
      expect(station.latitude, 0); 
      expect(station.longitude, 0); 
      expect(station.fuelPrice95, '1.50');
      expect(station.fuelPrice98, '1.60');
      expect(station.fuelPriceDiesel, '1.40');
      expect(station.direction, 'Avenida Libertad 789');
    });
  });
}
