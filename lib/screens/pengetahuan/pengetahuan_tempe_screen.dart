import 'package:flutter/material.dart';

import '../../models/knowledge_article.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_navbar.dart';

class PengetahuanTempeScreen extends StatelessWidget {
  final KnowledgeArticle article;
  final ValueChanged<int>? onNavigateTab;

  const PengetahuanTempeScreen({
    super.key,
    required this.article,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF7),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(context, 'Pengetahuan Tempe'),
            ),
            SliverToBoxAdapter(child: _buildTempeHero()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
              sliver: SliverList.list(
                children: [
                  _tempeBadge(),
                  const SizedBox(height: 14),
                  const Text(
                    'Mengenal Tempe: Superfood Tradisional Asli Indonesia',
                    style: TextStyle(
                      fontSize: 23,
                      height: 1.18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF201F1F),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    article.introduction,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.62,
                      color: Color(0xFF655951),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      const Icon(
                        Icons.health_and_safety_outlined,
                        color: Color(0xFF783900),
                        size: 19,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          '3 Khasiat Utama untuk Tubuh',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF292522),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  for (
                    var index = 0;
                    index < article.sections.length;
                    index++
                  ) ...[
                    _TempeBenefitCard(
                      section: article.sections[index],
                      icon: switch (index) {
                        0 => Icons.spa_outlined,
                        1 => Icons.favorite_outline_rounded,
                        _ => Icons.shield_outlined,
                      },
                      iconBackground: switch (index) {
                        0 => const Color(0xFF8BF28D),
                        1 => const Color(0xFFFFDCCB),
                        _ => const Color(0xFFFFD9DC),
                      },
                    ),
                    if (index < article.sections.length - 1)
                      const SizedBox(height: 9),
                  ],
                  const SizedBox(height: 18),
                  _buildTempeQuote(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 2,
        onTap: (index) async {
          await Navigator.of(context).maybePop();
          onNavigateTab?.call(index);
        },
      ),
    );
  }

  Widget _buildTempeHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          height: 224,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/tempe_original.jpg',
                fit: BoxFit.cover,
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0x66000000)],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                bottom: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F2EC),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.grain, size: 13, color: Color(0xFF783900)),
                      SizedBox(width: 5),
                      Text(
                        'Fermentasi Alami Kampung Sanan',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF783900),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tempeBadge() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFF874515),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified_outlined, size: 14, color: Colors.white),
            SizedBox(width: 5),
            Text(
              'EDUKASI & GIZI',
              style: TextStyle(
                fontSize: 13,
                letterSpacing: 0.3,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTempeQuote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF874515),
        borderRadius: BorderRadius.circular(13),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.workspace_premium_outlined,
                size: 17,
                color: Color(0xFFFFD1A7),
              ),
              SizedBox(width: 7),
              Text(
                'WARISAN BUDAYA DUNIA',
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 0.4,
                  color: Color(0xFFFFD1A7),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            '“Tempe adalah warisan gastronomi Nusantara yang membuktikan bahwa kecerdasan leluhur mampu menghadirkan nutrisi berkelanjutan bagi peradaban dunia.”',
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Kandidat UNESCO Intangible Cultural Heritage List',
            style: TextStyle(fontSize: 10, color: Color(0xFFFFD1A7)),
          ),
        ],
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
}

class _TempeBenefitCard extends StatelessWidget {
  final KnowledgeSection section;
  final IconData icon;
  final Color iconBackground;

  const _TempeBenefitCard({
    required this.section,
    required this.icon,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF2ECE8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF472B1A)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF292522),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  section.body,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Color(0xFF655951),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
