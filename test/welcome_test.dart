import 'package:ahorra_gas/components/nav/main_nav.dart';
import 'package:ahorra_gas/components/ubication/my_location.dart' as mockLocationService;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ahorra_gas/screens/welcome/welcome.dart';
import 'package:mockito/mockito.dart';

class LocationService {
  Future<bool> checkAndRequestLocationPermission() async {
    return true;
  }
}

class MockLocationService extends Mock implements LocationService {}

void main() {
  testWidgets('Test de WelcomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: WelcomeScreen()));

    expect(find.text('¡Empieza ahorrar!'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    when(mockLocationService.checkAndRequestLocationPermission()).thenAnswer((_) async => true);

    await tester.pumpAndSettle();
    
    expect(find.byType(MainNavScreen), findsOneWidget);
  });
}
