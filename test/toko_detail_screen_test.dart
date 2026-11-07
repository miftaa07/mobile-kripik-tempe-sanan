import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kampung_keripik_tempe/screens/toko/toko_detail_screen.dart';

void main() {
  testWidgets('detail toko menampilkan informasi dan katalog produk', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TokoDetailScreen(
          nama: 'Toko Sanan Jaya',
          gambar: 'assets/images/toko_rohani.jpg',
          alamat: 'Jl. Sanan No. 12, Malang',
          jamBuka: '07.00 - 21.00 WIB',
          deskripsi: 'Toko keripik tempe khas Sanan.',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Detail Toko'), findsOneWidget);
    expect(find.text('Toko Sanan Jaya'), findsOneWidget);
    expect(find.text('Hubungi Toko via WhatsApp'), findsOneWidget);

    final scrollable = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(
      find.text('Katalog Produk & Harga'),
      300,
      scrollable: scrollable,
    );
    expect(find.text('Katalog Produk & Harga'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Keripik Tempe Original'),
      300,
      scrollable: scrollable,
    );
    expect(find.text('Keripik Tempe Original'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Hampers Spesial Sanan'),
      300,
      scrollable: scrollable,
    );
    expect(find.text('Hampers Spesial Sanan'), findsOneWidget);
    expect(find.text('Rp 50.000'), findsOneWidget);
  });
}
