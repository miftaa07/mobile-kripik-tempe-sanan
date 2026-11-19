import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:kampung_keripik_tempe/core/di/app_dependencies.dart';
import 'package:kampung_keripik_tempe/features/toko/repositories/product_repository.dart';
import 'package:kampung_keripik_tempe/features/toko/views/toko_detail_screen.dart';

void main() {
  testWidgets('detail toko menampilkan informasi dan katalog', (tester) async {
    final mockClient = MockClient((request) async {
      return http.Response(
        jsonEncode({
          'success': true,
          'message': 'Data produk berhasil diambil',
          'data': [],
        }),
        200,
        headers: {'content-type': 'application/json'},
      );
    });

    final dependencies = AppDependencies(
      externalLinkLauncher: AppDependencies.instance.externalLinkLauncher,
      productRepository: ProductRepository(client: mockClient),
      tokoRepository: AppDependencies.instance.tokoRepository,
      homeRepository: AppDependencies.instance.homeRepository,
      knowledgeRepository: AppDependencies.instance.knowledgeRepository,
      locationRepository: AppDependencies.instance.locationRepository,
      recommendationRepository:
          AppDependencies.instance.recommendationRepository,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: TokoDetailScreen(
          nama: 'Toko Sanan Jaya',
          gambar: 'assets/images/toko_rohani.jpg',
          alamat: 'Jl. Sanan No. 12, Malang',
          jamBuka: '07.00 - 21.00 WIB',
          deskripsi: 'Toko keripik tempe khas Sanan.',
          dependencies: dependencies,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Detail Toko'), findsOneWidget);
    expect(find.text('Toko Sanan Jaya'), findsOneWidget);
    expect(find.text('Hubungi Toko via WhatsApp'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Katalog Produk & Harga'),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    await tester.pumpAndSettle();

    expect(find.text('Katalog Produk & Harga'), findsOneWidget);
    expect(
      find.text('Daftar produk langsung dari etalase toko'),
      findsOneWidget,
    );

    mockClient.close();
  });
}
