import 'package:flutter/material.dart';

import '../../models/knowledge_article.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_navbar.dart';

class KnowledgeDetailScreen extends StatelessWidget {
  final KnowledgeArticle article;
  final ValueChanged<int>? onNavigateTab;

  const KnowledgeDetailScreen({
    super.key,
    required this.article,
    this.onNavigateTab,
  });

  bool get _isHistoryArticle => article.title == 'Sejarah Kampung Sanan';
  bool get _isTempeArticle => article.title == 'Pengetahuan tentang Tempe';
  bool get _isProcessArticle =>
      article.title == 'Proses Pembuatan Keripik Tempe';
  bool get _isFactsArticle => article.title == 'Fakta & Informasi Tempe';

  @override
  Widget build(BuildContext context) {
    if (_isHistoryArticle) {
      return _buildHistoryLayout(context);
    }
    if (_isTempeArticle) {
      return _buildTempeLayout(context);
    }
    if (_isProcessArticle) {
      return _buildProcessLayout(context);
    }
    if (_isFactsArticle) {
      return _buildFactsLayout(context);
    }

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

  Widget _buildFactsLayout(BuildContext context) {
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

  Widget _buildProcessLayout(BuildContext context) {
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

  Widget _buildTempeLayout(BuildContext context) {
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

  Widget _buildHistoryLayout(BuildContext context) {
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
