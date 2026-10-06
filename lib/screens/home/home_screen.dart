import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/product_card.dart';
import '../../widgets/hampers_card.dart';
import '../../widgets/toko_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          // =========================
          // HEADER
          // =========================
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(21, 18, 21, 0),
            sliver: SliverToBoxAdapter(
              child: _buildHeader(),
            ),
          ),

          // =========================
          // SEARCH
          // =========================
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(21, 14, 21, 0),
            sliver: SliverToBoxAdapter(
              child: _buildSearch(),
            ),
          ),

          // =========================
          // AI CARD
          // =========================
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(21, 22, 21, 0),
            sliver: SliverToBoxAdapter(
              child: _buildAiCard(),
            ),
          ),

          // =========================
          // PRODUK TERBARU
          // =========================
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(21, 17, 0, 0),
            sliver: SliverToBoxAdapter(
              child: _buildSectionHeader(
                title: 'Produk Terbaru',
                onTap: () {},
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 231,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(21, 13, 21, 0),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final products = [
                    {
                      'name': 'Kripik Tempe Original',
                      'store': 'Toko Sanan Jaya',
                      'variant': 'Original',
                      'price': 'Rp 10.000',
                    },
                    {
                      'name': 'Kripik Tempe BBQ',
                      'store': 'Toko Bu Susi',
                      'variant': 'BBQ',
                      'price': 'Rp 10.000',
                    },
                    {
                      'name': 'Kripik Tempe Pedas',
                      'store': 'Toko Pak Rudi',
                      'variant': 'Pedas',
                      'price': 'Rp 10.000',
                    },
                  ];

                  final product = products[index];

                  return ProductCard(
                    image: '',
                    name: product['name']!,
                    store: product['store']!,
                    variant: product['variant']!,
                    price: product['price']!,
                  );
                },
              ),
            ),
          ),

          // =========================
          // PAKET HAMPERS
          // =========================
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(21, 17, 0, 0),
            sliver: SliverToBoxAdapter(
              child: _buildSectionHeader(
                title: 'Paket Hampers',
                onTap: () {},
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 225,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(21, 13, 21, 0),
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final hampers = [
                    {
                      'name': 'Hampers Spesial Sanan',
                      'store': 'Toko Sanan Jaya',
                      'description': 'Isi 4 varian keripik tempe',
                      'price': 'Rp 50.000',
                    },
                    {
                      'name': 'Hampers Keluarga',
                      'store': 'Toko Bu Susi',
                      'description': 'Isi 5 varian keripik tempe',
                      'price': 'Rp 75.000',
                    },
                  ];

                  final item = hampers[index];

                  return HampersCard(
                    image: '',
                    name: item['name']!,
                    store: item['store']!,
                    description: item['description']!,
                    price: item['price']!,
                  );
                },
              ),
            ),
          ),

          // =========================
          // TOKO
          // =========================
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(21, 18, 0, 0),
            sliver: SliverToBoxAdapter(
              child: _buildSectionHeader(
                title: 'Temukan Toko di Sanan',
                onTap: () {},
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 244,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(21, 13, 21, 0),
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final stores = [
                    {
                      'name': 'Toko Sanan Jaya',
                      'address': 'Jl. Sanan No. 12, Malang',
                      'description':
                          'Toko legendaris dengan berbagai varian keripik tempe.',
                    },
                    {
                      'name': 'Toko Ar - Ridlo',
                      'address': 'Jl. Sanan No. 28, Malang',
                      'description':
                          'Terkenal dengan rasa khas dan kualitas terjaga.',
                    },
                  ];

                  final store = stores[index];

                  return TokoCard(
                    image: '',
                    name: store['name']!,
                    address: store['address']!,
                    description: store['description']!,
                  );
                },
              ),
            ),
          ),

          // =========================
          // PENGETAHUAN SANAN
          // =========================
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(21, 18, 21, 20),
            sliver: SliverToBoxAdapter(
              child: _buildKnowledgeCard(),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.primary,
              width: 1.5,
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.eco_outlined,
            size: 22,
            color: AppTheme.primary,
          ),
        ),

        const SizedBox(width: 9),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kampung Keripik Tempe',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF67432F),
                ),
              ),
              Text(
                'Sanan',
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 27,
                  height: 0.95,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
        ),

        Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.notifications_none_rounded,
              size: 27,
              color: AppTheme.primary,
            ),
            Positioned(
              right: -1,
              top: 1,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9572B),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearch() {
    return Container(
      height: 43,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE5DDD6),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: Color(0xFF897E77),
          ),
          hintText: 'Cari toko, produk, atau informasi...',
          hintStyle: TextStyle(
            fontSize: 11.5,
            color: Color(0xFFB2AAA5),
          ),
          contentPadding: EdgeInsets.only(
            top: 12,
            bottom: 12,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // AI CARD
  // ============================================================

  Widget _buildAiCard() {
    return Container(
      height: 194,
      decoration: BoxDecoration(
        color: const Color(0xFFF8E6D3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFECD2BA),
        ),
      ),
      child: Stack(
        children: [
          // =========================
          // ROBOT ASSET
          // =========================
          Positioned(
            right: -45,
            bottom: -20,
            child: SizedBox(
              width: 220,
              height: 194,
              child: Image.asset(
                'assets/images/robot.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // =========================
          // CONTENT
          // =========================
          Padding(
            padding: const EdgeInsets.fromLTRB(
              27,
              13,
              100,
              15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE7D6C6),
                    ),
                  ),
                  child: const Text(
                    '✦  Asisten Cerdas Sanan',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Judul
                const Text(
                  'Bingung pilih toko?',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF432A1D),
                  ),
                ),

                const SizedBox(height: 5),

                // Deskripsi
                const Text(
                  'Temukan toko atau produk keripik\n'
                  'tempe yang sesuai dengan\n'
                  'kebutuhanmu.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.55,
                    color: Color(0xFF76665D),
                  ),
                ),

                const SizedBox(height: 8),

                // Button
                SizedBox(
                  height: 34,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '✦ Bantu Saya Memilih',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D2723),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 21),
          child: TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Lihat Semua ›',
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // KNOWLEDGE CARD
  // ============================================================

  Widget _buildKnowledgeCard() {
    return Container(
      height: 151,
      decoration: BoxDecoration(
        color: const Color(0xFFF4E3CF),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE8D2B9),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          17,
          15,
          10,
          12,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kenali Kampung Sanan',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3C3028),
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Kenal lebih dekat dengan Kampung\n'
                    'Sanan, kawasan industri yang dikenal sebagai\n'
                    'salah satu sentra industri keripik tempe di\n'
                    'Malang.',
                    style: TextStyle(
                      fontSize: 9,
                      height: 1.4,
                      color: Color(0xFF71655D),
                    ),
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text(
                      'Selengkapnya ›',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 110,
                  color: const Color(0xFFE2D2C2),
                  child: const Icon(
                    Icons.image_outlined,
                    size: 40,
                    color: Color(0xFFB5A394),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}