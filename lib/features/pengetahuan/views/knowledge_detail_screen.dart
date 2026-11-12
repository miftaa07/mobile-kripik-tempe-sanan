import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../models/knowledge_article.dart';
import 'fakta_informasi_tempe_screen.dart';
import 'pengetahuan_tempe_screen.dart';
import 'proses_pembuatan_screen.dart';
import 'sejarah_sanan_screen.dart';

class KnowledgeDetailScreen extends StatelessWidget {
  final KnowledgeArticle article;
  final ValueChanged<int>? onNavigateTab;

  const KnowledgeDetailScreen({
    super.key,
    required this.article,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    final page = switch (article.title) {
      'Sejarah Kampung Sanan' => SejarahSananScreen(
        article: article,
        onNavigateTab: onNavigateTab,
      ),
      'Pengetahuan tentang Tempe' => PengetahuanTempeScreen(
        article: article,
        onNavigateTab: onNavigateTab,
      ),
      'Proses Pembuatan Keripik Tempe' => ProsesPembuatanScreen(
        article: article,
        onNavigateTab: onNavigateTab,
      ),
      'Fakta & Informasi Tempe' => FaktaInformasiTempeScreen(
        article: article,
        onNavigateTab: onNavigateTab,
      ),
      _ => null,
    };
    if (page != null) return page;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildHero()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              sliver: SliverList.list(
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 24,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.introduction,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.65,
                      color: AppTheme.textGrey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  for (final section in article.sections) ...[
                    _ArticleSection(section: section),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, [String title = 'Pengetahuan']) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 20, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.primary,
            tooltip: 'Kembali',
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset(
              'assets/images/kampung_sanan.jpg',
              height: 210,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              height: 90,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xB8000000)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Color(0xFFFFD35D),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Text(
                      article.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticleSection extends StatelessWidget {
  final KnowledgeSection section;

  const _ArticleSection({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFE5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            section.body,
            style: const TextStyle(
              fontSize: 13,
              height: 1.6,
              color: AppTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
