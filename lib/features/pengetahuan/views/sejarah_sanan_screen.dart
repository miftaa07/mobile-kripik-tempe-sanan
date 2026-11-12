import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../navigation/widgets/bottom_navbar.dart';
import '../models/knowledge_article.dart';

class SejarahSananScreen extends StatelessWidget {
  final KnowledgeArticle article;
  final ValueChanged<int>? onNavigateTab;

  const SejarahSananScreen({
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
            SliverToBoxAdapter(child: _buildHeader(context, 'Sejarah Sanan')),
            SliverToBoxAdapter(child: _buildHistoryHero()),
            SliverToBoxAdapter(child: _buildHistoryCard()),
            SliverToBoxAdapter(child: _buildHistoryFact()),
            const SliverToBoxAdapter(child: SizedBox(height: 18)),
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

  Widget _buildHistoryHero() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 225,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/images/kampung_sanan.jpg', fit: BoxFit.cover),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xB8000000)],
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: _historyBadge(
                  icon: Icons.archive_outlined,
                  label: 'Arsip Komunitas Sanan',
                ),
              ),
              Positioned(
                left: 14,
                right: 14,
                bottom: 12,
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '“Proses perajangan kedelai di tampah bambu...”',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.42),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Dok. 1974',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F3F2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _historyBadge(
            icon: Icons.workspace_premium_outlined,
            label: 'Warisan Tradisi Sejak 1960-an',
            background: const Color(0xFFFFDDCA),
          ),
          const SizedBox(height: 8),
          _historyBadge(
            icon: Icons.eco_outlined,
            label: '100% Organik',
            background: const Color(0xFFEEF0ED),
            foreground: const Color(0xFF237B3B),
          ),
          const SizedBox(height: 18),
          const Text(
            'Sejarah Kampung Sanan',
            style: TextStyle(
              fontSize: 22,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: Color(0xFF783900),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Kampung Sanan mulai dikenal sebagai sentra produksi keripik tempe sejak tahun 1960-an. Berawal dari usaha rumahan berskala kecil yang memanfaatkan kedelai pilihan berkualitas, kini Sanan berkembang pesat menjadi ikon kuliner legendaris khas Malang yang telah mendunia.',
            style: TextStyle(
              fontSize: 14,
              height: 1.62,
              color: Color(0xFF655951),
            ),
          ),
          const SizedBox(height: 18),
          _buildHistoryQuote(),
          const SizedBox(height: 42),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  'Jejak Transformasi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF292522),
                  ),
                ),
              ),
              const Text(
                '1960 – Masa Kini',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF783900),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _HistoryMilestone(
            year: '1960',
            icon: Icons.water_drop_outlined,
            title: 'Awal Mula Tempe Basah',
            body: 'Sentra rumahan pengolahan kedelai lokal dan limbah kulit ari untuk pakan...',
          ),
          const SizedBox(height: 10),
          const _HistoryMilestone(
            year: '1975',
            icon: Icons.soup_kitchen_outlined,
            title: 'Inovasi Keripik Renyah',
            body: 'Percobaan penggorengan tempe tipis dengan bumbu tradisional pertama kali',
          ),
          const SizedBox(height: 10),
          const _HistoryMilestone(
            year: '1990',
            icon: Icons.storefront_outlined,
            title: 'Oleh-oleh Wajib Malang',
            body: 'Munculnya deretan toko resmi di Jalan Sanan dan pengukuhan kawasan...',
          ),
          const SizedBox(height: 10),
          const _HistoryMilestone(
            year: '2020+',
            icon: Icons.qr_code_2,
            title: 'Eduwisata & Digitalisasi',
            body: 'Kampung Sanan bertransformasi ke platform digital, ekspor mancanegara,...',
            highlighted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryQuote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.format_quote_rounded,
            size: 23,
            color: Color(0xFF783900),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              '“Dari sisa potongan tempe rumahan, lahirlah karya kriya pangan renyah yang menghidupi lebih dari 600 keluarga perajin tempe di Sanan hingga hari ini.”',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                fontStyle: FontStyle.italic,
                color: Color(0xFF282421),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryFact() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F3F2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFB7F2B7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lightbulb,
              color: Color(0xFF08772D),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tahukah Anda?',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF292522),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Ragi tempe khas Sanan memiliki mikroflora fermentasi alami yang membuat aroma keripik tetap sedap tanpa pengawet sintetis.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
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

  Widget _historyBadge({
    required IconData icon,
    required String label,
    Color background = Colors.white,
    Color foreground = const Color(0xFF402719),
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: foreground),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: foreground,
            ),
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

class _HistoryMilestone extends StatelessWidget {
  final String year;
  final IconData icon;
  final String title;
  final String body;
  final bool highlighted;

  const _HistoryMilestone({
    required this.year,
    required this.icon,
    required this.title,
    required this.body,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final accent = highlighted ? Colors.white : const Color(0xFF783900);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlighted ? const Color(0xFFEDE4DE) : Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 50,
            decoration: BoxDecoration(
              color: highlighted
                  ? const Color(0xFF783900)
                  : const Color(0xFFE8DDD5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  year,
                  style: TextStyle(
                    color: accent,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(icon, color: accent, size: 16),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: highlighted
                        ? const Color(0xFF783900)
                        : const Color(0xFF292522),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
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
