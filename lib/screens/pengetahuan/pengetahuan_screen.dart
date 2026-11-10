import 'package:flutter/material.dart';

import '../../models/knowledge_article.dart';
import '../../theme/app_theme.dart';
import 'knowledge_detail_screen.dart';

class PengetahuanScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final ValueChanged<int>? onNavigateTab;

  const PengetahuanScreen({super.key, this.onBack, this.onNavigateTab});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context)),
          SliverToBoxAdapter(child: _buildAboutSanan()),
          SliverToBoxAdapter(child: _buildStats()),
          SliverToBoxAdapter(child: _buildExploreHeading()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            sliver: SliverList.separated(
              itemCount: knowledgeArticles.length,
              itemBuilder: (context, index) {
                final article = knowledgeArticles[index];
                return _ExploreCard(
                  article: article,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => KnowledgeDetailScreen(
                        article: article,
                        onNavigateTab: onNavigateTab,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, _) => const SizedBox(height: 10),
            ),
          ),
          SliverToBoxAdapter(child: _buildTourismCard()),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 20, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.textDark,
            tooltip: 'Kembali',
          ),
          const SizedBox(width: 4),
          const Text(
            'About Sanan',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSanan() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/kampung_sanan.jpg',
                  height: 210,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.08),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.58),
                        ],
                        stops: const [0, 0.45, 1],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: _imageBadge(
                    Icons.verified,
                    'Sentra Industri Tempe Sanan',
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _imageBadge(
                        Icons.location_on_outlined,
                        'Klojen, Kota Malang',
                      ),
                      _imageBadge(Icons.history, 'Est. 1960'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Row(
            children: [
              Icon(Icons.circle, size: 10, color: AppTheme.primary),
              SizedBox(width: 8),
              Text(
                'KEARIFAN LOKAL MALANG',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primary,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Kampung Sanan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Pusat produksi keripik tempe di Malang yang telah dikenal sejak lama. Kampung ini menjadi salah satu ikon kuliner khas daerah dengan cita rasa yang unik dan turun-temurun.',
            style: TextStyle(
              fontSize: 13,
              height: 1.55,
              color: AppTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppTheme.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: const [
          Expanded(
            child: _StatCard(value: '500+', label: 'Pengrajin\nTempe'),
          ),
          SizedBox(width: 9),
          Expanded(
            child: _StatCard(value: '1960', label: 'Sejak Berdiri'),
          ),
          SizedBox(width: 9),
          Expanded(
            child: _StatCard(value: '15+', label: 'Varian Rasa'),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreHeading() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 27, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Eksplorasi Informasi',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),
          ),
          Text(
            '${knowledgeArticles.length} Kategori',
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTourismCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF5EF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEFE3D7)),
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.outlined_flag, color: AppTheme.primary, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WISATA EDUKASI TEMPE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Pengunjung dapat melihat langsung proses pembuatan keripik tempe hangat dari dapur perajin di sepanjang jalan Sanan.',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.55,
                      color: AppTheme.textGrey,
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

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5EF),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFEFE3D7)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              height: 1.15,
              color: AppTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  final KnowledgeArticle article;
  final VoidCallback onTap;

  const _ExploreCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFAF5EF),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          constraints: const BoxConstraints(minHeight: 88),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFEFE3D7)),
          ),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0E6DA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(article.icon, color: AppTheme.primary, size: 21),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      article.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      article.subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.35,
                        color: AppTheme.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right,
                size: 21,
                color: AppTheme.textGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
