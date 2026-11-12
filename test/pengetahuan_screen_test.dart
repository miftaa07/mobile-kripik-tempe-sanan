import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kampung_keripik_tempe/features/pengetahuan/data_sources/knowledge_local_data_source.dart';
import 'package:kampung_keripik_tempe/features/pengetahuan/views/pengetahuan_screen.dart';
import 'package:kampung_keripik_tempe/features/navigation/widgets/bottom_navbar.dart';

void main() {
  testWidgets('kartu eksplorasi membuka halaman informasinya', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    var selectedTab = -1;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PengetahuanScreen(
            onNavigateTab: (index) => selectedTab = index,
          ),
        ),
      ),
    );

    final scrollable = find.byType(Scrollable).first;
    for (final article in knowledgeArticles) {
      final card = find.text(article.title).first;
      await tester.scrollUntilVisible(card, 250, scrollable: scrollable);
      await tester.tap(card);
      await tester.pumpAndSettle();

      if (article.title == 'Sejarah Kampung Sanan') {
        expect(find.text(article.title), findsOneWidget);
        expect(find.text('Jejak Transformasi'), findsOneWidget);
        expect(find.byType(BottomNavbar), findsOneWidget);
        await tester.scrollUntilVisible(
          find.text('Tahukah Anda?'),
          250,
          scrollable: find.byType(Scrollable).first,
        );
        expect(find.text('Tahukah Anda?'), findsOneWidget);
        await tester.drag(
          find.byType(CustomScrollView).last,
          const Offset(0, 1000),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byTooltip('Kembali'));
        await tester.pumpAndSettle();
      } else if (article.title == 'Pengetahuan tentang Tempe') {
        expect(find.text('Pengetahuan Tempe'), findsOneWidget);
        expect(
          find.text('Mengenal Tempe: Superfood Tradisional Asli Indonesia'),
          findsOneWidget,
        );
        expect(find.text('3 Khasiat Utama untuk Tubuh'), findsOneWidget);
        expect(find.text(article.sections.first.title), findsOneWidget);
        expect(find.byType(BottomNavbar), findsOneWidget);
        await tester.tap(find.byTooltip('Kembali'));
        await tester.pumpAndSettle();
      } else if (article.title == 'Proses Pembuatan Keripik Tempe') {
        expect(find.text('Proses Pembuatan'), findsOneWidget);
        expect(find.text('Tahapan Pengolahan'), findsOneWidget);
        expect(find.text('5 Langkah Inti'), findsOneWidget);
        await tester.scrollUntilVisible(
          find.text('Rahasia Kerenyahan Sanan'),
          250,
          scrollable: find.byType(Scrollable).first,
        );
        expect(find.text('Rahasia Kerenyahan Sanan'), findsOneWidget);
        expect(find.text(article.sections.last.title), findsOneWidget);
        expect(find.byType(BottomNavbar), findsOneWidget);
        await tester.drag(
          find.byType(CustomScrollView).last,
          const Offset(0, 1200),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byTooltip('Kembali'));
        await tester.pumpAndSettle();
      } else if (article.title == 'Fakta & Informasi Tempe') {
        expect(find.text('Fakta Tempe'), findsOneWidget);
        expect(
          find.text('Fakta Menarik Seputar Tempe & Kampung Sanan'),
          findsOneWidget,
        );
        expect(find.text('Tahukah Anda?'), findsOneWidget);
        expect(find.text(article.sections.first.title), findsOneWidget);
        expect(find.byType(BottomNavbar), findsOneWidget);
        await tester.scrollUntilVisible(
          find.text('Tips Menyimpan Keripik Tempe'),
          250,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.scrollUntilVisible(
          find.text('Ingin Mencicipi Langsung?'),
          250,
          scrollable: find.byType(Scrollable).first,
        );
        expect(find.text('Ingin Mencicipi Langsung?'), findsOneWidget);
        await tester.tap(find.text('Jelajahi Toko Sanan'));
        await tester.pumpAndSettle();
        expect(selectedTab, 1);
      } else {
        expect(find.text(article.title), findsNWidgets(2));
        expect(find.text(article.sections.first.title), findsOneWidget);
        await tester.tap(find.byTooltip('Kembali'));
        await tester.pumpAndSettle();
      }
    }
  });
}
