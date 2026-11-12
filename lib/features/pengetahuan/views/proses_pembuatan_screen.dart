import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../navigation/widgets/bottom_navbar.dart';
import '../models/knowledge_article.dart';

class ProsesPembuatanScreen extends StatelessWidget {
  final KnowledgeArticle article;
  final ValueChanged<int>? onNavigateTab;

  const ProsesPembuatanScreen({
    super.key,
    required this.article,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(context, 'Proses Pembuatan'),
            ),
            SliverToBoxAdapter(child: _buildProcessHero()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              sliver: SliverList.list(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF874515),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'PROSES PRODUKSI',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 0.3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.verified_outlined,
                        size: 14,
                        color: Color(0xFF16833E),
                      ),
                      const SizedBox(width: 4),
                      const Expanded(
                        child: Text(
                          'Tradisi Turun-Temurun',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF655951),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  const Text(
                    'Dari Kedelai Pilihan Menjadi Keripik Renyah Khas Sanan',
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
                  const SizedBox(height: 16),
                  _buildProcessSummary(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Tahapan Pengolahan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF292522),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3EFED),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${article.sections.length} Langkah Inti',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF655951),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  for (
                    var index = 0;
                    index < article.sections.length;
                    index++
                  ) ...[
                    _ProcessStepCard(
                      number: index + 1,
                      section: article.sections[index],
                    ),
                    if (index < article.sections.length - 1)
                      const SizedBox(height: 9),
                  ],
                  const SizedBox(height: 12),
                  _buildProcessSecret(),
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

  Widget _buildProcessHero() {
    return SizedBox(
      height: 186,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash_background.png',
            fit: BoxFit.cover,
            alignment: const Alignment(0, 0.62),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.42, 1],
                colors: [Colors.transparent, Colors.white],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F3F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const _ProcessSummaryItem(
            icon: Icons.timer_outlined,
            iconBackground: Color(0xFFFFDDCA),
            title: 'Durasi Total',
            subtitle: '3 Hari Pembuatan',
          ),
          Container(
            width: 1,
            height: 38,
            margin: const EdgeInsets.symmetric(horizontal: 9),
            color: const Color(0xFFE6DFDA),
          ),
          const _ProcessSummaryItem(
            icon: Icons.eco_outlined,
            iconBackground: Color(0xFF8BF28D),
            title: 'Bahan Baku',
            subtitle: '100% Kedelai Alami',
          ),
        ],
      ),
    );
  }

  Widget _buildProcessSecret() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F3F1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.stars_rounded,
                size: 18,
                color: Color(0xFF874515),
              ),
              const SizedBox(width: 7),
              const Expanded(
                child: Text(
                  'Rahasia Kerenyahan Sanan',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF292522),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Kunci kerenyahan renyah tanpa keras terletak pada perpaduan kelembapan fermentasi dan teknik penirisan sentrifugal minyak panas langsung usai digoreng.',
            style: TextStyle(
              fontSize: 12,
              height: 1.55,
              color: Color(0xFF655951),
            ),
          ),
          const SizedBox(height: 12),
          for (final tip in const [
            'Ragi alami hasil kultur lokal berpuluh tahun',
            'Tanpa bahan perenyah kimia atau zat pengawet',
            'Minyak selalu diganti secara berkala dan higienis',
          ]) ...[
            Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 15,
                  color: Color(0xFF16833E),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    tip,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.45,
                      color: Color(0xFF403A36),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
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

class _ProcessSummaryItem extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final String title;
  final String subtitle;

  const _ProcessSummaryItem({
    required this.icon,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
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
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF292522),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
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

class _ProcessStepCard extends StatelessWidget {
  final int number;
  final KnowledgeSection section;

  const _ProcessStepCard({required this.number, required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F3F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF783900),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 14,
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
