import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kampung_keripik_tempe/screens/lokasi/lokasi_screen.dart';

void main() {
  testWidgets('shows the Kampung Sanan location guide', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LokasiScreen()));

    expect(find.text('Lokasi'), findsOneWidget);
    expect(find.text('Gerbang Gapura Sanan'), findsOneWidget);
    expect(find.text('Buka Rute Menuju Kampung Sanan'), findsOneWidget);
    expect(find.text('Dari Terminal Arjosari'), findsOneWidget);
    expect(find.text('Pukul 08.00 – 16.00 WIB'), findsOneWidget);
  });
}
