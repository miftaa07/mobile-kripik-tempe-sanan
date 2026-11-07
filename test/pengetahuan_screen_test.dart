import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kampung_keripik_tempe/models/knowledge_article.dart';
import 'package:kampung_keripik_tempe/screens/pengetahuan/pengetahuan_screen.dart';

void main() {
  testWidgets('kartu eksplorasi membuka halaman informasinya', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: PengetahuanScreen())),
    );

    final scrollable = find.byType(Scrollable).first;
    for (final article in knowledgeArticles) {
      final card = find.text(article.title).first;
      await tester.scrollUntilVisible(card, 250, scrollable: scrollable);
      await tester.tap(card);
      await tester.pumpAndSettle();

      expect(find.text(article.title), findsNWidgets(2));
      expect(find.text(article.sections.first.title), findsOneWidget);

      await tester.tap(find.byTooltip('Kembali'));
      await tester.pumpAndSettle();
    }
  });
}
