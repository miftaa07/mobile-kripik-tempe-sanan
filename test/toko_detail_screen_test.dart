import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kampung_keripik_tempe/features/toko/views/toko_detail_screen.dart';

void main() {
  testWidgets('detail toko menampilkan informasi dan katalog', (tester) async {
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

    // Tunggu proses rendering awal.
    await tester.pump();

    // Memastikan informasi toko tampil.
    expect(find.text('Detail Toko'), findsOneWidget);
    expect(find.text('Toko Sanan Jaya'), findsOneWidget);
    expect(find.text('Hubungi Toko via WhatsApp'), findsOneWidget);

    // Scroll sampai bagian katalog terlihat.
    await tester.scrollUntilVisible(
      find.text('Katalog Produk & Harga'),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    await tester.pump();

    // Memastikan katalog tampil.
    expect(find.text('Katalog Produk & Harga'), findsOneWidget);
    expect(
      find.text('Daftar produk langsung dari etalase toko'),
      findsOneWidget,
    );
  });
}
