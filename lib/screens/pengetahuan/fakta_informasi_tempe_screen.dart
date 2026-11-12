import 'package:flutter/material.dart';

import '../../models/knowledge_article.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_navbar.dart';

class FaktaInformasiTempeScreen extends StatelessWidget {
  final KnowledgeArticle article;
  final ValueChanged<int>? onNavigateTab;

  const FaktaInformasiTempeScreen({
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
            SliverToBoxAdapter(child: _buildHeader(context, 'Fakta Tempe')),
            SliverToBoxAdapter(child: _buildFactsHero()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
              sliver: SliverList.list(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDDCA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'FAKTA & STATISTIK',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 0.3,
                          color: Color(0xFF783900),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Fakta Menarik Seputar Tempe & Kampung Sanan',
                    style: TextStyle(
                      fontSize: 22,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF201F1F),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.introduction,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.62,
                      color: Color(0xFF655951),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xFF783900),
                        size: 19,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Tahukah Anda?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF292522),
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
                    _FactCard(
                      number: index + 1,
                      section: article.sections[index],
                      icon: switch (index) {
                        0 => Icons.groups_rounded,
                        1 => Icons.public_rounded,
                        2 => Icons.restaurant_rounded,
                        _ => Icons.verified_user_outlined,
                      },
                      color: switch (index) {
                        0 => const Color(0xFFFFDDCA),
                        1 => const Color(0xFF8BF28D),
                        2 => const Color(0xFFFFD9DC),
                        _ => const Color(0xFFFFDDCA),
                      },
                    ),
                    if (index < article.sections.length - 1)
                      const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 24),
                  _buildStorageTips(),
                  const SizedBox(height: 24),
                  _buildExploreStore(context),
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

  Widget _buildFactsHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          height: 224,
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
                    colors: [Colors.transparent, Color(0x66000000)],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                bottom: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F2EC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.eco_outlined,
                        size: 13,
                        color: Color(0xFF783900),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Warisan Kuliner Malang',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF402719),
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

  Widget _buildStorageTips() {
    const tips = [
      (
        icon: Icons.lock_outline,
        title: 'Simpan dalam Wadah Kedap Udara',
        body: 'Gunakan toples atau zip-lock segera setelah kemasan dibuka agar kelembapan udara tidak membuat tekstur alot.',
      ),
      (
        icon: Icons.wb_sunny_outlined,
        title: 'Jauhkan dari Sinar Matahari Langsung',
        body: 'Suhu ruang sejuk dan terhindar dari panas mempertahankan aroma minyak kelapa sawit alami tetap segar tanpa tengik.',
      ),
      (
        icon: Icons.cyclone_outlined,
        title: 'Tips Kejutan: Hangatkan Cepat',
        body: 'Bila sempat melempem, masukkan ke dalam oven atau air fryer selama 2 menit pada suhu 150°C untuk kerenyahan maksimal seperti baru digoreng.',
      ),
    ];

    return Column(
      children: [
        Row(
          children: const [
            Icon(
              Icons.tips_and_updates_outlined,
              color: Color(0xFF16833E),
              size: 19,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Tips Menyimpan Keripik Tempe',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF292522),
                ),
              ),
            ),
            Text(
              'Tetap Renyah',
              style: TextStyle(fontSize: 10, color: Color(0xFF655951)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFF2ECE8)),
          ),
          child: Column(
            children: [
              for (var index = 0; index < tips.length; index++) ...[
                _StorageTip(
                  icon: tips[index].icon,
                  title: tips[index].title,
                  body: tips[index].body,
                ),
                if (index < tips.length - 1) const SizedBox(height: 14),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExploreStore(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
      decoration: BoxDecoration(
        color: const Color(0xFF874515),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF9B5D2A),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.storefront_outlined,
              color: Colors.white,
              size: 23,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Ingin Mencicipi Langsung?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Temukan deretan gerai tempe Sanan legendaris dan pesan varian rasa favorit Anda dengan mudah.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              height: 1.45,
              color: Color(0xFFFFE6D1),
            ),
          ),
          const SizedBox(height: 14),
          TextButton.icon(
            onPressed: () async {
              await Navigator.of(context).maybePop();
              onNavigateTab?.call(1);
            },
            iconAlignment: IconAlignment.end,
            icon: const Icon(
              Icons.arrow_forward,
              size: 18,
              color: Color(0xFF783900),
            ),
            label: const Text(
              'Jelajahi Toko Sanan',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF783900),
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
              shape: const StadiumBorder(),
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

class _FactCard extends StatelessWidget {
  final int number;
  final KnowledgeSection section;
  final IconData icon;
  final Color color;

  const _FactCard({
    required this.number,
    required this.section,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F3F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Icon(icon, size: 19, color: const Color(0xFF783900)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9E5E3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  number.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF655951),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            section.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF292522),
            ),
          ),
          const SizedBox(height: 6),
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
    );
  }
}

class _StorageTip extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _StorageTip({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Color(0xFF8BF28D),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 17, color: const Color(0xFF08772D)),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF292522),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                body,
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
    );
  }
}
