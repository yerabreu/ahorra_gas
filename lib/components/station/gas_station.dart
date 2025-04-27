class GasStation {
  final String name;
  final double latitude;
  final double longitude;
  final String fuelPrice;

  GasStation({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.fuelPrice,
  });

  factory GasStation.fromJson(Map<String, dynamic> json) {
    return GasStation(
      name: json['nombreEstacion'] ?? 'N/A',
      latitude: double.tryParse(json['latitud'].replaceAll(',', '.')) ?? 0,
      longitude: double.tryParse(json['longitud'].replaceAll(',', '.')) ?? 0,
      fuelPrice: json['Gasolina95'] ?? 'N/A',
    );
  }
}
