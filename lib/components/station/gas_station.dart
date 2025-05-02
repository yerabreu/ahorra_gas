class GasStation {
  final String name;
  final double latitude;
  final double longitude;
  final String fuelPrice95;
  final String fuelPrice98;
  final String fuelPriceDiesel;

  GasStation({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.fuelPrice95,
    required this.fuelPrice98,
    required this.fuelPriceDiesel,
  });

  factory GasStation.fromJson(Map<String, dynamic> json) {
    return GasStation(
      name: json['nombreEstacion'] ?? 'N/A',
      latitude: double.tryParse(json['latitud'].replaceAll(',', '.')) ?? 0,
      longitude: double.tryParse(json['longitud'].replaceAll(',', '.')) ?? 0,
      fuelPrice95: json['Gasolina95'] ?? 'N/A',
      fuelPrice98: json['Gasolina98'] ?? 'N/A',
      fuelPriceDiesel: json['Diesel'] ?? 'N/A',
    );
  }
}
