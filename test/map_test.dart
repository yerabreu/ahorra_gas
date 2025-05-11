import 'package:ahorra_gas/components/ubication/my_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:geolocator/geolocator.dart'; 

class MockGeolocator extends Mock implements GeolocatorPlatform {}

void main() {
  testWidgets('Test de obtener ubicación en MyLocation', (WidgetTester tester) async {
    final mockGeolocator = MockGeolocator();

    when(mockGeolocator.getCurrentPosition()).thenAnswer(
      (_) async => Position(
        latitude: 40.7128,
        longitude: -74.0060,
        timestamp: DateTime.now(),
        accuracy: 10,
        altitude: 0,
        heading: 0,
        speed: 0,
        altitudeAccuracy: 5,
        headingAccuracy: 5,
        speedAccuracy: 5,
      ),
    );

    GeolocatorPlatform.instance = mockGeolocator;

    await tester.pumpWidget(
      MaterialApp(
        home: MyLocation(),  
      ),
    );

    expect(find.text(''), findsOneWidget);

    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); 

    expect(find.text('Latitud: 40.7128, Longitud: -74.0060'), findsOneWidget);
  });
}
